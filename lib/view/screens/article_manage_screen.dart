import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project111/components/my_colors.dart';
import 'package:project111/components/my_component.dart';
import 'package:project111/controller/article_manage_controller.dart';
import 'package:project111/gen/assets.gen.dart';
import 'package:project111/components/my_string.dart';
import 'package:project111/main.dart';

class ArticleManage extends StatelessWidget {
  ArticleManage({super.key});

  var articleManageController = Get.find<ArticleManageController>();

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
      body: Obx(
        () => articleManageController.loading.value
            ? const loading()
            : articleManageController.articleList.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: articleManageController.articleList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          articleManageController.getArticleManaged();
                          Get.toNamed(NamedRoute.routeArticleDetail);
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
                                          articleManageController
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
                                              articleManageController
                                                  .articleList[index].author!,
                                              style: textTheme.displaySmall,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              textAlign: TextAlign.end,
                                            ),
                                            Text(
                                              articleManageController
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
                                    imageUrl: articleManageController
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
                                  articleManageController.articleList.length -
                                      1)
                                const Divider(
                                  color: SolidColors.underLine,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : emptyScreen(text),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 16),
        child: ElevatedButton(
            style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(0, Get.height / 14))),
            onPressed: () {},
            child: const Text(MyString.writeblogBottom)),
      ),
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
          Get.back();
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
