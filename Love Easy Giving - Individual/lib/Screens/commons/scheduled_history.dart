import '../../styles/button_styles.dart';
import '../../widgets/alert_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Constants/colors.dart';
import '../../Controller/app_controller.dart';
import '../../Strip_Payments/scheduled_timer.dart';
import '../../widgets/steam_builder.dart';
import '../../widgets/text_widget.dart';

// ignore: must_be_immutable
class ScheduledHistory extends StatelessWidget {
  final MyAppController _controller = MyAppController();
  Color backgroundColor;
  String userid;
  String appmode;
  String pound = '\u00A3';
  String app;
  ScheduledHistory({
    @required this.backgroundColor,
    @required this.userid,
    @required this.appmode,
    @required this.app,
  });
  @override
  Widget build(BuildContext context) {
    print('Scheduled:' + userid);
    return StreamBuilder(
        stream: _controller.scheduleRef
            .where('userid', isEqualTo: userid)
            .where('AppType', isEqualTo: appmode)
            .where('appmode', isEqualTo: app)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return builderCommons(background: backgroundColor);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return builderCommons(background: backgroundColor);
          }
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                var pound = String.fromCharCode(
                    int.parse(snapshot.data.docs[index].get('unicode')));
                print(pound);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 112,
                        width: 257,
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 20, right: 20, bottom: 5),
                        child: Column(
                          children: [
                            appText(
                                text:
                                    snapshot.data.docs[index].get('MosqueName'),
                                fontSize: 15,
                                color: backgroundColor == Colors.white
                                    ? htextDark
                                    : Colors.white,
                                align: TextAlign.center,
                                alignment: Alignment.center,
                                fontWeight: FontWeight.bold),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 5.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  appText(
                                    text: NumberFormat.currency(symbol: pound)
                                        .format(int.parse(snapshot
                                            .data.docs[index]
                                            .get('Amount')))
                                        .toString(),
                                    fontSize: 12,
                                    color: backgroundColor == Colors.white
                                        ? htextDark
                                        : Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: appText(
                                        text: DateFormat('dd MMMM, yyyy')
                                            .format(snapshot.data.docs[index]
                                                .get('duration')['start']
                                                .toDate()),
                                        fontSize: 12,
                                        color: backgroundColor == Colors.white
                                            ? htextDark
                                            : Colors.white,
                                        align: TextAlign.center,
                                        alignment: Alignment.center),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: appText(
                                        text: snapshot.data.docs[index]
                                            .get('reason'),
                                        fontSize: 12,
                                        color: backgroundColor == Colors.white
                                            ? htextDark
                                            : Colors.white,
                                        align: TextAlign.end,
                                        alignment: Alignment.topRight),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment:  Alignment.center,
                              child: Container(
                                width: 160,
                                padding: EdgeInsets.only(top: 3),
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 5),
                                child: ElevatedButton(
                                  style: elevatedButton(
                                    primary:
                                        backgroundColor == loveJummahScaffold
                                            ? Colors.grey
                                            : selectColor,
                                  ),
                                  onPressed: () async {
                                    _controller.cancelPaymentRef.add({
                                      'userid': userid,
                                      'MosqueName': snapshot.data.docs[index]
                                          .get('MosqueName'),
                                      'Amount': snapshot.data.docs[index]
                                          .get('Amount'),
                                      'duration': snapshot.data.docs[index]
                                          .get('duration'),
                                      'reason': snapshot.data.docs[index]
                                          .get('reason'),
                                      'CancellationTime': DateTime.now(),
                                      'AppType': appmode,
                                      'appmode': app,
                                      'unicode': snapshot.data.docs[index]
                                          .get('unicode')
                                    });
                                    _controller.scheduleRef
                                        .doc(snapshot.data.docs[index].id)
                                        .delete()
                                        .then((value) async {
                                      timer.cancel();
                                      print('Cancelled');
                                      showToast(
                                          message:
                                              "Scheduled donation has been cancelled successfully!");
                                    });
                                  },
                                  child: appText(
                                      alignment: Alignment.center,
                                      text: 'CANCEL PAYMENT',
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1.5,
                        color: backgroundColor == Colors.white
                            ? Colors.grey
                            : Colors.white,
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
