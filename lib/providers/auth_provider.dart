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
    showLoadingIndicator(hint: "Signing In...");
    final response = await super.apiClient.callWebService(
        path: ApiConstant.API_USER_LOGIN,
        method: ApiMethod.POST,
        body: {
          'username': email,
          'password': password,
        },
        withAuth: false);
    hideLoadingIndicator();
    response.fold((l) {
      AppLog.print('left----> ' + l.toString());
      showErrorToast(l.toString());
      currentUser = null;
    }, (r) {
      AppLog.print('right----> ' + r.toString());
      currentUser = UserModel.fromJson(r);
      // Save to preference
      super.pref.user = currentUser;
      notifyListeners();
    });
    return currentUser;
  }

  Future<bool> forgotPassword() async {
    showLoadingIndicator();
    final response = await super.apiClient.callWebService(
        path: ApiConstant.API_FORGOT_PASSWORD,
        method: ApiMethod.POST,
        body: {'username': pref.user.username},
        withAuth: false);
    hideLoadingIndicator();
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
    showLoadingIndicator(hint: 'Updating Password');
    final response = await super.apiClient.callWebService(
        path: ApiConstant.API_CHANGE_PASSWORD,
        method: ApiMethod.POST,
        body: {
          'oldpassword': oldPassword,
          'newpassword': newPassword,
          'username': pref.user.username
        });
    hideLoadingIndicator();
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
