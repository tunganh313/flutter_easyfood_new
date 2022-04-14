import 'package:flutter_easyfood_new/model/server_user_model.dart';

abstract class ManagerRestaurantViewModel{
  Future registerServerUser(ServerUserModel serverUserModel);
}