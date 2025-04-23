import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rental/utils/extensions.dart';
import 'package:rental/utils/favorites_utils.dart';
import '../models/Estate.dart';

class EstateDetailsPage extends StatefulWidget {
  final Estate estate;

  const EstateDetailsPage({required this.estate});

  @override
  _EstateDetailsPageState createState() => _EstateDetailsPageState();
}

class _EstateDetailsPageState extends State<EstateDetailsPage>{
  bool isFavorite = false;
  late GoogleMapController mapController;
  final LatLng _center = LatLng(37.7749, -122.4194);

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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              widget.estate.title,
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 4,),
            Text(
              '(${widget.estate.id})',
              style: theme.textTheme.bodySmall,
            )
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? theme.colorScheme.error : theme.iconTheme.color,
            ),
            onPressed: _toggleFavorite,
          )
        ],
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
              style: theme.textTheme.titleLarge,
            ),
            SizedBox(height: 8),

            Text(
              "\$${widget.estate.price}",
              style: TextStyle(
                  fontSize: 20,
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 16),

            Text(
              "Description",
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            Text(
              "This is a detailed description of the property. It includes information about the location, amenities, and unique features of the estate.",
              style: theme.textTheme.bodySmall,
            ),
            SizedBox(height: 16),
            Text(
              "Property Details",
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            _buildFeaturesTable(),
            SizedBox(height: 16),
            Text(
              "Location on Map",
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 15.0,
                ),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesTable(){
    final theme = Theme.of(context);
    return Column(
      children: widget.estate.features.entries.map((entry){
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              entry.key.capitalize().removeUnderscore(),
              style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              entry.value.toString().capitalize(),
              style: theme.textTheme.bodySmall,
            ),
          ],
        );
      }).toList(),
    );
  }
}