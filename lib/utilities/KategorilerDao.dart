
import 'package:netflixclone/Kategoriler.dart';
import 'package:netflixclone/VeritabaniYardimcisi.dart';

class KategorilerDao{

  //Tum kategorileri aliyoruz
  Future<List<Kategoriler>> kategoriGetir() async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM kategoriler");


    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Kategoriler(category_id: satir["kategori_id"], kategori_ad: satir["kategori_ad"]);
    });
  }
}