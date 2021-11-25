import 'package:astrokit/src/Screens/astre_detail.dart';
import 'package:astrokit/src/Screens/list_astres.dart';
import 'package:astrokit/src/Screens/home.dart';
import 'package:astrokit/src/Screens/user_settings.dart';
import 'package:astrokit/src/utils/theme_model.dart';
import 'package:astrokit/src/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'Screens/day_detail.dart';
import 'Screens/login_screen.dart';
import 'settings/settings_controller.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return ChangeNotifierProvider(
          create: (_) => ThemeModel(),
          child: Consumer(
            builder: (context, ThemeModel themeNotifier, child) => MaterialApp(
              restorationScopeId: 'app',
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              onGenerateTitle: (context) =>
                  AppLocalizations.of(context)!.appTitle,
              theme: lightTheme,
              darkTheme: ThemeModel.darkTheme,
              themeMode: themeNotifier.themeMode,
              onGenerateRoute: (RouteSettings routeSettings) {
                switch (routeSettings.name) {
                  case UserSettings.routeName:
                    return PageTransition(
                        child:
                            UserSettings(args: routeSettings.arguments as Map),
                        type: PageTransitionType.leftToRight);
                  case DayDetail.routeName:
                    return PageTransition(
                        child:
                            DayDetail(dayData: routeSettings.arguments as Map),
                        type: PageTransitionType.rightToLeft);
                  case Home.routeName:
                    return PageTransition(
                        child: Home(routeSettings.name),
                        type: routeSettings.name == UserSettings.routeName
                            ? PageTransitionType.leftToRight
                            : PageTransitionType.rightToLeft);
                  case ListAstres.routeName:
                    return PageTransition(
                        child: const ListAstres(),
                        type: routeSettings.name == UserSettings.routeName
                            ? PageTransitionType.leftToRight
                            : PageTransitionType.rightToLeft);
                  case AstreDetail.routeName:
                    return PageTransition(
                      type: PageTransitionType.rightToLeft,
                      curve: Curves.linear,
                      child: AstreDetail(
                          astre:
                              routeSettings.arguments as Map<String, dynamic>),
                    );
                  case LoginScreen.routeName:
                  default:
                    return PageTransition(
                        child: const LoginScreen(),
                        type: PageTransitionType.fade);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
