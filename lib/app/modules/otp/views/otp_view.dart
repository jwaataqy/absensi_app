import 'package:absen_app_application/app/controllers/auth_controller.dart';
import 'package:absen_app_application/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({Key? key}) : super(key: key);
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
                  InkWell(
                    onTap: () => Get.toNamed(Routes.PHONE_NUMBER),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.black87,
                        ),
                        width: lebar * 0.3,
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
                        )),
                  ),
                  SizedBox(height: 108),
                  Container(
                    width: lebar,
                    child: Pinput(
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      onSubmitted: (value) => auth.CheckOtp(value),
                      onCompleted: (value) => auth.CheckOtp(value),
                      length: 6,
                    ),
                  ),
                  Gap(32),
                  Container(
                    width: lebar,
                  ),
                  Gap(32),
                  Text(
                    " resent code",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gap(32),
                ],
              )),
        ],
      ),
    );
  }
}
