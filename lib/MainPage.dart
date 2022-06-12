import 'package:flutter/material.dart';
import 'package:netflixclone/Kategoriler.dart';
import 'package:netflixclone/KategorilerDao.dart';

import 'FilmlerSayfa.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

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
