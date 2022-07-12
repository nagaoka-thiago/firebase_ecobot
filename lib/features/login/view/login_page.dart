import 'package:firebase_ecobot/features/login/controller/login_controller.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 160,
                width: 340,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: AssetImage("assets/generic-logo.png"),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await _controller.signInWithGoogle(context);
                },
                child: Container(
                  height: 60,
                  width: 340,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/google-button2.png"),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 60,
                  width: 340,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/apple-button.png"),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
