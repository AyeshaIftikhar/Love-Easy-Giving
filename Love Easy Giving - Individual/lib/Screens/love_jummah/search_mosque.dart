import '../../Constants/colors.dart';
import '../../Controller/app_controller.dart';
import '../../styles/button_styles.dart';
import '../../widgets/alert_widgets.dart';
import '../../widgets/app_dialogs.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/copyright.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SearchMosque extends StatelessWidget {
  SearchMosque({Key key}) : super(key: key);
  // ignore: unused_field
  final MyAppController _app = Get.find();
  Color _background = Get.arguments;
  var _parameters = Get.parameters;
  TextEditingController postcode = TextEditingController();
  TextEditingController area = TextEditingController();
  var search = GlobalKey<FormState>();
  var searched = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      persistentFooterButtons: [copyrightwidget()],
      drawer: AppDrawer(
        color: _background,
        appMode: _parameters['app_mode'],
        app: _parameters['app'],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: search,
          child: Column(
            children: [
              vspace(height: 50),
              Align(
                alignment: Alignment.topLeft,
                child: Builder(
                  builder: (context) => IconButton(
                    icon: Image.asset('assets/images/Group 215.png',
                        width: 25.23, height: 15.44),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
              ),
              vspace(height: 40),
              Container(
                child: Image.asset('assets/images/LoveJummah/group315.png'),
              ),
              vspace(height: 70),
              appText(
                  text: 'SEARCH BY POSTCODE',
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              vspace(height: 20),
              CustomTextFormField(
                maxLines: 1,
                controller: postcode,
                hint: 'ENTER POSTCODE',
                keyboardType: TextInputType.text,
                // validator: (val) {
                //   if (val.isEmpty) {
                //     return '*Required';
                //   }
                //   return null;
                // },
                decorColor: Colors.grey,
                typedTextColor: Colors.white,
                errorColor: selectColor,
                borderColor: selectColor,
                focusColor: selectColor,
                cursorColor: selectColor,
              ),
              vspace(height: 50),
              appText(
                  text: 'SEARCH BY AREA',
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              vspace(height: 20),
              CustomTextFormField(
                maxLines: 1,
                controller: area,
                hint: 'ENTER AREA',
                keyboardType: TextInputType.text,
                // validator: (val) {
                //   if (val.isEmpty) {
                //     return '*Required';
                //   }
                //   return null;
                // },
                decorColor: Colors.grey,
                typedTextColor: Colors.white,
                errorColor: selectColor,
                borderColor: selectColor,
                focusColor: selectColor,
                cursorColor: selectColor,
              ),
              vspace(height: 120),
              Container(
                  height: 50,
                  width: 150,
                  child: OutlinedButton(
                    child: appText(
                        text: 'NEXT',
                        fontSize: 13,
                        align: TextAlign.center,
                        fontWeight: FontWeight.bold,
                        alignment: Alignment.center),
                    onPressed: () {
                      if (search.currentState.validate()) {
                        if (postcode.text != '' && area.text != '') {
                          try {
                            _app.mosqueRef
                                .where('Postcode',
                                    isEqualTo: postcode.text.toUpperCase())
                                .where('Address.Area', isEqualTo: area.text)
                                .get()
                                .then((snapshot) {
                              _app.mosqueRef.doc(snapshot.docs[0].id).update({
                                'searched':
                                    snapshot.docs[0].data()['searched'] + 1,
                              });

                              _app.searchRef.doc(snapshot.docs[0].id).set({
                                'Address': snapshot.docs[0].data()['Address'],
                                'Name': snapshot.docs[0].data()['Name'],
                                'Postcode': snapshot.docs[0].data()['Postcode'],
                                'StripeApikey':
                                    snapshot.docs[0].data()['StripeApikey'],
                                'Time': DateTime.now(),
                                'regNo':
                                    snapshot.docs[0].data()['CharityRegNo'],
                                'image': snapshot.docs[0].data()['image'],
                                'searched': snapshot.docs[0].data()['searched'],
                              }).then((value) {
                                var address = snapshot.docs[0].data()['Address']
                                        ['City'] +
                                    ',' +
                                    snapshot.docs[0].data()['Address']
                                        ['Street'] +
                                    ',' +
                                    snapshot.docs[0].data()['Address']['Area'] +
                                    ',' +
                                    snapshot.docs[0].data()['Address']
                                        ['County'] +
                                    ',' +
                                    snapshot.docs[0].data()['Address']
                                        ['Country'];
                                mosqueDialog(
                                  context,
                                  backgroundColor: _background,
                                  name: snapshot.docs[0].data()['Name'],
                                  address: address,
                                  stripeKey:
                                      snapshot.docs[0].data()['StripeApikey'],
                                  buttonText: 'SCHEDULE FRIDAYS',
                                  bottomText: 'SCHEDULE FRIDAYS IN ADVANCE',
                                  footerText: '& NEVER MISS A JUMMAH',
                                  app: _parameters['app'],
                                );
                              });
                            }).catchError((e) {
                              showToast(
                                  message:
                                      'There is no data exists according to your search.\nPlease try again with other credentials.');
                              search.currentState.save();
                            });
                          } catch (e) {
                            showToast(
                                message:
                                    'There is no data exists according to your search.\nPlease try again with other credentials.');
                            search.currentState.save();
                          }
                        } else if (postcode.text != '') {
                          try {
                            _app.mosqueRef
                                .where('Postcode',
                                    isEqualTo: postcode.text.toUpperCase())
                                .get()
                                .then((snapshot) {
                              _app.mosqueRef.doc(snapshot.docs[0].id).update({
                                'searched':
                                    snapshot.docs[0].data()['searched'] + 1,
                              });

                              _app.searchRef.doc(snapshot.docs[0].id).set({
                                'Address': snapshot.docs[0].data()['Address'],
                                'Name': snapshot.docs[0].data()['Name'],
                                'Postcode': snapshot.docs[0].data()['Postcode'],
                                'StripeApikey':
                                    snapshot.docs[0].data()['StripeApikey'],
                                'Time': DateTime.now(),
                                'regNo':
                                    snapshot.docs[0].data()['CharityRegNo'],
                                'image': snapshot.docs[0].data()['image'],
                                'searched': snapshot.docs[0].data()['searched'],
                              }).then((value) {
                                var address = snapshot.docs[0].data()['Address']
                                        ['City'] +
                                    ',' +
                                    snapshot.docs[0].data()['Address']
                                        ['Street'] +
                                    ',' +
                                    snapshot.docs[0].data()['Address']['Area'] +
                                    ',' +
                                    snapshot.docs[0].data()['Address']
                                        ['County'] +
                                    ',' +
                                    snapshot.docs[0].data()['Address']
                                        ['Country'];
                                mosqueDialog(
                                  context,
                                  backgroundColor: _background,
                                  name: snapshot.docs[0].data()['Name'],
                                  address: address,
                                  stripeKey:
                                      snapshot.docs[0].data()['StripeApikey'],
                                  buttonText: 'SCHEDULE FRIDAYS',
                                  bottomText: 'SCHEDULE FRIDAYS IN ADVANCE',
                                  footerText: '& NEVER MISS A JUMMAH',
                                  app: _parameters['app'],
                                );
                              });
                            }).catchError((e) {
                              showToast(
                                  message:
                                      'There is no data exists according to your search.\nPlease try again with other credentials.');
                              search.currentState.save();
                            });
                          } catch (e) {
                            showToast(
                                message:
                                    'There is no data exists according to your search.\nPlease try again with other credentials.');
                            search.currentState.save();
                          }
                        } else if (area.text != '') {
                          try {
                            _app.mosqueRef
                              ..where("Adress.Area", isEqualTo: area.text)
                                  .get()
                                  .then((snapshot) {
                                print(snapshot.docs[0].id);
                                _app.mosqueRef.doc(snapshot.docs[0].id).update({
                                  'searched':
                                      snapshot.docs[0].data()['searched'] + 1,
                                });

                                _app.searchRef.doc(snapshot.docs[0].id).set({
                                  'Address': snapshot.docs[0].data()['Address'],
                                  'Name': snapshot.docs[0].data()['Name'],
                                  'Postcode':
                                      snapshot.docs[0].data()['Postcode'],
                                  'StripeApikey':
                                      snapshot.docs[0].data()['StripeApikey'],
                                  'Time': DateTime.now(),
                                  'regNo':
                                      snapshot.docs[0].data()['CharityRegNo'],
                                  'image': snapshot.docs[0].data()['image'],
                                  'searched':
                                      snapshot.docs[0].data()['searched'],
                                }).then((value) {
                                  var address = snapshot.docs[0]
                                          .data()['Address']['City'] +
                                      ',' +
                                      snapshot.docs[0].data()['Address']
                                          ['Street'] +
                                      ',' +
                                      snapshot.docs[0].data()['Address']
                                          ['Area'] +
                                      ',' +
                                      snapshot.docs[0].data()['Address']
                                          ['County'] +
                                      ',' +
                                      snapshot.docs[0].data()['Address']
                                          ['Country'];
                                  mosqueDialog(
                                    context,
                                    backgroundColor: _background,
                                    name: snapshot.docs[0].data()['Name'],
                                    address: address,
                                    stripeKey:
                                        snapshot.docs[0].data()['StripeApikey'],
                                    buttonText: 'SCHEDULE FRIDAYS',
                                    bottomText: 'SCHEDULE FRIDAYS IN ADVANCE',
                                    footerText: '& NEVER MISS A JUMMAH',
                                    app: _parameters['app'],
                                  );
                                });
                              });
                            // }).catchError((e) {
                            //   print("Error: $e");
                            //   showToast(
                            //       message:
                            //           'There is no data exists according to your search.\nPlease try again with other credentials.');
                            //   search.currentState.save();
                            // });
                          } catch (e) {
                            print("Error: $e");
                            showToast(
                                message:
                                    'There is no data exists according to your search.\nPlease try again with other credentials.');
                            search.currentState.save();
                          }
                        } else {
                          showToast(
                              message:
                                  'There is no data exists according to your search.\nPlease try again with other credentials.');
                          search.currentState.save();
                        }
                        search.currentState.save();
                      }
                    },
                    style: outlinebutton(
                      borderColor: selectColor,
                      borderwidth: 2,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
