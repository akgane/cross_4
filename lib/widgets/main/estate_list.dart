import 'package:flutter/material.dart';
import 'package:rental/utils/route_generator.dart';

import '../../models/Estate.dart';
import '../../pages/EstateDetailsPage.dart';
import '../../widgets/main/estate_card.dart';

class EstateList extends StatelessWidget {
  final List<Estate> estates;

  const EstateList({
    required this.estates
  });

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
        itemBuilder: (context, index){
          final estate = estates[index];
          return EstateCard(
            estate: estate,
            onTap: (){
              estate.increaseViews();

              Navigator.pushNamed(
                context,
                AppRoutes.estateDetails,
                arguments: {
                  'estate' : estate
                }
              );
            }
          );
        }
      )
    );
  }
}