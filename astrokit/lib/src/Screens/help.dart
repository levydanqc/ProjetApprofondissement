import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:astrokit/src/Shared/app_bar.dart';
import 'package:astrokit/src/Shared/progress_indicator.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);
  static const routeName = "/help";

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> with TickerProviderStateMixin {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;
  double _value = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      'assets/help.mp4',
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.addListener(() {
      setState(() {
        _value = _controller.value.position.inSeconds.toDouble();
      });
    });

    animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1).animate(animation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void showIcon() {
    setState(() {
      animation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animation.reverse();
        }
      });
      animation.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(
        context: context,
        title: Text(
          "Aide",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  });
                  showIcon();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    FutureBuilder<void>(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          );
                        } else {
                          return Center(
                            child: progressIndicator(),
                          );
                        }
                      },
                    ),
                    FadeTransition(
                      opacity: _fadeInFadeOut,
                      child: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_circle_outline_rounded,
                        color: Colors.amber,
                        size: 100,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
              child: SliderTheme(
                data: const SliderThemeData(
                    valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                    valueIndicatorColor: Colors.redAccent,
                    valueIndicatorTextStyle: TextStyle(
                      color: Colors.white,
                    )),
                child: Slider(
                  // divisions: _controller.value.duration.inSeconds,
                  label: '$_value',
                  activeColor: Colors.amber,
                  inactiveColor: Colors.grey,
                  value: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                      _controller.seekTo(Duration(seconds: value.toInt()));
                      _controller.play();
                    });
                  },
                  min: 0,
                  max: _controller.value.duration.inSeconds.toDouble(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
          showIcon();
        },
        child: Icon(
          _controller.value.isPlaying
              ? Icons.pause_rounded
              : Icons.play_arrow_rounded,
        ),
      ),
    );
  }
}
