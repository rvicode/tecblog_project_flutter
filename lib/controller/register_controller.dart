import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project111/components/api_constant.dart';
import 'package:project111/services/dio_services.dart';

class RegisterController extends GetxController {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController activeCodeTextEditingController =
      TextEditingController();

  register() async {
    Map<String, dynamic> map = {
      'email': emailTextEditingController.text,
      'command': 'register',
    };

    var response =
        await DioServices().postMethod(map, ApiConstant.postRegister);
  }
}
