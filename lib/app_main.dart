import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gestor_fire/core/flavors/app_flavor.dart';
import 'package:gestor_fire/core/ui/app_nav_global_key.dart';
import 'package:gestor_fire/core/ui/app_theme.dart';
import 'package:gestor_fire/core/ui/widgets/loaders/loaders.dart';
import 'package:gestor_fire/shared/infra/routes/route_generator.dart';

class AppMain extends StatelessWidget {
  const AppMain({super.key});

  @override
  Widget build(BuildContext context) {
    final flavor = AppFlavorConfig.current;

    return AsyncStateBuilder(
      enableLog: kDebugMode,
      customLoader: Loaders.appLoader,
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: flavor.appName,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('pt', 'BR')],
          theme: AppTheme.light(flavor),
          darkTheme: AppTheme.dark(flavor),
          themeMode: ThemeMode.system,
          navigatorKey: AppNavGlobalKey.instance.navKey,
          navigatorObservers: [asyncNavigatorObserver],
          initialRoute: RouteGeneratorKeys.authLogin,
          onGenerateRoute: RouteGenerator.generateRoute,
          builder: (context, child) {
            if (child == null) {
              return const SizedBox.shrink();
            }

            if (!flavor.isDevelopment) {
              return child;
            }

            return Banner(
              message: flavor.bannerName,
              location: BannerLocation.topStart,
              color: flavor.bannerColor,
              child: child,
            );
          },
        );
      },
    );
  }
}
