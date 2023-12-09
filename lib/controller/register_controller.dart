import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project111/components/api_constant.dart';
import 'package:project111/components/storage_const.dart';
import 'package:project111/services/dio_services.dart';
import 'package:project111/view/register_intro.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project111/view/screens/main_screen.dart';
import 'package:project111/widget/bottom_sheet_upload_file.dart';

class RegisterController extends GetxController {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController activeCodeTextEditingController =
      TextEditingController();

  var email = '';
  var userId;

  register() async {
    Map<String, dynamic> map = {
      'email': emailTextEditingController.text,
      'command': 'register',
    };

    var response =
        await DioServices().postMethod(map, ApiConstant.postRegister);

    email = emailTextEditingController.text;
    userId = response.data['user_id'];
  }

  verify() async {
    Map<String, dynamic> map = {
      'email': email,
      'user_id': userId,
      'code': activeCodeTextEditingController.text,
      'command': 'verify',
    };

    var response =
        await DioServices().postMethod(map, ApiConstant.postRegister);
    var status = response.data['response'];

    switch (status) {
      case 'verified':
        var box = GetStorage();
        box.write(StorageKey.userID, response.data['user_id']);
        box.write(StorageKey.token, response.data['token']);

        debugPrint('verified');

        debugPrint(box.read(StorageKey.token));
        debugPrint(box.read(StorageKey.userID));
        Get.snackbar('Ok: ', 'Login Succssusfully',
            backgroundColor: Colors.green);
        Get.offAll(const MainScreen());
        break;
      case 'incorrect_code':
        Get.snackbar('Error: ', 'Incorrace Code', backgroundColor: Colors.red);
        break;
      case 'expired':
        Get.snackbar('Error: ', 'Expired', backgroundColor: Colors.yellow);
        break;
    }
  }

  toggleLogin() {
    if (GetStorage().read(StorageKey.token) == null) {
      Get.to(RegisterIntro());
    } else {
      routeToWriteBottomSheet();
    }
  }
}
