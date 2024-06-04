import 'package:absen_app_application/app/controllers/auth_controller.dart';
import 'package:absen_app_application/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
// import 'package:latihan_firebase/app/components/input.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final auth = Get.put(AuthController());
    final cntrl = Get.put(LoginController());

    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: tinggi,
            width: lebar,
            color: Colors.blue,
          ),
          Container(
            height: tinggi * 0.65,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 64, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 48),
                _Input(auth.emailController, "email"),
                SizedBox(height: 24),
                _Input(auth.passwordController, "password"),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Get.toNamed(Routes.LUPA_PASSWORD),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    _SIgnUpTeks(),
                  ],
                ),
                SizedBox(height: 24),
                InkWell(
                  onTap: () {
                    var email = auth.emailController.text;
                    var password = auth.passwordController.text;
                    if (email.isNotEmpty && password.isNotEmpty) {
                      auth.Login();
                    } else {
                      Get.defaultDialog(
                        title: "Error",
                        middleText: "Please fill in all fields.",
                        textConfirm: "OK",
                        backgroundColor: Colors.white,
                        onConfirm: () => Get.back(),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.black87,
                    ),
                    width: lebar,
                    height: 60,
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(3),
                Container(
                  width: lebar,
                  height: 1,
                  color: Colors.grey[300],
                ),
                Gap(2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _Icon("icons/email.svg"),
                    Gap(2),
                    InkWell(
                      onTap: () => auth.signInWithGoogle(),
                      child: _Icon(
                        "icons/google-icon.svg",
                      ),
                    ),
                    Gap(2),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.PHONE_NUMBER);
                      },
                      child: _Icon("icons/phone_number.svg"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  

  Widget _Input(TextEditingController controllers, String label) {
    return TextField(
      controller: controllers,
      decoration: InputDecoration(
        labelText: label,
        hintText: "enter ${label}",
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: Color.fromARGB(255, 193, 193, 193),
        ),
        labelStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(255, 175, 175, 175),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.black54)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Color(0xffe8e8e8))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Color.fromARGB(255, 207, 207, 207))),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Color(0xffe8e8e8)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 26),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Row _SIgnUpTeks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        InkWell(
          onTap: () => Get.toNamed(Routes.REGISTER),
          child: Text(
            "Register   ",
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Container _Icon(String urlIcon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration:
          BoxDecoration(color: Color(0xfff5f5f5), shape: BoxShape.circle),
      child: SvgPicture.asset(
        urlIcon,
        height: 32,
        width: 32,
      ),
    );
  }
}
