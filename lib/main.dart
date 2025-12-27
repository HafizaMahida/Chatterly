import 'package:chat_app/view/splash/splash_screen.dart';
import 'package:chat_app/view/utils/theme/theme_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
        designSize: const Size(360, 800),
    minTextAdapt: true,
    splitScreenMode: true,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeStyle.themeData(context),
        home: SplashScreen(),
      ),
    );
  }
}

