import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/services/auth_service.dart';
import 'package:netflixclone/views/movie/Favorites.dart';
import 'package:netflixclone/models/FilmModel.dart';
import 'package:netflixclone/views/login/LoginPage.dart';
import 'package:netflixclone/views/movie/Trailers.dart';

class DetailPage extends StatefulWidget {
  late FilmModel film;

  DetailPage({required this.film});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  /*YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: widget.movie!.videoName,
  );*/

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranGenisligi = ekranBilgisi.size.width;
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final _auth = auth_service();

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
              _auth.createFilm(widget.film.filmName, widget.film.imdbPoint);
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
