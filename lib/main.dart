import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project111/binding.dart';
import 'package:project111/components/my_colors.dart';
import 'package:project111/my_https_override.dart';
import 'package:project111/view/screens/article_detail_screen.dart';
import 'package:project111/view/screens/main_screen.dart';
import 'package:project111/view/screens/splash_screen.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: SolidColors.statusBarIconBrightness,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: SolidColors.systemNavigationBarColor,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('fa'),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa'), // Persian
      ],
      theme: liteTheme(),
      getPages: [
        GetPage(
            name: routeMainScreen,
            page: () => const MainScreen(),
            binding: RegisterBinding()),
        GetPage(
            name: routeArticleDetail,
            page: () => ArticleDetailScreen(),
            binding: ArticleBinding()),
      ],
      home: const SplashScreen(),
    );
  }

  ThemeData liteTheme() {
    return ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.black, width: 2)),
          filled: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              textStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return const TextStyle(fontSize: 25);
            }
            return const TextStyle(
                fontSize: 20, color: SolidColors.primeryColor);
          }), backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return const Color.fromARGB(255, 135, 9, 173);
            }
            return SolidColors.primeryColor;
          })),
        ),
        fontFamily: 'dana',
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: SolidColors.textTitle,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          headline2: TextStyle(
            color: SolidColors.subTitleColor,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          headline3: TextStyle(
            color: SolidColors.textTitle,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          headline4: TextStyle(
            color: SolidColors.subText,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          bodyText1: TextStyle(
            color: SolidColors.titleColor,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
          bodyText2: TextStyle(
            color: SolidColors.colorTitle,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ));
  }
}

const String routeMainScreen = '/MainScreen';
const String routeArticleDetail = '/ArticleDetail';
