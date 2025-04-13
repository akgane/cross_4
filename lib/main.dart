import 'package:flutter/material.dart';
import 'package:rental/data/data.dart';
import 'package:rental/models/Category.dart';
import 'package:rental/widgets/main_widgets.dart';

import 'models/Estate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rental Estate App',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Category> categories = List.from(exampleCategories);
    final List<Estate> estates = List.from(exampleEstates);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TopBar(username: "User name"),
            SizedBox(height: 16),
            CategoriesSection(categories: categories),
            SizedBox(height: 24),
            Section(title: "New", estates: estates),
            SizedBox(height: 24),
            Section(title: "Popular", estates: estates),
            SizedBox(height: 24),
            Section(title: "Test", estates: estates)
          ]
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(Icons.home), onPressed: () {}),
            IconButton(icon: Icon(Icons.favorite), onPressed: () {}),
            SizedBox(width: 40),
            IconButton(icon: Icon(Icons.message), onPressed: () {}),
            IconButton(icon: Icon(Icons.settings), onPressed: () {}),
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.orange,
        shape: CircleBorder(),
        child: Icon(Icons.swap_horiz),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}





// class HomePage extends StatelessWidget {
//   final categories = [
//     {'label': 'Home', 'image': Icons.home},
//     {'label': 'Office', 'image': Icons.business},
//     {'label': 'Apartment', 'image': Icons.apartment},
//     {'label': 'Villa', 'image': Icons.villa},
//   ];
//
//   final properties = [
//     {
//       'title': 'City Penthouse',
//       'address': '999 Skyline Avenue',
//       'price': '\$300,000.00',
//       'image': 'https://via.placeholder.com/150'
//     },
//     {
//       'title': 'Tropical House',
//       'address': '456 Paradise Lane',
//       'price': '\$300,000.00',
//       'image': 'https://via.placeholder.com/150'
//     },
//     {
//       'title': 'One more Tropical House',
//       'address': '456 Paradise Lane',
//       'price': '\$2,400,000.00',
//       'image': 'https://via.placeholder.com/150'
//     }
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             // Header
//             Row(
//               children: [
//                 CircleAvatar(
//                   backgroundImage: NetworkImage(
//                       'https://via.placeholder.com/150'),
//                   child: const Text("?"),// Replace with real user photo
//                 ),
//                 SizedBox(width: 12),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Welcome back", style: TextStyle(fontSize: 12)),
//                     Text("Username",
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//                 Spacer(),
//                 Icon(Icons.notifications_none),
//               ],
//             ),
//             SizedBox(height: 16),
//             // Categories
//             GridView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: categories.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 4, mainAxisSpacing: 12, crossAxisSpacing: 12),
//               itemBuilder: (context, index) {
//                 final item = categories[index];
//                 return Column(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: Colors.grey[200],
//                       ),
//                       padding: EdgeInsets.all(12),
//                       child: Icon(item['image'] as IconData),
//                     ),
//                     SizedBox(height: 4),
//                     Text(item['label']!.toString()),
//                   ],
//                 );
//               },
//             ),
//             SizedBox(height: 24),
//             // Popular section
//             sectionHeader("Popular"),
//             propertyList(),
//             SizedBox(height: 24),
//             // New section
//             sectionHeader("New"),
//             propertyList(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         shape: CircularNotchedRectangle(),
//         notchMargin: 8,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(icon: Icon(Icons.home), onPressed: () {}),
//             IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
//             SizedBox(width: 40), // Space for FAB
//             IconButton(icon: Icon(Icons.message_outlined), onPressed: () {}),
//             IconButton(icon: Icon(Icons.person_outline), onPressed: () {}),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         child: Icon(Icons.swap_horiz),
//         backgroundColor: Colors.orange,
//         shape: CircleBorder(),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
//
//   Widget sectionHeader(String title) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(title,
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         Text("See all",
//             style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w500))
//       ],
//     );
//   }
//
//   Widget propertyList() {
//     return Container(
//       height: 220,
//       margin: EdgeInsets.only(top: 12),
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: properties.length,
//         separatorBuilder: (_, __) => SizedBox(width: 12),
//         itemBuilder: (context, index) {
//           final item = properties[index];
//           return Container(
//             width: 160,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(color: Colors.grey.shade200, blurRadius: 6)
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ClipRRect(
//                     borderRadius:
//                     BorderRadius.vertical(top: Radius.circular(16)),
//                     child: Image.network(item['image']!,
//                         height: 100, width: double.infinity, fit: BoxFit.cover)),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(item['title']!,
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 14)),
//                       Row(
//                         children: [
//                           Icon(Icons.location_on,
//                               size: 14, color: Colors.grey),
//                           SizedBox(width: 4),
//                           Expanded(
//                               child: Text(item['address']!,
//                                   style: TextStyle(fontSize: 12),
//                                   overflow: TextOverflow.ellipsis)),
//                         ],
//                       ),
//                       SizedBox(height: 4),
//                       Text(item['price']!,
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.orange)),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

