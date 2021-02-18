import 'package:claim_investigation/screen/case_detail_screen.dart';
import 'package:claim_investigation/screen/case_list_screen.dart';
import 'package:claim_investigation/screen/forgotpassword_screen.dart';
import 'package:claim_investigation/screen/home_screen.dart';
import 'package:claim_investigation/screen/login_screen.dart';
import 'package:claim_investigation/widgets/video_player_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        {
          return MaterialPageRoute(
              builder: (_) => HomeScreen(), settings: settings);
        }
        break;
      case CaseListScreen.routeName:
        {
          return MaterialPageRoute(
              builder: (_) => CaseListScreen(), settings: settings);
        }
        break;
      case CaseDetailScreen.routeName:
        {
          return MaterialPageRoute(
              builder: (_) => CaseDetailScreen(), settings: settings);
        }
        break;
      case ForgotPasswordScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => ForgotPasswordScreen(),
            settings: settings,
          );
        }
        break;
      case VideoPlayerScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => VideoPlayerScreen(),
            settings: settings,
          );
        }
        break;
      default:
        {
          return MaterialPageRoute(
              builder: (_) => LoginScreen(), settings: settings);
        }
    }
  }
}
