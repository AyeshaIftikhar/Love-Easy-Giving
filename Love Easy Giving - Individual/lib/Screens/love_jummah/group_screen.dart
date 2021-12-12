import '../../Constants/colors.dart';
import '../../Controller/app_controller.dart';
import '../../styles/button_styles.dart';
import '../../widgets/alert_widgets.dart';
import '../../widgets/app_dialogs.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/copyright.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/steam_builder.dart';
import '../../widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MosqueGroup extends StatefulWidget {
  MosqueGroup({Key key}) : super(key: key);

  @override
  _MosqueGroupState createState() => _MosqueGroupState();
}

class _MosqueGroupState extends State<MosqueGroup> {
  final MyAppController _app = Get.find();
  Color _background = Get.arguments;
  var _parameters = Get.parameters;
  String name, stripeKey, address = '';
  int isSelected;

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
              vspace(height: 30),
            Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Center(
                    child: appText(
                        text: _parameters['title'].toUpperCase(),
                        fontSize: 23,
                        alignment: Alignment.center,
                        align: TextAlign.center,
                        fontWeight: FontWeight.bold))),
            vspace(height: 30),
            StreamBuilder(
                stream: _app.searchRef
                .limit(9)
                .orderBy('searched', descending: true)
                .where('searched', isGreaterThan: 0).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return builderCommons(background: _background);
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return builderCommons(background: _background);
                  }
                  return GridView.builder(
                      padding: EdgeInsets.all(10),
                      shrinkWrap: true,
                      itemCount: 9,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 15.0,
                          mainAxisSpacing: 17.0),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (isSelected == null) {
                              setState(() {
                                isSelected = index;
                                name = snapshot.data.docs[index].get('Name');
                                address =
                                    snapshot.data.docs[index].get('Address')['City']+','+snapshot.data.docs[index].get('Address')['Street']+','+snapshot.data.docs[index].get('Address')['Area']+','+snapshot.data.docs[index].get('Address')['County']+','+snapshot.data.docs[index].get('Address')['Country'];
                                stripeKey = snapshot.data.docs[index]
                                    .get('StripeApikey');
                              });
                              print(address);
                            } else if(isSelected == index){
                              setState(() {
                                isSelected = null;
                                name = '';
                                address = '';
                                stripeKey = '';
                              });
                            }
                          },
                          child: Container(
                            width: 120,
                            height: 100,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: selectColor, width: 2),
                                borderRadius: BorderRadius.circular(12),
                                color:
                                    isSelected != index ? null : selectColor),
                            child: appText(
                              text: snapshot.data.docs[index].get('Name'),
                              fontSize: 15,
                              alignment: Alignment.center,
                              align: TextAlign.center,
                            ),
                          ),
                        );
                      });
                }),
            vspace(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 45,
                  width: 140,
                  child: OutlinedButton(
                    child: appText(
                        text: 'NEXT',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        alignment: Alignment.center),
                    onPressed: () {
                      if (name != '' && stripeKey != '' && address != '') {
                        mosqueDialog(
                          context,
                          backgroundColor: _background,
                          name: name,
                          address: address,
                          stripeKey: stripeKey,
                          buttonText: 'SCHEDULE FRIDAYS',
                          bottomText: 'SCHEDULE FRIDAYS IN ADVANCE',
                          footerText: '& NEVER MISS A JUMMAH',
                          app: _parameters['app'],
                        );
                      } else {
                        showToast(
                            message: 'Please select a Mosque to proceed.');
                      }
                    },
                    style: outlinebutton(
                      borderColor: selectColor,
                      borderwidth: 2,
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  padding: EdgeInsets.only(left: 10),
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        isSelected = null;
                        name = '';
                        address = '';
                        stripeKey = '';
                      });
                      Get.toNamed('/searchMosque',
                          arguments: _background,
                          parameters: {
                            'title': '',
                            'app_mode': _parameters['app_mode'],
                            'app': _parameters['app'],
                          });
                    },
                    child: appText(
                        text: 'SEARCH MOSQUES',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        alignment: Alignment.center),
                    style: outlinebutton(
                        borderColor: selectColor, borderwidth: 2),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
