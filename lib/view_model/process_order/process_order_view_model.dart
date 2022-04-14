import 'package:flutter_easyfood_new/model/order_model.dart';
import 'package:flutter_easyfood_new/state/cart_state.dart';

abstract class ProcessOrderViewModel {
  Future<bool> submitOrder(OrderModel orderModel);

  Future<OrderModel> createOrderModel(
      {required String restaurantId,
        required double discount,
        required String firstName,
        required String lastName,
        required String address,
        required String comment,
        required bool isCod,
        required CartStateController cartStateController});
}
