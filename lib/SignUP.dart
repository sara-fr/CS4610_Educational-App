import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SignUpPageState createState() => _SignUpPageState();
}
class _SignUpPageState extends State<SignUpPage> {
  _SignUpPageState(){}
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool _validate = false;
  final _text = TextEditingController();
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }
  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        backgroundColor: Colors.indigo,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Column(
              children: [
                Expanded(
                  flex: 70,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: Text('Sign Up',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10, right: 30, left: 30),
                        child: TextField(
                          controller: emailController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Email',
                            border: OutlineInputBorder(),
                            fillColor: Color(0xfff3f3f4),
                            filled: true,
                            //errorText: _validate ? 'Value Can\'t Be Empty' : null,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10, right: 30, left: 30),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Password',
                            border: OutlineInputBorder(),
                            fillColor: Color(0xfff3f3f4),
                            filled: true,
                            //errorText: _validate ? 'Value Can\'t Be Empty' : null,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 10, right: 30, left: 30),
                        width: 200,
                        height: 70,
                        child: RaisedButton(
                          child: Text("Sign Up", style: TextStyle(fontSize: 22.0),),
                          textColor: Colors.white,
                          color: Colors.purple,
                          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                          onPressed: (){
                            setState(() {
                              //_text.text.isEmpty ? _validate = true : _validate = false;
                            });
                            FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: emailController.text, password: passwordController.text)
                                .then((authResult) {
                              print("Successfully signed up!");
                              var userProfile = {
                                "uid" : authResult.user.uid,
                                "email" : emailController.text,
                                "MyCards" : {"Welcome" : "Welcome"},
                              };
                              FirebaseDatabase.instance.reference().child("Users/" + authResult.user.uid)
                                  .set(userProfile).then((value) {
                                print("Successfully created the profile!");
                              }).catchError((error){
                                print("Failed to created the profile!");
                              });
                              Navigator.pop(context);
                            }).catchError((error){
                              print("Failed to sign up!");
                              print(error.toString());
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}