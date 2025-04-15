import 'package:flutter/material.dart';
import 'package:rental/utils/Extensions.dart';
import 'package:rental/utils/FavoriteUtils.dart';
import '../models/Estate.dart';

class EstateDetailsPage extends StatefulWidget {
  final Estate estate;

  const EstateDetailsPage({required this.estate});

  @override
  _EstateDetailsPageState createState() => _EstateDetailsPageState();
}

class _EstateDetailsPageState extends State<EstateDetailsPage>{
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async{
    final status = await FavoriteUtils.isFavorite(widget.estate.id);
    setState(() {
      isFavorite = status;
    });
  }

  Future<void> _toggleFavorite() async{
  await FavoriteUtils.toggleFavorite(widget.estate.id);
  setState(() {
    isFavorite = !isFavorite;
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.estate.title),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: _toggleFavorite,
          )
        ]
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.estate.imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),

            Text(
              widget.estate.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            Text(
              "\$${widget.estate.price}",
              style: TextStyle(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(

              "This is a detailed description of the property. It includes information about the location, amenities, and unique features of the estate.",
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            Text(
              "Property Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildFeaturesTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesTable(){
    return Column(
      children: widget.estate.features.entries.map((entry){
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              entry.key.capitalize(),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[800]),
            ),
            Text(
              entry.value.toString().capitalize(),
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ],
        );
      }).toList(),
    );
  }
}