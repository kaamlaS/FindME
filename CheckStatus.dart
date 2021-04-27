import 'dart:typed_data';

import 'package:find_me/Report.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:find_me/Help.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' as IO;
import 'package:fluttertoast/fluttertoast.dart';

class CheckStatus extends StatefulWidget {
  @override
  _CheckStatusState createState() => _CheckStatusState();
}

class _CheckStatusState extends State<CheckStatus> {
  var _Status;
  String match;
  String PersonName;
  String Gender;
  String Height;
  String LastSeenArea;
  String ReporterNumber;
  Uint8List imageFile;
  bool load = true;

  Future<Map> _status() async {
    var response = await http.get('http://192.168.18.13:5000/status');
    var data = json.decode(response.body);
    var decodedBytes = base64Decode(data['img']);
    data['img'] = decodedBytes;
    return data;
  }




  @override
  void initState(){
    _Status = _status();
    super.initState();
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
          title: Text('Check Status',style: TextStyle(fontFamily: 'Merriweather',color: Colors.white),textAlign: TextAlign.center,),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF532e7a),width: 3),
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  child: (load)?FutureBuilder(
                    future: _Status,
                    builder: (BuildContext context,AsyncSnapshot snapshot){
                      if(snapshot.hasData){
                        return Image.memory(snapshot.data['img']);
                      }
                      else{
                        return Center(
                          child: Container(
                            child: CircularProgressIndicator(strokeWidth: 10.0,valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF532e7a)),),
                            height: 100,
                            width: 100,
                            padding: EdgeInsets.only(top: 16.0),
                          ),
                        );
                      }
                    },

                  ): Text('No Report Found', style: TextStyle(fontSize: 20, fontFamily: 'Merriweather'),),
                ),
              ),
            ),
            Flexible(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF532e7a),width: 3),
                borderRadius: new BorderRadius.circular(10.0),
              ),
              child: (load)?FutureBuilder(
                future: _Status,
                builder: (BuildContext context,AsyncSnapshot snapshot){
                  if(snapshot.hasData){
                      PersonName = snapshot.data['name'];
                      Gender = snapshot.data['Gender'];
                      Height = snapshot.data['height'];
                      LastSeenArea = snapshot.data['Area'];
                      ReporterNumber = snapshot.data['RepNumber'];
                      match = snapshot.data['ismatch'];

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Text('Name: '+PersonName,style: TextStyle(fontFamily: 'Merriweather',fontSize: 15),),
                          Text('Gender: '+Gender,style: TextStyle(fontFamily: 'Merriweather',fontSize: 15),),
                          Text('Height: '+Height,style: TextStyle(fontFamily: 'Merriweather',fontSize: 15),textAlign: TextAlign.start,),
                          Text('Last seen in: '+LastSeenArea,style: TextStyle(fontFamily: 'Merriweather',fontSize: 15),textAlign: TextAlign.start,),
                          Text('Reporter\'s Number: '+ReporterNumber,style: TextStyle(fontFamily: 'Merriweather',fontSize: 15),textAlign: TextAlign.start,),
                          Text('Match: '+match,style: TextStyle(fontFamily: 'Merriweather',fontSize: 15),textAlign: TextAlign.start,),
                        ],
                      ),
                    );
                  }
                  else{
                    return Center(
                      child: Container(
                        child: CircularProgressIndicator(strokeWidth: 10.0,valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF532e7a)),),
                        height: 100,
                        width: 100,
                        padding: EdgeInsets.only(top: 16.0),
                      ),
                    );
                  }
                },

              ): Text('No Report Found', style: TextStyle(fontSize: 20, fontFamily: 'Merriweather')),
            ),
          ),
        ),
            Flexible(
              flex: 1,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                color: Color(0xFF532e7a),
                onPressed: (){
                  print('ho raha hai');
                  setState(() {
                    load = false;
                  });
                  Fluttertoast.showToast(msg: 'Report Deleted',gravity: ToastGravity.BOTTOM,timeInSecForIos: 3,backgroundColor: Colors.black,textColor: Colors.white);
                },
                child: Text("Delete Report",style: TextStyle(color: Colors.white,fontSize: 20.0)),
                padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
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
            ),
          ],
        ),
      ),
    );
  }
}
