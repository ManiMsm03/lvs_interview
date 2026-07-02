import 'package:flutter/cupertino.dart';
import 'package:lvsinterview/AppHelper/text_helper.dart';
import 'package:lvsinterview/Model/country_list_model.dart';
import 'package:lvsinterview/Model/models_list_model.dart';

import '../CommonWidgets/common_snack_bar.dart';
import '../Service/api_services.dart';
import '../Service/google_service.dart';

class DashboardProvider extends ChangeNotifier {
  final AuthService _auth = AuthService();
  final ApiService _api = ApiService();
  bool modelLoading = false;
  final Set<String> _followingIds = {};

  List<CountryListModel> _countryList = [];
  List<CountryListModel> get countryList => _countryList;
  List<ModelsListModel> _modelsList = [];
  List<ModelsListModel> get modelsList => _modelsList;


  final int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  final int _headerSelectedIndex = 0;
  int get headerSelectedIndex => _headerSelectedIndex;
  int _selectedCountryIndex = 0;
  int get selectedCountryIndex => _selectedCountryIndex;

   String _currentType = TextHelper.stream;

  String get currentType => _currentType;

  void loadCountries() {
    _countryList = [
      CountryListModel("Global", 'asset/nations/global.png', 0),
      CountryListModel("india", 'asset/nations/india.jpg', 1),
      CountryListModel("Philippines", 'asset/nations/philippines.png', 2),
      CountryListModel("Brazil", 'asset/nations/brazil.png', 3),
      CountryListModel("South Africa", 'asset/nations/south_Africa.png', 4),
    ];

    notifyListeners();
  }

  Future<void> loadModels() async {
    modelLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3));
    _modelsList = [
      ModelsListModel(
        "18.3k",
        "1",
        "Sastha",
        'asset/nations/india.jpg',
        'asset/models/sastha.jpg',
        1,
        'general',
      ),
      ModelsListModel(
        "8.2k",
        "2",
        "Vijay",
        'asset/nations/india.jpg',
        'asset/models/vj.jpg',
        1,
        'hot',
      ),
      ModelsListModel(
        "271.2k",
        "3",
        "Samantha",
        'asset/nations/brazil.png',
        'asset/models/sam.jpg',
        3,
        'actress',
      ),
      ModelsListModel(
        "4.2k",
        "4",
        "Mahi",
        'asset/nations/south_Africa.png',
        'asset/models/ms.jpg',
        4,
        'cricket',
      ),
      ModelsListModel(
        "11.2k",
        "5",
        "FZ-S",
        'asset/nations/south_Africa.png',
        'asset/models/fz.jpg',
        4,
        'bike',
      ),
      ModelsListModel(
        "0.2k",
        "6",
        "Tiger",
        'asset/nations/philippines.png',
        'asset/models/tiger.jpg',
        2,
        'animal',
      ),
      ModelsListModel(
        "10.2k",
        "7",
        "Eagle",
        'asset/nations/south_Africa.png',
        'asset/models/eagle.jpg',
        4,
        'bird',
      ),
    ];
    modelLoading = false;
    notifyListeners();
  }

  bool isFollowing(String id) { // already follow or not
    return _followingIds.contains(id);
  }

  void setType(String type) { // tab type handling function
    _currentType = type;
    resetCountry();
    notifyListeners();
  }
  List<ModelsListModel> get currentList {
    if (_currentType == TextHelper.hot) {
      return hotModels;
    } else if (_currentType == TextHelper.follow) {
      return followedModels;
    } else {
      return filteredModels;
    }
  }
  void toggleFollow(String id) { // follow and unfollow function
    if (_followingIds.contains(id)) {
      _followingIds.remove(id);
    } else {
      _followingIds.add(id);
    }
    notifyListeners();
  }

  void selectCountry(int index) { // country function
    _selectedCountryIndex = index;
    notifyListeners();
  }

  void resetCountry() { // reset function
    _selectedCountryIndex = 0;
    notifyListeners();
  }

  List<ModelsListModel> get filteredModels { // filter models
    if (_selectedCountryIndex == 0) {
      return _modelsList;
    }
    return _modelsList
        .where((m) => m.countryIndex == _selectedCountryIndex)
        .toList();
  }


  List<ModelsListModel> get hotModels { // hot topics models
    var list = _modelsList
        .where((e) => e.topic.toLowerCase() == TextHelper.hot.toLowerCase())
        .toList();

    if (_selectedCountryIndex == 0) {
      return list;
    }

    return list
        .where((e) => e.countryIndex == _selectedCountryIndex)
        .toList();
  }

  List<ModelsListModel> get followedModels { // following models
    var list = _modelsList
        .where((e) => _followingIds.contains(e.id))
        .toList();

    if (_selectedCountryIndex == 0) {
      return list;
    }

    return list
        .where((e) => e.countryIndex == _selectedCountryIndex)
        .toList();
  }


  Future<void> getCountryList(BuildContext context) async {

    String  countryListUrl = "";

    final response = await _api.getMethod(countryListUrl);

    if (response.statusCode == 200) {
      SnackBarHelper.showSnackBar(
        context,
        message: "Data loaded successfully",
      );

      _countryList = response.data;
      notifyListeners();
    } else {
      SnackBarHelper.showSnackBar(
        context,
        message: "Failed to load data",
        isError: true,
      );
    }
  }

  Future<void> logout() async { // logout function
    await _auth.signOut();
    notifyListeners();
  }
}
