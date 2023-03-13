import '../../Constants/colors.dart';
import '../../Controller/app_controller.dart';
import '../../widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class History extends StatefulWidget {
  History({Key? key, required this.appType, required this.appMode})
      : super(key: key);
  String appType;
  String appMode;

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final MyAppController _app = Get.find();
  List username = [];
  @override
  void initState() {
    // getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          StreamBuilder(
              stream: _app.givingRef
                  .where('AppType', isEqualTo: widget.appType)
                  .where('appmode', isEqualTo: widget.appMode)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(primaryDark),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (context, index) {

                        _app.userRef
                            .where('userid',
                                isEqualTo:
                                    snapshot.data.docs[index].get('userid'))
                            .get()
                            .then((value) {
                          if (value.docs.isNotEmpty) {
                            for (var doc in value.docs) {
                              setState(() {
                                username.add(doc.data()['name']);
                              });
                            }
                          }
                        }).catchError((e) {
                          // ignore: invalid_return_type_for_catch_error
                          return const SizedBox(
                              child: Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(primaryDark),
                            ),
                          ));
                        });
                          var pound = String.fromCharCode(
                  int.parse(snapshot.data.docs[index].get('unicode')));
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
                                  child: Image.asset('assets/applogo.png'),
                                ),
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: TextWidget(
                                  text: 'Charity/Mosque Name: ' +
                                      snapshot.data.docs[index]
                                          .get('MosqueName'),
                                  weight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: TextWidget(
                                  text:
                                      'Donated by: ${username[index]}\nDonation Amount: ${NumberFormat.currency(symbol: pound)
                                      .format(int.parse(snapshot
                                          .data.docs[index]
                                          .get('Amount')))
                                      .toString()}\nReason of Donation: ${snapshot.data.docs[index].get('Reason')}\nDonation Date: ${DateFormat('dd MMMM,yyyy').format(snapshot.data.docs[index].get('Payment Date').toDate()).toString()}\n',
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
    );
  }
}
