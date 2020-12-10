import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:learninglessons/MyCards.dart';

class AddCardsPage extends StatefulWidget {
  var uid;
  AddCardsPage(this.uid);
  @override
  _AddCardsPageState createState() => _AddCardsPageState();
}
class _AddCardsPageState extends State<AddCardsPage> {
  _AddCardsPageState(){}
  var termController = TextEditingController();
  var detailController = TextEditingController();
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
          title: Text("Add a New Flashcard"),
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
                        child: Text('New Card',
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
                          controller: termController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Term',
                            hintText: 'New Term',
                            border: OutlineInputBorder(),
                            fillColor: Color(0xfff3f3f4),
                            filled: true,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10, right: 30, left: 30),
                        child: TextField(
                          controller: detailController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Detail',
                            hintText: 'Description',
                            border: OutlineInputBorder(),
                            fillColor: Color(0xfff3f3f4),
                            filled: true,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 5, right: 30, left: 30),
                        width: 200,
                        height: 70,
                        child: RaisedButton(
                          child: Text("Add", style: TextStyle(fontSize: 22.0),),
                          textColor: Colors.white,
                          color: Colors.purple,
                          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                          onPressed: (){
                            termController.text;
                            detailController.text;
                            var newCard = {
                              termController.text : detailController.text,
                            };
                            FirebaseDatabase.instance.reference().child("Users/" + widget.uid).child("/MyCards/").child(termController.text)//push()
                                .set(detailController.text).then((value){//.set(newCard).then((value){
                              termController.text = "";
                              detailController.text = "";
                              FirebaseDatabase.instance.reference().child("Users/" + widget.uid + "/MyCards/").onChildAdded.listen((event) {
                                print("Card Added.");
                              });
                              Navigator.pop(context);
                            }).catchError((error){
                              print("Failed to Add.");
                            });
                            setState(() {});
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