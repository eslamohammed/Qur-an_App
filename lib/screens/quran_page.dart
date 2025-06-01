import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:easy_container/easy_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/quran.dart';
import 'package:quran_app/screens/show_ayah_page.dart';
import 'package:quran_app/utils/colors_manager.dart';
import 'package:quran_app/widgets/basmallah.dart';
import 'package:quran_app/widgets/header_widget.dart';

import '../widgets/Toast.dart';

class QuranViewPage extends StatefulWidget {
  int pageNumber;
  var jsonData; //for surah
  var shouldHighlightText;
  var highlightVerse;
  var suraJsonData;
  QuranViewPage({
    Key? key,
    required this.pageNumber,
    required this.jsonData,
    required this.shouldHighlightText,
    required this.highlightVerse,
    required this.suraJsonData,
  }) : super(key: key);

  @override
  State<QuranViewPage> createState() => _QuranViewPageState();
}

AudioPlayer player = AudioPlayer();
String reciter = "ar.alafasy";

class _QuranViewPageState extends State<QuranViewPage> {
  var highlightVerse;
  var shouldHighlightText;
  List<GlobalKey> richTextKeys = List.generate(
    604, // Replace with the number of pages in your PageView
    (_) => GlobalKey(),
  );

  Future<void> play(String url) async {
    await player.play(UrlSource(url));
    print("////////////////////////$url");
  }

  /// get index of page number from constructor
  setIndex() {
    setState(() {
      index = widget.pageNumber;
    });
  }

  int index = 0;
  late PageController _pageController;
  late Timer timer;
  String selectedSpan = ""; // select ayah

  highlightVerseFunction() {
    setState(() {
      shouldHighlightText = widget.shouldHighlightText;
    });
    if (widget.shouldHighlightText) {
      setState(() {
        highlightVerse = widget.highlightVerse;
      });

      Timer.periodic(const Duration(milliseconds: 400), (timer) {
        if (mounted) {
          setState(() {
            shouldHighlightText = false;
          });
        }
        Timer(const Duration(milliseconds: 200), () {
          if (mounted) {
            setState(() {
              shouldHighlightText = true;
            });
          }
          if (timer.tick == 4) {
            if (mounted) {
              setState(() {
                highlightVerse = "";

                shouldHighlightText = false;
              });
            }
            timer.cancel();
          }
        });
      });
    }
  }

  @override
  void initState() {
    setIndex();
    _pageController = PageController(initialPage: index);
    highlightVerseFunction();
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
        body: PageView.builder(
      reverse: true,
      scrollDirection: Axis.horizontal,
      onPageChanged: (a) {
        setState(() {
          selectedSpan = ""; //not select ayah when page scrolling
        });
        index = a;
        print(
            "================================================================================");
        print(index);
        print(
            "================================================================================");
      },
      controller: _pageController,
      itemCount: totalPagesCount + 1 /* specify the total number of pages */,
      itemBuilder: (context, index) {
        bool isEvenPage = index.isEven;

        if (index == 0) {
          return Image.asset(
            "assets/images/fp.png",
            fit: BoxFit.fill,
          );
        }

        return Container(
          decoration: const BoxDecoration(
            color: ColorManager.lilacPetals,
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0, left: 12),
                child: SingleChildScrollView(
                  // physics: const ClampingScrollPhysics(),
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
                                      onPressed: () async {
                                        await player.stop();
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                        size: 24,
                                      )),
                                  Text(
                                      widget.jsonData[getPageData(index)[0]
                                              ["surah"] -
                                          1]["name"],
                                      style: const TextStyle(
                                          fontFamily: "Taha", fontSize: 14)),
                                ],
                              ),
                            ),
                            EasyContainer(
                              borderRadius: 12,
                              color: ColorManager.lilacPetalsDark,
                              showBorder: true,
                              height: 20,
                              width: 120,
                              padding: 0,
                              margin: 0,
                              child: Center(
                                child: Text(
                                  "${"Page"}  $index ",
                                  style: const TextStyle(
                                    fontFamily: 'aldahabi',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: (screenSize.width * .27),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        //audio icon finctionality will be add later
                                        // play(getAudioURLByVerseNumber(2, reciter));
                                        // play("https://quran.com/1");

                                        //  play(getAudioURLBySurah(1, "ar.minshawi"));
                                        //   if (kDebugMode) {
                                        //     print(getAudioURLBySurah(5, reciter));
                                        //   }
                                        showToast("Comming soon",
                                            isError: false);
                                      },
                                      icon: const Icon(
                                        Icons.play_arrow,
                                        size: 24,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        //setteng icon finctionality will be add later
                                        showToast("Comming soon",
                                            isError: false);
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
                      if ((index == 1 || index == 2))
                        SizedBox(
                          height: (screenSize.height * .15),
                        ),
                      Directionality(
                          textDirection: m.TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: RichText(
                                key: richTextKeys[index - 1],
                                textDirection: m.TextDirection.rtl,
                                textAlign:
                                    (index == 1 || index == 2 || index > 570)
                                        ? TextAlign.center
                                        : TextAlign.center,
                                softWrap: true,
                                locale: const Locale("ar"),
                                text: TextSpan(
                                  style: TextStyle(
                                    color: m.Colors.black,
                                    fontSize: 23.sp.toDouble(),
                                  ),
                                  children: getPageData(index).expand((e) {
                                    List<InlineSpan> spans = [];
                                    for (var i = e["start"];
                                        i <= e["end"];
                                        i++) {
                                      // Header
                                      if (i == 1) {
                                        spans.add(WidgetSpan(
                                          child: HeaderWidget(
                                              e: e, jsonData: widget.jsonData),
                                        ));
                                        if (index != 187 && index != 1) {
                                          spans.add(WidgetSpan(
                                            child: Basmallah(index: 0),
                                          ));
                                        }
                                        if (index == 187) {
                                          spans.add(WidgetSpan(
                                            child: Container(
                                              height: 10.h,
                                            ),
                                          ));
                                        }
                                      }

                                      // Verses
                                      spans.add(TextSpan(
                                        recognizer: LongPressGestureRecognizer()
                                          ..onLongPress = () {
                                            //     // showAyahOptionsSheet(
                                            //     // index,
                                            //     // e["surah"],
                                            //     // i);
                                            // print("longpressed");
                                            // print("page Number : ${index}");
                                            // print("index : //////////////////////////////////");
                                            // print("Sura Number : ${e["surah"]}");
                                            // print(" e surah : ///////////////////////////////");
                                            // print("Ayah Number : ${i}");
                                            // print("i : //////////////////////////////////////");
                                            setState(() {
                                              shouldHighlightText = true;
                                              selectedSpan = " ${e["surah"]}$i";
                                            });
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (builder) => ShowAyah(
                                                  pageNumber: index,
                                                  suraNumber: e["surah"],
                                                  ayahNumber: i,
                                                  jsonData: widget.suraJsonData,
                                                  // pageNumber: getPageNumber(
                                                  //     suraNumberInQuran, 1)
                                                ),
                                              ),
                                            );
                                          }
                                          ..onLongPressDown = (details) {
                                            setState(() {
                                              selectedSpan = " ${e["surah"]}$i";
                                            });
                                          }
                                          ..onLongPressUp = () {
                                            setState(() {
                                              selectedSpan = "";
                                            });
                                            print("finished long press");
                                          }
                                          ..onLongPressCancel =
                                              () => setState(() {
                                                    selectedSpan = "";
                                                  }),
                                        text: i == e["start"]
                                            ? "${getVerseQCF(e["surah"], i).replaceAll(" ", "").substring(0, 1)}\u200A${getVerseQCF(e["surah"], i).replaceAll(" ", "").substring(1)}"
                                            : getVerseQCF(e["surah"], i)
                                                .replaceAll(' ', ''),
                                        //  i == e["start"]
                                        // ? "${getVerseQCF(e["surah"], i).replaceAll(" ", "").substring(0, 1)}\u200A${getVerseQCF(e["surah"], i).replaceAll(" ", "").substring(1).substring(0,  getVerseQCF(e["surah"], i).replaceAll(" ", "").substring(1).length - 1)}"
                                        // :
                                        // getVerseQCF(e["surah"], i).replaceAll(' ', '').substring(0,  getVerseQCF(e["surah"], i).replaceAll(' ', '').length - 1),
                                        style: TextStyle(
                                          color: Colors.black,
                                          height: (index == 1 || index == 2)
                                              ? 2.h
                                              : 1.95.h,
                                          letterSpacing: 0.w,
                                          wordSpacing: 0,
                                          fontFamily:
                                              "QCF_P${index.toString().padLeft(3, "0")}",
                                          fontSize: index == 1 || index == 2
                                              ? 28.sp
                                              : index == 145 || index == 201
                                                  ? index == 532 || index == 533
                                                      ? 22.5.sp
                                                      : 22.4.sp
                                                  : 23.1.sp,
                                          backgroundColor: Colors.transparent,
                                        ),
                                        children: const <TextSpan>[
                                          // TextSpan(
                                          //   text: getVerseQCF(e["surah"], i).substring(getVerseQCF(e["surah"], i).length - 1),
                                          //   style:  TextStyle(
                                          //     color: isVerseStarred(
                                          //                                                     e[
                                          //                                                         "surah"],
                                          //                                                     i)
                                          //                                                 ? Colors
                                          //                                                     .amber
                                          //                                                 : secondaryColors[getValue("quranPageolorsIndex")] // Change color here
                                          //   ),
                                          // ),
                                        ],
                                      ));
                                    }
                                    return spans;
                                  }).toList(),
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ); /* Your page content */
      },
    ));
  }
}
