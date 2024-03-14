import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/network/end_points.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';

class AudioPlayerScreen extends StatefulWidget {
  final String audioFromApi;

  const AudioPlayerScreen({super.key, required this.audioFromApi});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  AudioPlayer? _audioPlayer;
  Duration _duration = const Duration();
  Duration _position = const Duration();
  bool isPlaying = false;

  late String fullAudioUrl;

  @override
  void initState() {
    super.initState();

    //  audioUrl = "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3";
    // fullAudioUrl = "${Endpoints.imageBaseUrl}image-1705668471744.mp3";

    fullAudioUrl = "${Endpoints.imageBaseUrl}${widget.audioFromApi}";

    AppLogger.logD("${fullAudioUrl}");

    _audioPlayer = AudioPlayer();
    _audioPlayer?.onDurationChanged.listen((Duration d) {
      setState(() {
        _duration = d;
      });
    });
    _audioPlayer?.onPositionChanged.listen((Duration p) {
      setState(() {
        _position = p;

        AppLogger.logD("Position $p");
      });
    });

    _audioPlayer?.onPlayerComplete.listen((event) {
      // Triggered when audio playback is completed
      setState(() {
        play();
      });
    });

    play();
  }

  @override
  void dispose() {
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.r),
                    bottomRight: Radius.circular(40.r)),
                gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: ColorUtility.talentHeaderGradientColor)),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 18.w, right: 18.w, top: 14.h, bottom: 14.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const BackButton(
                      color: Colors.white,
                    ),
                    Text(
                      context.loc.headerAudioPlayer,
                      style: StyleUtility.kantumruyProSMedium18TextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize18.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Seekbar
          const SizedBox(
            height: 70,
          ),
          Slider(
            value: _position.inSeconds.toDouble(),
            min: 0.0,
            max: _duration.inSeconds.toDouble(),
            onChanged: (double value) {
              setState(() {
                seekToSecond(value.toInt());
              });
            },
            activeColor: ColorUtility.color5457BE,
            // Set the color when the slider is active
            inactiveColor: Colors.grey.withOpacity(0.5),
          ),
          SizedBox(
            height: 2.h,
          ),

          Container(
            margin: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${_position.inMinutes}:${(_position.inSeconds % 60).toString().padLeft(2, '0')}",
                  style: StyleUtility.unSelectTabTextStyle
                      .copyWith(fontSize: TextSizeUtility.textSize14.sp),
                ),
                Text(
                    "${_duration.inMinutes}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}",
                    style: StyleUtility.unSelectTabTextStyle
                        .copyWith(fontSize: TextSizeUtility.textSize14.sp)),
              ],
            ),
          ),

          SizedBox(
            height: 15.h,
          ),

          // Play/Pause button

          FloatingActionButton(
            backgroundColor: ColorUtility.color5457BE,
            onPressed: () {
              isPlaying ? pause() : play();
            },
            child:
                Icon(isPlaying ? Icons.pause : Icons.play_arrow, size: 28.sp),
          ),

          SizedBox(
            height: 10.h,
          ),

          // Total audio time
        ],
      ),
    );
  }

  Future<void> play() async {
    // await _audioPlayer?.play(UrlSource("https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3"));

    await _audioPlayer?.play(UrlSource(fullAudioUrl));

    //  _audioPlayer?.play("");
    setState(() {
      isPlaying = true;
    });
  }

  void pause() {
    _audioPlayer?.pause();
    setState(() {
      isPlaying = false;
    });
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    _audioPlayer?.seek(newDuration);
  }
}
