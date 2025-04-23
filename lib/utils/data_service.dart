import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental/models/Category.dart';
import 'package:rental/models/City.dart';
import 'package:rental/models/Estate.dart';
import 'package:rental/models/Users.dart';

class DataService {
  Future<List<Category>> fetchCategories() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('categories').get();
    return snapshot.docs.map((doc) => Category.fromFirestore(doc)).toList();
  }

  Future<List<Estate>> fetchEstates() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('estates').get();
    return snapshot.docs.map((doc) => Estate.fromFirestore(doc)).toList();
  }

  Future<User> fetchExampleUser() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
    return User.fromFirestore(snapshot.docs[0]);
  }

  Future<List<City>> fetchCities() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('cities').get();
    return snapshot.docs.map((doc) => City.fromFirestore(doc)).toList();
  }
}