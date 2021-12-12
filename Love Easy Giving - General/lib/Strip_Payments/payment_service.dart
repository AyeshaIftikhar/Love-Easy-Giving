import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';
import './.env.stripe_key.dart';
import './transaction_response.dart';

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static Uri paymentApiUrl = Uri.parse('${StripeService.apiBase}/payment_intents');
  static Map<String, String> headers = {
    'Authorization': 'Bearer $secret',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey: publishable,
        merchantId: "Test",
        androidPayMode: 'test'));
  }
  static Future<StripeTransactionResponse> payWithCard({
    @required String amount,
    @required String currency,
    @required CreditCard card,
    @required String description,
    @required String name,
    @required String phone,
    @required String email,
    @required BillingAddress billingAddress,
  }) async {
    try {


      var paymentMethod = await StripePayment.createPaymentMethod(
          PaymentMethodRequest(billingAddress: billingAddress,card: card)
      );
      //
      // var paymentMethod =
      //     await StripePayment.createPaymentMethod(paymentMethodRequest);
      var paymentIntent = await createPaymentIntent(
        amount: amount,
        currency: currency,
        description: description,
        card: card,
      );
      // BillingDetails billingDetails = BillingDetails(
      //   address: billingAddress,
      //   email: email,
      //   name: name,
      //   phone: phone,
      // );
      // print("done3");
      // // ignore: unused_local_variable
      // PaymentMethod paymentMethodToPass = PaymentMethod(
      //     billingDetails: billingDetails,
      //     card: card,
      //     created: paymentMethod.created,
      //     id: paymentMethod.id,
      //     customerId: paymentMethod.customerId,
      //     livemode: false,
      //     type: 'card');
      // print("done4");
      var response = await StripePayment.confirmPaymentIntent(
          PaymentIntent(
              clientSecret: paymentIntent['client_secret'],
              paymentMethodId: paymentMethod.id
          )
      );
      if (response.status == 'succeeded') {
        return new StripeTransactionResponse(
            message: 'Transaction successful',
            success: true
        );
      } else {
        return new StripeTransactionResponse(
            message: 'Transaction failed',
            success: false
        );
      }
    } on PlatformException catch(err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return  StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}',
          success: false
      );
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return new StripeTransactionResponse(
        message: message,
        success: false
    );
  }



  static Future<Map<String, dynamic>> createPaymentIntent({
    @required String amount,
    @required String currency,
    @required String description,
    @required CreditCard card,
    PaymentMethod paymentMethod,
  }) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card',
        'description': description,
      };
      var response = await http.post(
          StripeService.paymentApiUrl,
          body: body,
          headers: StripeService.headers
      );
      return jsonDecode(response.body);
    } catch (e) {
      print('Create Payment Intent: $e');
      return null;
    }
  }
}