import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  @override
  RxBool remember = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
}
