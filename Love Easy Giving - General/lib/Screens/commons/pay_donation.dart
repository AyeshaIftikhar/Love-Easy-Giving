import 'package:leggenerral/widgets/copyright.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stripe_payment/stripe_payment.dart';
import '../../Controller/app_controller.dart';
import '../../Strip_Payments/stripe_payments.dart';
import '../../Strip_Payments/payment_service.dart';
import '../../Strip_Payments/.env.stripe_key.dart';
import '../../Strip_Payments/scheduled_timer.dart';
import '../../Constants/colors.dart';
import '../../Constants/currencies.dart';
import '../../styles/button_styles.dart';
import '../../styles/input_decoration.dart';
import '../../widgets/alert_widgets.dart';
import '../../widgets/const_widgets.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/text_widget.dart';

class Donations extends StatefulWidget {
  @override
  _DonationsState createState() => _DonationsState();
}

class _DonationsState extends State<Donations> {
  TextEditingController price = TextEditingController();
  TextEditingController start = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController end = TextEditingController();
  final MyAppController _controller = Get.find();
  Color backgroundColor = Get.arguments;
  var payParameters = Get.parameters;
  var pay = GlobalKey<FormState>();
  String currrency, unicode;
  String type;
  final List<String> types = <String>["Zakah", "Fitrana", "Sadqah", "Others"];
  BillingAddress billingAddress;
  CreditCard _card;
  int amount;
  var re = RegExp(
    r'^'
    r'(?<day>[0-9]{1,2})'
    r'/'
    r'(?<month>[0-9]{1,2})'
    r'/'
    r'(?<year>[0-9]{4,})'
    r'$',
  );

  @override
  void initState() {
    super.initState();
    if (payParameters['app_mode'] == 'Ramadan') {
      setState(() {
        price.text = payParameters['amount'];
        currrency = 'GBP';
        type = 'Zakah';
        unicode = payParameters['unicode'];
        print(price.text);
        print(currrency);
        print(type);
        print(unicode.replaceAll('\\u', '0x'));
      });
    }
    if (payParameters['app_mode'] == 'Hajj_Qurbani') {
      price.text = payParameters['amount'];
      currrency = 'GBP';
      type = 'Saqdah';
      unicode = payParameters['unicode'];
      print(unicode.replaceAll('0x', '\\u'));
    }
    StripePayment.setOptions(StripeOptions(
      publishableKey: publishable,
      merchantId: payParameters['stripeKey'],
      androidPayMode: 'Live',
    ));
  }

  @override
  void dispose() {
    super.dispose();
    price.dispose();
    start.dispose();
    end.dispose();
    time.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      persistentFooterButtons: [
        copyrightwidget(
          color: backgroundColor == Colors.white ? selectColor : Colors.white,
        ),
      ],
      body: SingleChildScrollView(
        child: Form(
          key: pay,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                vspace(height: 50),
                customTop(
                  color: selectColor,
                  text: payParameters['pay_type'] == 'Schdeule'
                      ? 'Schedule'.toUpperCase()
                      : 'Pay Now'.toUpperCase(),
                  fontSize: 17,
                  textColor: backgroundColor == Colors.white
                      ? htextDark
                      : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                vspace(height: 30),
                if (payParameters['pay_type'] == 'Schdeule')
                  appText(
                      text: 'START DATE',
                      fontSize: 15,
                      color: backgroundColor == Colors.white
                          ? htextDark
                          : Colors.white,
                      fontWeight: FontWeight.bold),
                if (payParameters['pay_type'] == 'Schdeule')
                  CustomTextFormField(
                    label: 'Enter Start Date',
                    maxLines: 1,
                    controller: start,
                    hint: 'DD/MM/YYYY',
                    hfont: 16,
                    keyboardType: TextInputType.datetime,
                    textInputAction: TextInputAction.next,
                    validator: (val) {
                      if (val.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    decorColor: backgroundColor == Colors.white
                        ? htextDark
                        : Colors.white,
                    typedTextColor: backgroundColor == Colors.white
                        ? htextDark
                        : Colors.white,
                    errorColor: selectColor,
                    borderColor: selectColor,
                    focusColor: selectColor,
                    cursorColor: selectColor,
                  ),
                if (payParameters['pay_type'] == 'Schdeule') vspace(height: 30),
                if (payParameters['pay_type'] == 'Schdeule')
                  appText(
                      text: 'END DATE',
                      fontSize: 15,
                      color: backgroundColor == Colors.white
                          ? htextDark
                          : Colors.white,
                      fontWeight: FontWeight.bold),
                if (payParameters['pay_type'] == 'Schdeule')
                  CustomTextFormField(
                    label: 'Enter end date',
                    maxLines: 1,
                    controller: end,
                    hint: 'DD/MM/YYYY',
                    hfont: 16,
                    keyboardType: TextInputType.datetime,
                    textInputAction: TextInputAction.next,
                    validator: (val) {
                      if (val.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    decorColor: backgroundColor == Colors.white
                        ? htextDark
                        : Colors.white,
                    typedTextColor: backgroundColor == Colors.white
                        ? htextDark
                        : Colors.white,
                    errorColor: selectColor,
                    borderColor: selectColor,
                    focusColor: selectColor,
                    cursorColor: selectColor,
                  ),
                if (payParameters['pay_type'] == 'Schdeule') vspace(height: 30),
                if (payParameters['pay_type'] == 'Schdeule')
                  appText(
                      color: backgroundColor == Colors.white
                          ? htextDark
                          : Colors.white,
                      text: 'TIME',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                if (payParameters['pay_type'] == 'Schdeule')
                  CustomTextFormField(
                    label: 'Enter time to donate',
                    maxLines: 1,
                    controller: time,
                    hfont: 16,
                    keyboardType: TextInputType.datetime,
                    textInputAction: TextInputAction.next,
                    validator: (val) {
                      if (val.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    decorColor: backgroundColor == Colors.white
                        ? htextDark
                        : Colors.white,
                    typedTextColor: backgroundColor == Colors.white
                        ? htextDark
                        : Colors.white,
                    errorColor: selectColor,
                    borderColor: selectColor,
                    focusColor: selectColor,
                    cursorColor: selectColor,
                  ),
                if (payParameters['pay_type'] == 'Schdeule') vspace(height: 30),
                if (backgroundColor == loveJummahScaffold ||
                    payParameters['pay_type'] == 'Schdeule')
                  appText(
                      color: backgroundColor == Colors.white
                          ? htextDark
                          : Colors.white,
                      text: 'DONATION TYPE',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                if (backgroundColor == loveJummahScaffold ||
                    payParameters['pay_type'] == 'Schdeule')
                  DropdownButtonFormField<String>(
                    dropdownColor: Colors.white,
                    value: type,
                    items: types
                        .map((e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ))
                        .toList(),
                    selectedItemBuilder: (context) {
                      return types
                          .map((e) => DropdownMenuItem(
                                child: appText(
                                    text: e.toString(),
                                    fontSize: 15,
                                    color: backgroundColor == Colors.white
                                        ? htextDark
                                        : Colors.white),
                                value: e,
                              ))
                          .toList();
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 32,
                      color: backgroundColor == scaffoldColor
                          ? Colors.white
                          : selectColor,
                    ),
                    hint: appText(
                        text: 'Donation Type ',
                        color: backgroundColor == Colors.white
                            ? htextDark
                            : Colors.white,
                        fontSize: 16),
                    style: TextStyle(
                      fontFamily: 'Futura',
                      color: Colors.black,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) {
                      setState(() {
                        type = value;
                      });
                    },
                    validator: (val) {
                      if (val == null) {
                        return '*Required';
                      }
                      return null;
                    },
                    decoration: dropDownStyle(backgroundColor: backgroundColor),
                  ),
                vspace(height: 30),
                appText(
                    text: (payParameters['pay_type'] == 'Schdeule')
                        ? (backgroundColor == loveJummahScaffold)
                            ? 'AMOUNT EACH JUMMAH'
                            : 'AMOUNT EACH DAY'
                        : 'AMOUNT ONE-OFF',
                    fontSize: 15,
                    color: backgroundColor == Colors.white
                        ? htextDark
                        : Colors.white,
                    fontWeight: FontWeight.bold),
                CustomTextFormField(
                  hint: (payParameters['pay_type'] == 'Schdeule')
                      ? '100,000 \$'
                      : '\$ 100',
                  maxLines: 1,
                  hfont: 16,
                  controller: price,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (val) {
                    if (val.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                  decorColor: backgroundColor == Colors.white
                      ? htextDark
                      : Colors.white,
                  typedTextColor: backgroundColor == Colors.white
                      ? htextDark
                      : Colors.white,
                  errorColor: selectColor,
                  borderColor: selectColor,
                  focusColor: selectColor,
                  cursorColor: selectColor,
                ),
                vspace(
                    height:
                        payParameters['app_mode'] != 'Hajj_Qurbani' ? 30 : 50),
                appText(
                    text: 'CURRENCY',
                    fontSize: 15,
                    color: backgroundColor == Colors.white
                        ? htextDark
                        : Colors.white,
                    fontWeight: FontWeight.bold),
                DropdownButtonFormField<String>(
                  value: currrency,
                  items: currencyDrop
                      .map((e) => DropdownMenuItem(
                          child: appText(
                            text: e.label,
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          value: e.value,
                          onTap: () {
                            setState(() {
                              unicode = e.ucode;
                              print(unicode);
                            });
                          }))
                      .toList(),
                  selectedItemBuilder: (context) {
                    return currencyDrop
                        .map((e) => DropdownMenuItem(
                              child: appText(
                                text: e.label,
                                fontSize: 15,
                                color: backgroundColor == Colors.white
                                    ? htextDark
                                    : Colors.white,
                              ),
                              value: e.value,
                            ))
                        .toList();
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: 32,
                    color: backgroundColor == scaffoldColor
                        ? Colors.white
                        : selectColor,
                  ),
                  hint: appText(
                      text: 'Currency ',
                      color: backgroundColor == Colors.white
                          ? htextDark
                          : Colors.white,
                      fontSize: 16),
                  style: TextStyle(
                    fontFamily: 'Futura',
                    color: Colors.black,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (value) {
                    setState(() {
                      currrency = value;
                    });
                  },
                  validator: (val) {
                    if (val == null) {
                      return '*Required';
                    }
                    return null;
                  },
                  decoration: dropDownStyle(backgroundColor: backgroundColor),
                ),
                vspace(
                    height:
                        payParameters['app_mode'] != 'Hajj_Qurbani' ? 30 : 50),
                appText(
                    text: 'SELECTED CARD',
                    color: backgroundColor == Colors.white
                        ? htextDark
                        : Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                Column(
                  children: [
                    ListTile(
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => appText(
                                text: _controller.cardNumber.value,
                                color: backgroundColor == Colors.white
                                    ? htextDark
                                    : Colors.white,
                                fontSize: 16,
                              )),
                          Obx(() => appText(
                                text: _controller.expiry.value,
                                color: backgroundColor == Colors.white
                                    ? htextDark
                                    : Colors.white,
                                fontSize: 16,
                              )),
                        ],
                      ),
                      subtitle: Obx(() => Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: appText(
                              text: _controller.holderName.value,
                              color: backgroundColor == Colors.white
                                  ? htextDark
                                  : Colors.white,
                              fontSize: 16,
                            ),
                          )),
                    ),
                    Divider(
                      thickness: 1,
                      color: backgroundColor == scaffoldColor
                          ? Colors.white
                          : selectColor,
                    ),
                  ],
                ),
                vspace(
                    height:
                        payParameters['app_mode'] != 'Hajj_Qurbani' ? 50 : 70),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (payParameters['pay_type'] == 'Schdeule')
                      Container(
                        width: 140,
                        height: 41,
                        child: OutlinedButton(
                          onPressed: () async {
                            if (pay.currentState.validate()) {
                              print('schedule now pressed');
                              var endDate, startDate;
                              var endMatch = re.firstMatch(end.text);
                              if (endMatch == null) {
                                throw FormatException(
                                    'Unrecognized date format');
                              } else {
                                endDate = DateTime(
                                  int.parse(endMatch.namedGroup('year')),
                                  int.parse(endMatch.namedGroup('month')),
                                  int.parse(endMatch.namedGroup('day')),
                                );
                              }
                              var startMatch = re.firstMatch(start.text);
                              if (startMatch == null) {
                                throw FormatException(
                                    'Unrecognized date format');
                              } else {
                                startDate = DateTime(
                                  int.parse(startMatch.namedGroup('year')),
                                  int.parse(startMatch.namedGroup('month')),
                                  int.parse(startMatch.namedGroup('day')),
                                );
                                print(startDate);
                              }
                              int difference =
                                  endDate.difference(startDate).inDays;
                              print(difference);
                              if (DateTime.now().isBefore(startDate)) {
                                var today = DateTime.now();
                                print(today);
                                int diff = startDate.difference(today).inDays;
                                print('diff: $diff');
                                difference = difference + diff;
                                print('Updated Difference: $difference');
                              }
                              amount = int.parse(price.text);
                              print('converted amount $amount');
                              amount = amount * 100;
                              print(amount);
                              if(payParameters['app_mode'] == 'Ramadan'){
                                _controller.cbasketRef
                                    .where('appmode',
                                        isEqualTo: payParameters['app'])
                                    .where('userid',
                                        isEqualTo: _controller.userid.value)
                                    .where('paid', isEqualTo: 'no')
                                    .get()
                                    .then((_snapshot) {
                                  _snapshot.docs.forEach((_element) {
                                    var docid = _element.id;
                                    _controller.cbasketRef.doc(docid).update({
                                      'paid': 'yes',
                                    });
                                  });
                                });
                              }
                              _controller.scheduleRef.add({
                                'userid': _controller.userid.value,
                                'MosqueName': payParameters['mosque_name'],
                                'MosqueAddress': payParameters['m_address'],
                                'NumofDays': difference,
                                'Amount': price.text,
                                'reason': type,
                                'unicode': unicode.replaceAll('\\u', '0x'),
                                'TimeToDonate': time.text,
                                'duration': {
                                  'start': startDate,
                                  'end': endDate,
                                },
                                'appmode': payParameters['app'],
                                'Time': DateTime.now(),
                                'AppType': backgroundColor == Colors.white
                                    ? 'Hajj'
                                    : backgroundColor == loveJummahScaffold
                                        ? 'Jummah'
                                        : 'Ramadan',
                              }).then((value) async {
                                _card = setupCard(
                                  number: _controller.cardNumber.value,
                                  month: int.parse(
                                      _controller.expiry.value.split('/')[0]),
                                  eyear: int.parse(
                                      _controller.expiry.value.split('/')[1]),
                                );
                                print(_card);
                                billingAddress = BillingAddress(
                                  name: _controller.username.value,
                                  line1: _controller.addLine1.value,
                                  line2: _controller.addLine2.value,
                                  postalCode: _controller.postCode.value,
                                  city: _controller.city.value,
                                  state: _controller.state.value,
                                  country: _controller.country.value,
                                );
                                print('Billing Address: $billingAddress');
                                backgroundColor == loveJummahScaffold
                                    ? scheduleFriday(
                                        card: _card,
                                        unicode: unicode,
                                        amount: amount,
                                        time: time.text,
                                        description: type,
                                        currency: currrency,
                                        difference: difference,
                                        billingAddress: billingAddress,
                                        mosqueName:
                                            payParameters['mosque_name'],
                                        endDate: endDate,
                                        startDate: startDate,
                                        backgroundColor: backgroundColor,
                                        app: payParameters['app'],
                                      ).then((value) {
                                        showToast(
                                            message:
                                                'Donation Scheduled Successfully!');
                                        if (backgroundColor == Colors.white) {
                                          Get.offAllNamed('/hthanks');
                                        } else if (backgroundColor ==
                                            loveJummahScaffold) {
                                          Get.offAllNamed('/thanksJummah');
                                        } else if (backgroundColor ==
                                            scaffoldColor) {
                                          Get.offAllNamed('/Rthanks');
                                        }
                                      })
                                    : scheduledTimer(
                                            card: _card,
                                            amount: amount,
                                            unicode: unicode,
                                            time: time.text,
                                            description: type,
                                            currency: currrency,
                                            difference: difference,
                                            billingAddress: billingAddress,
                                            mosqueName:
                                                payParameters['mosque_name'],
                                            endDate: endDate,
                                            startDate: startDate,
                                            backgroundColor: backgroundColor,
                                            app: payParameters['app'])
                                        .then((value) {
                                        showToast(
                                            message:
                                                'Donation Scheduled Successfully!');
                                        if (backgroundColor == Colors.white) {
                                          Get.offAllNamed('/hthanks');
                                        } else if (backgroundColor ==
                                            loveJummahScaffold) {
                                          Get.offAllNamed('/thanksJummah');
                                        } else if (backgroundColor ==
                                            ramadanScaffoldColor) {
                                          Get.offAllNamed('/Rthanks');
                                        }
                                      });
                              });
                              pay.currentState.save();
                            }
                          },
                          child: appText(
                              text: 'SCHEDULE NOW',
                              color: backgroundColor == Colors.white
                                  ? htextDark
                                  : Colors.white,
                              fontSize: 12,
                              alignment: Alignment.center,
                              fontWeight: FontWeight.bold,
                              align: TextAlign.center),
                          style: outlinebutton(
                            radius: 10,
                            primary: selectColor,
                            borderColor: backgroundColor == scaffoldColor
                                ? Colors.white
                                : htextDark,
                          ),
                        ),
                      ),
                    if (payParameters['pay_type'] == 'Pay-One-Off')
                      Container(
                        width: 130,
                        height: 41,
                        child: OutlinedButton(
                          onPressed: () async {
                            if (pay.currentState.validate()) {
                              setState(() {
                                amount = int.parse(price.text);
                                print('converted amount $amount');
                                amount = amount * 100;
                                print(amount);
                                print('pay now pressed');
                                _card = setupCard(
                                  number: _controller.cardNumber.value,
                                  month: int.parse(
                                      _controller.expiry.value.split('/')[0]),
                                  eyear: int.parse(
                                      _controller.expiry.value.split('/')[1]),
                                );
                                print(_card);
                                billingAddress = BillingAddress(
                                  name: _controller.username.value,
                                  line1: _controller.addLine1.value,
                                  line2: _controller.addLine2.value,
                                  postalCode: _controller.postCode.value,
                                  city: _controller.city.value,
                                  state: _controller.state.value,
                                  country: _controller.country.value,
                                );
                                print('Billing Address: $billingAddress');
                              });
                              StripeService.payWithCard(
                                      amount: amount.toString(),
                                      currency: currrency,
                                      card: _card,
                                      description: type,
                                      name: _controller.username.value,
                                      phone: _controller.userPhone.value,
                                      email: _controller.userEmail.value,
                                      billingAddress: billingAddress)
                                  .then((transactionRespone) {
                                if (transactionRespone.success) {
                                  print('success');
                                  if (payParameters['app_mode'] ==
                                      'Hajj_Qurbani') {
                                    _controller.qbasketRef
                                        .where('appmode',
                                            isEqualTo: payParameters['app'])
                                        .where('userid',
                                            isEqualTo: _controller.userid.value)
                                        .where('paid', isEqualTo: 'no')
                                        .get()
                                        .then((_snapshot) {
                                      _snapshot.docs.forEach((_element) {
                                        var docid = _element.id;
                                        _controller.givingRef.add({
                                          'userid': _controller.userid.value,
                                          'MosqueName':
                                              _element.data()['charity_name'],
                                          'Amount': _element.data()['price'],
                                          'Reason': _element.data()['type'],
                                          'Payment Date': DateTime.now(),
                                          'Time': DateTime.now(),
                                          'appmode': payParameters['app'],
                                          'unicode':
                                              unicode.replaceAll('\\u', '0x'),
                                          'AppType':
                                              backgroundColor == Colors.white
                                                  ? 'Hajj'
                                                  : backgroundColor ==
                                                          loveJummahScaffold
                                                      ? 'Jummah'
                                                      : 'Ramadan',
                                        });
                                        _controller.qbasketRef
                                            .doc(docid)
                                            .update({
                                          'paid': 'yes',
                                        });
                                      });
                                    }).then((value) {
                                      if (backgroundColor == Colors.white) {
                                        Get.offAllNamed('/hthanks');
                                      } else if (backgroundColor ==
                                          loveJummahScaffold) {
                                        Get.offAllNamed('/thanksJummah');
                                      } else if (backgroundColor ==
                                          ramadanScaffoldColor) {
                                        Get.offAllNamed('/Rthanks');
                                      }
                                    });
                                  } else if (payParameters['app_mode'] ==
                                      'Ramadan') {
                                    _controller.cbasketRef
                                        .where('appmode',
                                            isEqualTo: payParameters['app'])
                                        .where('userid',
                                            isEqualTo: _controller.userid.value)
                                        .where('paid', isEqualTo: 'no')
                                        .get()
                                        .then((_snapshot) {
                                      _snapshot.docs.forEach((_element) {
                                        var docid = _element.id;
                                        _controller.givingRef.add({
                                          'userid': _controller.userid.value,
                                          'MosqueName':
                                              _element.data()['charity'],
                                          'Amount': _element.data()['price'],
                                          'Reason': _element.data()['type'],
                                          'Payment Date': DateTime.now(),
                                          'Time': DateTime.now(),
                                          'appmode': payParameters['app'],
                                          'unicode':
                                              unicode.replaceAll('\\u', '0x'),
                                          'AppType':
                                              backgroundColor == Colors.white
                                                  ? 'Hajj'
                                                  : backgroundColor ==
                                                          loveJummahScaffold
                                                      ? 'Jummah'
                                                      : 'Ramadan',
                                        });
                                        _controller.cbasketRef
                                            .doc(docid)
                                            .update({
                                          'paid': 'yes',
                                        });
                                      });
                                    }).then((value) {
                                      if (backgroundColor == Colors.white) {
                                        Get.offAllNamed('/hthanks');
                                      } else if (backgroundColor ==
                                          loveJummahScaffold) {
                                        Get.offAllNamed('/thanksJummah');
                                      } else if (backgroundColor ==
                                          ramadanScaffoldColor) {
                                        Get.offAllNamed('/Rthanks');
                                      }
                                    });
                                  } else {
                                    _controller.givingRef.add({
                                      'userid': _controller.userid.value,
                                      'MosqueName':
                                          payParameters['mosque_name'],
                                      'Amount': price.text,
                                      'Reason': type,
                                      'Payment Date': DateTime.now(),
                                      'Time': DateTime.now(),
                                      'appmode': payParameters['app'],
                                      'unicode':
                                          unicode.replaceAll('\\u', '0x'),
                                      'AppType': backgroundColor == Colors.white
                                          ? 'Hajj'
                                          : backgroundColor ==
                                                  loveJummahScaffold
                                              ? 'Jummah'
                                              : 'Ramadan',
                                    }).then((value) {
                                      if (backgroundColor == Colors.white) {
                                        Get.offAllNamed('/hthanks');
                                      } else if (backgroundColor ==
                                          loveJummahScaffold) {
                                        Get.offAllNamed('/thanksJummah');
                                      } else if (backgroundColor ==
                                          ramadanScaffoldColor) {
                                        Get.offAllNamed('/Rthanks');
                                      }
                                    });
                                  }
                                } else {
                                  print(transactionRespone.message);
                                  showSnackbar(
                                      title: 'Somethig went wrong!',
                                      message: 'Please try again later!');
                                }
                              });
                              pay.currentState.save();
                            }
                          },
                          child: appText(
                              text: 'PAY NOW',
                              fontSize: 13,
                              color: backgroundColor == Colors.white
                                  ? htextDark
                                  : Colors.white,
                              alignment: Alignment.center,
                              fontWeight: FontWeight.bold,
                              align: TextAlign.center),
                          style: outlinebutton(
                            radius: 10,
                            primary: selectColor,
                            borderColor: backgroundColor == scaffoldColor
                                ? Colors.white
                                : htextDark,
                          ),
                        ),
                      ),
                    Container(
                      width: 130,
                      height: 41,
                      child: OutlinedButton(
                        onPressed: () => Get.toNamed('/addCard',
                            arguments: backgroundColor,
                            parameters: {
                              'merchant_id': payParameters['merchant_id'],
                              'app': payParameters['app'],
                            }),
                        child: appText(
                            text: 'ADD CARD',
                            fontSize: payParameters['pay_type'] == 'Pay-One-Off'
                                ? 13
                                : 12.5,
                            color: backgroundColor == Colors.white
                                ? htextDark
                                : Colors.white,
                            alignment: Alignment.center,
                            fontWeight: FontWeight.bold,
                            align: TextAlign.center),
                        style: outlinebutton(
                          radius: 10,
                          primary: selectColor,
                          borderColor: backgroundColor == scaffoldColor
                              ? Colors.white
                              : htextDark,
                        ),
                      ),
                    ),
                  ],
                ),
                vspace(height: 50),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
