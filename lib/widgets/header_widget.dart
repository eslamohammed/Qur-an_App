// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:quran/quran.dart';

class HeaderWidget extends StatelessWidget {
  var e;
  var jsonData;

  HeaderWidget(
      {Key? key, required this.e, required this.jsonData, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
 
    return SizedBox(
      height: 50,
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/images/888-02.png",
              width: MediaQuery.of(context).size.width,
              height: 50,
    
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.7, vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "اياتها\n${getVerseCount(e["surah"])}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
        
                      fontSize: 5,
                      fontFamily: "UthmanicHafs13"),
                ),
                Center(
                    child:RichText(text:  TextSpan(text:                 e["surah"].toString(),

                  // textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "arsura",
                    fontSize: 22,color: Colors.black
             
                  ),
                ))),
                Text(
                  "ترتيبها\n${e["surah"]}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
             
                      fontSize: 5,
                      fontFamily: "UthmanicHafs13"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
