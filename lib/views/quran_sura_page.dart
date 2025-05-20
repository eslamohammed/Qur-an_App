// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
// import 'package:quran/dart';
import 'package:quran/quran.dart';
import 'package:quran_app/models/sura.dart';
import 'package:easy_container/easy_container.dart';
import 'package:quran_app/views/quran_page.dart';
import 'package:string_validator/string_validator.dart';
import 'package:audioplayers/audioplayers.dart';


import '../utils/colors_manager.dart';
import '../widgets/form_container.dart';

class QuranPage extends StatefulWidget {
  
  var suraJsonData;

  QuranPage({Key? key, required this.suraJsonData}) : super(key: key);
  
  @override
  State<QuranPage> createState() => _QuranPageState();
}
  AudioPlayer player = AudioPlayer();
  String reciter = "ar.alafasy";


class _QuranPageState extends State<QuranPage> {
  final TextEditingController _searchController = TextEditingController();

  bool isLoading = true;

  var searchQuery = "";
  var filteredData;
  List<Surah> surahList = [];
  var ayatFiltered;

  List pageNumbers = [];

  addFilteredData() async {
    await Future.delayed(const Duration(milliseconds: 600));
    setState(() {
      filteredData = widget.suraJsonData;
      isLoading = false;
    });
  }

  @override
  void initState() {
    addFilteredData();
    super.initState();
  }

  @override
  void dispose(){
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  ColorManager.lilacPetals,
      appBar: AppBar(
        backgroundColor: ColorManager.lilacPetals,
        title: const Text("Quran Page",style: TextStyle(fontSize: 25,),),
        centerTitle: true,
        
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10),
                  child: FormContainerWidget(
                  controller: _searchController,
                  labelText: "Search Qura'n",
                  icon: Icons.search,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  
                    if (value == "") {
                      filteredData = widget.suraJsonData;
                      pageNumbers = [];
                      setState(() {});
                    }
                  
                    if (searchQuery.isNotEmpty &&
                        isInt(searchQuery) &&
                        toInt(searchQuery) < 605 &&
                        toInt(searchQuery) > 0) {
                      pageNumbers.add(toInt(searchQuery));
                    }
                  
                    if (searchQuery.length > 3 || searchQuery.contains(" ")) {
                      setState(() {
                        ayatFiltered = [];
                        ayatFiltered = searchWords(searchQuery);
                        filteredData = widget.suraJsonData.where((sura) {
                          final suraName = sura['englishName'].toLowerCase();
                          final suraNameTranslated = getSurahNameArabic(sura["number"]);
                  
                          return suraName.contains(searchQuery.toLowerCase()) ||
                              suraNameTranslated.contains(searchQuery.toLowerCase());
                        }).toList();
                      });
                    }
                  },
                  ),
                ),
                const SizedBox(height: 20,),
                if (pageNumbers.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("page"),
                  ),
                ListView.separated(
                    reverse: true,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: EasyContainer(
                          onTap: () {
                            //////
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(pageNumbers[index].toString()),
                                Text(getSurahName(
                                    getPageData(pageNumbers[index])[0]
                                        ["surah"]))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Divider(
                            color: Colors.grey.withOpacity(.5),
                          ),
                        ),
                    itemCount: pageNumbers.length),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Divider(
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    print("${filteredData[0]["number"]}");
                    print("${index + 1}");
                    String suraName = filteredData[index]["englishName"];
                    String suraNameEnglishTranslated =
                        filteredData[index]["englishNameTranslation"];
                    int suraNumberInQuran = filteredData[index]["number"];
                    // String suraNameTranslated =
                    //     filteredData[index]["name"].toString();
                    int ayahCount = getVerseCount(filteredData[0]["number"]);

                    return Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: ColorManager.lilacPetals,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color:ColorManager.babyBlue),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: SizedBox(
                            width: 45,
                            height: 45,
                            child: Center(
                              child: Text(
                                filteredData[0]["number"].toString(),
                                style: const TextStyle(
                                    color: ColorManager.coldGrey, fontSize: 14),
                              ),
                            ),
                          ) //  Material(

                          ,
                          minVerticalPadding: 0,
                          title: SizedBox(
                            width: 90,
                            child: Row(
                              children: [
                                Text(
                                  suraName,
                                  style: const TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    // color: ColorManager.deepBlue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700, // Text color
                                  ),
                                ),
                              ],
                            ),
                          ),
                          subtitle: Text(
                            "$suraNameEnglishTranslated ($ayahCount)",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.withOpacity(.8)),
                          ),trailing: RichText(
                    // print("${filteredData["number"] + filteredData["name"]}");

                            text:  TextSpan(text:                filteredData[0]["number"].toString(),
                        style: const TextStyle(
                        fontFamily: "arsura",
                        fontSize: 22,color: Colors.black
                
                      ),
                    )),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => QuranViewPage(
                              shouldHighlightText: false,
                              highlightVerse: "",
                              jsonData: widget.suraJsonData,
                              pageNumber: getPageNumber(
                                  suraNumberInQuran, 1)
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
                if (ayatFiltered != null)
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: ayatFiltered["occurences"] > 10
                        ? 10
                        : ayatFiltered["occurences"],
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: EasyContainer(
                          color:Colors.green.withOpacity(0.05),////
                          borderRadius: 12,
                          onTap: () async {
                            
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (builder) => QuranViewPage(
                                  shouldHighlightText: false,
                                  highlightVerse: "",
                                  jsonData: widget.suraJsonData,
                                  pageNumber: getPageNumber(ayatFiltered["result"][index]["surah"],ayatFiltered["result"][index]["verse"]),
                                  ),
                                ),
                              );
                              ///Errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr heeeeeeeeeeeeeeeereeee
                              // print("${ayatFiltered["////////////////////////////////////////////////////"]}");
                              // getAudioURLBySurah(ayatFiltered["result"][index]["surah"],reciter);
                              // String audioUrl = getAudioURLBySurah(
                              //     ayatFiltered["result"][index]["surah"],
                              //     reciter
                              //   );
                              //   print(audioUrl);
                                
                              // await player.play(UrlSource(audioUrl));
                              // print("${ayatFiltered["////////////////////////////////////////////////////"]}");
                          },
                          child: Text(
                            "سورة ${getSurahNameArabic(ayatFiltered["result"][index]["surah"])} - ${getVerse(ayatFiltered["result"][index]["surah"], ayatFiltered["result"][index]["verse"], verseEndSymbol: true)}",
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 17),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
    );
  }
}
