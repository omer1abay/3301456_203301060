import 'package:flutter/services.dart';
import 'package:netflixclone/views/home/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netflixclone/views/LoadingScreen.dart';
import 'package:netflixclone/views/register/SignUp.dart';
import 'package:netflixclone/models/User.dart';
import '../../services/auth_service.dart';
import '../../services/dosyaIslemleri.dart';

class LoginPage extends StatefulWidget {
  static String ?username;
  late Future ?veri;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final formKey = GlobalKey<FormState>();
  final User user = User.empty();
  String checkUser = "";
  String password = "";
  var ekranBilgisi;
  late double width;
  late double height;
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
            width: width,
            height: height,
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logo(),
                  userName(),
                  Password(),
                  Login(),
                  LoginWithGoogle(),
                  Sign(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget logo() {
    return Image.asset("resimler/logo2.png");
  }

  Widget userName() {
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

  Widget Password() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: _passwordController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "Sifre",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        obscureText: true,
      ),
    );
  }

  Widget Login() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: width,
        height: height / 15,
        child: ElevatedButton(
          onPressed: () {
            String veri = _emailController.text.substring(0,_emailController.text.indexOf("@"));
            _dosyaIslemleri.veriYaz(veri);
            _loginWithEmail();
          },
          child: Text("Giriş Yap"),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget LoginWithGoogle() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: width,
        height: height / 15,
        child: ElevatedButton(
          onPressed: () {
            _logInWithGoogle();
          },
          child: Text("Google ile Giriş Yap"),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
        ),
      ),
    );
  }


  Widget Sign() {
    return TextButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUp()));
      },
      child: Text(
        "Kayıt Ol",
        style: TextStyle(color: Colors.red, fontSize: 20),
      ),
    );
  }

  void _logInWithGoogle(){
    _authservice.signInWithGoogle().then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DrawerPage()));
    }).whenComplete(() => null);
  }

  void _loginWithEmail() {

    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      _authservice
          .signInWithEmail(_emailController.text, _passwordController.text)
          .then((value) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Container(
              color: Colors.transparent,
              child: const Center(child: LoadingPage()),
            );
          },
        );
        Future.delayed(const Duration(milliseconds: 1000), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DrawerPage()));
        });
      }).catchError((error) {
        if (error.toString().contains('wrong-password')) {
          _warningToast("Yanlış Parola");
        }
        else if (error.toString().contains('user-not-found')) {
          _warningToast("Girilen Kullanıcıya Ait Bilgiler Bulunamadı.");
        }
        else if (error.toString().contains('invalid-email')) {
          _warningToast("Lütfen Geçerli Bir E-mail Adresi Giriniz.");
        }else{
          _warningToast("${error.toString()}");
        }
      }).whenComplete(() => null);
    } else {
      _warningToast("İstenilen Bilgileri Lütfen Eksiksiz Giriniz");
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
        fontSize: 14);
  }


}










