import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learninglessons/MyCards.dart';
import 'package:learninglessons/SignUP.dart';

class SigninPage extends StatefulWidget {
  SigninPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SigninPageState createState() => _SigninPageState();
}
class _SigninPageState extends State<SigninPage> {
  _SigninPageState(){}
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
                      child: Text('Login',
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
                          // errorText: _validate ? 'Value Can\'t Be Empty' : null,
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
                      margin: EdgeInsets.only(top: 20, bottom: 5, right: 30, left: 30),
                      width: 200,
                      height: 70,
                      child: RaisedButton(
                        child: Text("Login", style: TextStyle(fontSize: 22.0),),
                        textColor: Colors.white,
                        color: Colors.purple,
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                        onPressed: (){
                          setState(() {
                            //  _text.text.isEmpty ? _validate = true : _validate = false;
                          });
                          FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: emailController.text, password: passwordController.text)
                              .then((value) {
                            //FirebaseAuth.instance.currentUser();
                            print("Successfully logged in!");
                            FirebaseAuth auth = FirebaseAuth.instance;
                            User user = auth.currentUser;
                            var uid = user.uid;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyCardsPage(uid)),
                            );
                          }).catchError((error){
                            print("Failed to log in!");
                            print(error.toString());
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 10, right: 30, left: 30),
                      width: 200,
                      height: 70,
                      child: RaisedButton(
                        child: Text("Sign Up", style: TextStyle(fontSize: 22.0),),
                        textColor: Colors.white,
                        color: Colors.purple,
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpPage(title: "Create new account")),
                          );
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