import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/FavoriteList.dart';
import 'package:netflixclone/Favorites.dart';
import 'package:netflixclone/FilmModel.dart';
import 'package:netflixclone/LoginPage.dart';
import 'package:netflixclone/Trailers.dart';

class DetailPage extends StatefulWidget {
  late FilmModel film;

  DetailPage({required this.film});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  /*YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: widget.film!.videoName,
  );*/

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranGenisligi = ekranBilgisi.size.width;
    final double ekranYuksekligi = ekranBilgisi.size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.film.filmName),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.volunteer_activism),
            onPressed: () {
              FavoriteList.filmler.add(widget.film);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Favourites(widget.film)));
            },
          ),
        ],
      ),
      body: Container(
        width: ekranGenisligi,
        height: ekranYuksekligi,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Trailers(widget.film)));
                  },
                  child: GestureDetector(
                      onDoubleTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Trailers(widget.film)));
                      },
                      child: Image.asset("filmler/${widget.film.imageName}"))),
              Text(
                "Filmin Fragmanı için resime tıklayınız",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: ekranGenisligi / 25),
              ),
              Text(
                "Yönetmen : ${widget.film.yonetmen.yonetmen_ad}",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: ekranGenisligi / 20),
              ),
              Text(
                "Imdb Puanı : ${widget.film.imdbPoint}",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: ekranGenisligi / 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
