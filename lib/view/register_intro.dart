import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project111/controller/register_controller.dart';
import 'package:project111/gen/assets.gen.dart';
import 'package:project111/components/my_string.dart';
import 'package:project111/view/my_category.dart';
import 'package:validators/validators.dart';

class RegisterIntro extends StatelessWidget {
  RegisterIntro({super.key});

  RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    var text = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.images.tecbot.path, height: 100),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: MyString.welcomText, style: text.displaySmall)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35),
            child: ElevatedButton(
                onPressed: () {
                  showModelBottomSheetEmail(context, size, text);
                },
                child: const Text(MyString.letsGo)),
          )
        ],
      )),
    ));
  }

  Future<dynamic> showModelBottomSheetEmail(
      BuildContext context, Size size, TextTheme text) {
    var confirmEmail = false;
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: size.height / 2,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                color: Colors.white,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      MyString.createEmail,
                      style: text.displaySmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: TextField(
                        controller:
                            registerController.emailTextEditingController,
                        onChanged: (value) {
                          if (isEmail(value)) {
                            confirmEmail = true;
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: 'techblog@gmail.com',
                            hintStyle: text.headlineMedium),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          registerController.register();
                          Navigator.pop(context);
                          _showModelBottomSheetCodeMessage(context, size, text);
                        },
                        child: const Text('ادامه'))
                  ]),
            ),
          );
        });
  }

  Future<dynamic> _showModelBottomSheetCodeMessage(
      BuildContext context, Size size, TextTheme text) {
    var confirmCode = false;
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: size.height / 2,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                color: Colors.white,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      MyString.createCode,
                      style: text.displaySmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: TextField(
                        controller:
                            registerController.activeCodeTextEditingController,
                        onChanged: (value) {
                          if (isInt(value)) {
                            confirmCode = true;
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: '******', hintStyle: text.headlineMedium),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (confirmCode == true) {
                            var response = registerController.verify();
                            if (response == 'expired '){
                            Get.to(const MyCategory());
                            }
                          }
                        },
                        child: const Text('ادامه'))
                  ]),
            ),
          );
        });
  }
}
