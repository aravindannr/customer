import 'package:flutter/cupertino.dart';
import 'package:teresa_customer/screen/sign_in/credential_sign_in.dart';
import 'package:teresa_customer/screen/sign_in/splash.dart';
class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const ScreenSplash(),
        );
      case '/credentialSignIn':
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const CredentialSignIn(),
        );
      default:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const CredentialSignIn(),
        );
    }
  }
}
