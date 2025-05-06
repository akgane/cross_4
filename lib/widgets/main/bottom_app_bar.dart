import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../misc/app_routes.dart';
import '../../models/Estate.dart';
import '../../utils/favorites_utils.dart';
import '../../misc/route_generator.dart';

class MyBottomAppBar extends StatelessWidget{
  final List<Estate> estates;

  const MyBottomAppBar({
    super.key,
    required this.estates
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(icon: Icon(Icons.camera_alt), onPressed: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? photo = await picker.pickImage(source: ImageSource.camera);
          }),

          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () async {

              if(FirebaseAuth.instance.currentUser!.isAnonymous) return;

              List<Estate> favorites = await FavoriteUtils.getFavoriteEstates(estates);

              Navigator.pushNamed(context, AppRoutes.favorites, arguments: {'estates': favorites});
            },
          ),

          SizedBox(width: 40),

          IconButton(
              icon: Icon(Icons.message),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.chats)
          ),

          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.settings)
          ),
        ],
      ),

    );
  }
}