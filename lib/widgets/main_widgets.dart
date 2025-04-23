import 'package:flutter/material.dart';
import 'package:rental/models/Category.dart';
import 'package:rental/pages/EstateDetailsPage.dart';
import 'package:rental/utils/CategoriesUtils.dart';
import 'package:rental/utils/Extensions.dart';
import '../models/Estate.dart';
import '../pages/AllEstatesPage.dart'; // Импортируем модель Estate

class TopBar extends StatelessWidget{
  final String username;

  const TopBar({required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/1.jpg'),
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Welcome back!",
                style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyMedium?.color)),
            Text(
                username,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyMedium?.color)),
          ],
        ),
        Spacer(),
        Icon(
            Icons.notifications_none,
            color: Theme.of(context).iconTheme.color,
        ),
      ],
    );
  }
}

class CategoriesSection extends StatelessWidget{
  final List<Category> categories;
  final List<Estate> allEstates;

  CategoriesSection({required this.categories, required this.allEstates});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 12, crossAxisSpacing: 12),
      itemBuilder: (context, index){
        final category = categories[index];
        return GestureDetector(
          onTap: (){
            Navigator.push(
                context, 
                MaterialPageRoute(
                    builder:
                        (context) =>
                            AllEstatesPage
                              (
                                title: category.title,
                                estates: CategoriesUtils.getCategoryEstates(allEstates, category.title)
                            )
                )
            );
          },
            child: Column(
              children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  // color: Colors.grey[200],
                  color: Theme.of(context).cardColor,
                ),
                padding: EdgeInsets.all(12),
                child: Icon(
                    category.icon,
                    color: Theme.of(context).iconTheme.color
                ),
              ),
              SizedBox(height: 4),
              Text(
                  category.title,
                  style: TextStyle(
                    fontSize: 14, color: Theme.of(context).textTheme.bodyMedium?.color
                  )
              ),
            ],
          )
        );
      },
    );
  }
}

// Виджет для отображения секции (заголовок + список недвижимости)
class Section extends StatelessWidget {
  final String title;
  final List<Estate> estates;

  const Section({required this.title, required this.estates});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: title,
          onSeeAllPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllEstatesPage(title: title, estates: estates)),
            );
          }
        ),
        EstateList(estates: estates),
      ],
    );
  }
}

// Виджет для заголовка секции
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAllPressed;

  const SectionHeader({required this.title, required this.onSeeAllPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onSeeAllPressed,
          child: Text(
            "See all",
            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}

// Виджет для списка недвижимости
class EstateList extends StatelessWidget {
  final List<Estate> estates;

  const EstateList({required this.estates});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 200,
      margin: EdgeInsets.only(top: 12),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: estates.length,
        separatorBuilder: (_, __) => SizedBox(width: 12),
        itemBuilder: (context, index) {
          final estate = estates[index];
          return GestureDetector(
            onTap: (){
              estate.increaseViews();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EstateDetailsPage(estate: estate)
                )
              );
            },
            child: Container(
              width: 160,
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                      blurRadius: 6
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      estate.imageUrl,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          estate.title,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 14, color: Colors.grey),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                estate.address,
                                style: TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          "\$${estate.price}",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          );
        },
      ),
    );
  }
}