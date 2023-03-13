import './my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'configure_noweb.dart' if (dart.library.html) 'configure_web.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureApp();
  runApp(MyApp());
}

