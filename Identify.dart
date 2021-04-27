import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Identify extends StatefulWidget {
  @override
  _IdentifyState createState() => _IdentifyState();
}

class _IdentifyState extends State<Identify> {
  bool load = true;
  var number = null;
  String defaultNumber = ' ';
  File imageFile;
  
  Future Check() async{
    print('yolo');
    final bytes = imageFile.readAsBytesSync();
    String img64 = base64Encode(bytes);
    Map data = {'img':img64};
    var body = json.encode(data);
    dynamic response = await http.post('http://192.168.18.13:5000/Identify',body : body, headers: {"Content-Type": "application/json"});
    String result = response.body.toString();
    if (response.statusCode == 200){
      setState(() {
        number = result;
        load = true;
      });
    }else {
      setState(() {
        number = '03308435660';
        load = true;
      });
    }

  }
  
  call() async {
    String url = 'tel:$number';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _openGallery(BuildContext context) async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      Check();
      load = false;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async{
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
      Check();
      load = false;
    });
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

  Widget _ImageViewer() {
    if(imageFile == null) {
      return Text('No Image Selected',style: TextStyle(fontFamily: 'Merriweather',fontSize: 40),textAlign: TextAlign.center,);
    }else {
      return Image.file(imageFile, width: 400, height: 400);
    }
  }

  Widget _MatchViewer() {
    if(number == null) {
      return Text(' ',style: TextStyle(fontFamily: 'Merriweather',color: Colors.blue[900],fontSize: 40),textAlign: TextAlign.center,);
    }else if (number is String){
      setState(() {
        load = true;
      });
      return Text('You got a Match!',style: TextStyle(fontFamily: 'Merriweather',color: Colors.green[900],fontSize: 30),textAlign: TextAlign.center,);
    }
    else {
      return Text('Not a match',style: TextStyle(fontFamily: 'Merriweather',color: Colors.red[900],fontSize: 30),textAlign: TextAlign.center,);
    }
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
          title: Text('Identify',style: TextStyle(fontFamily: 'Merriweather',color: Colors.white),textAlign: TextAlign.center,),
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget> [
                _ImageViewer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: (){
                      _showChoiceDialog(context);
                    },
                      child: (load)? Text('Select Image'): CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF532e7a)), strokeWidth: 5.0,),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    RaisedButton(
                      onPressed: (){
                        call();
                      },
                      child: Text('Call Reporter'),
                    ),
                  ],
                ),
                Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF532e7a)),
                  ),
                  child: _MatchViewer(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

