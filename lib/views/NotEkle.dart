import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/utilities/NotesDao.dart';

class NotEkle extends StatefulWidget {
  const NotEkle({Key? key}) : super(key: key);

  @override
  State<NotEkle> createState() => _NotEklePageState();
}

class _NotEklePageState extends State<NotEkle> {
  final TextEditingController notEditingController = TextEditingController();
  late FirebaseFirestore _services;
  late FirebaseAuth _auth;

  Future<void> ekle(String content, String id) async {
    await NotesDao().notEkle(content, id);
  }

  @override
  void initState() {
    super.initState();
    _services = FirebaseFirestore.instance;
    _auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        actions: [
          IconButton(
              onPressed:  () {
                ekle(notEditingController.text, _auth.currentUser!.uid);
                Navigator.pop(context);
              },
              icon: Icon(Icons.add)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          controller: notEditingController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: "Notunuzu Giriniz",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}
