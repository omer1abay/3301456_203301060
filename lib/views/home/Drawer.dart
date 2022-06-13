import 'dart:io';
import 'package:flutter/material.dart';
import 'package:netflixclone/views/Favorites.dart';
import 'package:netflixclone/views/login/LoginPage.dart';
import 'package:netflixclone/views/MainPage.dart';
import 'package:netflixclone/views/Profile.dart';
import 'package:netflixclone/views/register/Settings.dart';
import 'package:netflixclone/views/register/SignUp.dart';
import 'package:netflixclone/services/dosyaIslemleri.dart';
import 'package:netflixclone/views/weatherScreen.dart';
import 'package:path_provider/path_provider.dart';


class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  var sayfaListe = [MainPage(), Favourites.empty(), ProfilePage(), SettingsPage(),SignUp(), LoginPage(),WeatherScreen()];
  int secilen = 0;
  final dosya = DosyaIslemleri();
  final login = LoginPage();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: sayfaListe[secilen],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.red
                ),
                child: FutureBuilder(
                  future: dosya.veriOku(),
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      var veri = snapshot.data;
                      return Text("Merhaba : ${veri}", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),);
                    }else{
                      return Text("Merhaba : ", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),);
                    }
                  },
                )
            ),
            ListTile(
              title: Text("Anasayfa"),
              onTap: (){
                setState(() {
                  secilen = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Favoriler"),
              onTap: (){
                setState(() {
                  secilen = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Profil"),
              onTap: (){
                setState(() {
                  secilen = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Ayarlar"),
              onTap: (){
                setState(() {
                  secilen = 3;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Kayıt Ol"),
              onTap: (){
                setState(() {
                  secilen = 4;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Giriş Yap"),
              onTap: (){
                setState(() {
                  secilen = 5;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Hava Durumu"),
              onTap: (){
                setState(() {
                  secilen = 6;
                });
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
