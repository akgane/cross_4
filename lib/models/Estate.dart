import 'package:cloud_firestore/cloud_firestore.dart';

class Estate{
  final String id;
  final String title;
  final String category;
  final String address;
  final String imageUrl;
  final double price;
  final int views;
  final Map<String, dynamic> features;
  final DateTime postedDate;

  Estate({
    required this.id,
    required this.title,
    required this.category,
    required this.address,
    required this.imageUrl,
    required this.price,
    this.views = 0,
    required this.features,
    required this.postedDate
  });

  factory Estate.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    DateTime parsePostedDate(dynamic dateData) {
      if (dateData is String) {
        return DateTime.parse(dateData);
      } else if (dateData is Timestamp) {
        return dateData.toDate();
      } else {
        return DateTime.now();
      }
    }

    return Estate(
      id: doc.id,
      title: data['title'] ?? 'No Title',
      category: data['category'] ?? 'Unknown',
      address: data['address'] ?? 'No Address',
      imageUrl: data['imageUrl'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      postedDate: parsePostedDate(data['postedDate']),
      features: Map<String, dynamic>.from(data['features'] ?? {}),
    );
  }

  Estate copyWith() {
    return Estate(
      id: id,
      title: title,
      category: category,
      address: address,
      imageUrl: imageUrl,
      price: price,
      postedDate: postedDate,
      features: Map<String, dynamic>.from(features),
    );
  }
}