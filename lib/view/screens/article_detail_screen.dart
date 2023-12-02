import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project111/components/my_colors.dart';
import 'package:project111/components/my_component.dart';
import 'package:project111/components/my_string.dart';
import 'package:project111/controller/article_contorller.dart';
import 'package:project111/controller/article_detail_contorller.dart';
import 'package:project111/gen/assets.gen.dart';
import 'package:get/get.dart';
import 'package:project111/controller/home_screen_controller.dart';
import 'package:project111/view/screens/article_list_screen.dart';

class ArticleDetailScreen extends StatelessWidget {
  ArticleDetailScreen({super.key});

  var articleController = Get.find<ArticleDetailController>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    var bodyMargin = size.width / 10;
    HomeScreenController homeScreenController = Get.put(HomeScreenController());
    var articleDetailController =
        Get.find<ArticleDetailController>();
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () => articleDetailController.articleDetailModel.value.image == null
              ? SizedBox(height: Get.height, child: const loading())
              : Column(children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: articleDetailController
                            .articleDetailModel.value.image!,
                        imageBuilder: (context, imageProvider) =>
                            Image(image: imageProvider),
                        placeholder: (context, url) => const loading(),
                        errorWidget: (context, url, error) => Image(
                            image: AssetImage(
                                Assets.images.singlePlaceHolder.path)),
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
                      SizedBox(
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_right_alt,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                            const SizedBox(
                              width: 270,
                            ),
                            const Icon(
                              Icons.bookmark_outline,
                              color: Colors.white,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, top: 15, left: 15),
                    child: Text(
                      articleDetailController.articleDetailModel.value.title!,
                      style: textTheme.displaySmall,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 15, top: 15, left: 15),
                    child: Row(
                      children: [
                        Image(
                            image: AssetImage(Assets.icons.avatar.path),
                            width: 55),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          articleDetailController
                              .articleDetailModel.value.author!,
                          style: textTheme.displaySmall,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          articleDetailController
                              .articleDetailModel.value.createdAt!,
                          style: textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 40, left: 40, top: 25),
                    child: Text(
                      articleDetailController.articleDetailModel.value.content!,
                      style: textTheme.displaySmall,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: articleDetailController.tagList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                              8, 8, index == 0 ? bodyMargin : 8, 8),
                          child: Container(
                            height: 60,
                            decoration: const BoxDecoration(
                              color: SolidColors.selectTagsColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      var tagsId = articleDetailController
                                          .tagList[index].id!;

                                      Get.find<ArticleController>()
                                          .getArticleListWithId(tagsId);

                                      Get.to(ArticleList(
                                        title: tagsId = articleDetailController
                                            .tagList[index].title!,
                                      ));
                                    },
                                    child: Text(
                                        articleDetailController
                                            .tagList[index].title!,
                                        style: textTheme.displaySmall),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 40, top: 25),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          MyString.anOtherArticle,
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: size.height / 2.4,
                      child: Obx(() => ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                homeScreenController.topVisitedList.length,
                            itemBuilder: (context, index) {
                              // Blog
                              return GestureDetector(
                                onTap: () {
                                  articleDetailController.getArticleDetail(
                                      homeScreenController
                                          .topVisitedList[index].id!);
                                },
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      8, 23, index == 0 ? bodyMargin : 8, 0),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Stack(children: [
                                            SizedBox(
                                              height: size.height / 3.8,
                                              width: size.width / 1.95,
                                              child: CachedNetworkImage(
                                                imageUrl: homeScreenController
                                                    .topVisitedList[index]
                                                    .image!,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  foregroundDecoration:
                                                      BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    gradient: const LinearGradient(
                                                        colors: GradiantColors
                                                            .homeBlogCoverGradiant,
                                                        begin: Alignment
                                                            .bottomCenter,
                                                        end: Alignment
                                                            .topCenter),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    const SpinKitThreeBounce(
                                                  color:
                                                      SolidColors.primeryColor,
                                                  size: 50.0,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(
                                                  Icons
                                                      .image_not_supported_outlined,
                                                  size: 50.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 8,
                                              right: 20,
                                              left: 20,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    homeScreenController
                                                        .topVisitedList[index]
                                                        .author!,
                                                    style:
                                                        textTheme.displayMedium,
                                                  ),
                                                  const SizedBox(
                                                    width: 16,
                                                  ),
                                                  Text(
                                                    homeScreenController
                                                        .topVisitedList[index]
                                                        .view!,
                                                    style:
                                                        textTheme.displayMedium,
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 5),
                                                    child: Icon(
                                                      Icons.remove_red_eye,
                                                      color:
                                                          SolidColors.scafoldBg,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]),
                                          // title
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 12, 10, 0),
                                            child: SizedBox(
                                              width: size.width / 2.4,
                                              child: Text(
                                                homeScreenController
                                                    .topVisitedList[index]
                                                    .title!,
                                                style: textTheme.displayLarge,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )))
                ]),
        ),
      ),
    ));
  }
}
