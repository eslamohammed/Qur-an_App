import 'package:flutter/material.dart';
import 'package:quran_app/screens/my_home_page.dart';
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
        designSize: const Size(392.72, 800.72),
        builder: (context, child) =>  const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Quran',

          home: MyHomePage(),
      )
    );
  }
}