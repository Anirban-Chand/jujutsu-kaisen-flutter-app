import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_vpn/flutter_vpn.dart';

class PlayEpisode extends StatefulWidget {
  final String episodeUrl;
  const PlayEpisode({required this.episodeUrl});
  @override
  _PlayEpisodeState createState() => _PlayEpisodeState();
}

class _PlayEpisodeState extends State<PlayEpisode> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  // VPN Service
  var state = FlutterVpnState.disconnected;
  CharonErrorState? charonState = CharonErrorState.NO_ERROR;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.episodeUrl);
    _initializeVideoPlayerFuture = _controller.initialize();

    // vpn service
    FlutterVpn.prepare();
    FlutterVpn.onStateChanged.listen((s) => setState(() => state = s));

    // loop the video player
    _controller.setLooping(true);

    super.initState();
    setState(() {});
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    // vpn disconnect
    FlutterVpn.disconnect();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(_controller),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Wrap the play or pause in a call to `setState`. This ensures the
                    // correct icon is shown.
                    setState(() {
                      // If the video is playing, pause it.
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        // If the video is paused, play it.
                        _controller.play();
                      }

                      // vpn service starts
                      FlutterVpn.simpleConnect(
                          '219.100.37.196', 'vpn','vpn');
                    });
                  },
                  // Display the correct icon depending on the state of the player.
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                ),
              ],
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
