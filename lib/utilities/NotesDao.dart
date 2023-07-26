import 'package:netflixclone/models/Notes.dart';
import 'package:netflixclone/services/VeritabaniYardimcisi.dart';
import 'package:sqflite/sqflite.dart';

class NotesDao{
  Future<List<Notes>> notGetir(String userId) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM notlar WHERE notlar.user_id = '$userId'");

    return List.generate(maps.length, (i)  {
      var satir = maps[i];
      return Notes(satir["id"],icerik: satir["icerik"], user_id : satir["user_id"]);
    });
  }

  Future<void> notEkle(String content, String userId) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var bilgiler = Map<String,dynamic>();
    bilgiler["icerik"] = content;
    bilgiler["user_id"] = userId;


    var maps = await db.insert("notlar",bilgiler);
    if(maps != null){
      print("Ekleme başarılı");
    }
    await db.batch().commit();
  }
  
  Future<void> notSil(int id) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var maps = await db.rawQuery("DELETE FROM notlar WHERE notlar.id = $id");
  }
  
}