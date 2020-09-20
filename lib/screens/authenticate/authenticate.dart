import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool _showSignin = true;
  void toggleView() {
    setState(() => _showSignin = !_showSignin);
  }

  @override
  Widget build(BuildContext context) {
    if (_showSignin) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}