import 'package:flutter/material.dart';
import 'package:netflixclone/FavoriteList.dart';
import 'package:netflixclone/FilmModel.dart';

import 'DetailPage.dart';

class Favourites extends StatefulWidget {
  late FilmModel film;

  Favourites(this.film);
  Favourites.empty();

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranGenisligi = ekranBilgisi.size.width;
    final double ekranYuksekligi = ekranBilgisi.size.height;

    /*setState(() {
      FavoriteList.filmler.add(widget.film);
    });*/

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoriler"),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                FavoriteList.filmler.clear();
              });
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: ListView.builder(
          itemCount: FavoriteList.filmler.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: ekranYuksekligi / 5,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(film: FavoriteList.filmler[index])));
                },
                child: Card(
                  color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        FavoriteList.filmler[index].filmName,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: ekranGenisligi / 20),
                      ),
                      Text(
                        "Imdb Puanı : " +
                            FavoriteList.filmler[index].imdbPoint.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: ekranGenisligi / 20),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
