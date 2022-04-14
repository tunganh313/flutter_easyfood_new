import 'package:flutter_easyfood_new/model/order_model.dart';

abstract class OrderHistoryViewModel{
  Future<List<OrderModel>> getUserHistory(String restaurantId,String statusMode);


}