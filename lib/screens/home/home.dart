import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/services/database.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    void signOut() async {
      await _auth.signOut();
    }

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      initialData: List(),
      value: DatabaseService().brews,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person, color: Colors.white),
              label: Text('Logout', style: TextStyle(color: Colors.white)),
              onPressed: signOut,
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings, color: Colors.white),
              label: Text('Settings', style: TextStyle(color: Colors.white)),
              onPressed: _showSettingsPanel,
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover
            )
          ),
          child: BrewList()
        ),
      ),
    );
  }
}