import 'dart:math';

import 'package:absen_app_application/app/modules/admin/controllers/admin_controller.dart';
import 'package:absen_app_application/app/modules/home/controllers/home_controller.dart';
import 'package:absen_app_application/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:get/get.dart';

class AuthController extends GetxController {
  String codeOTP = "";
  final homecontrller = Get.put(HomeController());
  final admincontroller = Get.put(AdminController());

  Stream authStatus = FirebaseAuth.instance.authStateChanges();
  //TODO: Implement AuthController
  RxBool remember = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController forgotPasswordController =
      TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
 Login() async {
    try {
      Get.defaultDialog(
          content: CircularProgressIndicator(
            color: Colors.blue,
          ),
          title: "Loading...");

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      //Get user ID from credential
      String userId = credential.user!.uid;

      //Retrieve user document from Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      //Get user name and role from user document
      String userName = userSnapshot['name'];
      String role = userSnapshot['role'];
      print("username : $userName, role: $role");

      //Set data login for home controller

      //Navigate based on role
      if (role == 'pengguna') {
      homecontrller.SetDataLogin(userName);

        Get.offAllNamed(Routes.HOME);
      } else if (role == 'admin') {
      admincontroller.SetDataLogin(userName);

        Get.offAllNamed(Routes.ADMIN); // Ensure you have defined Routes.ADMIN
      } else {
        Get.defaultDialog(
            title: "Error",
            middleText: "Invalid role. Please contact support.");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('user not found');
        Get.defaultDialog(title: "User not found.");
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.defaultDialog(title: "Wrong password provided for that user.");
      }
    } finally {
      Get.back(); // Close the loading dialog
    }
  }
  signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      try {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
        Get.defaultDialog(
            content: CircularProgressIndicator(
              color: Colors.blue,
            ),
            title: "Loading...");
        await FirebaseAuth.instance.signInWithPopup(googleProvider);
        Get.back();
        Get.offAllNamed(Routes.HOME);
      } catch (e) {
        // Get.defaultDialog(title: "Failed login google ");
        Get.back();
        print("error");
      }
    }
  }

  resetPassword() async {
    try {
      Get.defaultDialog(
          content: CircularProgressIndicator(
            color: Colors.blue,
          ),
          title: "Loading...");
      Get.defaultDialog(
        title: "Loading...",
      );
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: forgotPasswordController.text,
      );
      Get.back();
      Get.defaultDialog(
        title: "Password Reset Email Sent",
        middleText: "Please check your email to reset your password.",
      );
    } catch (e) {
      print("Error sending password reset email: $e");
      Get.back(); // Tutup dialog loading jika terjadi kesalahan
      Get.defaultDialog(
        title: "Error",
        middleText: "Failed to send password reset email. Please try again.",
      );
    }
  }

  SendOtp() async {
    try {
      Get.defaultDialog(
        middleText: "loading ..",
      );
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+62${phoneNumberController.text}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) {
            if (value.user != null) {
              Get.toNamed(Routes.OTP);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.defaultDialog(
            middleText: "Gagal mengirim OTP. Silahkan coba lagi.",
          );
        },
        codeSent: (String vericationID, int? resenToken) {
          codeOTP = vericationID;
        },
        codeAutoRetrievalTimeout: (String vericationID) {
          codeOTP = vericationID;
        },
        timeout: Duration(seconds: 60),
      );
      Get.toNamed(Routes.OTP);
    } catch (e) {
      Get.defaultDialog(
        middleText: "Gagal mengirim OTP. Silahkan coba lagi.",
      );
    }
  }

  CheckOtp(String smsCode) async {
    try {
      Get.defaultDialog(
        middleText: "loading...",
      );
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: codeOTP, smsCode: smsCode))
          .then((value) {
        if (value.user != null) {
          Get.toNamed(Routes.HOME);
        }
      });
    } catch (e) {
      Get.defaultDialog(
        middleText: "Gagal",
      );
    }
  }

  Register() async {
    try {
      Get.defaultDialog(
          content: CircularProgressIndicator(
            color: Colors.blue,
          ),
          title: "Loading...");

      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      String userId = credential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'name': nameController.text,
        'email': emailController.text,
      });

      Get.defaultDialog(
          content: CircularProgressIndicator(
            color: Colors.blue,
          ),
          title: "Register successfully!");

      Get.offAllNamed(Routes.LOGIN);
    } on FirebaseAuthException catch (e) {
      Get.defaultDialog(
          content: CircularProgressIndicator(
            color: Colors.blue,
          ),
          title: "Register gagal");
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future AddUserDetails(String name, String email) async {
    try {} catch (e) {
      Get.defaultDialog(
          content: CircularProgressIndicator(
            color: Colors.blue,
          ),
          title: "error");
    }
  }

  Future<void> signInWithEmailAndLink(String email, String link) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailLink(email: email, emailLink: link);
      // Pengguna berhasil masuk, lakukan sesuatu seperti menavigasi ke halaman beranda
      Get.offAllNamed('/home');
    } catch (e) {
      // Tangani kesalahan, misalnya tautan kedaluwarsa atau tidak valid
      print('Error: $e');
    }
  }

  Logout() async {
    try {
      Get.defaultDialog(
          middleText: "Do you want to logout this account?",
          textConfirm: "Yes",
          textCancel: "No",
          backgroundColor: Colors.white,
          onConfirm: () => Get.offAllNamed(Routes.LOGIN));
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      print('Erorr : ${e}');
    }
  }
}
