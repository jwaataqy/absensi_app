import 'package:absen_app_application/app/controllers/auth_controller.dart';
import 'package:absen_app_application/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../controllers/lupa_password_controller.dart';

class LupaPasswordView extends GetView<LupaPasswordController> {
  const LupaPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final auth = Get.put(AuthController());

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
              height: tinggi * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 64, vertical: 32),
              child: Column(
                children: [
                  Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 108),
                  _Input(auth.forgotPasswordController, "email"),
                  // Pinput(
                  //   controller: auth.forgotPasswordController,

                  // ),
                  Gap(32),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          var forgotPassword =
                              auth.forgotPasswordController.text;
                          if (forgotPassword.isNotEmpty) {
                            auth.resetPassword();
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
                          width: lebar / 2.8,
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
                      Gap(16),
                      InkWell(
                        onTap: () => Get.offAllNamed(Routes.LOGIN),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.black87,
                          ),
                          width: lebar / 2.8,
                          height: 60,
                          child: Center(
                            child: Text(
                              'Back',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
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
}
