import 'package:flutter/material.dart';
import 'package:rental/pages/all_estates_page.dart';
import 'package:rental/utils/categories_utils.dart';
import 'package:rental/misc/route_generator.dart';
import 'package:rental/widgets/main/category_card.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../misc/app_routes.dart';
import '../../models/Category.dart';
import '../../models/Estate.dart';

class CategoriesSection extends StatelessWidget{
  final List<Category> categories;
  final List<Estate> allEstates;

  CategoriesSection({
    required this.categories,
    required this.allEstates
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            AppLocalizations.of(context)!.m_categories,
            style: theme.textTheme.titleMedium
          )
        ),

        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: categories.map((category){
            return CategoryCard(
              title: category.title,
              icon: category.icon,
              onTap: () =>
                Navigator.pushNamed(
                  context,
                  AppRoutes.categoryEstateList,
                  arguments: {
                    'title': category.title,
                    'estates': allEstates
                  }
                ),
            );
          }).toList(),
        )
      ],
    );
  }
}
