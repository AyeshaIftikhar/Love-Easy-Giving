import '../../Constants/colors.dart';
import '../../Controller/app_controller.dart';
import '../../styles/button_styles.dart';
import '../../widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndividualMosques extends StatelessWidget {
  IndividualMosques({Key? key}) : super(key: key);

  final MyAppController _app = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 30,
              width: 250,
              padding: const EdgeInsets.only(right: 30),
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit_outlined,
                  color: Color(0xff6B5233),
                ),
                label: const TextWidget(
                  text: 'Add New Mosque',
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
          const SizedBox(height: 20),
          StreamBuilder(
              stream: _app.mosqueRef.snapshots(),
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
                                              .get('image') !=
                                          ''
                                      ? Image.network(snapshot.data.docs[index]
                                          .get('image'))
                                      : Image.asset('assets/applogo.png'),
                                ),
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: TextWidget(
                                  text: 'Mosque Name: ' +
                                      snapshot.data.docs[index].get('Name'),
                                  weight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: TextWidget(
                                  text:
                                      'Address: ${snapshot.data.docs[index]['Address']['Street']},${snapshot.data.docs[index]['Address']['Area']},${snapshot.data.docs[index]['Address']['City']},${snapshot.data.docs[index]['Address']['County']},${snapshot.data.docs[index]['Address']['Country']}\nPost Code: ${snapshot.data.docs[index].get('Postcode')}\nCharity Registration Number: ${snapshot.data.docs[index].get('CharityRegNo')}\nStripe Key: ${snapshot.data.docs[index].get('StripeApikey')}\n',
                                  lineHeight: 1.5,
                                ),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // IconButton(
                                    //   icon: const Icon(Icons.edit_outlined,
                                    //       color: htextDark),
                                    //   onPressed: () {},
                                    // ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outlined,
                                          color: htextDark),
                                      onPressed: () {
                                        _app.mosqueRef
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
