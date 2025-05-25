// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/screens/adhkar_detail.dart';
import 'package:quran_app/utils/colors_manager.dart';

class AdhkarPage extends StatefulWidget {
  var adkharJsonData;

  AdhkarPage({Key? key, required this.adkharJsonData}) : super(key: key);

  @override
  State<AdhkarPage> createState() => _AdhkarPageState();
}
// final _player = AudioPlayer();

class _AdhkarPageState extends State<AdhkarPage> {
  List<dynamic> adhkarData = [];

  @override
  void initState() {
    super.initState();
    loadAzkar();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> loadAzkar() async {
    final String jsonString = await rootBundle.loadString('assets/data/adhkar.json');
    final List<dynamic> data = jsonDecode(jsonString);
    setState(() {
      adhkarData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lilacPetals,

      appBar: AppBar(
        title: Text('أذكار المسلم',textDirection: TextDirection.rtl,
                      style: TextStyle(
                      color: Colors.black, fontSize: 25.sp.toDouble(),
                      fontWeight: FontWeight.bold
                      ),
                    ),
        elevation: 0, 
        backgroundColor: ColorManager.lilacPetals,
        centerTitle: true,
      ),

      body: adhkarData.isEmpty
      ? const Center(child: CircularProgressIndicator())
      : ListView.builder(
          itemCount: adhkarData.length,
          itemBuilder: (context, index) {
            final category = adhkarData[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: EasyContainer(
                color: Colors.brown.withOpacity(0.05),
                borderRadius: 12,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdkharDetailsPage(
                        categoryName: category['category'],
                        items: category['array'],
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        category['category'],
                        textDirection: TextDirection.rtl,
                          style: TextStyle(
                              color: Colors.black, fontSize: 23.sp.toDouble()),
                          ),
                        ),
                    // const Icon(
                    //   Icons.arrow_forward_ios,
                    //   color: Colors.brown,
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    
    // Scaffold(
    //   appBar: AppBar(title: const Text('أذكار المسلم')),
    //   body: adhkarData.isEmpty
    //       ? const Center(child: CircularProgressIndicator())
    //       : ListView.builder(
    //           itemCount: adhkarData.length,
    //           itemBuilder: (context, index) {
    //             final category = adhkarData[index];
    //             return ExpansionTile(
    //               title: Text(category['category']),
    //               children: List<Widget>.from(
    //                 category['array'].map<Widget>((zekr) {
    //                   return ListTile(
    //                     title: Text(zekr['text']),
    //                     subtitle: Text('التكرار: ${zekr['count']}'),
    //                     trailing: IconButton(
    //                       icon: const Icon(Icons.play_arrow),
    //                       onPressed: () {
    //                         playAudio(zekr['audio']);
    //                       },
    //                     ),
    //                   );
    //                 }),
    //               ),
    //             );
    //           },
    //         ),
    // );
  }
}