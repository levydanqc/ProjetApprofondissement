import 'package:astrokit/src/Shared/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);
  static const routeName = "/help";

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> with TickerProviderStateMixin {
  late VideoPlayerController _controller;
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/help.mov")
      ..initialize().then((_) {
        setState(() {});
      });
    animation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 0.5).animate(animation);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
      body: Container(
        alignment: Alignment.center,
        child: _controller.value.isInitialized
            ? Stack(
                alignment: Alignment.center,
                children: [
                  FadeTransition(
                      opacity: _fadeInFadeOut,
                      child: Icon(_controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow)),
                  GestureDetector(
                    onTap: () {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                      animation.addStatusListener((status) {
                        if (status == AnimationStatus.completed) {
                          animation.reverse();
                        } else if (status == AnimationStatus.dismissed) {
                          animation.forward();
                        }
                      });
                      animation.forward();
                    },
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ],
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => _controller.value.isPlaying
              ? _controller.pause()
              : _controller.play());
        },
        child:
            Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
