import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/network/end_points.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoFromApi;

  const VideoPlayerScreen({super.key, required this.videoFromApi});

  @override
  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();


    _controller = VideoPlayerController.networkUrl(Uri.parse(
       //    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
        Endpoints.imageBaseUrl + widget.videoFromApi
      //  Endpoints.imageBaseUrl +"image-1705738782698.mp4"
    ))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true); //loop through video
    //  _controller.initialize(); //initialize the VideoPlayer


  }

  @override
  void dispose() {
    _controller.dispose(); //dispose the VideoPlayer
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    return "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
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
                     // context.loc.headerAudioPlayer,
                      "Video Player",
                      style: StyleUtility.kantumruyProSMedium18TextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize18.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
             height: 15.h),
          Expanded(
            child: Center(

             // padding: const EdgeInsets.all(20),
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    VideoPlayer(_controller),
                    _PlayPauseOverlay(
                      controller: _controller,
                    ),
                    // VideoProgressIndicator(
                    //
                    //   _controller,
                    //   allowScrubbing: true,
                    //   colors: VideoProgressColors(
                    //
                    //     playedColor: ColorUtility.color5457BE,
                    //
                    //   )
                    // ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
              height: 15.h),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15.w),
            child: VideoProgressIndicator(

                _controller,
                allowScrubbing: true,
                colors: const VideoProgressColors(

                  playedColor: ColorUtility.color5457BE,

                )
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(_controller.value.position),
                  style: StyleUtility.unSelectTabTextStyle.copyWith(
                    fontSize: TextSizeUtility.textSize14.sp,
                    color: ColorUtility.colorWhite
                  ),
                ),
                Text(
                  _formatDuration(_controller.value.duration),
                  style: StyleUtility.unSelectTabTextStyle.copyWith(
                      fontSize: TextSizeUtility.textSize14.sp,
                      color: ColorUtility.colorWhite
                  ),
                ),
              ],
            ),
          ),
          FloatingActionButton(
            backgroundColor: ColorUtility.color5457BE,
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),

          SizedBox(
            height: 10.h,
          )
          , SafeArea(
            child: SizedBox(
              height: 20.h,
            ),
          )


        ],
      ),
    );
  }
}

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({required this.controller});

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.play();
          },
        ),
      ],
    );
  }
}

///AUDIO PLAYER


