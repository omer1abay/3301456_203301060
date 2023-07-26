import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:netflixclone/models/FilmModel.dart';
import 'package:netflixclone/views/LoadingScreen.dart';

class auth_service{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithEmail(String email, String password) async{
    var user = await _auth.signInWithEmailAndPassword(email: email, password: password).whenComplete(() => null);
    return user.user;
  }

  Future signOut() async{
    return await _auth.signOut();
  }

  Future<User?> createPerson(String username, String email, String password) async{
    var user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    await _firestore.collection("Person").doc(user.user?.uid ?? "").set({'username' : username, 'email':email,'password':password});
    return user.user;
  }

  Future createFilm(String filmName, double imdbPoint) async{
    var user = _auth.currentUser;
    final docFilm = _firestore.collection("Movies").doc("${filmName+user!.uid}");


    final json = {
      'filmName' : filmName,
      'imdbPoint' : imdbPoint,
      'id' : user.uid
    };

    await docFilm.set(json);
  }

  Future<UserCredential> signInWithGoogle() async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
    return _auth.signInWithCredential(credential);
  }

}