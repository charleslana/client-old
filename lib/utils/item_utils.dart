import '../data/images.dart';

String getItemImage(int id) {
  switch (id) {
    case 1:
      return item1;
    case 2:
      return item2;
    case 3:
      return item3;
    case 4:
      return item4;
    default:
      return item1;
  }
}
