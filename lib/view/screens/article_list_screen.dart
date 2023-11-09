import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project111/components/my_colors.dart';
import 'package:project111/components/my_component.dart';
import 'package:project111/controller/article_contorller.dart';
import 'package:project111/controller/article_detail_contorller.dart';
import 'package:project111/view/screens/article_detail_screen.dart';
import 'package:project111/view/screens/main_screen.dart';

// ignore: must_be_immutable
class ArticleList extends StatelessWidget {
  const ArticleList({super.key});


  @override
  Widget build(BuildContext context) {
  ArticleController articleController = Get.put(ArticleController());

  ArticleDetailController articleDetailController =
      Get.put(ArticleDetailController());
    var textTheme = Theme.of(context).textTheme;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(90),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'مقالات جدید',
                          style: textTheme.displaySmall,
                        ),
                      ),
                    ),
                  ],
                  leading: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const MainScreen()));
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
                ),
              ),
            ),
            body: Padding(
              padding:
                  const EdgeInsets.only(top: 5, right: 15, left: 15, bottom: 5),
              child: Obx(() => ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: articleController.articleList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          articleDetailController.id.value = int.parse(
                              articleController.articleList[index].id
                                  .toString());
                          Get.to(const ArticleDetailScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 230,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          articleController
                                              .articleList[index].title!,
                                          style: textTheme.displaySmall,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          textAlign: TextAlign.end,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              articleController
                                                  .articleList[index].author!,
                                              style: textTheme.displaySmall,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              textAlign: TextAlign.end,
                                            ),
                                            Text(
                                              articleController
                                                  .articleList[index].createAt!,
                                              style: textTheme.displaySmall,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              textAlign: TextAlign.end,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  CachedNetworkImage(
                                    imageUrl: articleController
                                        .articleList[index].image!,
                                    imageBuilder: (context, imageProvider) {
                                      return SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover)),
                                        ),
                                      );
                                    },
                                    placeholder: (context, url) {
                                      return const loading();
                                    },
                                    errorWidget: (context, url, error) {
                                      return const Icon(
                                        Icons.image_not_supported_outlined,
                                        size: 15,
                                        color: Colors.grey,
                                      );
                                    },
                                  ),
                                ],
                              ),
                              if (index !=
                                  articleController.articleList.length - 1)
                                const Divider(
                                  color: SolidColors.underLine,
                                )
                            ],
                          ),
                        ),
                      );
                    },
                  )),
            ),
          ),
        ));
  }
}
