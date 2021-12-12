import 'package:leggenerral/widgets/copyright.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../Controller/app_controller.dart';
import '../../Constants/colors.dart';
import '../../styles/button_styles.dart';
import '../../widgets/alert_widgets.dart';
import '../../widgets/const_widgets.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/text_widget.dart';

class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final MyAppController _controller = Get.find();
  var backgroundColor = Get.arguments;
  // ignore: unused_field
  var _parameters = Get.parameters;
  var addCard = GlobalKey<FormState>();
  TextEditingController cname = TextEditingController();
  TextEditingController cnumber = TextEditingController();
  TextEditingController expiry = TextEditingController();
  TextEditingController csv = TextEditingController();

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
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Form(
          key: addCard,
          child: Column(
            children: [
              vspace(height: 50),
              customTop(
                  color: selectColor,
                  text: 'Add Card',
                  fontSize: 17,
                  textColor: backgroundColor == Colors.white
                      ? selectColor
                      : Colors.white,
                  fontWeight: FontWeight.bold),
              vspace(height: 10),
              // Container(
              //   margin: EdgeInsets.only(
              //     top: 30,
              //   ),
              //   decoration: BoxDecoration(
              //     color: selectColor,
              //     border: Border.all(color: hborder),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Column(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.only(top: 35.0),
              //         child: appText(
              //             text: '0000\t0000\t0000\t0000',
              //             fontSize: 18.5,
              //             align: TextAlign.center,
              //             fontWeight: FontWeight.w500,
              //             alignment: Alignment.center),
              //       ),
              //       Padding(
              //         padding:
              //             const EdgeInsets.only(top: 10.0, right: 20),
              //         child: appText(
              //             text: 'Expiry Date',
              //             fontSize: 15,
              //             align: TextAlign.center,
              //             fontWeight: FontWeight.w500,
              //             alignment: Alignment.topRight),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.only(top: 5.0, right: 50),
              //         child: appText(
              //             text: '20/10',
              //             fontSize: 16,
              //             align: TextAlign.left,
              //             fontWeight: FontWeight.w500,
              //             alignment: Alignment.topRight),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.only(left: 20),
              //         child: appText(
              //             text: 'Card Holder Name',
              //             fontSize: 14,
              //             align: TextAlign.left,
              //             fontWeight: FontWeight.w500,
              //             alignment: Alignment.topLeft),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.only(top: 7, left: 20),
              //         child: appText(
              //             text: 'John Doe',
              //             fontSize: 17,
              //             align: TextAlign.left,
              //             fontWeight: FontWeight.w500,
              //             alignment: Alignment.topLeft),
              //       ),
              //       vspace(height: 25),
              //     ],
              //   ),
              // ),
              vspace(height: 20),
              Column(
                children: [
                  CustomTextFormField(
                    label: 'CARD NUMBER',
                    maxLines: 1,
                    maxLength: 16,
                    hfont: 14,
                    controller: cnumber,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    lengthEnforcement: MaxLengthEnforcement.enforced,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (val) {
                      if (val.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    decorColor: Colors.grey,
                    errorColor: backgroundColor == scaffoldColor
                        ? Colors.white
                        : selectColor,
                    counterColor: backgroundColor == scaffoldColor
                        ? Colors.white
                        : selectColor,
                    borderColor: backgroundColor == scaffoldColor
                        ? Colors.white
                        : selectColor,
                    cursorColor: backgroundColor == scaffoldColor
                        ? Colors.white
                        : selectColor,
                    focusColor: backgroundColor == scaffoldColor
                        ? Colors.white
                        : selectColor,
                    typedTextColor: backgroundColor == Colors.white
                        ? htextDark
                        : Colors.white,
                  ),
                  CustomTextFormField(
                    maxLines: 1,
                    hfont: 14,
                    label: 'CARD HOLDER NAME',
                    controller: cname,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (val) {
                      if (val.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    decorColor: Colors.grey,
                    errorColor: backgroundColor == scaffoldColor
                        ? Colors.white
                        : selectColor,
                    borderColor: backgroundColor == scaffoldColor
                        ? Colors.white
                        : selectColor,
                    cursorColor: backgroundColor == scaffoldColor
                        ? Colors.white
                        : selectColor,
                    focusColor: backgroundColor == scaffoldColor
                        ? Colors.white
                        : selectColor,
                    typedTextColor: backgroundColor == Colors.white
                        ? htextDark
                        : Colors.white,
                  ),
                  CustomTextFormField(
                    maxLines: 1,
                    hfont: 14,
                    label: 'EXPIRY DATE',
                    controller: expiry,
                    keyboardType: TextInputType.datetime,
                    textInputAction: TextInputAction.next,
                    validator: (val) {
                      if (val.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    decorColor: Colors.grey,
                    errorColor: backgroundColor == scaffoldColor
                        ? Colors.white
                        : selectColor,
                    borderColor: backgroundColor == scaffoldColor
                        ? Colors.white
                        : selectColor,
                    cursorColor: backgroundColor == scaffoldColor
                        ? Colors.white
                        : selectColor,
                    focusColor: backgroundColor == scaffoldColor
                        ? Colors.white
                        : selectColor,
                    typedTextColor: backgroundColor == Colors.white
                        ? htextDark
                        : Colors.white,
                  ),
                  CustomTextFormField(
                    maxLines: 1,
                    hfont: 14,
                    label: 'SECUIRTY CODE',
                    maxLength: 3,
                    controller: csv,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    lengthEnforcement: MaxLengthEnforcement.enforced,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (val) {
                      if (val.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    decorColor: Colors.grey,
                    counterColor: backgroundColor == scaffoldColor
                        ? Colors.white
                        : selectColor,
                    errorColor: backgroundColor == scaffoldColor
                        ? Colors.white
                        : selectColor,
                    borderColor: backgroundColor == scaffoldColor
                        ? Colors.white
                        : selectColor,
                    cursorColor: backgroundColor == scaffoldColor
                        ? Colors.white
                        : selectColor,
                    focusColor: backgroundColor == scaffoldColor
                        ? Colors.white
                        : selectColor,
                    typedTextColor: backgroundColor == Colors.white
                        ? htextDark
                        : Colors.white,
                  ),
                  vspace(height: 30),
                  Container(
                    width: 130,
                    height: 41,
                    child: OutlinedButton(
                      child: appText(
                          text: 'ADD CARD',
                          color: backgroundColor == Colors.white
                              ? htextDark
                              : Colors.white,
                          fontSize: 13,
                          align: TextAlign.center,
                          alignment: Alignment.center,
                          fontWeight: FontWeight.bold),
                      onPressed: () {
                        try {
                          print('pressed');
                          print(addCard.currentState.validate());
                          if (addCard.currentState.validate()) {
                            print('schedule now pressed');
                            print(cnumber.text);
                            print(cname.text);
                            print(expiry.text);
                            print(csv.text);
                            try {
                              _controller.cardRef.add({
                                'userid': _controller.userid.value,
                                'card_number': cnumber.text,
                                'holder_name': cname.text,
                                'csv': csv.text,
                                'expiry_date': expiry.text,
                                'Time': DateTime.now(),
                                'appmode': _parameters['app'],
                              }).then((snapshot) {
                                showToast(message: 'Card added successfully.');
                                _controller.cardNumber.value = cnumber.text;
                                _controller.holderName.value = cname.text;
                                _controller.expiry.value = expiry.text;
                                Get.back();
                              });
                            } catch (e) {
                              print('Add Card to Firebase Exception: $e');
                              showToast(
                                  message:
                                      'Something went wrong. Try again later.');
                            }
                            addCard.currentState.save();
                          }
                        } catch (e) {
                          print(e);
                          showSnackbar(
                              title: 'Something went wrong.',
                              message: 'Please try again later.');
                        }
                      },
                      style: outlinebutton(
                        borderwidth: 2,
                        borderColor: backgroundColor == scaffoldColor
                            ? Colors.white
                            : htextDark,
                      ),
                    ),
                  ),
                  vspace(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
