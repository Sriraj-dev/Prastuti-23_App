import 'package:flutter/material.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/view_models/splash_view_model.dart';
import 'package:video_player/video_player.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  SplashViewModel splashViewModel = SplashViewModel();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig.init(context);
  }

  @override
  void initState() {
    super.initState();
    splashViewModel.initiateApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: const <Widget>[
          VideoWidget(),
        ],
      ),
    );
  }
}

class VideoWidget extends StatefulWidget {
  const VideoWidget({Key? key}) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/splash_view/splash_view_video.mp4')
      ..initialize().then((_) {
        _controller.setVolume(0.0);
        _controller.setLooping(true);
        _controller.play();
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: _controller.value.isInitialized
          ? LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width:
                constraints.maxWidth,
                height:
                constraints.maxHeight,
                child: VideoPlayer(_controller),
              ),
            ),
          );
        },
      )
          : Container(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
