import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:learninglessons/AddCards.dart';

class MyCardsPage extends StatefulWidget {
  var uid;
  MyCardsPage(this.uid);
  @override
  _MyCardsPageState createState() => _MyCardsPageState();
}
var term = [];
var content = [];
class _MyCardsPageState extends State<MyCardsPage> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
    FirebaseDatabase.instance.reference().child("Users/" + widget.uid).child("/MyCards/").once()
        .then((datasnapshot) {
      print("Successfully loaded the data!");
      datasnapshot.value.forEach((k, v) {
        term.add(k);
        content.add(v);
      });
      setState(() {});
    }).catchError((error){
      print("Failed to load the data!");
    });
  }
  _MyCardsPageState(){
    uploadMyCardsCards();
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
  void uploadMyCardsCards(){
    //initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Flashcards"),
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
                child: Text("${term[counter]}", style: TextStyle(fontSize: 22.0),
                ),
                alignment: Alignment.center,
              ),
              back: Container(
                padding: EdgeInsets.all(10.0),
                color: Colors.white70,
                width: 300,
                height: 200,
                child: Text("${content[counter]}", style: TextStyle(fontSize: 22.0),
                ),
                alignment: Alignment.center,
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
                    //print(widget.uid);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddCardsPage(widget.uid)),
                    );
                  },
                  child: Icon(Icons.add),
                  backgroundColor: Colors.lightGreen,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}