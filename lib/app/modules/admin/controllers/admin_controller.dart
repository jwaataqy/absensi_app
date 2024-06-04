import 'package:get/get.dart';

class AdminController extends GetxController {
  RxString usernama = ''.obs;

  @override
  SetDataLogin(String username) async {
    usernama.value = username;
  }
  //TODO: Implement AdminController

  // final count = 0.obs;
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  // void increment() => count.value++;
}
