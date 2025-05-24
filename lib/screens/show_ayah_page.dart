import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/quran.dart';

import '../services/network_handler.dart' as TafsirService;

// ignore: must_be_immutable
class ShowAyah extends StatefulWidget {
  int pageNumber;
  var jsonData; //for surah
  int ayahNumber;
  var suraNumber;

  ShowAyah({
    Key? key,
    required this.pageNumber,
    required this.ayahNumber,
    required this.suraNumber,
    required this.jsonData,
  }) : super(key: key);

  @override
  State<ShowAyah> createState() => _ShowAyahState();
}

class _ShowAyahState extends State<ShowAyah> {
  int index = 0;

  // late PageController _pageController;
  /// get index of page number from constructor
  setIndex() {
    setState(() {
      index = widget.pageNumber;
    });
  }

  String tafsir = "";

  void _loadTafsir() async {
    tafsir =
        await TafsirService.fetchTafsir(widget.suraNumber, widget.ayahNumber);
    setState(() {}); // لتحديث الواجهة بعد جلب التفسير
  }

  @override
  void initState() {
    _loadTafsir();
    setIndex();
    // _pageController = PageController(initialPage: index);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: screenSize.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: (screenSize.width * .27),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                size: 24,
                              )),
                          Text(
                              widget.jsonData[
                                  getPageData(index)[0]["surah"] - 1]["name"],
                              style: const TextStyle(
                                  fontFamily: "Taha", fontSize: 14)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: (screenSize.width * .27),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                //setteng icon finctionality will be add later
                              },
                              icon: const Icon(
                                Icons.settings,
                                size: 24,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Center(),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: EasyContainer(
                  color: Colors.green.withOpacity(0.05), ////
                  borderRadius: 12,
                  onTap: () async {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //   builder: (builder) => QuranViewPage(
                    //       shouldHighlightText: false,
                    //       highlightVerse: "",
                    //       jsonData: widget.suraJsonData,
                    //       pageNumber: getPageNumber(ayatFiltered["result"][index]["surah"],ayatFiltered["result"][index]["verse"]),
                    //       suraJsonData:widget.suraJsonData,
                    //       ),
                    //     ),
                    //   );
                  },
                  child: Text(
                    getVerse(widget.suraNumber, widget.ayahNumber,
                        verseEndSymbol: true),
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: Colors.black, fontSize: 23.sp.toDouble()),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: EasyContainer(
                  color: Colors.brown.withOpacity(0.05), ////
                  borderRadius: 12,
                  onTap: () async {},
                  child: Text(
                    "سورة : ${getSurahNameArabic(widget.suraNumber)}\nالايه : ${widget.ayahNumber}\nوهي : سورة ${(getPlaceOfRevelation(widget.suraNumber) == 'Makkah') ? 'مكية' : 'مدنية'} \nالتفسير: ${tafsir == '' ? "فشل في جلب التفسير // افحص الاتصال" : tafsir}",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: Colors.black, fontSize: 23.sp.toDouble()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}