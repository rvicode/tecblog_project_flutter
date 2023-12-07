import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project111/gen/assets.gen.dart';
import 'package:project111/main.dart';

routeToWriteBottomSheet() {
  Get.bottomSheet(Container(
    height: Get.height / 2,
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        color: Colors.white),
    child: Column(children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            SvgPicture.asset(Assets.images.tecbot.path, height: 60),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'دونسته هات رو با بقیه به اشتراک بذار ...',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          """فکر کن !!  اینجا بودنت به این معناست که یک گیک تکنولوژی هستی
      دونسته هات رو با  جامعه‌ی گیک های فارسی زبان به اشتراک بذار..""",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.right,
        ),
      ),
      const SizedBox(
        height: 50,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(NamedRoute.routeArticleManage);
            },
            child: Container(
              height: 50,
              color: Colors.white,
              child: Row(
                children: [
                  Image.asset(
                    Assets.icons.write.path,
                    height: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'مدیریت مقاله ها',
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => print('hiii'),
            child: Container(
              height: 50,
              color: Colors.white,
              child: Row(
                children: [
                  Image.asset(
                    Assets.icons.podcast.path,
                    height: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'مدیریت پادکست ها',
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
          ),
        ],
      )
    ]),
  ));
}
