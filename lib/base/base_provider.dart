import 'package:claim_investigation/service/api_client.dart';
import 'package:claim_investigation/storage/app_pref.dart';
import 'package:claim_investigation/util/app_helper.dart';
import 'package:flutter/cupertino.dart';

import '../main.dart';


class BaseProvider extends ChangeNotifier {

  ApiClient apiClient = getIt<ApiClient>();
  AppSharedPref pref = getIt<AppSharedPref>();
  AppHelper appHelper = getIt<AppHelper>();


  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
