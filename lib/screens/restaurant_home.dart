import 'dart:math';
import 'dart:ui';

import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyfood_new/model/popular_item_model.dart';
import 'package:flutter_easyfood_new/screens/menu.dart';
import 'package:flutter_easyfood_new/screens/restaurant_home_detail.dart';
import 'package:flutter_easyfood_new/state/main_state.dart';
import 'package:flutter_easyfood_new/widgets/common/common_widgets.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantHome extends StatelessWidget {
  final drawerZoomController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.redAccent,
      body: ZoomDrawer(
        controller: drawerZoomController,
        menuScreen: MenuScreen(drawerZoomController),
        mainScreen: RestaurantHomeDetail(drawerZoomController),
        borderRadius: 24.0,
        showShadow: true,
        angle: 0.0,
        backgroundColor: Colors.grey[300]!,
        slideWidth: MediaQuery.of(context).size.width*0.65,
        openCurve: Curves.bounceInOut,
        closeCurve: Curves.ease,
      ),
    ));
  }
}
