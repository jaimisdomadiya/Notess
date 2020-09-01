import 'package:FIREBASELOGIN/database_helper.dart';
import 'package:FIREBASELOGIN/screens/note_details.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'Note.dart';


class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note>noteList;
  int count = 0;

  String displayName;
  FirebaseUser user;

  bool isSignedIn = false;

  checkAuthentication() async {
    _auth.onAuthStateChanged.listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, "/SigninPage");
      }
     });
  }
  
  getUser() async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    await firebaseUser?.reload();
    firebaseUser = await _auth.currentUser();

    if (firebaseUser != null) {
      setState((){
        this.user = firebaseUser;
        this.isSignedIn = true;
        this.displayName = user.displayName;
      });
    }
    // print(this.user);
  }
  
  signOut() async {
    _auth.signOut();
  }

  @override
  void initState(){
    super.initState();
    this.checkAuthentication();
    this.getUser();
  }


  @override
  Widget build(BuildContext context) {
    if (noteList == null){
      noteList = List<Note>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Note'),
        backgroundColor: Colors.black87,
      ),
      

      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Jaimis"),
              accountEmail: Text("jemish@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.black
                        : Colors.black,
                child: Icon(Icons.person, color: Colors.green,),
                
              ),
            ),
            ListTile(
              onTap: (){
                Navigator.pushNamed(context, "/NoteList");
              },
              title: Text("Home"),
              leading: Icon(Icons.home),
            ),
            ListTile(
              onTap: (){
                Navigator.pushNamed(context, "/Profile");
              },
              title: Text("Profile"),
              leading: Icon(Icons.account_circle),
            ),
            ListTile(
              title: Text("Events"),
              leading: Icon(Icons.event_note),
            ),
            ListTile(
              title: Text("Notification"),
              leading: Icon(Icons.notifications),
            ),
          ]
        
        ),
      ),
      
      body: getNoteListView(),
      
        floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: () {
          navigateToDetail(Note('', '', 2), 'Add Note');
        },
      ),
    );
  }
  ListView getNoteListView(){
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, position){
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.black,
          elevation: 4.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/12.png'),
            ),
            title: Text(this.noteList[position].title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
          subtitle: Text(this.noteList[position].date,
          style: TextStyle(
              color: Colors.white,
            ),
          ),
          trailing: GestureDetector(
            child: Icon(Icons.open_in_new, color: Colors.white),
            onTap: (){
              navigateToDetail(this.noteList[position], 'Edit Todo');
            },
          ),
        ),
      );
    },
  );
}

    void navigateToDetail(Note note, String title) async {
      bool result = await Navigator.push(context, MaterialPageRoute(builder: (context){
        return NoteDetail(note, title);
      }));

      if (result == true){
        // update the view
        updateListView();
      }
    }
    void updateListView(){
      final Future<Database> dbFuture = databaseHelper.initializeDatabase();
      dbFuture.then((database){
        Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
        noteListFuture.then((noteList){
          setState(() {
            this.noteList = noteList;
            this.count = noteList.length;
          });
        });
      });
    }
}