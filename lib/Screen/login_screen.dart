import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lvsinterview/AppHelper/color_helper.dart';
import 'package:lvsinterview/AppHelper/text_helper.dart';
import 'package:lvsinterview/AppHelper/text_style_helper.dart';
import 'package:lvsinterview/CommonWidgets/common_button.dart';
import 'package:lvsinterview/CommonWidgets/common_text_form_field.dart';
import 'package:lvsinterview/Provider/login_screen_provider.dart';
import 'package:lvsinterview/Screen/dashboard.dart';
import 'package:lvsinterview/Screen/other_screens.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorHelper.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<LoginScreenProvider>(
        builder: (context, loginProvider, child) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  child: Image.asset('asset/bg.png', fit: BoxFit.cover),
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Image.asset(
                          'asset/splash_logo.png',
                          height: 50,
                          width: 50,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Text(
                                TextHelper.welcome,
                                style: TextStyleHelper.boldBlackTwenty,
                              ),
                            ),
                            Image.asset(
                              'asset/hifi.png',
                              height: 45,
                              width: 45,
                            ),
                          ],
                        ),
                        Text(
                          TextHelper.streamJourney,
                          style: TextStyleHelper.normalBlackTwelve,
                        ),
                        SizedBox(height: 36),
                        Form(
                          key: loginProvider.key,
                          child: Column(
                            children: [
                              CommonTextFormField(
                                headerText: TextHelper.emailHeader,
                                headerColor: ColorHelper.grey,
                                controller: loginProvider.userNameController,
                                hintText: TextHelper.emailHint,
                                hintColor: ColorHelper.grey,
                                textInputAction: TextInputAction.next,
                                onChanged: (value) {
                                  setState(() {
                                    loginProvider.userNameController.text =
                                        value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return TextHelper.userNameEmpty;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 12),
                              CommonTextFormField(
                                headerText: TextHelper.passwordHeader,
                                headerColor: ColorHelper.grey,
                                controller: loginProvider.passwordController,
                                hintText: TextHelper.passwordHint,
                                hintColor: ColorHelper.grey,
                                obscureText: loginProvider.obscure,
                                onChanged: (value) {
                                  setState(() {
                                    loginProvider.passwordController.text =
                                        value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return TextHelper.passWordEmpty;
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.done,
                                password: true,
                                passwordShow: () {
                                  setState(() {
                                    loginProvider.obscure =
                                        !loginProvider.obscure;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                TextHelper.forgotPassword,
                                style: TextStyleHelper.textWithLineGreen
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        CommonButton(
                          height: .06,
                          width: 8,
                          textStyle: TextStyleHelper.boldWhiteFourteen,
                          buttonText: TextHelper.login,

                          gradientColors: [
                            ColorHelper.loginBtn1,
                            ColorHelper.loginBtn2,
                          ],
                          onPress: () async {
                            if (loginProvider.key.currentState!.validate()) {

                              var user =  await loginProvider.loginUser(context);

                              if(user != null && mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Dashboard(),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .11,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                endIndent: 10,
                                indent: 2,
                                color: ColorHelper.white,
                                height: 1,
                              ),
                            ),
                            Text(
                              TextHelper.continueWith,
                              style: TextStyleHelper.normalWhiteFourteen,
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                endIndent: 2,
                                indent: 10,
                                color: ColorHelper.white,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        CommonButton(
                          height: .06,
                          width: 8,
                          isLoading: loginProvider.isLoading,
                          textStyle: TextStyleHelper.normalBlackFourteen,
                          imageName: 'asset/google.png',
                          buttonText: TextHelper.continueGoogle,
                          onPress: () async {
                            final user = await loginProvider.loginWithGoogle();
                            if (user != null && mounted) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => Dashboard()),
                              );
                            }
                          },
                          buttonColor: ColorHelper.white,
                        ),
                        SizedBox(height: 18),
                        CommonButton(
                          height: .06,
                          width: 8,
                          buttonText: TextHelper.continueFacebook,
                          textStyle: TextStyleHelper.normalBlackFourteen,
                          imageName: 'asset/facebook.png',
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => OtherScreens(
                                      screenName: TextHelper.facebook,
                                    ),
                              ),
                            );
                          },
                          buttonColor: ColorHelper.white,
                        ),
                        SizedBox(height: 24),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => OtherScreens(
                                      screenName: TextHelper.signupScreen,
                                    ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Text(
                                  TextHelper.newUser,
                                  style: TextStyleHelper.normalWhiteFourteen,
                                ),
                              ),
                              Text(
                                TextHelper.signup,
                                style: TextStyleHelper.textWithLineYellow
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
