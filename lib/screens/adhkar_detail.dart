import 'package:audioplayers/audioplayers.dart';
import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/widgets/Toast.dart';

import '../utils/colors_manager.dart';

class AdkharDetailsPage extends StatefulWidget {
  final String categoryName;
  final List<dynamic> items;

  const AdkharDetailsPage({
    Key? key,
    required this.categoryName,
    required this.items,
    // required this.playAudio,
  }) : super(key: key);

  @override
  State<AdkharDetailsPage> createState() => _AdkharDetailsPageState();
}

class _AdkharDetailsPageState extends State<AdkharDetailsPage> {
  late AudioPlayer _audioPlayer = AudioPlayer();
  // late AudioPlayer _audioPlayer;
  bool hasAudioStarted = false;

  @override
  void initState() {
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        hasAudioStarted = false;
      });
    });
    _audioPlayer = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playAudio(String relativePath) async {
    try {
      final cleanPath = relativePath.startsWith('/')
          ? relativePath.substring(1)
          : relativePath;

      await _audioPlayer.play(AssetSource(cleanPath));
    } catch (e) {
      showToast("خطأ في تشغيل الصوت", isError: true);
      debugPrint('خطأ في تشغيل الصوت: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          textDirection: TextDirection.rtl,
          style: TextStyle(
              color: Colors.black,
              fontSize: 25.sp.toDouble(),
              fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: ColorManager.lilacPetals,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final zekr = widget.items[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: EasyContainer(
              color: Colors.green.withOpacity(0.1),
              borderRadius: 12,
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          zekr['text'],
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontFamily: 'aldahabi',
                            fontSize: 18,
                          ),
                        ),
                        const Divider(
                          color: Colors.black45,
                          thickness: 2,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.play_arrow,
                                    color: Colors.black),
                                onPressed: () {
                                  // widget.playAudio(zekr['audio']);
                                  playAudio(zekr['audio']);
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.pause,
                                    color: Colors.black),
                                onPressed: () async {
                                  if (!hasAudioStarted) {
                                    if (_audioPlayer.state ==
                                        PlayerState.playing) {
                                      setState(() {
                                        hasAudioStarted = true;
                                      });
                                      await _audioPlayer.pause();
                                    } else {
                                      showToast("لا يوجد ايه قيد التشغيل",
                                          isError: true);
                                    }
                                  } else {
                                    if (_audioPlayer.state ==
                                        PlayerState.playing) {
                                      await _audioPlayer.pause();
                                    } else {
                                      await _audioPlayer.resume();
                                    }

                                    //   if (_audioPlayer.playing) {
                                    //     _audioPlayer.pause();
                                    //   } else {
                                    //     showToast("لا يوجد ذكر قيد التشغيل",
                                    //         isError: true);
                                  }
                                },
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'التكرار: ${zekr['count']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
