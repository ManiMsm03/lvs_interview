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
        "model 1",
        'asset/nations/india.jpg',
        'asset/models/india_model_1.png',
        1,
        'model',
      ),
      ModelsListModel(
        "8.2k",
        "2",
        "model 2",
        'asset/nations/india.jpg',
        'asset/models/india_model_2.jpg',
        1,
        'model',
      ),
      ModelsListModel(
        "271.2k",
        "3",
        "model 3",
        'asset/nations/india.jpg',
        'asset/models/india_model_3.jpg',
        1,
        'hot',
      ),
      ModelsListModel(
        "111.8k",
        "4",
        "model 4",
        'asset/nations/philippines.png',
        'asset/models/phi_model_1.jpg',
        2,
        'hot',
      ), ModelsListModel(
        "71.7k",
        "5",
        "model 5",
        'asset/nations/philippines.png',
        'asset/models/phi_model_2.jpg',
        2,
        'model',
      ),
      ModelsListModel(
        "11.8k",
        "6",
        "model 6",
        'asset/nations/brazil.png',
        'asset/models/brazil_model_1.png',
        3,
        'hot',
      ),  ModelsListModel(
        "70.5k",
        "7",
        "model 7",
        'asset/nations/brazil.png',
        'asset/models/brazil_model_2.png',
        3,
        'model',
      ),
      ModelsListModel(
        "81.2k",
        "8",
        "model 8",
        'asset/nations/brazil.png',
        'asset/models/brazil_model_3.png',
        3,
        'model',
      ), ModelsListModel(
        "12.2k",
        "9",
        "Ira Arey",
        'asset/nations/south_Africa.png',
        'asset/models/south_africa_model_1jpg.jpg',
        4,
        'cricket',
      ),

    ];
    modelLoading = false;
    notifyListeners();
  }

  bool isFollowing(String id) {
    return _followingIds.contains(id);
  }

  void setType(String type) {
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
  void toggleFollow(String id) {
    if (_followingIds.contains(id)) {
      _followingIds.remove(id);
    } else {
      _followingIds.add(id);
    }
    notifyListeners();
  }

  void selectCountry(int index) {
    _selectedCountryIndex = index;
    notifyListeners();
  }

  void resetCountry() { // reset function
    _selectedCountryIndex = 0;
    notifyListeners();
  }

  List<ModelsListModel> get filteredModels {
    if (_selectedCountryIndex == 0) {
      return _modelsList;
    }
    return _modelsList
        .where((m) => m.countryIndex == _selectedCountryIndex)
        .toList();
  }


  List<ModelsListModel> get hotModels {
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

  List<ModelsListModel> get followedModels {
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

    String  countryListUrl = "geturl";

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

  Future<void> logout() async {
    await _auth.signOut();
    notifyListeners();
  }
}
