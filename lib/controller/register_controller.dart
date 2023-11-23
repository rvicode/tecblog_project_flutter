import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project111/components/api_constant.dart';
import 'package:project111/components/storage_const.dart';
import 'package:project111/services/dio_services.dart';
import 'package:project111/view/register_intro.dart';
import 'package:project111/view/screens/main_screen.dart';
import 'package:get_storage/get_storage.dart';

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

    var box = GetStorage();
    if (response.data['response'] == 'verified') {
      box.write(userID, response.data['user_id']);
      box.write(token, response.data['token']);
    }
  }
}