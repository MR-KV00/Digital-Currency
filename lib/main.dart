import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kv_dev/providers/ThemeProvider.dart';
import 'package:kv_dev/ui/core/ThemeSwitcher.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]
  );

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ThemeProvider())],
      child: const KvApp(),

    ),
  );
}

class KvApp extends StatefulWidget {
  const KvApp({Key? key}) : super(key: key);

  @override
  State<KvApp> createState() => _KvAppState();
}

class _KvAppState extends State<KvApp> {


  @override
  Widget build(BuildContext context) {

    return Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            locale: Locale('en',''),
           localizationsDelegates: const [
             AppLocalizations.delegate,
             GlobalMaterialLocalizations.delegate,
             GlobalWidgetsLocalizations.delegate,
             GlobalCupertinoLocalizations.delegate
           ],
            supportedLocales: const [
              Locale("en",''),
              Locale("fa",'')
            ],
            themeMode: themeProvider.themeMode,
            theme: MyTheme.lightMode,
            darkTheme: MyTheme.darkMode,
            debugShowCheckedModeBanner: false,
            home: Directionality(
              textDirection: TextDirection.ltr,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text("Digital Currency"),
                  actions: const [
                    ThemeSwitcher(),
                  ],
                ),
                body: Container(
                  child: Center(
                    child: Text(AppLocalizations.of(context)!.helloWorld)
                  ),
                ),
              ),

            ),
          );
        });
  }
}
