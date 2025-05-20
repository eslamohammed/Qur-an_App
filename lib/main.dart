import 'package:flutter/material.dart';
import 'package:quran_app/utils/colors_manager.dart';
import 'package:quran_app/views/my_home_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.73, 800.73),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Quran',
        theme: ThemeData(
          fontFamily: 'Cairo',
          scaffoldBackgroundColor: ColorManager.lilacPetals,
          appBarTheme: const AppBarTheme(
            backgroundColor: ColorManager.babyBlue,
            elevation: 4,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: ColorManager.deepBlue,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(color: ColorManager.deepBlue),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              color: ColorManager.coldGrey,
              fontSize: 16,
            ),
            bodyMedium: TextStyle(
              color: ColorManager.deepBlue,
              fontSize: 14,
            ),
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: ColorManager.babyBlue,
            secondary: ColorManager.deepBlue,
          ),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}