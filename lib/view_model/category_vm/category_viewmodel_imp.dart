import 'package:flutter_easyfood_new/firebase/category_reference.dart';
import 'package:flutter_easyfood_new/model/category_model.dart';

import 'category_viewmodel.dart';

class CategoryViewModelImp implements CategoryViewModel {
  @override
  Future<List<CategoryModel>> displayCategoryByRestaurantId(
      String restaurantId) {
    return getCategoryByRestaurantId(restaurantId);
  }
}
