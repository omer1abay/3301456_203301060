import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netflixclone/views/LoadingScreen.dart';
import 'package:netflixclone/services/auth_service.dart';
import 'package:netflixclone/services/dosyaIslemleri.dart';

import '../../models/User.dart';

class SignUp extends StatefulWidget {
  static List<User> userList = <User>[];

  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  late var ekranBilgisi;
  late double width;
  late double height;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final auth_service _authservice = auth_service();
  final DosyaIslemleri _dosyaIslemleri = DosyaIslemleri();

  @override
  Widget build(BuildContext context) {
    ekranBilgisi = MediaQuery.of(context);
    width = ekranBilgisi.size.width;
    height = ekranBilgisi.size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            height: height,
            width: width,
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Logo(), Email(), UserName(), Password(), Sign()],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Logo() {
    return Image.asset("resimler/logo2.png");
  }

  Widget Email() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "E-Mail",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget UserName() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: _usernameController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "Kullanici Adi",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget Password() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "Sifre",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget Sign() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: width,
        height: height / 15,
        child: ElevatedButton(
          onPressed: () {
            _registerOnTap();
          },
          child: Text("Kayıt Ol"),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
        ),
      ),
    );
  }

  void _registerOnTap() {
    if (_usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _emailController.text.isNotEmpty) {
      _authservice.createPerson(_usernameController.text, _emailController.text, _passwordController.text)
          .then((value) => {Navigator.pop(context)})
          .catchError((error){_warningToast(error);})
          .whenComplete(() => null);
    } else {
      _warningToast("Lütfen istenilen bilgileri eksiksiz giriniz");
    }
  }

  Future<bool?> _warningToast(String text) {
    return Fluttertoast.showToast(
        msg: text,
        timeInSecForIosWeb: 2,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14
    );
  }

}
