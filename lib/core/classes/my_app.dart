import 'package:firebase_ecobot/features/login/view/login_page.dart';
import 'package:flutter/material.dart';

import '../../features/form/view/form_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const LoginPage(),
    );
  }
}
