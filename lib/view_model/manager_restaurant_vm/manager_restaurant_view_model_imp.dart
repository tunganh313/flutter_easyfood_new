import 'package:flutter_easyfood_new/firebase/server_user_reference.dart';
import 'package:flutter_easyfood_new/model/server_user_model.dart';
import 'package:flutter_easyfood_new/state/server_manager_state.dart';
import 'package:flutter_easyfood_new/view_model/manager_restaurant_vm/manager_restaurant_view_model.dart';
import 'package:get/get.dart';

class ManagerRestaurantVMImp implements ManagerRestaurantViewModel{
  ServerManagerState serverManagerState = Get.find();
  @override
  Future registerServerUser(ServerUserModel serverUserModel) async{
      var result = await writeServerUserToFirebase(serverUserModel);
      if(result){
          serverManagerState.isServerLogin.value = await checkIsServerUser(serverUserModel.uid);
          Get.back();
      }
  }

}