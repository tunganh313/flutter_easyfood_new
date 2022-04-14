import 'package:flutter_easyfood_new/firebase/order_reference.dart';
import 'package:flutter_easyfood_new/model/order_model.dart';
import 'package:flutter_easyfood_new/view_model/order_history_vm/order_history_view_model.dart';

class OrderHistoryViewModelImp implements OrderHistoryViewModel{
  @override
  Future<List<OrderModel>> getUserHistory(String restaurantId, String statusMode) {
    return getUserOrdersByRestaurant(restaurantId,statusMode);
  }
  
}