
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../AppHelper/color_helper.dart';
import '../AppHelper/text_helper.dart';
import '../AppHelper/text_style_helper.dart';
import '../CommonWidgets/common_gridview.dart';
import '../Model/models_list_model.dart';
import '../Provider/dashboard_provider.dart';

class StreamScreen extends StatefulWidget {
  final  String type;
  const StreamScreen({super.key,required this.type});

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      final provider = Provider.of<DashboardProvider>(context,listen: false);
      provider.setType(widget.type);
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
                SizedBox(
                  height: 25,
                  child: ListView.builder(
                    itemCount: dashboardProvider.countryList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final name = dashboardProvider.countryList[index].name;
                      final image = dashboardProvider.countryList[index].image;
                      final isSelected =
                          dashboardProvider.selectedCountryIndex == index;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                              isSelected
                                  ? ColorHelper.green
                                  : ColorHelper.greyShade300,
                              width: 1,
                            ),
                            color:
                            isSelected
                                ? ColorHelper.green.withOpacity(.3)
                                : ColorHelper.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              dashboardProvider.selectCountry(index);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    image,
                                    width: 12,
                                    height: 12,
                                    // fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(name,style:isSelected?TextStyleHelper.boldBlackTwelve:TextStyleHelper.normalBlackTwelve),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      final provider = Provider.of<DashboardProvider>(
                        context,
                        listen: false,
                      );
                      provider.loadCountries();
                      provider.loadModels();
                      provider.resetCountry();
                    },
                    child: CommonGridView(
                      isLoading: dashboardProvider.modelLoading,
                      items: dashboardProvider.currentList,

                      noData: Center(child: Image.asset('asset/no_data.jpg',fit: BoxFit.cover,)),

                      loadingItemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: ColorHelper.greyShade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        );
                      },

                      itemBuilder: (context, index, model) {
                        final isFollow = dashboardProvider.isFollowing(
                          model.id,
                        );

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorHelper.greyShade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(model.image, fit: BoxFit.cover),

                                Container(
                                  decoration:  BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        ColorHelper.black26,
                                        ColorHelper.transparent,
                                        ColorHelper.black54,
                                      ],
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top: 6,
                                  left: 5,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal:6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ColorHelper.black54,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 2.0),
                                          child: Icon(Icons.visibility_rounded,size: 12,color: ColorHelper.white,),
                                        ),
                                        Text(
                                          model.viewedCount,
                                          style:  TextStyle(
                                            color: ColorHelper.white,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Positioned(
                                  bottom: 5,
                                  left: 5,
                                  right: 5,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: ColorHelper.grey,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 6),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              model.name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style:  TextStyle(
                                                color: ColorHelper.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Image.asset(
                                              model.country,
                                              width: 12,
                                              height: 12,
                                            ),
                                          ],
                                        ),
                                      ),

                                      GestureDetector(
                                        onTap: () {
                                          dashboardProvider.toggleFollow(
                                            model.id,
                                          );
                                        },
                                        child: Container(
                                          width: 60,
                                          height: 20,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                            isFollow
                                                ? ColorHelper.grey
                                                : ColorHelper.yellowAccent,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Text(
                                            isFollow
                                                ? TextHelper.following
                                                : TextHelper.followingWithPlus,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

