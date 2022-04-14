import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyfood_new/const/const.dart';
import 'package:flutter_easyfood_new/model/order_model.dart';
import 'package:flutter_easyfood_new/state/main_state.dart';
import 'package:flutter_easyfood_new/strings/main_strings.dart';
import 'package:flutter_easyfood_new/view_model/order_history_vm/order_history_view_model_imp.dart';
import 'package:flutter_easyfood_new/widgets/order_history/order_history_list_widget.dart';
import 'package:flutter_easyfood_new/widgets/order_history/order_history_widget.dart';
import 'package:get/get.dart';

class OrderHistory extends StatelessWidget {
  final vm = new OrderHistoryViewModelImp();
  final MainStateController mainStateController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(orderHistoryText),
          backgroundColor: Colors.redAccent,
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.cancel)),
              Tab(icon: Icon(Icons.refresh)),
              Tab(icon: Icon(Icons.check)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OrderHistoryWidget(vm, mainStateController, ORDER_CANCELLED),
            OrderHistoryWidget(vm, mainStateController, ORDER_PROCESSING),
            OrderHistoryWidget(vm, mainStateController, ORDER_SHIPPED),
          ],
        ),
      ),
    ));
  }
}
