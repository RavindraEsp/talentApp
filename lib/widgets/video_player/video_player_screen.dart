import 'package:flutter/material.dart';
import 'package:talent_app/network/end_points.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerRemote extends StatefulWidget {
  final String file;

  const VideoPlayerRemote({super.key, required this.file});

  @override
  @override
  State<VideoPlayerRemote> createState() => _VideoPlayerRemoteState();
}

class _VideoPlayerRemoteState extends State<VideoPlayerRemote> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.network(
    //  // widget.url, //to access its parent class constructor or variable
    //   Endpoints.imageBaseUrl  + widget.url, //to access its parent class constructor or variable
    // );

    _controller = VideoPlayerController.networkUrl(Uri.parse(
        //   'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
        Endpoints.imageBaseUrl + widget.file))
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(padding: const EdgeInsets.only(top: 20.0)),
          Container(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  _PlayPauseOverlay(
                    controller: _controller,
                  ),
                  VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                  ),
                ],
              ),
            ),
          ),
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

// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';

//
// class AudioPlayerScreen extends StatefulWidget {
//
//   final String file;
//
//   const AudioPlayerScreen({super.key, required this.file});
//   @override
//   _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
// }
//
// class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
//   AudioPlayer? _audioPlayer;
//   String audioUrl =
//       'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';
//   bool isPlaying = false;
//   Duration _duration = Duration();
//   Duration _position = Duration();
//
//   @override
//   void initState() {
//     super.initState();
//     _audioPlayer = AudioPlayer();
//
//
//     _playAudio();
//   }
//
//    _playAudio() async {
//     var result = await _audioPlayer?.play(UrlSource("https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3"));
//
//
//
//   //  if (_audioPlayer.i) {
//       // success
//       setState(() {
//         isPlaying = true;
//       });
//    // } else {
//    //   print('Error playing audio');
//    // }
//
//     _audioPlayer?.onDurationChanged.listen((Duration duration) {
//       setState(() {
//         _duration = duration;
//
//         print(_duration.toString());
//       });
//     });
//
//     _audioPlayer?.onDurationChanged.listen((Duration position) {
//       setState(() {
//         _position = position;
//       });
//     });
//
//   }
//
//   void _pauseAudio() {
//     _audioPlayer?.pause();
//     setState(() {
//       isPlaying = false;
//     });
//   }
//
//   void _stopAudio() {
//     _audioPlayer?.stop();
//     setState(() {
//       isPlaying = false;
//       _position = Duration();
//     });
//   }
//
//   void _seekAudio(double value) {
//     Duration newPosition = Duration(milliseconds: (value * _duration.inMilliseconds).round());
//     _audioPlayer?.seek(newPosition);
//
//     setState(() {
//
//     });
//   }
//
//   @override
//   void dispose() {
//     _audioPlayer?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Audio Player Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Network Audio Player'),
//             Slider(
//               value: _position.inMilliseconds.toDouble(),
//               min: 0.0,
//               max: _duration.inMilliseconds.toDouble(),
//               onChanged: (value) {
//                 _seekAudio(value);
//               },
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.play_arrow),
//                   onPressed: isPlaying ? null : _playAudio,
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.pause),
//                   onPressed: isPlaying ? _pauseAudio : null,
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.stop),
//                   onPressed: isPlaying ? _stopAudio : null,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
