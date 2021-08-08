import 'package:flutter/material.dart';

class search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Searching Page'), backgroundColor: Colors.blue,),
      body: Center(
        child: Text ('Search for a doctor'),
      ),

    );
  }
}