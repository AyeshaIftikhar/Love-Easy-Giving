import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Constants/colors.dart';
import '../../Controller/app_controller.dart';
import '../../widgets/steam_builder.dart';
import '../../widgets/text_widget.dart';

// ignore: must_be_immutable
class PaidHistory extends StatelessWidget {
  final MyAppController _controller = MyAppController();
  Color backgroundColor;
  String userid;
  String appmode;
  String app;
  PaidHistory({
    @required this.backgroundColor,
    @required this.userid,
    @required this.appmode,
    @required this.app,
  });
  @override
  Widget build(BuildContext context) {
    print('Paid History:' + userid);
    return StreamBuilder(
        stream: _controller.givingRef
            .where("userid", isEqualTo: userid)
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
                      height: backgroundColor == Colors.white ? 79 : 65,
                      width: 257,
                      padding: EdgeInsets.only(
                        top: 10,
                        left: 20,
                        right: 20,
                      ),
                      // decoration: backgroundColor == Colors.white
                      //   ? null
                      //   : BoxDecoration(
                      //     borderRadius: BorderRadius.circular(12),
                      //     border: Border.all(
                      //       width: 2,
                      //       color: backgroundColor == Colors.white
                      //           ? htextDark
                      //           : Colors.white,
                      //     ),
                      //   ),
                      child: Column(
                        children: [
                          appText(
                              text: snapshot.data.docs[index].get('MosqueName'),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  fontWeight: FontWeight.w500,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: appText(
                                      text: DateFormat('dd MMMM, yyyy')
                                          .format(snapshot.data.docs[index]
                                              .get('Payment Date')
                                              .toDate())
                                          .toString(),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
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
                                          .get('Reason'),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: backgroundColor == Colors.white
                                          ? htextDark
                                          : Colors.white,
                                      align: TextAlign.end,
                                      alignment: Alignment.topRight),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // if(backgroundColor == Colors.white)
                    Divider(
                      thickness: 1.5,
                      color: backgroundColor == Colors.white
                          ? Colors.grey
                          : Colors.white,
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
