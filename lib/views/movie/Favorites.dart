import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/services/auth_service.dart';
import 'package:netflixclone/models/FilmModel.dart';
import 'package:netflixclone/views/home/MainPage.dart';

import 'DetailPage.dart';

class Favourites extends StatefulWidget {
  late FilmModel film;

  Favourites(this.film);
  Favourites.empty();

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {

  late FirebaseFirestore _services;
  late FirebaseAuth _auth;
  int _selectedIndex = 0;
  late String filmName;

  @override
  void initState() {
    super.initState();
    _services = FirebaseFirestore.instance;
    _auth = FirebaseAuth.instance;
  }

  Stream<QuerySnapshot> getFilm(String kulId) {
    var docm = _services
        .collection("Movies")
        .where("id", isEqualTo: kulId)
        .snapshots();
    return docm;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Favori Filmler"),
        leading: const Icon(Icons.movie),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              final docUser = _services.collection("Movies").doc(filmName+_auth.currentUser!.uid);
              docUser.delete();
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: getFilm(_auth.currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (BuildContext context, int index) {
                var film = snapshot.data!.docs[index];

                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.movie_outlined),
                        focusColor: Colors.red,
                        title: Text(
                          film["filmName"],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(film["imdbPoint"].toString()),
                        // isThreeLine: true,
                        selected: index == _selectedIndex,
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                            filmName = film["filmName"];

                          });
                        },
                      ),
                    ],
                  ),
                );
              })
              : const CircularProgressIndicator();
        },
      ),
    );
  }
}
