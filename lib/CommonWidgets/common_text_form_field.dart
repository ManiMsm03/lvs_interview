import 'package:flutter/material.dart';
import 'package:lvsinterview/AppHelper/color_helper.dart';

class CommonTextFormField extends StatelessWidget {
  final String? headerText;
  final TextInputType? keyBoardType;
  final TextInputAction? textInputAction;
  final String? hintText;
  final Color? hintColor;
  final Color? headerColor;
  final bool obscureText;
  final bool password;
  final VoidCallback? passwordShow;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  const CommonTextFormField({
    super.key,
    required this.headerText,
    required this.controller,
    required this.hintText,
    required this.hintColor,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.keyBoardType,
    this.textInputAction,
    this.headerColor,
    this.password = false,
    this.passwordShow,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerText!,
          style: TextStyle(
            color: headerColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 4),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          maxLines: 1,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: keyBoardType,
          onChanged: onChanged!,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Colors.grey[200],
            hintText: hintText,
            hintStyle: TextStyle(
              color: hintColor,
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
            counterText: "",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.transparent),),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            suffixIcon:
                password
                    ? IconButton(
                      onPressed: passwordShow,
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: ColorHelper.grey,
                      ),
                    )
                    : null,
          ),
        ),
      ],
    );
  }
}
