import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyfood_new/const/const.dart';
import 'package:flutter_easyfood_new/screens/restaurant_home.dart';
import 'package:flutter_easyfood_new/state/cart_state.dart';
import 'package:flutter_easyfood_new/state/main_state.dart';
import 'package:flutter_easyfood_new/state/place_order_state.dart';
import 'package:flutter_easyfood_new/strings/cart_strings.dart';
import 'package:flutter_easyfood_new/strings/place_order_strings.dart';
import 'package:flutter_easyfood_new/view_model/process_order/process_order_view_model_imp.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaceOrderScreen extends StatelessWidget {
  final placeOrderState = Get.put(PlaceOrderController());
  final placeOrderVm = new ProcessOrderViewModelImp();
  final CartStateController cartStateController = Get.find();
  final MainStateController mainStateController = Get.find();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final commentController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(placeOrderText),
        backgroundColor: Colors.redAccent,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: firstNameController,
                    validator: ValidationBuilder(
                            requiredMessage: '$firstNameText $isRequiredText')
                        .required()
                        .build(),
                    decoration: InputDecoration(
                        hintText: firstNameText,
                        label: Text(firstNameText),
                        border: OutlineInputBorder()),
                  )),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: TextFormField(
                    controller: lastNameController,
                    validator: ValidationBuilder(
                            requiredMessage: '$lastNameText $isRequiredText')
                        .required()
                        .build(),
                    decoration: InputDecoration(
                        hintText: lastNameText,
                        label: Text(lastNameText),
                        border: OutlineInputBorder()),
                  ))
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                      controller: addressController,
                      validator: ValidationBuilder(
                              requiredMessage: '$addressText $isRequiredText')
                          .required()
                          .build(),
                      decoration: InputDecoration(
                          hintText: addressText,
                          label: Text(addressText),
                          border: OutlineInputBorder()))
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        paymentText,
                        style: GoogleFonts.jetBrainsMono(
                            fontSize: 22, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      RadioListTile<String>(
                          title: const Text(codText),
                          value: COD_VAL,
                          groupValue: placeOrderState.paymentSelected.value,
                          onChanged: (String? val) {
                            placeOrderState.paymentSelected.value = val!;
                          }),
                      RadioListTile<String>(
                          title: const Text(brainTreeText),
                          value: BRAINTREE_VAL,
                          groupValue: placeOrderState.paymentSelected.value,
                          onChanged: (String? val) {
                            placeOrderState.paymentSelected.value = val!;
                          })
                    ],
                  )),
              SizedBox(
                height: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                      controller: commentController,
                      validator: ValidationBuilder(
                              requiredMessage: '$commentText $isRequiredText')
                          .required()
                          .build(),
                      decoration: InputDecoration(
                          hintText: commentText,
                          label: Text(commentText),
                          border: OutlineInputBorder()))
                ],
              ),
              Spacer(),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(placeOrderText),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      var order = await placeOrderVm.createOrderModel(
                          restaurantId: mainStateController
                              .selectedRestaurant.value.restaurantId,
                          address: addressController.text,
                          cartStateController: cartStateController,
                          comment: commentController.text,
                          discount: 0,
                          // Implement Discount code later
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          isCod:
                              placeOrderState.paymentSelected.value == COD_VAL
                                  ? true
                                  : false);
                      print('Hehe: ${order.toJson()}');
                      var result = await placeOrderVm.submitOrder(order);
                      Get.defaultDialog(
                          title: result ? orderSuccessText : orderFailedText,
                          middleText: result
                              ? orderSuccessMessageText
                              : orderFailedMessageText,
                          textConfirm: confirmText,
                          cancel: Container(),
                          onCancel: (){},
                          confirmTextColor: Colors.yellow,
                          onConfirm: () {
                            cartStateController.clearCart(mainStateController
                                .selectedRestaurant.value.restaurantId);
                            Get.offAll(()=> RestaurantHome());
                          });
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
