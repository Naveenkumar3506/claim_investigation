import 'dart:convert';
import 'package:claim_investigation/base/base_provider.dart';
import 'package:claim_investigation/service/api_client.dart';
import 'package:claim_investigation/service/api_constants.dart';
import 'package:claim_investigation/util/app_helper.dart';
import 'package:claim_investigation/util/app_log.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends BaseProvider {
  UserModel currentUser;

  bool get isAuth {
    currentUser = pref.user;
    return currentUser != null;
  }

  Future<UserModel> authenticate(String email, String password) async {
    final response = await super.apiClient.callWebService(
        path: ApiConstant.API_USER_LOGIN,
        method: ApiMethod.POST,
        body: {
          'username': email,
          'password': password,
        },
        withAuth: false);
    response.fold((l) {
      AppLog.print('left----> ' + l.toString());
      showErrorToast(l.toString());
    }, (r) {
      AppLog.print('right----> ' + r.toString());
      currentUser = UserModel.fromJson(r);
      // Save to preference
      super.pref.user = currentUser;
      notifyListeners();
    });
    return currentUser;
  }

  Future<bool> forgotPassword(String email) async {
    final response = await super.apiClient.callWebService(
        path: ApiConstant.API_FORGOT_PASSWORD + email,
        method: ApiMethod.POST,
        body: {'email': email},
        withAuth: false);
    return response.fold((l) {
      AppLog.print('left----> ' + l.toString());
      showErrorToast(l.toString());
      return false;
    }, (r) {
      AppLog.print('right----> ' + r.toString());
      return true;
    });
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    final response = await super.apiClient.callWebService(
        path: ApiConstant.API_CHANGE_PASSWORD,
        method: ApiMethod.POST,
        body: {'oldpassword': oldPassword, 'newpassword': newPassword});
    return response.fold((l) {
      AppLog.print('left----> ' + l.toString());
      showErrorToast(l.toString());
      return false;
    }, (r) {
      AppLog.print('right----> ' + r.toString());
      return true;
    });
  }

  void clearUserData() {
    pref.removeUserModel();
    currentUser = null;
    //
    notifyListeners();
  }
}
