import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/utilities/FavoriteList.dart';
import 'package:netflixclone/pages/Favorites.dart';
import 'package:netflixclone/models/FilmModel.dart';
import 'package:netflixclone/pages/LoginPage.dart';
import 'package:netflixclone/pages/Trailers.dart';

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
                "Filmin Fragman?? i??in resime t??klay??n??z",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: ekranGenisligi / 25),
              ),
              Text(
                "Y??netmen : ${widget.film.yonetmen.yonetmen_ad}",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: ekranGenisligi / 20),
              ),
              Text(
                "Imdb Puan?? : ${widget.film.imdbPoint}",
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
