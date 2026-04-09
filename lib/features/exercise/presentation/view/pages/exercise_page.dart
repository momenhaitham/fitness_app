import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});
  @override
  
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'iLnmTe5Q2Qw',
    flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
    ),
    );
    return Scaffold(
      body: Column(
        children: [
          YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
              progressColors: const ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
              onReady: () {
                _controller.addListener(() {
                  
                },);
              },
          ),
        ],
      )
    );
  }
}
