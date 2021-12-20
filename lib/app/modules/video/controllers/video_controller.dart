import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class VideoController extends GetxController {
  //TODO: Implement VideoController
  AudioCache audioCache = AudioCache(prefix: 'assets/sounds/');
  AudioPlayer player = AudioPlayer();
  final count = 0.obs;
  late Uri uri;

  @override
  void onInit() async {
    super.onInit();
    print('----onInit----');
    // uri = await audioCache.load('yuanfang.mp3');
    // await player.setUrl(uri.toString());
    // print('1232323');

  }

  play() async {
    player = await audioCache.play(
      'yuanfang.mp3',
    );
    player.onAudioPositionChanged.listen((event) {
      print('------position-----$event');
    });
    player.onPlayerError.listen((event) {
      print(event);
    }, onError: (err) {
      print('--error----$err');
    });
    player.onPlayerStateChanged.listen((event) {
      print('----state-0----$event');
    });
  }

  stop() {
    player.stop();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() async {
    // int result = await audioPlayer.release();
    // if (result == 1) {
    //   print('release success');
    // } else {
    //   print('release failed');
    // }
  }

  void increment() => count.value++;
}
