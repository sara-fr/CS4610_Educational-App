import 'package:flutter/material.dart';
import 'package:learninglessons/Chemistry.dart';
import 'package:learninglessons/Physics.dart';
import 'package:learninglessons/Signin.dart';
import 'Math.dart';
import 'Coding.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Learning',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: "E-Flashcards Learning"),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.indigo,
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50, bottom: 10, right: 20, left: 20),
                  width: 300,
                  height: 100,
                  child: RaisedButton(
                    child: Text("Math", style: TextStyle(fontSize: 22.0),),
                    textColor: Colors.white,
                    color: Colors.purple,
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MathPage(title: "Learn Math")),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
                  width: 300,
                  height: 100,
                  child: RaisedButton(
                    child: Text("Coding", style: TextStyle(fontSize: 22.0),),
                    textColor: Colors.white,
                    color: Colors.purple,
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CodingPage(title: "Learn Coding")),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
                  width: 300,
                  height: 100,
                  child: RaisedButton(
                    child: Text("Physics", style: TextStyle(fontSize: 22.0),),
                    textColor: Colors.white,
                    color: Colors.purple,
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PhysicsPage(title: "Learn Physics")),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
                  width: 300,
                  height: 100,
                  child: RaisedButton(
                    child: Text("Chemistry", style: TextStyle(fontSize: 22.0),),
                    textColor: Colors.white,
                    color: Colors.purple,
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChemistryPage(title: "Learn Chemistry")),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
                  width: 300,
                  height: 100,
                  child: RaisedButton(
                    child: Text("Sign in", style: TextStyle(fontSize: 22.0),),
                    textColor: Colors.white,
                    color: Colors.lightGreen,
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SigninPage(title: "Sign In")),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
