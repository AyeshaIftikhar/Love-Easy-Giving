import '../../Constants/colors.dart';
import '../../Controller/app_controller.dart';
import '../../widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppUsers extends StatelessWidget {
  AppUsers({Key? key}) : super(key: key);
  final MyAppController _app = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white.withAlpha(0),
        title: const TextWidget(
          text: 'Love Easy Giving - Users',
          weight: FontWeight.bold,
          alignment: Alignment.center,
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios, color: htextDark),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const SizedBox(height: 10),
            StreamBuilder(
                stream: _app.userRef.snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
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
                                leading: const CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage(
                                    'assets/applogo.png',
                                  ),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: TextWidget(
                                    text: snapshot.data.docs[index].get('name'),
                                    weight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: TextWidget(
                                    text: 'Email: ${snapshot.data.docs[index].get('email')}\nPhone Number: ${snapshot.data.docs[index].get('phoneNo')}\nTax Payer: ${snapshot.data.docs[index].get('taxpayer')}\nAddress: ${snapshot.data.docs[index]['address']['line1']},${snapshot.data.docs[index]['address']['line2']},${snapshot.data.docs[index]['address']['city']},${snapshot.data.docs[index]['address']['state']},${snapshot.data.docs[index]['address']['country']},\nPost Code: ${snapshot.data.docs[index]['postCode']}',
                                    lineHeight: 1.5,
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
      ),
    );
  }
}
