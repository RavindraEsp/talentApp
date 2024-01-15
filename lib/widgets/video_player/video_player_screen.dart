// // ignore_for_file: library_private_types_in_public_api
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:video_player/video_player.dart';
//
//
// // class VideoPlayerScreen extends StatefulWidget {
// //   final String videoUrl;
// //   //  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
// //   const VideoPlayerScreen({super.key, required this.videoUrl});
// //
// //   @override
// //   _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
// // }
// //
// // class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
// //   late VideoPlayerController _controller;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
// //       ..initialize().then((_) {
// //         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
// //         _controller.play();
// //         setState(() {});
// //       });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.black87,
// //       appBar: AppBar(
// //         backgroundColor: Colors.black,
// //         iconTheme: IconThemeData(color: Colors.white),
// //         title: Text(
// //           'Video',
// //           style: TextStyle(
// //               color: Colors.white,
// //               fontSize: 16.sp,
// //               fontWeight: FontWeight.w600),
// //         ),
// //       ),
// //       body: Center(
// //         child: _controller.value.isInitialized
// //             ? AspectRatio(
// //                 aspectRatio: _controller.value.aspectRatio,
// //                 child: VideoPlayer(_controller),
// //               )
// //             : Container(),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           setState(() {
// //             _controller.value.isPlaying
// //                 ? _controller.pause()
// //                 : _controller.play();
// //           });
// //         },
// //         child: Icon(
// //           _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
// //         ),
// //       ),
// //     );
// //   }
// //
// //   @override
// //   void dispose() {
// //     super.dispose();
// //     _controller.dispose();
// //   }
// // }
//
//
// class VideoApp extends StatefulWidget {
//   const VideoApp({super.key});
//
//   @override
//   _VideoAppState createState() => _VideoAppState();
// }
//
// class _VideoAppState extends State<VideoApp> {
//   late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.networkUrl(Uri.parse(
//         'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
//       ..initialize().then((_) {
//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//         setState(() {});
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Video Demo',
//       home: Scaffold(
//         body: Center(
//           child: _controller.value.isInitialized
//               ? AspectRatio(
//             aspectRatio: _controller.value.aspectRatio,
//             child: VideoPlayer(_controller),
//           )
//               : Container(),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             setState(() {
//               _controller.value.isPlaying
//                   ? _controller.pause()
//                   : _controller.play();
//             });
//           },
//           child: Icon(
//             _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }
//
//

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';




class AudioPlayerScreen extends StatefulWidget {
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  AudioPlayer? _audioPlayer;
  String audioUrl =
      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';
  bool isPlaying = false;
  Duration _duration = Duration();
  Duration _position = Duration();

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();


    _playAudio();
  }

   _playAudio() async {
    var result = await _audioPlayer?.play(UrlSource("https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3"));



  //  if (_audioPlayer.i) {
      // success
      setState(() {
        isPlaying = true;
      });
   // } else {
   //   print('Error playing audio');
   // }

    _audioPlayer?.onDurationChanged.listen((Duration duration) {
      setState(() {
        _duration = duration;

        print(_duration.toString());
      });
    });

    _audioPlayer?.onDurationChanged.listen((Duration position) {
      setState(() {
        _position = position;
      });
    });

  }

  void _pauseAudio() {
    _audioPlayer?.pause();
    setState(() {
      isPlaying = false;
    });
  }

  void _stopAudio() {
    _audioPlayer?.stop();
    setState(() {
      isPlaying = false;
      _position = Duration();
    });
  }

  void _seekAudio(double value) {
    Duration newPosition = Duration(milliseconds: (value * _duration.inMilliseconds).round());
    _audioPlayer?.seek(newPosition);

    setState(() {

    });
  }

  @override
  void dispose() {
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Network Audio Player'),
            Slider(
              value: _position.inMilliseconds.toDouble(),
              min: 0.0,
              max: _duration.inMilliseconds.toDouble(),
              onChanged: (value) {
                _seekAudio(value);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: isPlaying ? null : _playAudio,
                ),
                IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: isPlaying ? _pauseAudio : null,
                ),
                IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: isPlaying ? _stopAudio : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

