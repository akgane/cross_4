import '../models/Estate.dart';

class CategoriesUtils{
  static List<Estate> getCategoryEstates(List<Estate> allEstates, String categoryTitle){
    return allEstates.where((estate) => estate.category.toLowerCase() == categoryTitle.toLowerCase()).toList();
  }
}