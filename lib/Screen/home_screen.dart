import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lvsinterview/AppHelper/text_style_helper.dart';
import 'package:lvsinterview/Screen/other_screens.dart';
import 'package:lvsinterview/Screen/stream_screen.dart';
import 'package:provider/provider.dart';
import 'package:lvsinterview/AppHelper/text_helper.dart';
import 'package:lvsinterview/Provider/dashboard_provider.dart';

import '../AppHelper/color_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<DashboardProvider>(context, listen: false);
      provider.loadCountries();
      provider.loadModels();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorHelper.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Consumer<DashboardProvider>(
          builder: (context, dashboardProvider, child) {
            return Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      Image.asset('asset/splash_logo.png', width: 40, height: 40),
                      Spacer(),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration:  BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorHelper.black12,
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.center,
                                children: [
                                   Icon(
                                    Icons.notifications_none,
                                    size: 28,
                                    color: ColorHelper.grey,
                                  ),

                                  Positioned(
                                    top: 1,
                                    right: 6,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration:  BoxDecoration(
                                        color:ColorHelper.red,
                                        shape: BoxShape.circle,
                                      ),
                                      constraints: const BoxConstraints(
                                        minWidth: 16,
                                        minHeight: 16,
                                      ),
                                      child:  Center(
                                        child: Text(
                                          TextHelper.zero,
                                          style: TextStyleHelper.boldWhiteTen
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    ColorHelper.loginBtn1,
                                    ColorHelper.loginBtn2,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Icon(
                                Icons.wallet_giftcard_sharp,
                                color: ColorHelper.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Expanded(
                  child: DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        TabBar(
                          isScrollable: true,
                          dividerColor: ColorHelper.transparent,
                          indicatorColor:ColorHelper.transparent,
                          labelColor: ColorHelper.forgotPassword,
                          unselectedLabelColor: ColorHelper.grey,
                          labelStyle: TextStyleHelper.boldGreenSixteen,
                          tabAlignment: TabAlignment.start,
                          tabs: [
                            Tab(text: TextHelper.stream),
                            Tab(text: TextHelper.hot),
                            Tab(text: TextHelper.follow),
                          ],
                        ),

                        Expanded(
                          child: TabBarView(
                            children: [
                              StreamScreen(type: TextHelper.stream,),
                              StreamScreen(type: TextHelper.hot),
                              StreamScreen(type: TextHelper.follow),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )

              ],
            );
          },
        ),
      ),
    );
  }
}
