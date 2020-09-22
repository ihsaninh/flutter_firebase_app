import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:email_validator/email_validator.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  void signIn() async {
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      dynamic result = await _auth.signInUser(email, password);
      if (result == null) {
        setState(() {
          error = 'Failed to sign in';
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In to Brew Crew'),
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.0),
              TextFormField(
                decoration: inputDecoration.copyWith(hintText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (val) => !EmailValidator.validate(val) ? 'Enter a valid email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: inputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password +6 chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text('Sign In', style: TextStyle(color: Colors.white)),
                onPressed: signIn,
              ),
              SizedBox(height: 20.0),
              Text(
                error, 
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        )
      ),
    );
  }
}