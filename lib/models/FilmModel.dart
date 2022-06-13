import 'package:netflixclone/models/Kategoriler.dart';
import 'package:netflixclone/models/Yonetmenler.dart';

class FilmModel{
  late int id;
  late String filmName;
  late String videoName;
  late String imageName;
  late double imdbPoint;
  Kategoriler kategori;
  Yonetmenler yonetmen;

  FilmModel(this.id, this.filmName, this.videoName, this.imageName,
      this.imdbPoint, this.kategori, this.yonetmen);

/*
  FilmModel({required this.id_,required this.filmName});

  factory FilmModel.fromSnapshot(DocumentSnapshot snapshot){
    return FilmModel(id_: snapshot.id, filmName: snapshot["FilmName"]);
  }*/


}




