import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:lvsinterview/AppHelper/color_helper.dart';

class TextStyleHelper {

 static final normalBlackTwelve =  TextStyle(
     fontSize: 12,
     color: ColorHelper.black,
     fontWeight: FontWeight.normal);

 static final boldBlackTwelve =   TextStyle(
     fontSize: 12,
     color: ColorHelper.black,
     fontWeight: FontWeight.w600);
 static final boldWhiteTen=   TextStyle(
  color:ColorHelper.white,
  fontSize: 10,
  fontWeight: FontWeight.bold,
 );
 static final normalBlackFourteen =  TextStyle(
     fontSize: 14,
     color: ColorHelper.black,
     fontWeight: FontWeight.bold);
 static final boldGreenSixteen =  TextStyle(
     fontSize: 16,
     color: ColorHelper.forgotPassword,
     fontWeight: FontWeight.bold);

 static final normalWhiteFourteen =  TextStyle(
     fontSize: 14,
     color: ColorHelper.loginYellow,
     fontWeight: FontWeight.normal);
 static final boldWhiteFourteen =  TextStyle(
     fontSize: 14,
     color: ColorHelper.loginYellow,
     fontWeight: FontWeight.bold);

 static final boldBlackTwenty =  GoogleFonts.poppins(
     fontSize: 20,
     color: ColorHelper.black,
     fontWeight: FontWeight.bold);

 static final textWithLineGreen =  TextStyle(
  color: ColorHelper.forgotPassword,
  fontWeight: FontWeight.w700,
  decoration: TextDecoration.underline,
  decorationColor: ColorHelper.forgotPassword,
  decorationThickness: 2,
 );
     static final textWithLineYellow =  TextStyle(
  color: ColorHelper.loginYellow,
  fontWeight: FontWeight.w600,
  decoration: TextDecoration.underline,
  decorationColor: ColorHelper.loginYellow,
  decorationThickness: 2,
 );




}