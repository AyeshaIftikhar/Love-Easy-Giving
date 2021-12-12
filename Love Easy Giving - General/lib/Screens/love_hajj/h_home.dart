import 'package:leggenerral/widgets/alert_widgets.dart';
import 'package:leggenerral/widgets/copyright.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Constants/colors.dart';
import '../../Controller/app_controller.dart';
import '../../styles/button_styles.dart';
import '../../widgets/steam_builder.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/text_widget.dart';

class HajjHome extends StatefulWidget {
  @override
  _HajjHomeState createState() => _HajjHomeState();
}

class _HajjHomeState extends State<HajjHome> {
  final MyAppController _controller = Get.find();
  Color _background = Get.arguments;
  var _parameters = Get.parameters;
  String name, address, price, stripeKey, image, pack;
  int isSelected;
  final MyAppController _appController = Get.find();
  @override
  void initState() {
    super.initState();
    _appController.isFireStoreConnected().then((value) {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      persistentFooterButtons: [copyrightwidget(color: htextDark)],
      drawer: AppDrawer(
        color: _background,
        appMode: _parameters['app_mode'],
        app: _parameters['app'],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
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
              vspace(height: 20),
              appText(
                  text: _parameters['title'],
                  fontSize: 28,
                  color: htextDark,
                  align: TextAlign.center,
                  alignment: Alignment.center,
                  fontWeight: FontWeight.bold),
              vspace(height: 30),
              _parameters['mode'] == 'charity'
                  ? StreamBuilder(
                      stream: _controller.charRef.snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return builderCommons(background: _background);
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return builderCommons(background: _background);
                        }
                        return GridView.builder(
                            padding: EdgeInsets.all(10),
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 13,
                                    mainAxisSpacing: 15),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isSelected == null) {
                                      isSelected = index;
                                      name = snapshot.data.docs[index]
                                          .get('cName');
                                      address = snapshot.data.docs[index]
                                          .get('Address');
                                      stripeKey = snapshot.data.docs[index]
                                          .get('StripeApiKey');
                                      image = snapshot.data.docs[index]
                                          .get('rimage');
                                    } else if (isSelected == index) {
                                      isSelected = null;
                                      name = null;
                                      address = null;
                                      stripeKey = null;
                                      image = null;
                                    }
                                  });
                                },
                                child: Container(
                                  height: 101,
                                  width: 102,
                                  padding: EdgeInsets.only(
                                      left: 7, right: 7, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                    color: isSelected != index
                                        ? index == 4
                                            ? Color(0xffAF874F).withOpacity(0.5)
                                            : Colors.black.withOpacity(0.7)
                                        : selectColor,
                                    border: Border.all(
                                        color: selectColor, width: 2.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 15.0),
                                        child: appText(
                                          text: snapshot.data.docs[index]
                                              .get('cName')
                                              .toString()
                                              .split(' ')[0],
                                          fontSize: 10,
                                          align: TextAlign.center,
                                          alignment: Alignment.center,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      appText(
                                        text: snapshot.data.docs[index]
                                            .get('cName')
                                            .toString()
                                            .split(' ')[1],
                                        fontSize: 10,
                                        align: TextAlign.center,
                                        alignment: Alignment.center,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      appText(
                                        text: snapshot.data.docs[index]
                                            .get('cName')
                                            .toString()
                                            .split(' ')[2],
                                        fontSize: 10,
                                        align: TextAlign.center,
                                        alignment: Alignment.center,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      })
                  : StreamBuilder(
                      stream: _controller.charityRef.snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return builderCommons(background: _background);
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return builderCommons(background: _background);
                        }
                        return GridView.builder(
                            padding: EdgeInsets.all(10),
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 13,
                                    mainAxisSpacing: 15),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    stripeKey = snapshot.data.docs[index]
                                        .get('StripeApiKey');
                                  });
                                  try {
                                    _controller.qbasketRef.add({
                                      'added_time': DateTime.now(),
                                      'unicode': '0x00A3',
                                      'appmode': _parameters['app'],
                                      'userid': _controller.userid.value,
                                      'paid': 'no',
                                      'price': snapshot.data.docs[index]
                                          .get('basketPrice'),
                                      'charity_name':
                                          snapshot.data.docs[index].get('Name'),
                                      'charity_address': snapshot
                                          .data.docs[index]
                                          .get('Address'),
                                      'type':
                                          snapshot.data.docs[index].get('type'),
                                      'number_of_pack': '1',
                                      'initial_price': int.parse(snapshot
                                          .data.docs[index]
                                          .get('basketPrice')),
                                      'stripekey': snapshot.data.docs[index]
                                          .get('StripeApiKey'),
                                    }).then((value) {
                                      showToast(
                                          message:
                                              'Item added to cart successfully.\nClick on Pay Now to proceed further.');
                                    });
                                  } catch (e) {
                                    print('Qurbani Cart Exception: $e');
                                    showToast(
                                        message:
                                            'Something went wrong. Plrase try again later.');
                                  }
                                },
                                child: Container(
                                  height: 101,
                                  width: 102,
                                  padding: EdgeInsets.only(
                                      left: 7, right: 7, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                    color:
                                        index == 0 || index == 6 || index == 8
                                            ? htextDark.withOpacity(0.75)
                                            : Colors.black.withOpacity(0.6),
                                    border: Border.all(
                                        color: selectColor, width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/lamb.png'),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      appText(
                                        text: '\u00A3' +
                                            snapshot.data.docs[index]
                                                .get('basketPrice'),
                                        fontSize: 10,
                                        align: TextAlign.center,
                                        alignment: Alignment.center,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      appText(
                                        text: snapshot.data.docs[index]
                                            .get('Name')
                                            .toString()
                                            .split(' ')[0],
                                        fontSize: 10,
                                        align: TextAlign.center,
                                        alignment: Alignment.center,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      appText(
                                        text: snapshot.data.docs[index]
                                            .get('Name')
                                            .toString()
                                            .split(' ')[1],
                                        fontSize: 10,
                                        align: TextAlign.center,
                                        alignment: Alignment.center,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      appText(
                                        text: snapshot.data.docs[index]
                                            .get('Name')
                                            .toString()
                                            .split(' ')[2],
                                        fontSize: 10,
                                        align: TextAlign.center,
                                        alignment: Alignment.center,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }),
              vspace(height: 30),
              // if (_parameters['mode'] == 'qurbani')
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Container(
              //         width: 150,
              //         height: 49,
              //         padding: EdgeInsets.all(10),
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10.0),
              //           border: Border.all(color: selectColor, width: 2.0),
              //         ),
              //         child: Center(
              //           child: DropdownButtonHideUnderline(
              //             child: DropdownButton<String>(
              //               style: TextStyle(
              //                   color: htextDark, fontFamily: 'Futura'),
              //               isExpanded: false,
              //               items: <String>[
              //                 '1',
              //                 '2',
              //                 '3',
              //                 '4',
              //                 '5',
              //                 '6',
              //                 '7',
              //                 '8',
              //                 '9',
              //               ].map((String value) {
              //                 return DropdownMenuItem(
              //                   value: value,
              //                   child: appText(
              //                     text: value,
              //                     fontSize: 12,
              //                     color: Colors.black,
              //                   ),
              //                 );
              //               }).toList(),
              //               onChanged: (val) {
              //                 setState(() {
              //                   pack = val;
              //                 });
              //               },
              //               hint: appText(
              //                   text: 'Add Food Pack',
              //                   fontSize: 14,
              //                   color: htextDark,
              //                   fontWeight: FontWeight.bold,
              //                   alignment: Alignment.center,
              //                   align: TextAlign.center),
              //               iconSize: 0.0,
              //             ),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 49,
              //         width: 150,
              //         padding: EdgeInsets.only(left: 05),
              //         child: OutlinedButton(
              //           child: appText(
              //               text: 'ADD SADQAH',
              //               fontSize: 14,
              //               color: htextDark,
              //               fontWeight: FontWeight.bold,
              //               alignment: Alignment.center,
              //               align: TextAlign.center),
              //           onPressed: () {
              //             setState(() {
              //               setState(() {
              //                 isSelected = null;
              //                 name = null;
              //                 address = null;
              //                 stripeKey = null;
              //                 image = null;
              //                 _parameters['title'] = 'CHOOSE YOUR CHARITY';
              //                 _parameters['mode'] = 'charity';
              //               });
              //             });
              //           },
              //           style: outlinebutton(
              //             borderColor: selectColor,
              //             borderwidth: 2,
              //             radius: 10,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              if (_parameters['mode'] == 'qurbani') vspace(height: 10),
              if (_parameters['mode'] == 'qurbani')
                Container(
                  width: 110,
                  height: 41,
                  child: OutlinedButton(
                    child: appText(
                        text: 'PAY NOW',
                        fontSize: 13,
                        color: htextDark,
                        fontWeight: FontWeight.bold,
                        alignment: Alignment.center,
                        align: TextAlign.center),
                    onPressed: () {
                      Get.toNamed(
                        '/basket',
                        arguments: _background,
                        parameters: {
                          'app_mode': _parameters['app_mode'],
                          'app': _parameters['app'],
                          'mode': _parameters['mode'],
                          'unicode': '0x00A3',
                          'stripekey': stripeKey,
                        },
                      );
                    },
                    style: outlinebutton(
                      borderColor: htextDark,
                      borderwidth: 1.5,
                      radius: 10,
                    ),
                  ),
                ),
              if (_parameters['mode'] == 'charity')
                Container(
                  width: 140,
                  height: 41,
                  child: OutlinedButton(
                    child: appText(
                        text: 'SCHEDULE NOW',
                        fontSize: 12,
                        color: htextDark,
                        fontWeight: FontWeight.bold,
                        alignment: Alignment.center,
                        align: TextAlign.center),
                    onPressed: () {
                      print(name);
                      print(image);
                      if (name != null &&
                          address != null &&
                          stripeKey != null &&
                          image != null) {
                        Get.toNamed('/selectCard',
                            arguments: _background,
                            parameters: {
                              'm_name': name,
                              'address': address,
                              'pay_type': 'Schdeule',
                              'stripeKey': stripeKey,
                              'amount': '',
                              'app_mode': 'Hajj_Sadqah',
                              'charity_cause': '',
                              'cause_name': '',
                              'app': _parameters['app'],
                            });
                        // hajjDialog(
                        //   context,
                        //   name: name,
                        //   address: address,
                        //   stripeKey: stripeKey,
                        //   mode: _parameters['mode'],
                        //   logo: image,
                        //   bottomText: 'SCHEDULE SADQAH IN ADVANCE',
                        //   app: _parameters['app'],
                        // );
                      } else {
                        Get.snackbar(
                            'Attention!', "Please select a charity to proceed.",
                            colorText: selectColor);
                      }
                    },
                    style: outlinebutton(
                      borderColor: htextDark,
                      borderwidth: 2,
                      radius: 10,
                    ),
                  ),
                ),
              vspace(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
