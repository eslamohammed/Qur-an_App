import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app/screens/adhkar_page.dart';
import 'package:quran_app/utils/colors_manager.dart';
import 'package:quran_app/screens/quran_sura_page.dart';

import '../models/zekr.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var widgejsonData; //to recive data and passing to next widget
  var widgeadhkarjsonData; //to recive data and passing to next widget


  /// func to load سور القران  ====> step 1 section 1
  loadJsonAsset() async {
    final String jsonString =
        await rootBundle.loadString('assets/json/surahs.json');
    var data = jsonDecode(jsonString);
    setState(() {
      widgejsonData = data;
    });
  }

  /// func to load  الاذكار ====> step 1 section 2
loadAzkar() async {
  final String jsonString = await rootBundle.loadString('assets/data/adhkar.json');
  final data = jsonDecode(jsonString);

  setState(() {
    widgeadhkarjsonData = data;
  });
}
  @override
  void initState() {
    loadJsonAsset();  /// step ====> 2 calling in init state

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lilacPetals,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => QuranPage(
                                suraJsonData: widgejsonData, ///here we send data to qura'n page
                              )));
                },
                child: const Text("Go To Quran Page : Press Here")),
                const SizedBox(height: 20,),
                ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => AdhkarPage(
                                adkharJsonData: widgeadhkarjsonData, ///here we send data to adkhar page
                              ),
                            ),
                          );
                },
                child: const Text("Go To Azkar Page : Press Here")),
          ],
        ),
      ),
    );
  }
}
