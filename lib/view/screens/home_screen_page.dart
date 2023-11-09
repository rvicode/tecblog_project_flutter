import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:project111/components/my_component.dart';
import 'package:project111/controller/home_screen_controller.dart';
import 'package:project111/gen/assets.gen.dart';
import 'package:project111/components/my_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:project111/components/my_string.dart';
import 'package:project111/view/screens/article_detail_screen.dart';
import 'package:project111/view/screens/article_list_screen.dart';

// ignore: must_be_immutable
class HomeScreenPage extends StatelessWidget {
  HomeScreenPage({
    super.key,
    required this.size,
    required this.text,
    required this.bodyMargin,
  });

  final Size size;
  final TextTheme text;
  final double bodyMargin;
  HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: homeScreenController.loading.value == false
                ? Column(
                    children: [
                      poster(),
                      const SizedBox(
                        height: 16,
                      ),
                      tagsList(),
                      HomePageSeeMoreBlog(text: text),
                      topVisited(),
                      HomePageSeeMorePodCast(text: text),
                      topPodCast(),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  )
                : const loading(),
          ),
        ],
      ),
    );
  }

  Widget topVisited() {
    return SizedBox(
        height: size.height / 2.4,
        child: Obx(() => ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: homeScreenController.topVisitedList.length,
              itemBuilder: (context, index) {
                // Blog
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const ArticleDetailScreen()));
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
                                      .topVisitedList[index].image!,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    foregroundDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      gradient: const LinearGradient(
                                          colors: GradiantColors
                                              .homeBlogCoverGradiant,
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      const SpinKitThreeBounce(
                                    color: SolidColors.primeryColor,
                                    size: 50.0,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.image_not_supported_outlined,
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
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      homeScreenController
                                          .topVisitedList[index].author!,
                                      style: text.displayMedium,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      homeScreenController
                                          .topVisitedList[index].view!,
                                      style: text.displayMedium,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        Icons.remove_red_eye,
                                        color: SolidColors.scafoldBg,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                            // title
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 12, 10, 0),
                              child: SizedBox(
                                width: size.width / 2.4,
                                child: Text(
                                  homeScreenController
                                      .topVisitedList[index].title!,
                                  style: text.displayLarge,
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
            )));
  }

  Widget topPodCast() {
    return SizedBox(
        height: size.height / 2.4,
        child: Obx(
          () => ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: homeScreenController.topPodCast.length,
            itemBuilder: (context, index) {
              // Podcast
              return InkWell(
                onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ArticleDetailScreen()));
                  },
                child: Padding(
                  padding:
                      EdgeInsets.fromLTRB(8, 23, index == 0 ? bodyMargin : 8, 0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: size.height / 3.8,
                            width: size.width / 2.0,
                            child: CachedNetworkImage(
                              imageUrl:
                                  homeScreenController.topPodCast[index].poster!,
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  const SpinKitThreeBounce(
                                color: SolidColors.primeryColor,
                                size: 50.0,
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.image_not_supported_outlined,
                                size: 50.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          // title
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 12, 10, 0),
                            child: SizedBox(
                              width: size.width / 2.4,
                              child: Text(
                                  homeScreenController.topPodCast[index].title!,
                                  style: text.headline1,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  Widget poster() {
    return Obx(
      () => Stack(children: [
        Container(
          width: size.width / 1.25,
          height: size.height / 4.2,
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
                colors: GradiantColors.homePostCoverGradiant,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: CachedNetworkImage(
            imageUrl: homeScreenController.poster.value.image!,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => loading(),
            errorWidget: (context, url, error) => const Icon(
              Icons.image_not_supported_outlined,
              size: 50.0,
              color: Colors.grey,
            ),
          ),
        ),
        Positioned(
          bottom: 12,
          right: 0,
          left: 0,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  homeScreenController.poster.value.title!,
                  style: text.bodyText1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  Widget tagsList() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: homeScreenController.tags.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(8, 8, index == 0 ? bodyMargin : 8, 8),
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
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: Row(
                  children: [
                    ImageIcon(
                      AssetImage(Assets.icons.hashtag.keyName),
                      color: Colors.white,
                      size: 14,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(homeScreenController.tags[index].title!,
                        style: text.headline2),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HomePageSeeMorePodCast extends StatelessWidget {
  const HomePageSeeMorePodCast({
    super.key,
    required this.text,
  });

  final TextTheme text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, top: 25),
      child: Row(
        children: [
          ImageIcon(
            AssetImage(Assets.icons.micPhone.keyName),
            color: SolidColors.colorTitle,
          ),
          const SizedBox(
            width: 16,
          ),
          InkWell(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ArticleList()));
            },
            child: Text(
              MyString.viewHotesPodcast,
              style: text.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}

class HomePageSeeMoreBlog extends StatelessWidget {
  const HomePageSeeMoreBlog({
    super.key,
    required this.text,
  });

  final TextTheme text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, top: 25),
      child: Row(
        children: [
          ImageIcon(
            AssetImage(Assets.icons.pen.keyName),
            color: SolidColors.colorTitle,
          ),
          const SizedBox(
            width: 16,
          ),
          InkWell(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ArticleList()));
            },
            child: Text(
              MyString.viweHotesBlog,
              style: text.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
