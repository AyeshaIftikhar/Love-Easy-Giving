import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Constants/colors.dart';

Center builderCommons({
  @required Color background,
}) {
  return Center(
    child: CircularProgressIndicator(
      backgroundColor: background == Colors.white ? htextDark : textColor,
    ),
  );
}

commons(
  AsyncSnapshot<QuerySnapshot> snapshot,
  Color _background,
) {
  if (!snapshot.hasData) {
    return builderCommons(background: _background);
  }
  if (snapshot.connectionState == ConnectionState.waiting) {
    return builderCommons(background: _background);
  }
}
