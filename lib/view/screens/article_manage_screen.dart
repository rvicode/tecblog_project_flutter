import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project111/components/my_colors.dart';
import 'package:project111/controller/register_controller.dart';
import 'package:project111/gen/assets.gen.dart';
import 'package:project111/components/my_string.dart';
import 'package:project111/main.dart';

class ArticleManage extends StatelessWidget {
  ArticleManage({super.key});

  var registerController = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    var text = Theme.of(context).textTheme;

    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: appbar(textTheme),
        ),
      ),
      body: emptyScreen(text),
    ));
  }

  Widget emptyScreen(TextTheme text) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(Assets.images.techbotEmpty.path, height: 100),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: MyString.emptyTextManage, style: text.displaySmall)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 35),
          child: ElevatedButton(
              onPressed: () {}, child: const Text(MyString.emptyBotton)),
        )
      ],
    ));
  }

  appbar(TextTheme textTheme) {
    var title = 'مدیریت مقاله ها';

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Center(
            child: Text(
              title,
              style: textTheme.displaySmall,
            ),
          ),
        ),
      ],
      leading: InkWell(
        onTap: () {
          Get.toNamed(NamedRoute.routeArticleDetail);
        },
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: SolidColors.primeryColor),
          child: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
