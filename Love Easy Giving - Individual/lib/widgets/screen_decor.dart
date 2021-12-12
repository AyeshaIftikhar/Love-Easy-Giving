import 'package:flutter/material.dart';

Center topDecor({
  @required double height,
  @required double width,
}
) {
  return Center(
    child: Image.asset(
      'assets/images/topdecor.png',
      width: width,
      height:height,
    ),
  );
}

Center bottomDecor({
  @required double height,
  @required double width,
}) {
  return Center(
    child: Image.asset('assets/images/group367.png', width: width, height: height,),
  );
}
