import 'package:flutter/material.dart';
import 'package:netflixclone/models/Kategoriler.dart';
import 'package:netflixclone/services/auth_service.dart';
import 'package:netflixclone/utilities/KategorilerDao.dart';
import 'package:netflixclone/views/login/LoginPage.dart';

import '../movie/FilmlerSayfa.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final _auth = auth_service();

  Future<List<Kategoriler>> listele() async {
    var kategoriListesi = await KategorilerDao().kategoriGetir();
    return kategoriListesi;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Netflix"),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _auth.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Kategoriler>>(
        future: listele(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var kategoriListesi = snapshot.data;
            return ListView.builder(
                itemCount: kategoriListesi!.length,
                itemBuilder: (context, index)  {
                  var kategori = kategoriListesi[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FilmlerSayfa(kategori: kategori,)));
                    },
                    child: Card(
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(kategori.kategori_ad),
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
        },

      ),
    );
  }
}
