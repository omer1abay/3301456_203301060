import 'package:flutter/material.dart';
import 'package:netflixclone/views/movie/DetailPage.dart';
import 'package:netflixclone/models/FilmModel.dart';
import 'package:netflixclone/utilities/FilmlerDao.dart';
import 'package:netflixclone/models/Kategoriler.dart';
import 'package:netflixclone/views/movie/Trailers.dart';
import 'package:netflixclone/models/Yonetmenler.dart';

class FilmlerSayfa extends StatefulWidget {
  Kategoriler kategori;
  FilmlerSayfa({required this.kategori});

  @override
  State<FilmlerSayfa> createState() => _FilmlerSayfaState();
}

class _FilmlerSayfaState extends State<FilmlerSayfa> {

  Future<List<FilmModel>> listele(int kategori_id) async {
    var filmListesi = await FilmlerDao().filmleriGetir(kategori_id);

    return filmListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filmler : ${widget.kategori.kategori_ad}"),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<List<FilmModel>>(
        future: listele(widget.kategori.category_id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var filmlerListesi = snapshot.data;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3.5
              ),
              itemCount: filmlerListesi!.length,
              itemBuilder: (context, index)  {
                var kategori = filmlerListesi[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(film: filmlerListesi[index],)));
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("filmler/${filmlerListesi[index].imageName}"),
                        ),
                        Text(filmlerListesi[index].filmName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      ],
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
