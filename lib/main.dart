import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:islamicapp/shared/router.dart';
import 'package:quran_library/quran_library.dart';
import 'core/constant/cash.dart';
import 'features/prayer/bloc/prayerBloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await cash.initialpref();

  await Hive.initFlutter();

  await Hive.openBox('favourites');
  await Hive.openBox('hadiths');

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await QuranLibrary.init();
  QuranLibrary.initWordAudio();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScalifyProvider(
      config: ScalifyConfig(
        designWidth: 393,
        designHeight: 829,

        minScale: 1.0,

        maxScale: 3.0,

        memoryProtectionThreshold: 1400.0,
        highResScaleFactor: 0.85,
      ),

      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => PrayerBloc()..startLogic()),
        ],
        child: MaterialApp.router(
          theme: ThemeData(useMaterial3: false),
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,

          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
