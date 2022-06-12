import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';

class DosyaIslemleri{


  Future<void> veriYaz(String veri) async{
    var ad = await getApplicationDocumentsDirectory();

    var uygulamaDosyalamaYolu = await ad.path;

    var dosya = File("$uygulamaDosyalamaYolu/username.txt");

    dosya.writeAsString(veri);

  }

  Future<String> veriOku() async{

    try{
      var ad = await getApplicationDocumentsDirectory();

      var uygulamaDosyalamaYolu = await ad.path;

      var dosya = File("$uygulamaDosyalamaYolu/username.txt");

      String veri = await dosya.readAsString();
      print(veri);
      return veri;

    }catch(e){
      return e.toString();
    }

  }

}