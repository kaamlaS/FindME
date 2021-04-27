import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:find_me/Home.dart';
import 'package:find_me/Help.dart';
import 'package:find_me/Report.dart';
import 'package:find_me/Explore.dart';
import 'package:find_me/Identify.dart';
import 'package:find_me/CheckStatus.dart';
import "package:find_me/Signup.dart";
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:fluttertoast/fluttertoast.dart';


void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData(
      unselectedWidgetColor: Colors.white,
    ),
    home: SafeArea(
      child: Scaffold(
        body: MyForm(),
      ),
    ),

  );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  TextEditingController EmailAddressController, PasswordController;
  final _FormKey = GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EmailAddressController = TextEditingController() ;
    PasswordController = TextEditingController() ;
  }

  sendMail() async{
    String username = 'k173762@nu.edu.pk';
    String password = 'itsallabout728';

    // ignore: deprecated_member_use
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'no-reply')
      ..recipients.add('kaamlasalman.ks@gmail.com')
      //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Password Reset Request'
      //..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h2>Reset Password</h2>\n<p>A password reset event has been triggered.\n The password reset window is limited to two hours.\nIf you do not reset your password within two hours, you will need to submit a new request.To complete the password reset process, visit the following link\n:<a href='https://Findme.com/PasswordReset'>FindME.com/PasswordReset</a></p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      Fluttertoast.showToast(msg: 'Please check your email',gravity: ToastGravity.BOTTOM,timeInSecForIos: 3,backgroundColor: Colors.black,textColor: Colors.white);
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _FormKey,
        child: SafeArea(
          child: Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/screen1.jpg'),
            fit: BoxFit.cover,
          ),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: SizedBox(
                width: 20.0,
                height: 50,
              ),),

            // FIND ME
            Flexible(
              flex: 3,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 40, 0, 0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan> [
                        TextSpan(text: 'Find',style: TextStyle(fontSize: 40.0,fontFamily: 'Merriweather')),
                        TextSpan(text: 'ME', style: TextStyle(fontSize: 40.0,fontFamily: 'Merriweather',fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // LOGIN email
            Flexible(
              flex: 2,
              child:  Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: TextFormField(
                    controller: EmailAddressController,
                    style: TextStyle(color: Colors.white,fontSize: 18.0),
                    decoration: InputDecoration(
                      fillColor: Colors.black38,
                      focusColor: Colors.white,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.black38),
                      ),
                      hintText: "Email Address",
                    ),
                    textAlign: TextAlign.center,
                    validator: (value){
                      if(value.isEmpty & !RegExp(
                          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                          .hasMatch(value)){
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),

            // LOGIN PASSWORD
            Flexible(
              flex: 2,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 10.0) ,
                  child: TextFormField(
                    controller: PasswordController,
                    style: TextStyle(color: Colors.white,fontSize: 18.0),
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      filled: true,
                      fillColor: Colors.black38,
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.black38),
                      ),
                      hintText: "Password",
                    ),
                    textAlign: TextAlign.center,
                    validator: (value){
                      if(value.isEmpty){
                        return 'Password Required';
                      }
                      if(value.length < 8){
                        return "8 CHARACTERS LONG CODEWORD";
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                ),

              ),
            ),

            //Button
            Flexible(
              flex: 1,
              child: ButtonTheme(
                minWidth: 100.0,
                child: RaisedButton(

                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  color: Colors.white54,
                  onPressed: (){
                    print('ho raha hai');
                    if(EmailAddressController != null && PasswordController != null && _FormKey.currentState.validate()) {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> new Home()));
                    }
                  },
                  child: Text("Log in",style: TextStyle(color: Colors.white,fontSize: 20.0)),
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                ),
              ),
            ),

            // Sign up line
            Flexible(
              flex: 1,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan> [
                      TextSpan(text: 'Don\'t have an account?',style: TextStyle(fontSize: 18.0,color: Colors.white)),
                      TextSpan(
                        text: 'Sign up',
                        style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.white,decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                        ..onTap = (){
                          print('signup');
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> new Signup()));
                        },

                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Forgot password
            Flexible(
              flex: 1,
              child: Center(
                child: InkWell(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan> [
                        TextSpan(
                            text: 'Forgot password?',
                            style: TextStyle(fontSize: 18.0,color: Colors.white,decoration: TextDecoration.underline)),
                      ],
                    ),

                  ),
                  onTap: (){
                    sendMail();
                  },
                ),
              ),
            ),

            Flexible(
              flex: 1,
              child: SizedBox(
                width: 20.0,
                height: 150,
              ),),

            //help icon button
            Expanded(
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
        ));
  }
}

