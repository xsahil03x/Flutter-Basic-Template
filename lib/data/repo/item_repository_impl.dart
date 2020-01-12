import 'package:flutter_template/data/item_repository.dart';
import 'package:flutter_template/data/model/item.dart';
import 'package:flutter_template/data/remote/api_base_helper.dart';
import 'package:meta/meta.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ApiBaseHelper _apiHelper;

  ItemRepositoryImpl({
    @required ApiBaseHelper helper,
  }) : _apiHelper = helper;

  @override
  List<Item> fetchItems() {
    // TODO: implement fetchItems
    return null;
  }
}
