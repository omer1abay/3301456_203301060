
import 'package:netflixclone/FilmModel.dart';
import 'package:netflixclone/Kategoriler.dart';
import 'package:netflixclone/Yonetmenler.dart';

import 'VeritabaniYardimcisi.dart';

class FilmlerDao{
  Future<List<FilmModel>> filmleriGetir(int kategori_id) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM filmler, kategoriler, yonetmenler "
        "WHERE filmler.kategori_id = kategoriler.kategori_id and filmler.yonetmen_id = yonetmenler.yonetmen_id "
        "and filmler.kategori_id = $kategori_id");


    return List.generate(maps.length, (i) {
      var satir = maps[i];
      var k = Kategoriler(category_id: satir["kategori_id"], kategori_ad: satir["kategori_ad"]);
      var y = Yonetmenler(satir["yonetmen_id"], satir["yonetmen_ad"]);
      var f = FilmModel(satir["film_id"], satir["film_ad"], satir["videoName"], satir["film_resim"], satir["imdbPoint"], k, y);
      
      return f;
    });
  }
}