import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as IO;
import 'dart:async';
import 'dart:convert';



class Explore extends StatefulWidget {

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<Person> people = [];
  IO.File imagefile;
  var _getpeople;

  Future<List<Person>> _getPeople() async {
    var response = await http.get('http://192.168.18.13:5000/explore');
    var data = json.decode(response.body);
    int count = 0;
    for (var x in data){
      var decodedBytes = base64Decode(x['img']);
      Person person = Person(x['name'],x['Gender'],x['height'], x['Area'],x['RepNumber'],decodedBytes);
       people.add(person);
       count = count+1;
     }
     print(people.length);


    return people;
  }

  @override
  void initState(){
    _getpeople = _getPeople();
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
          title: Text('Explore Repository',style: TextStyle(fontFamily: 'Merriweather',color: Colors.white),textAlign: TextAlign.center,),
        ),
        body: Container(
          child: FutureBuilder(
              future: _getpeople,
              builder: (BuildContext context,AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index){
                        return Column(
                          children: [
                            Image.memory(people[index].imageFile),
                            Text('Name: '+people[index].PersonName,style: TextStyle(fontFamily: 'Merriweather',fontSize: 15),),
                            Text('Gender: '+people[index].Gender,style: TextStyle(fontFamily: 'Merriweather',fontSize: 15),),
                            Text('Height: '+people[index].Height,style: TextStyle(fontFamily: 'Merriweather',fontSize: 15),textAlign: TextAlign.start,),
                            Text('Last seen in: '+people[index].LastSeenArea,style: TextStyle(fontFamily: 'Merriweather',fontSize: 15),textAlign: TextAlign.start,),
                            Text('Reporter\'s Number: '+people[index].ReporterNumber,style: TextStyle(fontFamily: 'Merriweather',fontSize: 15),textAlign: TextAlign.start,),
                            Divider(
                              color: Color(0xFF532e7a),
                            ),
                          ],
                        );
                      }
                      );
                }
                else{
                  return Center(
                    child: Container(
                      child: CircularProgressIndicator(strokeWidth: 10.0,valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF532e7a))),
                      height: 100,
                      width: 100,
                      padding: EdgeInsets.only(top: 16.0),
                    ),
                  );
                }
              },),
        ),
      ),
    );
  }
}

class Person {
  String PersonName;
  String Gender;
  String Height;
  String LastSeenArea;
  String ReporterNumber;
  Uint8List imageFile;

  Person(this.PersonName, this.Gender, this.Height, this.LastSeenArea, this.ReporterNumber,this.imageFile);
}
