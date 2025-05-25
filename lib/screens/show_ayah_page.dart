import 'package:audioplayers/audioplayers.dart';
import 'package:easy_container/easy_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/quran.dart';
import 'package:quran_app/screens/quran_page.dart';
import 'package:quran_app/widgets/Toast.dart';
import 'package:quran_app/widgets/share_sheet.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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

    Future<void> play(String url) async {
    await player.play(UrlSource(url));
    print("SSSSSSSSSSSSSSSSSSSSSSS : $url");
  }

  int getGlobalVerseNumber(int surahNumber, int verseNumber) {
  List<int> versesPerSurah = [
    7, 286, 200, 176, 120, 165, 206, 75, 129, 109, // الفاتحة - يونس
    123, 111, 43, 52, 99, 128, 111, 110, 98, 135,
    112, 78, 118, 64, 77, 227, 93, 88, 69, 60,
    34, 30, 73, 54, 45, 83, 182, 88, 75, 85,
    54, 53, 89, 59, 37, 35, 38, 29, 18, 45,
    60, 49, 62, 55, 78, 96, 29, 22, 24, 13,
    14, 11, 11, 18, 12, 12, 30, 52, 52, 44,
    28, 28, 20, 56, 40, 31, 50, 40, 46, 42,
    29, 19, 36, 25, 22, 17, 19, 26, 30, 20,
    15, 21, 11, 8, 8, 19, 5, 8, 8, 11,
    11, 8, 3, 9, 5, 4, 7, 3, 6, 3,
    5, 4, 5, 6
  ];

  int offset = versesPerSurah.sublist(0, surahNumber - 1).fold(0, (a, b) => a + b);
  return offset + verseNumber;
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
                      width: (screenSize.width * .35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _loadTafsir();
                                });
                              },
                              icon: const Icon(
                                Icons.refresh,
                                size: 24,
                              )),
                          IconButton(
                            onPressed: () async{
                              try {
                                final connectivityResult = await Connectivity().checkConnectivity();
                                final isConnected = await InternetConnectionChecker.instance.hasConnection;

                                if (connectivityResult == ConnectivityResult.none || !isConnected) {
                                  showToast("لا يوجد اتصال بالإنترنت", isError: true);
                                  showToast("Check your Network Connection",isError: true);
                                  return;
                                }
                                
                                play(getAudioURLByVerseNumber(getGlobalVerseNumber(widget.suraNumber, widget.ayahNumber), reciter));
                                  if (kDebugMode) {
                                      print("${getGlobalVerseNumber(widget.suraNumber, widget.ayahNumber)}");
                                      print(getAudioURLByVerseNumber(getGlobalVerseNumber(widget.suraNumber, widget.ayahNumber), reciter));
                                  }

                              } catch (e) {
                                showToast("خطأ في التشغيل أو الاتصال", isError: true);
                                showToast("Check your Network Connection",isError: true);
                                print("/////////////////////////////////خطأ: $e");
                              }
                            },
                            icon: const Icon(
                              Icons.audiotrack_outlined,
                              size: 24,
                            )),
                          IconButton(
                              onPressed: () {
                                //setteng icon finctionality will be add later
                                showToast("Comming soon",isError: false);
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
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: EasyContainer(
                  color: Colors.green.withOpacity(0.05), ////
                  borderRadius: 12,
                  onTap: () async {
                    ////here
                    final verse = getVerse(widget.suraNumber, widget.ayahNumber, verseEndSymbol: true);
                      ShareSheet.showShareAyahOptions(
                        context: context,
                        verseText: verse,
                      );
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
                  onTap: () async {
                    final verse = getVerse(widget.suraNumber, widget.ayahNumber, verseEndSymbol: true);
                      ShareSheet.showShareTafsirOptions(
                        context: context,
                        verseText: verse,
                      );
                  },
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