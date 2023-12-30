import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project111/components/dimens.dart';
import 'package:project111/components/my_colors.dart';
import 'package:project111/components/my_component.dart';
import 'package:project111/components/my_string.dart';
import 'package:project111/controller/article_manage_controller.dart';
import 'package:project111/controller/file_picker_controller.dart';
import 'package:project111/controller/home_screen_controller.dart';
import 'package:project111/gen/assets.gen.dart';
import 'package:get/get.dart';
import 'package:project111/main.dart';
import 'package:project111/services/file_pick.dart';
import 'package:project111/view/screens/article_manage_edit.dart';

class ArticleManageDetail extends StatelessWidget {
  ArticleManageDetail({super.key});

  FilePickerController filePickerController = Get.put(FilePickerController());

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    var bodyMargin = size.width / 15;
    var manageArticleController = Get.find<ArticleManageController>();

    getTitle() {
      Get.defaultDialog(
          title: 'عنوان مقاله',
          titleStyle: const TextStyle(color: SolidColors.scafoldBg),
          content: TextField(
            controller: manageArticleController.titleTextEditingController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: 'عنوان مقاله',
            ),
          ),
          backgroundColor: SolidColors.primeryColor,
          radius: 8,
          confirm: ElevatedButton(
              onPressed: (() {
                manageArticleController.updateTitle();
                Get.back();
              }),
              child: const Text('تمام')));
    }

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
          child: Obx(()=> Column(children: [
              Stack(
                children: [
                 SizedBox(
                      height: Get.height / 3,
                      width: Get.width,
                      child: filePickerController.file.value.name == 'nothing'
                          ? CachedNetworkImage(
                              imageUrl: '',
                              imageBuilder: (context, imageProvider) =>
                                  Image(image: imageProvider),
                              placeholder: (context, url) => const loading(),
                              errorWidget: (context, url, error) => Image(
                                  image: AssetImage(
                                      Assets.images.singlePlaceHolder.path)),
                            )
                          : Image.file(
                              File(filePickerController.file.value.path!),
                              fit: BoxFit.cover,
                            ),
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
                        onTap: (() {
                          pickFile();
                        }),
                        child: Container(
                          height: 30,
                          width: 150,
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
                          onTap: (() {
                            getTitle();
                          }),
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
                            manageArticleController.articleInfoModel.value.title!,
                            style: textTheme.displayLarge,
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
                          onTap: (() {
                            Get.to(ArticleContentEditor());
                          }),
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
                            manageArticleController
                                .articleInfoModel.value.content!,
                            style: textTheme.displayLarge,
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
                          onTap: (() {
                            chooseCatsBottomSheet(textTheme);
                          }),
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
                          height: 50,
                        ),
                        Text(
                          manageArticleController
                                      .articleInfoModel.value.catName ==
                                  null
                              ? MyString.noCategorySelected
                              : manageArticleController
                                  .articleInfoModel.value.catName!,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  chooseCatsBottomSheet(TextTheme textTheme) {
    var homeScreenController = Get.find<HomeScreenController>();
    var manageArticleController = Get.find<ArticleManageController>();

    Get.bottomSheet(
        Container(
          height: Get.height / 1.5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimens.medium + 4),
                topRight: Radius.circular(Dimens.medium + 4)),
          ),
          child: Padding(
            padding: EdgeInsets.all(Dimens.small),
            child: SingleChildScrollView(
              child: Column(children: [
                const Text(MyString.writeCategory),
                SizedBox(
                  height: Dimens.small,
                ),
                Cats(
                  textTheme: textTheme,
                  homeScreenController: homeScreenController,
                  articleManageController: manageArticleController,
                )
              ]),
            ),
          ),
        ),
        isScrollControlled: true,
        persistent: true);
  }
}

class Cats extends StatelessWidget {
  Cats(
      {Key? key,
      required this.homeScreenController,
      required this.articleManageController,
      required this.textTheme})
      : super(key: key);

  final HomeScreenController homeScreenController;
  final ArticleManageController articleManageController;
  TextTheme textTheme;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 1.7,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: homeScreenController.tags.length,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () async {
              articleManageController.articleInfoModel.update((val) {
                val?.catName = homeScreenController.tags[index].title!;
                val?.catId = homeScreenController.tags[index].id!;
              });
              Get.back();
            },
            child: Padding(
              padding: EdgeInsets.only(left: Dimens.small),
              child: Container(
                height: Dimens.large - 2,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    gradient: LinearGradient(colors: GradiantColors.tags)),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        Dimens.small, Dimens.small, Dimens.small, Dimens.small),
                    child: Center(
                      child: Text(
                        homeScreenController.tags[index].title!,
                        style: textTheme.headline2,
                      ),
                    )),
              ),
            ),
          );
        }),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
      ),
    );
  }
}