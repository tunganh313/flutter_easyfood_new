import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyfood_new/model/cart_model.dart';
import 'package:flutter_easyfood_new/screens/place_order_screen.dart';
import 'package:flutter_easyfood_new/state/cart_state.dart';
import 'package:flutter_easyfood_new/state/main_state.dart';
import 'package:flutter_easyfood_new/view_model/cart_vm/cart_view_model.dart';
import 'package:flutter_easyfood_new/view_model/menu_vm/menu_viewmodel_imp.dart';
import 'package:get/get.dart';

class CartViewModelImp implements CartViewModel {
  final MainStateController mainStateController = Get.find();
  final MenuViewModelImp menuViewModelImp = new MenuViewModelImp();



  @override
  void updateCart(CartStateController controller, String restaurantId,
      int index, int value) {
    // Update quantity
    controller.cart.value = controller.getCart(restaurantId);
    controller.cart[index].quantity = value;
    controller.cart.refresh();
    controller.saveDatabase();
  }



  @override
  void deleteCart(
      CartStateController controller, String restaurantId, int index) {
    controller.cart.value = controller.getCart(restaurantId);
    controller.cart.removeAt(index);
    controller.saveDatabase();
  }


  @override
  void clearCart(CartStateController controller) {
    controller
        .clearCart(mainStateController.selectedRestaurant.value.restaurantId);
  }

  @override
  processCheckout(BuildContext context, List<CartModel> cart) {
    if (FirebaseAuth.instance.currentUser != null)
    {
      // Business of Checkout
        Get.to(() => PlaceOrderScreen() );

    } else {
      menuViewModelImp.login(context);
    }
  }
}
