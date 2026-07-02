import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lvsinterview/AppHelper/color_helper.dart';
import 'package:lvsinterview/AppHelper/text_style_helper.dart';

class OtherScreens extends StatelessWidget {
  final String screenName;
  const OtherScreens({super.key, required this.screenName});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorHelper.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return  Scaffold(
      extendBody: true,
     backgroundColor: ColorHelper.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(screenName,style: TextStyleHelper.boldBlackTwenty,),
              ],
            )
          ],
        ),
      ),
    );
  }
}
