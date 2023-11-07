import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taxiapp/src/app.dart';
import 'package:flutter_taxiapp/src/bloc/auth_boc.dart';
import 'package:flutter_taxiapp/src/resources/login_page.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(
      new AuthBloc(),
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      )));
}
