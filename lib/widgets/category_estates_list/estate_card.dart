import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental/utils/route_generator.dart';
import '../../models/Estate.dart';
import '../../pages/EstateDetailsPage.dart';
import '../../utils/favorites_utils.dart';

class EstateCardStyles {
  static const double cardMarginBottom = 16;
  static const double borderRadius = 12;
  static const double imageWidth = 190;
  static const double imageHeight = 120;
  static const double iconSize = 16;
  static const double paddingAll = 12;
  static const double spacingSmall = 4;
  static const double spacingMedium = 8;
}

class EstateCard extends StatefulWidget{
  final Estate estate;

  const EstateCard({required this.estate});

  @override
  State<StatefulWidget> createState() => _EstateCardState();
}

class _EstateCardState extends State<EstateCard>{
  bool isFavorite = false;

  @override void initState() {
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

  Widget _buildTitle(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(EstateCardStyles.paddingAll),
      child: Text(
        widget.estate.title,
        style: Theme.of(context).textTheme.titleMedium
      )
    );
  }

  Widget _buildImage(BuildContext context){
    return ClipRRect(
      borderRadius: BorderRadius.circular(EstateCardStyles.borderRadius),
      child: Image.network(
        widget.estate.imageUrl,
        width: EstateCardStyles.imageWidth,
        height: EstateCardStyles.imageHeight,
        fit: BoxFit.cover
      )
    );
  }

  Widget _buildDetails(BuildContext context){
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.estate.address,
            style: theme.textTheme.bodySmall,
          ),

          SizedBox(height: EstateCardStyles.spacingMedium),

          Text(
            '\$${widget.estate.price}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.secondary
            )
          )
        ]
      )
    );
  }

  Widget _buildViewsCounter(BuildContext context){
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          Icons.visibility,
          size: EstateCardStyles.iconSize,
          color: theme.textTheme.bodySmall?.color
        ),

        SizedBox(width: EstateCardStyles.spacingSmall,),

        Text(
          '${widget.estate.views} views',
          style: theme.textTheme.bodySmall
        )
      ]
    );
  }

  Widget _buildFavoriteButton(BuildContext context){
    final theme = Theme.of(context);
    return IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite
              ? theme.colorScheme.error
              : theme.iconTheme.color
        ),
      onPressed: _toggleFavorite,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
        onTap: () {
          widget.estate.increaseViews();

          Navigator.pushNamed(
              context,
              AppRoutes.estateDetails,
              arguments:
              {
                'estate': widget.estate
              });
        },
        child: Container(
          margin: EdgeInsets.only(bottom: EstateCardStyles.cardMarginBottom),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(EstateCardStyles.borderRadius),
            boxShadow: [
              BoxShadow(
                color:  theme.colorScheme.onSurface.withValues(alpha: 0.2),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(context),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: EstateCardStyles.paddingAll),

                  _buildImage(context),

                  SizedBox(width: EstateCardStyles.paddingAll),

                  _buildDetails(context),

                  _buildFavoriteButton(context)
                ]
              ),

              Padding(
                padding: const EdgeInsets.all(EstateCardStyles.paddingAll),
                child: _buildViewsCounter(context)
              )
            ],
          ),
        )
    );
  }
}