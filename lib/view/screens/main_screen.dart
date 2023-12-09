import 'package:flutter/material.dart';
import 'package:project111/components/my_string.dart';
import 'package:project111/controller/register_controller.dart';
import 'package:project111/gen/assets.gen.dart';
import 'package:project111/components/my_colors.dart';
import 'package:project111/view/screens/home_screen_page.dart';
import 'package:project111/components/my_component.dart';
import 'package:get/get.dart';
import 'package:project111/view/screens/profile_screen.dart';
import 'package:share_plus/share_plus.dart';

final GlobalKey<ScaffoldState> _keys = GlobalKey();

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RxInt selectPageIndex = 0.obs;

    var text = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    var bodyMargin = size.width / 10;

    return SafeArea(
        child: Scaffold(
      key: _keys,
      drawer: Drawer(
        backgroundColor: SolidColors.systemNavigationBarColor,
        child: Padding(
          padding: EdgeInsets.only(right: bodyMargin, left: bodyMargin),
          child: ListView(children: [
            DrawerHeader(
                child: Center(
                    child: Image.asset(
              Assets.images.lo.path,
              scale: 3,
            ))),
            ListTile(
              title: Text(
                'پروفایل کاربری',
                style: text.headline3,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                            size: size, text: text, bodyMargin: bodyMargin)));
              },
            ),
            const Divider(
              color: SolidColors.underLine,
            ),
            ListTile(
              title: Text(
                'درباره تک بلاگ',
                style: text.headline3,
              ),
              onTap: () {},
            ),
            const Divider(
              color: SolidColors.underLine,
            ),
            ListTile(
              title: Text(
                'اشتراک گذاری تک بلاگ',
                style: text.headline3,
              ),
              onTap: () async {
                await Share.share(MyString.shareText);
              },
            ),
            const Divider(
              color: SolidColors.underLine,
            ),
            ListTile(
              title: Text(
                'تک بلاگ در گیتهاب',
                style: text.headline3,
              ),
              onTap: () {
                getLaunchUrl(MyString.launchGitHubUrl);
              },
            ),
            const Divider(
              color: SolidColors.underLine,
            ),
          ]),
        ),
      ),
      backgroundColor: SolidColors.systemNavigationBarColor,

      // AppBar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: SolidColors.systemNavigationBarColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  _keys.currentState!.openDrawer();
                },
                child: const Icon(
                  Icons.menu,
                  color: SolidColors.textTitle,
                )),
            Assets.images.lo
                .image(height: size.height / 13, width: size.width / 2),
            const Icon(
              Icons.search,
              color: SolidColors.textTitle,
            )
          ],
        ),
      ),

      // Body Home Screen Page
      body: Stack(children: [
        Positioned.fill(child: Obx(() {
          return IndexedStack(
            index: selectPageIndex.value,
            children: [
              HomeScreenPage(size: size, text: text, bodyMargin: bodyMargin),
              ProfileScreen(size: size, text: text, bodyMargin: bodyMargin),
            ],
          );
        })),
        BottomPageNavigationBar(
          size: size,
          changePageIndex: (int value) {
            selectPageIndex.value = value;
          },
        ),
      ]),
    ));
  }
}

class BottomPageNavigationBar extends StatelessWidget {
  const BottomPageNavigationBar({
    super.key,
    required this.size,
    required this.changePageIndex,
  });

  final Size size;
  final Function(int) changePageIndex;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        height: size.height / 10,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: GradiantColors.bottomNavGradiant,
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            right: 50,
            left: 50,
            bottom: 8,
          ),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                gradient: LinearGradient(
                  colors: GradiantColors.bottomNav,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: (() => changePageIndex(0)),
                  icon: ImageIcon(AssetImage(Assets.icons.home.keyName)),
                  color: Colors.white,
                  iconSize: 30,
                ),
                IconButton(
                  onPressed: () {
                    Get.find<RegisterController>().toggleLogin();
                  },
                  icon: ImageIcon(AssetImage(Assets.icons.par.keyName)),
                  color: Colors.white,
                  iconSize: 30,
                ),
                IconButton(
                  onPressed: (() => changePageIndex(1)),
                  icon: ImageIcon(AssetImage(Assets.icons.user.keyName)),
                  color: Colors.white,
                  iconSize: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
