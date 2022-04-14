import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyfood_new/const/const.dart';
import 'package:flutter_easyfood_new/model/order_model.dart';
import 'package:flutter_easyfood_new/screens/order_view_detail_screen.dart';
import 'package:flutter_easyfood_new/state/order_history_state.dart';
import 'package:flutter_easyfood_new/utils/utils.dart';
import 'package:flutter_easyfood_new/widgets/common/common_widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderHistoryListWidget extends StatelessWidget {
  final orderDetailState = Get.put(OrderHistoryState());

  OrderHistoryListWidget({Key? key, required this.listOrder}) : super(key: key);
  final List<OrderModel> listOrder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: LiveList(
          showItemInterval: Duration(milliseconds: 300),
          showItemDuration: Duration(milliseconds: 300),
          reAnimateOnVisibility: true,
          scrollDirection: Axis.vertical,
          itemCount: listOrder.length,
          itemBuilder: animationItemBuilder((index) => InkWell(
                onTap: () {
                  orderDetailState.selectedOrder.value = listOrder[index];
                  Get.to(()=> OrderViewDetailScreen());
                },
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: listOrder[index].cartItemList[0].image,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, err) => Center(
                          child: Icon(Icons.image),
                        ),
                        progressIndicatorBuilder: (context, url, download) =>
                            Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          color: Color(COLOR_OVERPLAY),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Order #${listOrder[index].orderNumber}',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.jetBrainsMono(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          'Ngày ${convertToDate(listOrder[index].createdDate)}',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.jetBrainsMono(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          'Tình trạng đặt hàng: ${convertStatus(listOrder[index].orderStatus)}',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.jetBrainsMono(
                                              color: Colors.white,
                                              fontSize: 18),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ))
      ],
    );
  }
}
