import 'package:flutter/material.dart';
import 'package:project111/gen/assets.gen.dart';
import 'package:project111/components/my_colors.dart';
import 'package:project111/components/my_string.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.size,
    required this.text,
    required this.bodyMargin,
  });

  final Size size;
  final TextTheme text;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black)),
        body: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Image(
                image: AssetImage(Assets.icons.avatar.keyName),
                height: 120,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageIcon(
                    AssetImage(Assets.icons.pen.keyName),
                    color: SolidColors.colorTitle,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    MyString.editProfileImage,
                    style: text.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'آروین ویسی',
                style: text.displayLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'َarvinvisi03@gmail.com',
                style: text.displayLarge,
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(
                color: SolidColors.underLine,
                indent: 45,
                endIndent: 45,
              ),
              InkWell(
                onTap: () {},
                child: SizedBox(
                  height: 40,
                  width: 330,
                  child: Center(
                    child: Text(
                      MyString.viewFavBlog,
                      style: text.displayLarge,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: SolidColors.underLine,
                indent: 45,
                endIndent: 45,
              ),
              InkWell(
                onTap: () {},
                child: SizedBox(
                  height: 40,
                  width: 330,
                  child: Center(
                    child: Text(
                      MyString.viewFavPodCast,
                      style: text.displayLarge,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: SolidColors.underLine,
                indent: 45,
                endIndent: 45,
              ),
              InkWell(
                onTap: () {},
                child: SizedBox(
                  height: 40,
                  width: 330,
                  child: Center(
                    child: Text(
                      MyString.logOut,
                      style: text.displayLarge,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
