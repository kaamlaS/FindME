import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:find_me/Home.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:find_me/Help.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  bool load = true;
  var LostPeople = [];
  String PersonName;
  String Gender = 'Female';
  String Height;
  String LastSeenArea = 'Pechs';
  String ReporterNumber;


  final _FormKey = GlobalKey<FormState>();

  File imageFile;

  Future<bool> AddReport() async{
    final bytes = imageFile.readAsBytesSync();
    String img64 = base64Encode(bytes);
    Map data = {'Name': PersonName,'Gender': Gender,'Height': Height,'Area': LastSeenArea,'Number':ReporterNumber,'img64': img64};
    String body = json.encode(data);
    dynamic response = await http.post('http://192.168.18.13:5000/report',body : body, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200){
      Fluttertoast.showToast(msg: 'Lost Person reported',gravity: ToastGravity.BOTTOM,timeInSecForIos: 3,backgroundColor: Colors.black,textColor: Colors.white);
    }
    else {
      Fluttertoast.showToast(msg: 'Update not possible',gravity: ToastGravity.BOTTOM,timeInSecForIos: 3,backgroundColor: Colors.black,textColor: Colors.white);
    }
    return true;
  }


  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
      load = false;
    });
    if (load == false){
      await Fluttertoast.showToast(msg: 'Image Selected',gravity: ToastGravity.CENTER,timeInSecForIos: 3,backgroundColor: Colors.black,textColor: Colors.white);
    }
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async{
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
      load = false;
    });
    if (load == false){
      await Fluttertoast.showToast(msg: 'Image Selected',gravity: ToastGravity.CENTER,timeInSecForIos: 3,backgroundColor: Colors.black,textColor: Colors.white);
    }
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Choose Any One'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              GestureDetector(
                child: Text('Gallery'),
                onTap: (){
                  _openGallery(context);
                 },
              ),
              Padding(padding: EdgeInsets.all(10),),
              GestureDetector(
                child: Text('Camera'),
                onTap: (){
                  _openCamera(context);
                 },
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _buildName(){
    return TextFormField(
      cursorColor: Color(0xFF532e7a),
      cursorHeight: 25,
      decoration: InputDecoration(labelText: 'Name of Missing Individual',
        labelStyle: TextStyle(color: Colors.black,fontSize: 15),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,),
      validator: (value){
        if(value.isEmpty){
          return "Name is Required";
        }
        return null;
      },
      onSaved: (String value){
        PersonName = value;
      },
    );
  }

  Widget _buildGender(){
    return Column(
      children: [
        Text('Enter Gender',style: TextStyle(fontFamily: 'Merriweather',fontSize: 15),),
        DropdownButton(
            value: Gender,
            items: [
          DropdownMenuItem(child: Text('Female',style: TextStyle(fontFamily: 'Merriweather',fontSize: 15),),value: 'Female',),
          DropdownMenuItem(child: Text('Male',style: TextStyle(fontFamily: 'Merriweather',fontSize: 15),),value: 'Male',),
        ], onChanged: (value){
          setState(() {
            Gender = value;
          });
        }),
      ],
    );
  }

  Widget _buildHeight(){
    return Container(
      height: 50,
      width: 100,
      child: TextFormField(
        cursorColor: Color(0xFF532e7a),
        cursorHeight: 25,
        decoration: InputDecoration(labelText: 'Height',
          labelStyle: TextStyle(color: Colors.black,fontSize: 15),
          border: OutlineInputBorder(),),
        validator: (value){
          if(value.isEmpty){
            return "Height is Required";
          }
          return null;
        },
        onSaved: (String value){
          Height = value;
        },
      ),
    );
  }

  Widget _buildArea(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Enter Last Area Seen in',style: TextStyle(fontFamily: 'Merriweather',fontSize: 15),),
        DropdownButton(
            value: LastSeenArea,
            items: [
              DropdownMenuItem(child: Text('Pechs',style: TextStyle(fontFamily: 'Merriweather',fontSize: 15),),value: 'Pechs',),
              DropdownMenuItem(child: Text('Hassan Square',style: TextStyle(fontFamily: 'Merriweather',fontSize: 15),),value: 'Hassan Square',),
              DropdownMenuItem(child: Text('Tariq Road',style: TextStyle(fontFamily: 'Merriweather',fontSize: 15),),value: 'Tariq Road',),
              DropdownMenuItem(child: Text('Nipa',style: TextStyle(fontFamily: 'Merriweather',fontSize: 15),),value: 'Nipa',),
              DropdownMenuItem(child: Text('Seaview',style: TextStyle(fontFamily: 'Merriweather',fontSize: 15),),value: 'Seaview',),
            ], onChanged: (value){
          setState(() {
            LastSeenArea = value;
          });
        }),
      ],
    );
  }

  Widget _buildRepNumber(){
    return Container(
      height: 50,
      width: 150,
      child: TextFormField(
        cursorColor: Color(0xFF532e7a),
        cursorHeight: 25,
        decoration: InputDecoration(labelText: 'Reporter\'s Number',
          labelStyle: TextStyle(color: Colors.black,fontSize: 15),
          border: OutlineInputBorder(),),
        validator: (value){
          if(value.isEmpty){
            return "Number is Required";
          }
          return null;
        },
        onSaved: (String value){
          ReporterNumber = value;
        },
      ),
    );
  }

  Widget _buildImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Add photo of missing individual',style: TextStyle(color: Colors.black,fontSize: 15),),
        IconButton(
          iconSize: 40.0,
          icon: Icon(
            Icons.add_a_photo,
            color: Colors.black,
          ),
          onPressed: () {
            _showChoiceDialog(context);
          },
        ),
      ],
    );
  }


  @override
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
          title: Text('Add Information',style: TextStyle(fontFamily: 'Merriweather',color: Colors.white),textAlign: TextAlign.center,),
        ),
        body: Form(
          key: _FormKey,
          child: Container(
            margin: EdgeInsets.only(left: 10.0),
            child: ListView(

              children: [Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  _buildName(),
                  Divider(
                    color: Color(0xFF532e7a),
                  ),
                  _buildGender(),
                  Divider(
                    color: Color(0xFF532e7a),
                  ),
                  _buildHeight(),
                  Divider(
                    color: Color(0xFF532e7a),
                  ),
                  _buildArea(),
                  Divider(
                    color: Color(0xFF532e7a),
                  ),
                  _buildRepNumber(),
                  Divider(
                    color: Color(0xFF532e7a),
                  ),
                  _buildImage(),
                  SizedBox(height: 50),
                  Center(
                    child: RaisedButton(onPressed: (){
                      if (_FormKey.currentState.validate()){
                        _FormKey.currentState.save();
                        print(PersonName);
                        print(Height);
                        print(ReporterNumber);
                        print(Gender);
                        print(LastSeenArea);
                        print(imageFile);
                        AddReport();
                      }
                      else {
                        return;
                      }
                    },
                      color: Color(0xFF532e7a),
                      child: Text('Add Report', style: TextStyle(color: Colors.white,fontFamily: 'Merriweather',fontSize: 20),),
                    ),
                  ),
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
              ),],
            ),
          ),
        ),
      ),

    );
  }
}
