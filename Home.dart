import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:find_me/Report.dart';
import 'package:find_me/Explore.dart';
import 'package:find_me/Identify.dart';
import 'package:find_me/CheckStatus.dart';
import 'package:find_me/Help.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        //Color(0xffd5cce0)

        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Home
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  padding: EdgeInsets.only(left: 40.0),
                  margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  alignment: Alignment.bottomLeft,
                  height: 100,
                  width: 200,
                  child: RichText(text: TextSpan(text: 'Home',style: TextStyle(fontSize: 40.0,fontFamily: 'Merriweather',color: Colors.black),
                  ),
                  ),
              ),),

              // Report and identify
              Flexible(
                fit: FlexFit.loose,
                child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        print('report missing person');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> new Report()));
                      },
                      child: Container(
                      height: 200,
                      margin: EdgeInsets.fromLTRB(10, 5, 5, 5),
                      decoration: BoxDecoration(
                        color: Color(0xFF532e7a),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        boxShadow: [BoxShadow(
                          color: Color(0xFF533051).withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0,3),
                        ),
                        ],
                      ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:[
                            Icon(Icons.person_outline_outlined, color: Colors.white, size: 90.0),
                            Text('Report Missing Person',textAlign: TextAlign.center,style: TextStyle(fontSize: 18.0,fontFamily: 'MerriWeather'),),
                          ],
                        ),
                  ),
                    ),
                  ),
                  Expanded(child: InkWell(
                    onTap: (){
                      print('identify');
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> new Identify()));
                    },
                    child: Container(
                      height: 200,
                      margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
                      decoration: BoxDecoration(
                        color: Color(0xFF532e7a),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        boxShadow: [BoxShadow(
                          color: Color(0xFF533051).withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0,3),
                        ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:[
                          Icon(Icons.photo_camera_rounded, color: Colors.white, size: 90.0),

                          Text('Identify Missing Person',textAlign: TextAlign.center,style: TextStyle(fontSize: 18.0,fontFamily: 'MerriWeather'),),
                        ],
                      ),
                    ),
                  ),
                  ),
                ],
              ),),
              Flexible(child: Row(
          children: [
              Expanded(child: InkWell(
                onTap: (){
                  print('Check status');
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new CheckStatus()));
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        width: 300,
                        margin: EdgeInsets.fromLTRB(10, 5, 5, 5),
                        decoration: BoxDecoration(
                          color: Color(0xFF532e7a),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          boxShadow: [BoxShadow(
                            color: Color(0xFF533051).withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0,3),
                          ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:[
                            Icon(Icons.outlined_flag_rounded, color: Colors.white, size: 90.0),
                            Text('Check Status on Reported Person',textAlign: TextAlign.center,style: TextStyle(fontSize: 18.0,fontFamily: 'MerriWeather'),),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ),
              Expanded(child: InkWell(
                onTap: (){
                  print('Explore List of Missing People');
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new Explore()));
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        width: 300,
                        margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
                        decoration: BoxDecoration(
                          color: Color(0xFF532e7a),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          boxShadow: [BoxShadow(
                            color: Color(0xFF533051).withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0,3),
                          ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:[
                            Icon(Icons.language_sharp, color: Colors.white, size: 90.0),
                            Text('Explore List of Missing People',textAlign: TextAlign.center,style: TextStyle(fontSize: 18.0,fontFamily: 'MerriWeather'),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ),
          ],
        ),),
              Flexible(
                fit: FlexFit.tight,
                child: Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        iconSize: 40.0,
                        icon: Icon(
                          Icons.help,
                          color: Colors.black,
                        ),
                        onPressed: (){
                          print("what");
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> new Help()));
                        },
                      ),
                    ),
                  ),
                ],
              ),),
            ],
          ),
        ),
      ),
    );
  }
}

