import 'package:flutter_easyfood_new/model/popular_item_model.dart';

abstract class RestaurantHomeDetailViewModel{
  Future<List<PopularItemModel>> displayMostPopularByRestaurantId(
      String restaurantId);
  Future<List<PopularItemModel>> displayBestDealsByRestaurantId(
      String restaurantId);
}