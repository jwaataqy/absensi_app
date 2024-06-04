import 'package:absen_app_application/app/controllers/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../controllers/admin_controller.dart';

class AdminView extends GetView<AdminController> {
  const AdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final auth = Get.put(AuthController());
    // String data = Get.arguments;
    String userEmail = FirebaseAuth.instance.currentUser!.email!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'AdminView is working',
              style: TextStyle(fontSize: 20),
            ),
            Gap(12),
            Obx(
              () => Text(
                "Halo ${controller.usernama}, Logged as ${userEmail}",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Gap(12),
            ElevatedButton(
                onPressed: () {
                  auth.Logout();
                },
                child: Text('Logout'))
          ],
        ),
      ),
    );
  }
}
