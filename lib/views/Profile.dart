import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/models/Notes.dart';
import 'package:netflixclone/utilities/NotesDao.dart';
import 'package:netflixclone/views/NotEkle.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late FirebaseAuth _auth;
  int _selectedIndex = 0;
  late String filmName;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
  }

  Future<List<Notes>> listele() async {
    var notListesi = await NotesDao().notGetir(_auth.currentUser!.uid);
    return notListesi;
  }

  Future<void> sil(int id) async{
    var sil = await NotesDao().notSil(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          backgroundColor: Colors.red,
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NotEkle()));
              },
            ),
          ],
        ),
        body: FutureBuilder<List<Notes>>(
            future: listele(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var notListesi = snapshot.data;
                return ListView.builder(
                  itemCount: notListesi!.length,
                  itemBuilder: (context, index) {
                    var not = notListesi[index];
                    return GestureDetector(

                      onDoubleTap: () {
                        print(not.id);
                        sil(not.id);
                        setState(() {

                        });
                      },
                      child: Card(
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Text(not.icerik),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center();
              }
            }));
  }
}
