import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:firebase_database/firebase_database.dart';

class MathPage extends StatefulWidget {
  MathPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MathPageState createState() => _MathPageState();
}
var term = [];
var content = [];
class _MathPageState extends State<MathPage> {
  _MathPageState(){
    uploadMathCards();
  }
  int counter = 0;
  void incrementCounter() {
    setState(() {
      if(counter == (term.length+1)){
        counter = 0;
      } else {
        counter++;
      }
    });
  }
  void decrementCounter() {
    setState(() {
      if(counter == 0){
        counter = 0;
      } else{
        counter--;
      }
    });
  }
  void uploadMathCards(){
    FirebaseDatabase.instance.reference().child("Math/").once()
        .then((datasnapshot) {
      print("Successfully loaded the data!");
      datasnapshot.value.forEach((k, v){
        content.add(v);
        term.add(k);
      });
    }).catchError((error){
      print("Failed to load the data!");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.indigo,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlipCard(
                direction: FlipDirection.HORIZONTAL,
                front: Container(
                  padding: EdgeInsets.all(10.0),
                  color: Colors.white70,
                  width: 300,
                  height: 200,
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(50),
                  child: Text("${term[counter]}", style: TextStyle(fontSize: 22.0)),
                ),
                back: Container(
                  padding: EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  color: Colors.white70,
                  //margin: EdgeInsets.all(50),
                  //width: 300,
                  //height: 200,
                  child: Image.network('${content[counter]}'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    child: Icon(Icons.arrow_back, color: Colors.white),
                    color: Colors.purple,
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                    onPressed: (){
                    decrementCounter();
                  },
                  ),
                  RaisedButton(
                    child: Icon(Icons.arrow_forward, color: Colors.white),
                    color: Colors.purple,
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                    onPressed: (){
                    incrementCounter();
                  },
                  ),
                ],
              ),
            ],
          ),
      ),
    );
  }
}