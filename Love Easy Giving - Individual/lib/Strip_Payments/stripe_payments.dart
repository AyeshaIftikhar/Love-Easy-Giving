import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';

setPaymentOptions({
  @required String publishable,
  @required String merchantid,
  @required String payMode,
}) {
  StripePayment.setOptions(
    StripeOptions(
      publishableKey: publishable,
      merchantId: merchantid,
      androidPayMode: payMode,
  ));
}

CreditCard setupCard({
  @required String number,
  @required int month,
  @required int eyear,
}) {
  return CreditCard(
    number: number, 
    expMonth: month,
    expYear: eyear,
  );
}
