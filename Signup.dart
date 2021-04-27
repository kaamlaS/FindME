import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:find_me/Home.dart';
import 'package:find_me/Help.dart';
import 'package:find_me/main.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: MyForm(),)
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
  bool _value = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EmailAddressController = TextEditingController() ;
    PasswordController = TextEditingController() ;
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
                  flex: 4,
                  child: SizedBox(
                    width: 20.0,
                    height: 160,
                  ),),
                Flexible(
                  flex: 2,
                  child: Text('SignUp',style: TextStyle(fontSize: 50,fontFamily: 'Merriweather',color: Colors.white),),
                ),
                SizedBox(
                  height: 20,
                ),
                // SignUP email
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

                Flexible(
                  flex: 1,
                  child: CheckboxListTile(
                    title: RichText(
                      text: TextSpan(
                        children: <TextSpan> [
                          TextSpan(text: 'I agree to the ',style: TextStyle(fontSize: 18.0,color: Colors.white)),
                          TextSpan(
                            text: 'Terms of Services ',
                            style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.white,decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = (){
                                print('Terms');
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> new Signup()));
                              },
                          ),
                          TextSpan(text: 'and ',style: TextStyle(fontSize: 18.0,color: Colors.white)),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.white,decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = (){
                                print('Privacy');
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> new Signup()));
                              },
                          ),
                        ],
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    checkColor: Colors.black,
                    activeColor: Colors.white,
                    value: _value,
                    onChanged: (value){
                      setState(() {
                        print(value);
                        _value = value;
                      });
                    },
                  ),
                ),

                SizedBox(
                  height: 20,
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
                      child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 20.0)),
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                    ),
                  ),
                ),

                // Log in line
                Flexible(
                  flex: 1,
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan> [
                          TextSpan(text: 'Already have an account?',style: TextStyle(fontSize: 18.0,color: Colors.white)),
                          TextSpan(
                            text: 'Log in',
                            style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.white,decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = (){
                                print('Log in');
                                Navigator.pop(context);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),


                Flexible(
                  flex: 2,
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


