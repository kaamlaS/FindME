import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 40,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFF532e7a),
        title: Text('Help',style: TextStyle(fontFamily: 'Merriweather',color: Colors.white),textAlign: TextAlign.center,),
      ),
      body: Container(),
    );
  }
}
