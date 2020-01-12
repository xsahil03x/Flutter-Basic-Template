import 'package:flutter_template/data/model/item.dart';

abstract class ItemRepository {
  List<Item> fetchItems();
}
