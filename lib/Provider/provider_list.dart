import 'package:lvsinterview/Provider/dashboard_provider.dart';
import 'package:provider/provider.dart';
import 'package:nested/nested.dart';

import 'login_screen_provider.dart';

class ProviderList {
   static final List<SingleChildWidget> provider = [
    ChangeNotifierProvider<LoginScreenProvider>(create:(_)=>LoginScreenProvider()),
    ChangeNotifierProvider<DashboardProvider>(create:(_)=>DashboardProvider()),


  ];

}