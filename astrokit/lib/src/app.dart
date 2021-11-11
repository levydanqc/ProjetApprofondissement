import 'package:astrokit/src/Screens/astre_detail.dart';
import 'package:astrokit/src/Screens/list_astres.dart';
import 'package:astrokit/src/Screens/home.dart';
import 'package:astrokit/src/Screens/user_settings.dart';
import 'package:astrokit/src/class/astres.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:page_transition/page_transition.dart';
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
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
            // Providing a restorationScopeId allows the Navigator built by the
            // MaterialApp to restore the navigation stack when a user leaves and
            // returns to the app after it has been killed while running in the
            // background.
            restorationScopeId: 'app',

            // Provide the generated AppLocalizations to the MaterialApp. This
            // allows descendant Widgets to display the correct translations
            // depending on the user's locale.
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,

            // Use AppLocalizations to configure the correct application title
            // depending on the user's locale.
            //
            // The appTitle is defined in .arb files found in the localization
            // directory.
            onGenerateTitle: (context) =>
                AppLocalizations.of(context)!.appTitle,

            // Define a light and dark color theme. Then, read the user's
            // preferred ThemeMode (light, dark, or system default) from the
            // SettingsController to display the correct theme.
            theme: ThemeData(),
            darkTheme: ThemeData.dark(),
            themeMode: settingsController.themeMode,

            // Define a function to handle named routes in order to support
            // Flutter web url navigation and deep linking.
            onGenerateRoute: (RouteSettings routeSettings) {
              switch (routeSettings.name) {
                case UserSettings.routeName:
                  return PageTransition(
                      child: UserSettings(args: routeSettings.arguments as Map),
                      type: PageTransitionType.leftToRight);
                case DayDetail.routeName:
                  return PageTransition(
                      child: DayDetail(dayData: routeSettings.arguments as Map),
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
                        astre: routeSettings.arguments as Map<String, dynamic>),
                  );
                case LoginScreen.routeName:
                default:
                  return PageTransition(
                      child: const LoginScreen(),
                      type: PageTransitionType.fade);
              }
            });
      },
    );
  }
}
