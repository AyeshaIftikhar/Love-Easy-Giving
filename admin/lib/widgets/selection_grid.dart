import '../../Constants/colors.dart';
import '../../widgets/text_widget.dart';
import 'package:flutter/material.dart';

class SelectionGrid extends StatelessWidget {
  const SelectionGrid(
      {Key? key,
      this.width = 170,
      this.height = 150,
      required this.text,
      required this.icon})
      : super(key: key);
  final double width;
  final double height;
  final String text;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(height: 10),
          TextWidget(text: text, alignment: Alignment.center, ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: htextDark),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
