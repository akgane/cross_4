import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/City.dart';

class MapPage extends StatefulWidget{
  List<City> cities;

  MapPage({required this.cities});

  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>{
  late GoogleMapController mapController;

  LatLng _center = const LatLng(51.169392, 71.449074);

  City? selectedCity;

  void _onMapCreated(GoogleMapController controller){
    mapController = controller;
  }

  void _updateMapCenter(City city){
    setState(() {
      _center = LatLng(city.lat, city.lan);
      selectedCity = city;
    });

    mapController.animateCamera(
      CameraUpdate.newLatLng(_center)
    );
  }

  @override
  Widget build(BuildContext context){
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc!.p_map),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButton<City>(
              value: selectedCity,
              hint: Text(loc.map_select_city),
              isExpanded: true,
              items: widget.cities.map((City city){
                return DropdownMenuItem<City>(value: city, child: Text(city.name));
              }).toList(),
              onChanged: (City? newValue){
                if(newValue != null){
                  _updateMapCenter(newValue);
                }
              },
            )
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(target: _center, zoom: 12.0),
            )
          )
        ]
      )
    );
  }
}