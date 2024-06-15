import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:teresa_customer/routes.dart';
import 'package:teresa_customer/utils/theme/theme_provider.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then(
    (value) async {
      if (kIsWeb) {
        await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: 'AIzaSyBGz_JGsidAhrGMDg8FzVEAv0Twne4Z-3k',
            appId: '1:624813111806:web:aad81ebb4fe6e7129de8af',
            messagingSenderId: '624813111806',
            projectId: 'teresa-crm-67199',
            authDomain: 'teresa-crm-67199.firebaseapp.com',
            storageBucket: 'teresa-crm-67199.appspot.com',
          ),
        );
      } else {
        await Firebase.initializeApp();
        await FirebaseAppCheck.instance.activate(
            appleProvider: AppleProvider.debug,
            androidProvider: kDebugMode
                ? AndroidProvider.debug
                : AndroidProvider.playIntegrity);
      }
      runApp(
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
          child: const ShopTeresa(),
        ),
      );
    },
  );
}

class ShopTeresa extends StatelessWidget {
  const ShopTeresa({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (routeSettings) => Routes.generateRoute(
        routeSettings,
      ),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
