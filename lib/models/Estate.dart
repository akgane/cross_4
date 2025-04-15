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
}