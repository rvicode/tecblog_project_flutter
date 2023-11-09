import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project111/gen/assets.gen.dart';
import 'package:project111/components/my_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class MainTags extends StatelessWidget {
  const MainTags({
    super.key,
    required this.bodyMargin,
    required this.text,
    required this.index,
  });

  final double bodyMargin;
  final TextTheme text;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
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
        padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
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
            Text('', style: text.headline2),
          ],
        ),
      ),
    );
  }
}

getLaunchUrl(String url) async {
  var myUri = Uri.parse(url.toString());

  if (await canLaunchUrl(myUri)) {
    await launchUrl(myUri);
  } else {
    log('cant show $myUri');
  }
}

class loading extends StatelessWidget {
  const loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SpinKitThreeBounce(
      color: SolidColors.primeryColor,
      size: 50.0,
    );
  }
}
