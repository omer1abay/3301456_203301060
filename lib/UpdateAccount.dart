import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/Drawer.dart';
import 'package:netflixclone/Settings.dart';
import 'package:netflixclone/auth_service.dart';

import 'User.dart';

class UpdateAccount extends StatefulWidget {

  const UpdateAccount({Key? key}) : super(key: key);

  @override
  _UpdateAccountState createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount> {
  final formKey = GlobalKey<FormState>();
  late var ekranBilgisi;
  late double width;
  late double height;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;


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
                children: [Email(), UserName(), Password(), Sign(),Sign1(),Sign2()],
              ),
            ),
          ),
        ),
      ),
    );
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
            final docUser = FirebaseFirestore.instance.collection("Person").doc(_auth.currentUser?.uid);
            docUser.update({"username":_usernameController.text});
            Navigator.push(context, MaterialPageRoute(builder: (context) => DrawerPage()));
          },
          child: Text("Ad Güncelle"),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget Sign1() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: width,
        height: height / 15,
        child: ElevatedButton(
          onPressed: () {
            final docUser = FirebaseFirestore.instance.collection("Person").doc(_auth.currentUser?.uid);
            docUser.update({"email":_emailController.text});
            Navigator.push(context, MaterialPageRoute(builder: (context) => DrawerPage()));
          },
          child: Text("E-mail Güncelle"),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget Sign2() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: width,
        height: height / 15,
        child: ElevatedButton(
          onPressed: () {
            final docUser = FirebaseFirestore.instance.collection("Person").doc(_auth.currentUser?.uid);
            docUser.update({"password":_passwordController.text});
            Navigator.push(context, MaterialPageRoute(builder: (context) => DrawerPage()));
          },
          child: Text("Şifre Güncelle"),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
        ),
      ),
    );
  }

}
