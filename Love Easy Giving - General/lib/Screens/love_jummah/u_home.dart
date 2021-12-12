import 'package:leggenerral/widgets/copyright.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/app_controller.dart';
import '../../Constants/colors.dart';
import '../../widgets/steam_builder.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/app_dialogs.dart';
import '../../widgets/text_widget.dart';

class UHome extends StatefulWidget {
  @override
  _UHomeState createState() => _UHomeState();
}

class _UHomeState extends State<UHome> {
  final MyAppController _appController = Get.find();
  var _parameters = Get.parameters;
  var _background = Get.arguments;

  @override
  void initState() {
    super.initState();
    _appController.isFireStoreConnected().then((value) {
      // print(_appController.isRamadan.value);
      // print(_appController.isHajj.value);
      // print(_appController.isJummah.value);
      // print(_appController.username.value);
      // print(_appController.userPhone.value);
      // print(_appController.addLine1.value);
      // print(_appController.addLine2.value);
      // print(_appController.city.value);
      // print(_appController.state.value);
      // print(_appController.country.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      persistentFooterButtons: [copyrightwidget()],
      appBar: AppBar(
        title: appText(
          text: _parameters['title'],
          fontSize: 17,
          color: _background == Colors.white ? selectColor : Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      drawer: AppDrawer(
        color: _background,
        appMode: _parameters['app_mode'],
        app: _parameters['app'],
      ),
      body: StreamBuilder(
        stream: _appController.mosqueRef.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return builderCommons(background: _background);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return builderCommons(background: _background);
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              print(snapshot.data.docs[index].get('image'));
              return Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(5.0),
                  leading: Container(
                      width: 50,
                      child: Image.network(
                          snapshot.data.docs[index].get('image'))),
                  title: Text(snapshot.data.docs[index].get('Name'),
                      style: TextStyle(
                          fontFamily: 'Futura',
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                  subtitle: Text(
                      snapshot.data.docs[index].get('Address')['City'] +
                          ',' +
                          snapshot.data.docs[index].get('Address')['Street'] +
                          ',' +
                          snapshot.data.docs[index].get('Address')['Area'] +
                          ',' +
                          snapshot.data.docs[index].get('Address')['County'] +
                          ',' +
                          snapshot.data.docs[index].get('Address')['Country'],
                      style: TextStyle(
                        fontFamily: 'Futura',
                        fontSize: 12,
                      )),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xffB08850),
                  ),
                  onTap: () => mosqueDialog(
                    context,
                    app: _parameters['app'],
                    backgroundColor: _background,
                    name: snapshot.data.docs[index].get('Name'),
                    logo: snapshot.data.docs[index].get('image'),
                    address: snapshot.data.docs[index].get('Address')['City'] +
                        ',' +
                        snapshot.data.docs[index].get('Address')['Street'] +
                        ',' +
                        snapshot.data.docs[index].get('Address')['Area'] +
                        ',' +
                        snapshot.data.docs[index].get('Address')['County'] +
                        ',' +
                        snapshot.data.docs[index].get('Address')['Country'],
                    stripeKey: snapshot.data.docs[index].get(
                        'StripeApikey'), // it will be the merchant id of the charity
                    buttonText: _parameters['app_mode'] == 'Jummah'
                        ? 'SCHEDULE FRIDAYS'
                        : 'SCHEDULE SADQAH',
                    bottomText: _parameters['app_mode'] == 'Jummah'
                        ? 'SCHEDULE FRIDAYS IN ADVANCE'
                        : '',
                    footerText: _parameters['app_mode'] == 'Jummah'
                        ? '& NEVER MISS A JUMMAH'
                        : '',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
