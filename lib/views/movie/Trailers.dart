import 'dart:io';
import 'package:flutter/material.dart';
import 'package:netflixclone/models/FilmModel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Trailers extends StatefulWidget {

  late FilmModel film;

  Trailers(this.film);

  @override
  _TrailersState createState() => _TrailersState();
}

class _TrailersState extends State<Trailers> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.film.filmName}  fragmanı"),
        backgroundColor: Colors.red,
      ),
      body: WebView(
        initialUrl: widget.film.videoName,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
