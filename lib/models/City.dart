import 'package:cloud_firestore/cloud_firestore.dart';

class City{
  String name;
  double lat;
  double lan;

  City({required this.name, required this.lat, required this.lan});

  factory City.fromFirestore(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;

    return City(
      name: data['name'] ?? 'No city name',
      lat: (data['lat'] as num?)?.toDouble() ?? 51.169392,
      lan: (data['lan'] as num?)?.toDouble() ?? 71.449074
    );
  }
}