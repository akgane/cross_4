import 'package:rental/models/Estate.dart';

class SortUtils{
  static List<Estate> sortBy(String sortBy, List<Estate> estates, bool ascending){
    switch(sortBy){
      case "price":
        estates.sort((a, b) => (ascending ? a.price.compareTo(b.price) : b.price.compareTo(a.price)));
        break;
      case "title":
        estates.sort((a, b) => (ascending ? a.title.compareTo(b.title) : b.title.compareTo(a.title)));
        break;
      case "date":
        estates.sort((a, b) {
          final dateA = a.postedDate;
          final dateB = b.postedDate;
          print("${dateA} | ${dateB}");
          return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
        });
        break;
    }
    return estates;
  }

  static List<Estate> getRandom(int count, List<Estate> estates){
    estates.shuffle();
    return estates.take(count).toList();
  }
}