import 'package:astrokit/src/Shared/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);
  static const routeName = "/help";

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> with TickerProviderStateMixin {
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'H9miEYiEing',
    flags: const YoutubePlayerFlags(
      hideControls: false,
      controlsVisibleAtStart: true,
      autoPlay: false,
      mute: false,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
        child: YoutubePlayer(
          controller: _controller,
          aspectRatio: 19.5 / 9,
          width: size.width * 2,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
