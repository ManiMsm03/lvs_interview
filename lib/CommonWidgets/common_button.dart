import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lvsinterview/AppHelper/text_helper.dart';

import '../AppHelper/color_helper.dart';

class CommonButton extends StatelessWidget {
  final double height;
  final double width;
  final String buttonText;
  final String? imageName;
  final Color? buttonColor;
  final bool isLoading;
  final List<Color>? gradientColors;
  final TextStyle textStyle;
 final VoidCallback onPress;


   const CommonButton({super.key, required this.height, required this.width, required this.buttonText, required this.onPress, this.imageName, required this.textStyle, this.buttonColor,
     this.gradientColors, this.isLoading = false,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height:MediaQuery.of(context).size.height* height ,
        width:MediaQuery.of(context).size.width* width ,
        child:DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: gradientColors == null ? (buttonColor ?? Colors.blue) : null,
            gradient: gradientColors != null
                ? LinearGradient(colors: gradientColors!)
                : null,
          ),
          child: ElevatedButton(onPressed: onPress,style: ElevatedButton.styleFrom(    backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),), child: isLoading
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                              height: 20,
                              width: 20,
                              child: CupertinoActivityIndicator(
                  color: Colors.black,
                              )
                            ),
                  Padding(
                    padding:  EdgeInsets.only(left: 8.0),
                    child: Text(TextHelper.loading,style: TextStyle(color: ColorHelper.black),),
                  )
                ],
              ):Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(imageName!=null)Image.asset(imageName!,height: 15,width: 15,),
             if(imageName!=null) SizedBox(width: 10,),
              Text(buttonText,style: textStyle,),
            ],
          ),),
        ));
  }
}
