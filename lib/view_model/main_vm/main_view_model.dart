import 'package:flutter_easyfood_new/model/restaurant_model.dart';

abstract class MainViewModel{
  Future<List<RestaurantModel>> displayRestaurantList();
}
