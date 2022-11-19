import 'package:app_proposal/auth/read%20data/get_user_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        title: const Text('I-translate mo app!'
            ),
            actions: [
              GestureDetector(
                onTap: (() {
                  FirebaseAuth.instance.signOut();
                }),
                child:Icon(Icons.logout)),
            ],
      ),
    );
  }
}