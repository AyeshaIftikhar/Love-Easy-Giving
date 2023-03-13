import '../../Constants/colors.dart';
import '../../Controller/app_controller.dart';
import '../../styles/button_styles.dart';
import '../../widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RamadanCharities extends StatelessWidget {
  RamadanCharities({Key? key}) : super(key: key);
  final MyAppController _app = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 30,
              width: 200,
              padding: const EdgeInsets.only(right: 30),
              child: OutlinedButton.icon(
                onPressed: () => Get.toNamed('/RamadanCharities'),
                icon: const Icon(
                  Icons.edit_outlined,
                  color: Color(0xff6B5233),
                ),
                label: const TextWidget(
                  text: 'Add New Charity',
                  color: Color(0xff6B5233),
                  alignment: Alignment.center,
                ),
                style: outlinebutton(
                  borderColor: const Color(0xff6B5233),
                  radius: 10,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          StreamBuilder(
              stream: _app.charRef.snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: Get.width * .3,
                          child: Card(
                            elevation: 5.0,
                            margin: const EdgeInsets.only(
                              left: 50,
                              right: 50,
                              bottom: 10,
                            ),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: ListTile(
                              contentPadding: const EdgeInsets.only(left: 20),
                              leading: CircleAvatar(
                                radius: 20,
                                child: SizedBox(
                                  child: snapshot.data.docs[index]
                                              .get('rimage') !=
                                          ''
                                      ? Image.network(snapshot.data.docs[index]
                                          .get('rimage'))
                                      : Image.asset('assets/applogo.png'),
                                ),
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: TextWidget(
                                  text: 'Charity Name: ' +
                                      snapshot.data.docs[index].get('cName'),
                                  weight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: TextWidget(
                                  text:
                                      'Address: ${snapshot.data.docs[index].get('Address')}\nPost Code: ${snapshot.data.docs[index].get('Postcode')}\nCharity Registration Number: ${snapshot.data.docs[index].get('charityRegNo')}\nStripe Key: ${snapshot.data.docs[index].get('StripeApiKey')}',
                                  lineHeight: 1.5,
                                ),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.only(right:15.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // IconButton(
                                    //   icon: const Icon(Icons.edit_outlined, color: htextDark),
                                    //   onPressed: (){},
                                    // ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outlined, color: htextDark),
                                      onPressed: (){
                                        _app.charRef
                                            .doc(snapshot.data.docs[index].id)
                                            .delete();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(primaryDark),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(primaryDark),
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
