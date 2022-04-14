import 'package:flutter_easyfood_new/firebase/restaurant_reference.dart';
import 'package:flutter_easyfood_new/model/restaurant_model.dart';
import 'package:flutter_easyfood_new/view_model/main_vm/main_view_model.dart';

class MainViewModelImp implements MainViewModel{
  @override
  Future<List<RestaurantModel>> displayRestaurantList() {
   return getRestaurantList();
  }

}