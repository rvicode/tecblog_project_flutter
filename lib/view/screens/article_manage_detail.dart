import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project111/components/my_colors.dart';
import 'package:project111/components/my_component.dart';
import 'package:project111/components/my_string.dart';
import 'package:project111/gen/assets.gen.dart';
import 'package:get/get.dart';
import 'package:project111/main.dart';

class ArticleManageDetail extends StatelessWidget {
  const ArticleManageDetail({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    var bodyMargin = size.width / 15;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding:
              const EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 16),
          child: ElevatedButton(
              style: ButtonStyle(
                  fixedSize:
                      MaterialStateProperty.all(Size(0, Get.height / 14))),
              onPressed: () {
                Get.toNamed(NamedRoute.routeMainScreen);
              },
              child: const Text(MyString.itsFinish)),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: '',
                  imageBuilder: (context, imageProvider) =>
                      Image(image: imageProvider),
                  placeholder: (context, url) => const loading(),
                  errorWidget: (context, url, error) => Image(
                      image: AssetImage(Assets.images.singlePlaceHolder.path)),
                ),
                Container(
                  height: 60,
                  foregroundDecoration: const BoxDecoration(
                      gradient: LinearGradient(
                    colors: GradiantColors.articleDetailScreenGradiant,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.arrow_right_alt,
                            color: Colors.white,
                            size: 40,
                          )),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: (() {}),
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: SolidColors.primeryColor),
                        child: Center(
                          child: Text('انتخاب تصویر+',
                              style: textTheme.headlineMedium),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: (() {}),
                        child: SizedBox(
                            height: 20,
                            child: Row(
                              children: [
                                Image.asset(Assets.icons.pen.path),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text(MyString.writeBlog)
                              ],
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'اینجا عنوان مقاله قرار میگیره ، یه عنوان جذاب انتخاب کن',
                          style: textTheme.headline1,
                          textAlign: TextAlign.start,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: (() {}),
                        child: SizedBox(
                            height: 20,
                            child: Row(
                              children: [
                                Image.asset(Assets.icons.pen.path),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text(MyString.writeFirstComment)
                              ],
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'من متن و بدنه اصلی مقاله هستم ، اگه میخوای من رو ویرایش کنی و یه مقاله جذاب بنویسی ، نوشته آبی رنگ بالا که نوشته "ویرایش متن اصلی مقاله" رو با انگشتت لمس کن تا وارد ویرایشگر بشی',
                          style: textTheme.headline1,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: (() {}),
                        child: SizedBox(
                            height: 20,
                            child: Row(
                              children: [
                                Image.asset(Assets.icons.pen.path),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text(MyString.writeCategory)
                              ],
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                  8, 8, index == 0 ? bodyMargin : 8, 8),
                              child: Container(
                                height: 60,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  gradient: LinearGradient(
                                      colors: GradiantColors.tags,
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 8, 20, 8),
                                  child: Row(
                                    children: [
                                      ImageIcon(
                                        AssetImage(
                                            Assets.icons.hashtag.keyName),
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text('Test',
                                          style: textTheme.displayMedium),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
