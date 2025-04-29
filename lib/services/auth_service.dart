// import 'package:firebase_auth/firebase_auth.dart';

// class AuthService{
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Future<void> registerWithEmail(String email, String password) async{
//     try{
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: email,
//           password: password
//       );
//     } on FirebaseAuthException catch (e){
//       print("Error: ${e.message}");
//     }
//   }
//
//   Future<void> login(String email, String password) async{
//     try{
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: email,
//           password: password
//       );
//     }on FirebaseAuthException catch (e){
//       print("Error: ${e.message}");
//     }
//   }
// }