import 'package:flutter/material.dart';
import 'package:rental/utils/route_generator.dart';
import 'package:rental/widgets/main/section_header.dart';

import '../../models/Estate.dart';
import 'estate_list.dart';

class Section extends StatelessWidget {
  final String title;
  final List<Estate> estates;

  const Section({
    required this.title,
    required this.estates
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
            title: title,
            onSeeAllPressed: () =>
              Navigator.pushNamed(
                  context,
                  AppRoutes.categoryEstateList,
                  arguments: {
                    'title': title,
                    'estates': estates
                  })

        ),

        SizedBox(height: 8),

        EstateList(estates: estates),
      ],
    );
  }
}
