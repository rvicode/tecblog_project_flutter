import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project111/controller/home_screen_controller.dart';
import 'package:project111/gen/assets.gen.dart';
import 'package:project111/components/my_colors.dart';
import 'package:project111/components/my_string.dart';
import 'package:project111/models/fake_data.dart';
import 'package:project111/components/my_component.dart';
import 'package:project111/view/screens/main_screen.dart';

class MyCategory extends StatefulWidget {
  const MyCategory({super.key});

  @override
  State<MyCategory> createState() => _MyCategoryState();
}

class _MyCategoryState extends State<MyCategory> {
  @override
  Widget build(BuildContext context) {
    var text = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    var bodyMargin = size.width / 10;
    HomeScreenController homeScreenController = Get.put(HomeScreenController());

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Center(
            child: Column(
              children: [
                SvgPicture.asset(
                  Assets.images.tecbot.path,
                  height: 120,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  MyString.successfulLogin,
                  style: text.headline3,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17)),
                      hintText: 'نام و نام خانوادگی',
                      contentPadding: const EdgeInsets.only(right: 25, top: 30),
                      hintStyle: text.headline4,
                      hintMaxLines: 50,
                      filled: false,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1)),
                    ),
                  ),
                ),
                Text(MyString.descriptionLogin,
                    style: text.displaySmall, textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: size.height / 7,
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: homeScreenController.tags.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 6,
                              crossAxisCount: 3,
                              mainAxisExtent: 125,
                              childAspectRatio: 0.3),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (() {
                            setState(() {
                              selectTags.add(tageList[index]);
                              tageList.removeAt(index);
                            });
                          }),
                          child: MainTags(
                            bodyMargin: bodyMargin,
                            text: text,
                            index: index,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Image.asset(Assets.icons.side.path, width: 70),

                // Select Tags
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: size.height / 9,
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: selectTags.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              crossAxisCount: 2,
                              mainAxisExtent: 125,
                              childAspectRatio: 0.3),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 80,
                          decoration: const BoxDecoration(
                            color: SolidColors.selectTagsColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(selectTags[index].title,
                                    style: text.displaySmall),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        tageList.add(selectTags[index]);
                                        selectTags.removeAt(index);
                                      });
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      size: 20,
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Wrap(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const MainScreen()));
                        },
                        child: const Text('ادامه')),
                  )
                ]),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
