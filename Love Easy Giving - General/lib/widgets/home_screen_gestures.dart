import 'package:flutter/material.dart';
import '../Constants/colors.dart';

class HomeGestures extends StatelessWidget {
  final String child;
  final Function onTap;
  HomeGestures({
    @required this.child,
    @required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          width: 300,
          height: 125,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color:scaffoldColor,
            image: DecorationImage(
              image: AssetImage(child),
            ),
            border: Border.all(color: Colors.white, width: 7),
          ),
        ),
      ),
      
    );
  }
}
