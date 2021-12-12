import '../../Constants/colors.dart';
import '../../Controller/app_controller.dart';
import '../../styles/button_styles.dart';
import '../../widgets/alert_widgets.dart';
import '../../widgets/const_widgets.dart';
import '../../widgets/copyright.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/steam_builder.dart';
import '../../widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CharityBasket extends StatefulWidget {
  const CharityBasket({Key key}) : super(key: key);

  @override
  _CharityBasketState createState() => _CharityBasketState();
}

class _CharityBasketState extends State<CharityBasket> {
  final MyAppController _controller = Get.find();
  Color _background = Get.arguments;
  var _parameters = Get.parameters;
  var cartTotal = 0;
  var price = 0;
  int quantity;
  String docid;
  var pound;
  int length = 0;

  getCartTotal() async {
    _controller.cbasketRef
        .where('appmode', isEqualTo: _parameters['app'])
        .where('userid', isEqualTo: _controller.userid.value)
        .where('paid', isEqualTo: 'no')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        setState(() {
          print(int.parse(element.data()['price']));
          cartTotal = cartTotal + int.parse(element.data()['price']);
          print(cartTotal);
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getCartTotal();
  }

  Future increaseQuantity(
      {@required String docid,
      @required int quantity,
      @required var price}) async {
    var initPrice;
    setState(() {
      print('Received Quantity: ' + quantity.toString());
      print('Received DocID:  $docid');
      print('Received Price:  $price');
      quantity = quantity + 1;
      _controller.cbasketRef.doc(docid).get().then((_snapshot) {
        setState(() {
          initPrice = _snapshot.data()['initial_price'];
          print('Initial Price:  $initPrice');
          price = price + initPrice;
          print('Increment Price:  $price');
          cartTotal = cartTotal + initPrice;
          print('cartTotal:  $cartTotal');
          _controller.cbasketRef.doc(docid).update({
            'quantity': quantity,
            'price': price.toString(),
          });
        });
      });
    });
  }

  Future decreaseQuantity(
      {@required String docid,
      @required int quantity,
      @required var amount}) async {
    var initPrice;
    setState(() {
      print('Received Quantity: ' + quantity.toString());
      print('Received DocID:  $docid');
      print('Received Price:  $amount');
      quantity = quantity - 1;
      _controller.cbasketRef.doc(docid).get().then((_snapshot) {
        setState(() {
          initPrice = _snapshot.data()['initial_price'];
          print('Initial Price:  $initPrice');
          amount = amount - initPrice;
          print('Decremented Price:  $amount');
          cartTotal = cartTotal - initPrice;
          print('cartTotal:  $cartTotal');
          _controller.cbasketRef.doc(docid).update({
            'quantity': quantity,
            'price': amount.toString(),
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      persistentFooterButtons: [copyrightwidget()],
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            vspace(height: 55),
            customTop(
                color: selectColor,
                text: _parameters['title'],
                fontSize: 27,
                textColor: textColor,
                fontWeight: FontWeight.bold,
                align: TextAlign.center,
                alignment: Alignment.center),
            vspace(height: 40),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 100.0),
                  child: appText(
                    text: 'Quantity',
                    fontSize: 14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35.0),
                  child: appText(
                    text: 'Type',
                    fontSize: 14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35.0, right: 20),
                  child: appText(
                    text: 'Price',
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            vspace(height: 5),
            Divider(
              thickness: 1.0,
            ),
            StreamBuilder(
                stream: _controller.cbasketRef
                    .where('appmode', isEqualTo: _parameters['app'])
                    .where('userid', isEqualTo: _controller.userid.value)
                    .where('paid', isEqualTo: 'no')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return builderCommons(
                      background: _background,
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return builderCommons(
                      background: _background,
                    );
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        length = snapshot.data.docs.length;
                        pound = String.fromCharCode(int.parse(
                            snapshot.data.docs[index].get('unicode')));
                        price =
                            int.parse(snapshot.data.docs[index].get('price'));
                        if (snapshot.data.docs[index].get('quantity') == 0) {
                          _controller.cbasketRef.doc(docid).delete();
                        }
                        return Container(
                          margin: const EdgeInsets.only(bottom: 25.0),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            SizedBox(
                              width: 90,
                              child: appText(
                                text:
                                    snapshot.data.docs[index].get('cause_name'),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                align: TextAlign.center,
                                alignment: Alignment.center,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    color: selectColor,
                                    child: IconButton(
                                      onPressed: () {
                                        print('add pressed');
                                        setState(() {
                                          docid = snapshot.data.docs[index].id;
                                          quantity = snapshot.data.docs[index]
                                              .get('quantity');
                                          var amount = int.parse(snapshot
                                              .data.docs[index]
                                              .get('price'));
                                          increaseQuantity(
                                            docid: docid,
                                            quantity: quantity,
                                            price: amount,
                                          );
                                        });
                                      },
                                      icon: Icon(Icons.add),
                                      iconSize: 20,
                                      padding: EdgeInsets.all(0),
                                      alignment: Alignment.center,
                                      tooltip: 'Add more packs',
                                    ),
                                  ),
                                  Container(
                                    width: 18,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        top: BorderSide(
                                            width: 1, color: Color(0xffC4C1BD)),
                                        bottom: BorderSide(
                                            width: 1, color: Color(0xffC4C1BD)),
                                      ),
                                    ),
                                    child: appText(
                                      text: snapshot.data.docs[index]
                                          .get('quantity')
                                          .toString(),
                                      fontSize: 10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      align: TextAlign.center,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    color: bText,
                                    child: IconButton(
                                        onPressed: () {
                                          print('decrease pressed');
                                          setState(() {
                                            print('current index: $index');
                                            docid =
                                                snapshot.data.docs[index].id;
                                            quantity = snapshot.data.docs[index]
                                                .get('quantity');
                                            var amount = int.parse(snapshot
                                                .data.docs[index]
                                                .get('price'));
                                            decreaseQuantity(
                                              docid: docid,
                                              quantity: quantity,
                                              amount: amount,
                                            );
                                          });
                                        },
                                        icon: Image.asset(
                                            'assets/images/Line 19.png'),
                                        iconSize: 20,
                                        padding: EdgeInsets.all(0),
                                        alignment: Alignment.center,
                                        tooltip: 'Decrease Quantity'),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 56,
                              margin: EdgeInsets.only(left: 25),
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    appText(
                                      text:
                                          snapshot.data.docs[index].get('type'),
                                      fontSize: 12.2,
                                      fontWeight: FontWeight.w500,
                                      align: TextAlign.center,
                                      alignment: Alignment.center,
                                    ),
                                    Icon(Icons.arrow_forward_ios,
                                        color: selectColor, size: 13),
                                  ]),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: appText(
                                text: NumberFormat.currency(symbol: pound)
                                    .format(price)
                                    .toString(),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                align: TextAlign.center,
                                alignment: Alignment.center,
                              ),
                            ),
                          ]),
                        );
                      });
                }),
            Divider(
              thickness: 1.0,
            ),
            vspace(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 49,
                  height: 25,
                  color: selectColor,
                  child: appText(
                    text: 'Total',
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    alignment: Alignment.center,
                    align: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 15),
                  child: appText(
                      text: NumberFormat.currency(symbol: pound)
                          .format(cartTotal)
                          .toString(),
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            vspace(
                height: length == 1
                    ? Get.height * 0.32
                    : length == 2
                        ? Get.height * 0.2
                        : length == 3
                            ? Get.height * 0.15
                            : Get.height * 0.1),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 139,
                    height: 41,
                    child: OutlinedButton(
                      onPressed: () {
                        if (cartTotal == 0) {
                          showToast(
                              message:
                                  'Please select a charity from previous page for donation to proceed further.');
                        } else {
                          Get.toNamed(
                            '/selectCard',
                            arguments: _background,
                            parameters: {
                              'app': _parameters['app'],
                              'app_mode': _parameters['app_mode'],
                              'unicode': _parameters['unicode'],
                              'pay_type': 'Pay-One-Off',
                              'amount': cartTotal.toString(),
                              'stripekey': _parameters['stripeKey'],
                            },
                          );
                        }
                      },
                      child: appText(
                          text: 'PAY NOW',
                          fontSize: 11.8,
                          alignment: Alignment.center,
                          fontWeight: FontWeight.bold,
                          align: TextAlign.center),
                      style: outlinebutton(
                        radius: 10,
                        primary: selectColor,
                        borderColor: selectColor,
                      ),
                    ),
                  ),
                  Container(
                    width: 139,
                    height: 41,
                    child: OutlinedButton(
                      onPressed: () {
                        if (cartTotal == 0) {
                          showToast(
                              message:
                                  'Please select a charity from previous page for donation to proceed further.');
                        } else {
                          Get.toNamed(
                            '/selectCard',
                            arguments: _background,
                            parameters: {
                              'app': _parameters['app'],
                              'app_mode': _parameters['app_mode'],
                              'unicode': _parameters['unicode'],
                              'pay_type': 'Schdeule',
                              'amount': cartTotal.toString(),
                              'stripekey': _parameters['stripeKey'],
                            },
                          );
                        }
                      },
                      child: appText(
                          text: 'SCHEDULE NOW',
                          fontSize: 11.8,
                          alignment: Alignment.center,
                          fontWeight: FontWeight.bold,
                          align: TextAlign.center),
                      style: outlinebutton(
                        radius: 10,
                        primary: selectColor,
                        borderColor: selectColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            vspace(height: 40),
          ],
        ),
      ),
    );
  }
}
