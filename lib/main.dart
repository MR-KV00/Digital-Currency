import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kv_dev/providers/CryptoApiProvider.dart';
import 'package:kv_dev/providers/ThemeProvider.dart';
import 'package:kv_dev/ui/core/MainWraper.dart';
import 'package:kv_dev/ui/core/ThemeSwitcher.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => CryptoApiProvider())
      ],

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
            themeMode: themeProvider.themeMode,
            theme: MyTheme.lightMode,
            darkTheme: MyTheme.darkMode,
            debugShowCheckedModeBanner: false,
            home: const Directionality(
                textDirection: TextDirection.ltr,
                child: MainWraper()

            ),
          );
        });
  }
}
