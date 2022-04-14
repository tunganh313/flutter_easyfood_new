import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyfood_new/firebase/server_user_reference.dart';
import 'package:flutter_easyfood_new/model/server_user_model.dart';
import 'package:flutter_easyfood_new/state/main_state.dart';
import 'package:flutter_easyfood_new/state/server_manager_state.dart';
import 'package:flutter_easyfood_new/strings/main_strings.dart';
import 'package:flutter_easyfood_new/strings/manager_restaurant_string.dart';
import 'package:flutter_easyfood_new/strings/place_order_strings.dart';
import 'package:flutter_easyfood_new/strings/restaurant_home_strings.dart';
import 'package:flutter_easyfood_new/view_model/manager_restaurant_vm/manager_restaurant_view_model.dart';
import 'package:flutter_easyfood_new/view_model/manager_restaurant_vm/manager_restaurant_view_model_imp.dart';
import 'package:flutter_easyfood_new/widgets/manager_restaurant/admin_card_item_widget.dart';
import 'package:flutter_easyfood_new/widgets/manager_restaurant/admin_panel_item_widget.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class ManagerRestaurantScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ManagerRestaurantScreenState();
}

class ManagerRestaurantScreenState extends State<ManagerRestaurantScreen> {
  ServerManagerState serverManagerState = Get.put(ServerManagerState());
  MainStateController mainStateController = Get.find();

  ManagerRestaurantViewModel managerRestaurantViewModel =
      new ManagerRestaurantVMImp();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      var result =
          await checkIsServerUser(FirebaseAuth.instance.currentUser!.uid);
      serverManagerState.isServerLogin.value = result;
      if (!result) // If user not login
        showRegisterDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
                child: Center(
              child: Icon(
                Icons.admin_panel_settings,
                size: 80,
              ),
            )),
            Divider(
              thickness: 1,
            ),
            AdminPanelItemWidget(
              icon: Icons.restaurant_menu,
              text: categoriesText,
              isExitWidget: false,
            ),
            Divider(
              thickness: 1,
            ),
            AdminPanelItemWidget(
              icon: Icons.list,
              text: orderText,
              isExitWidget: false,
            ),
            Divider(
              thickness: 1,
            ),
            Spacer(),
            Divider(
              thickness: 1,
            ),
            AdminPanelItemWidget(
              icon: Icons.exit_to_app,
              text: exitText,
              isExitWidget: true,
            ),
            Divider(
              thickness: 1,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(managerRestaurantText),
      ),
      body: Obx(() => serverManagerState.isServerLogin.value
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AdminCardItemWidget(
                  icon: Icons.file_copy,
                  text: 'Orders (+100)',
                ),
                AdminCardItemWidget(
                  icon: Icons.file_copy,
                  text: 'Total (\$3000)',
                )
              ],
            )
          : Center(
              child: Text('$forbiddenText'),
            )),
    ));
  }

  void showRegisterDialog() {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    Get.defaultDialog(
        title: registerManagerText,
        content: Form(
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
                                requiredMessage:
                                    '$firstNameText $isRequiredText')
                            .required()
                            .build(),
                        decoration: InputDecoration(
                            hintText: firstNameText,
                            label: Text(firstNameText),
                            border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: lastNameController,
                        validator: ValidationBuilder(
                                requiredMessage:
                                    '$lastNameText $isRequiredText')
                            .required()
                            .build(),
                        decoration: InputDecoration(
                            hintText: lastNameText,
                            label: Text(lastNameText),
                            border: OutlineInputBorder()),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        textConfirm: registerText,
        textCancel: cancelText,
        confirmTextColor: Colors.white,
        onConfirm: () async {
          ServerUserModel serverUserModel = new ServerUserModel(
              '${firstNameController.text} ${lastNameController.text}',
              mainStateController.selectedRestaurant.value.restaurantId,
              FirebaseAuth.instance.currentUser!.uid,
              FirebaseAuth.instance.currentUser!.phoneNumber.toString());
          await managerRestaurantViewModel.registerServerUser(serverUserModel);
        });
  }
}
