import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class AppbottNav extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return BottomNavigationBar(
        items:[
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.home, size: 20), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.database, size: 20), label: 'search'),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.userCircle, size: 20), label: 'Profile'),

        ].toList(),
        fixedColor: Colors.greenAccent,
        onTap:(int idx){
          switch(idx){
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/search');
              break;
            case 2:
              Navigator.pushNamed(context, '/Profile');
              break;
          }
        }
    );
  }
}