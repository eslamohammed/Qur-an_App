import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app/globalhelpers/constants.dart';
import 'package:quran_app/views/quran_sura_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var widgejsonData; //to recive data and passing to next widget

  /// func to load سور القران  ====> step 1
  loadJsonAsset() async {
    final String jsonString =
        await rootBundle.loadString('assets/json/surahs.json');
    var data = jsonDecode(jsonString);
    setState(() {
      widgejsonData = data;
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
      backgroundColor: quranPagesColor,
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => QuranPage(
                            suraJsonData: widgejsonData, ///here we send data to qura'n page
                          )));
            },
            child: const Text("Go To Quran Page")),
      ),
    );
  }
}
