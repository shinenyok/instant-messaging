import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im/app/util/ffmepg_util.dart';
import 'package:path_provider/path_provider.dart';

class VideoView extends StatefulWidget {
  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  final List<String> dataList = [
    '远方',
    '不为谁而作的歌',
    '七里香',
    '可惜没如果',
    '圣所',
    '她说',
    '江南',
    '赤伶',
    '那些你很冒险的梦',
    '阿刁'
  ];

  AudioCache cacheAudio = AudioCache();

  AudioPlayer player = AudioPlayer();
  List<String> imageList = [];

  @override
  void initState() {
    super.initState();
    initFFmpegWrap();
    // Future.delayed(Duration(seconds: 1), () {
      met();
    // });
  }

  met() async {
    Dio dio = Dio();
    Directory dir = await getApplicationDocumentsDirectory();
    getVideoFrames("${dir.path}/demo.mp4", 4, 4, (items) {
      print('items:$items');
      setState(() {
        imageList.assignAll(items);
      });
    });
  }

  void getImages(totalTime) async {
    Dio dio = Dio();
    Directory dir = await getApplicationDocumentsDirectory();
    Directory sonDir = Directory('${dir.path}/demo.mp4');
    bool exist = await sonDir.exists();
    if (exist) {
      getVideoFrames("${dir.path}/demo.mp4", totalTime, 4, (items) {
        print('items:$items');
        setState(() {
          imageList.assignAll(items);
        });
      });
    } else {
      dio.download(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
          "${dir.path}/demo.mp4", onReceiveProgress: (progress, total) {
        if (progress == total) {
          // var totalTime =  getVideoDuration('${dir.path}/demo.mp4');
          getVideoFrames("${dir.path}/demo.mp4", totalTime, 4, (items) {
            print('items:$items');
            setState(() {
              imageList.assignAll(items);
            });
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VideoView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              getImages(4);
            },
            child: Text('剪切'),
          ),
          Flexible(
            child: RotatedBox(
              quarterTurns: 3,
              child: Container(
                width: 100,
                color: Colors.cyan,
                child: ListWheelScrollView(
                  itemExtent: 100,
                  children: imageList.map(
                    (element) {
                      File file = File(element);
                      Image img = Image.file(
                        file,
                        errorBuilder: (context, url, error) {
                          print(url);
                          print('error:$error');
                          return Container(
                            color: Colors.cyanAccent,
                          );
                        },
                      );
                      return img;
                    },
                  ).toList(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
      // body: ListView(
      //   padding: EdgeInsets.only(top: 30),
      //   children: ListTile.divideTiles(
      //     context: context,
      //     color: Colors.white,
      //     tiles: dataList.map((e) => GestureDetector(
      //       onTap: () async{
      //         // rootBundle.load('assets/sounds/${PinyinHelper.getPinyin(e).removeAllWhitespace}.mp3').then((value) {
      //         //   print(value);
      //         // });
      //         // final FlutterFFprobe _flutterFFprobe = new FlutterFFprobe();
      //
      //         // cacheAudio.play('sounds/yuanfang.mp3');
      //        await cacheAudio.clearAll();
      //         cacheAudio.play('sounds/${PinyinHelper.getPinyin(e).removeAllWhitespace}.mp3');
      //       },
      //       child: Container(
      //         padding: EdgeInsets.all(8),
      //         child: Text(e),
      //       ),
      //     ),),
      //   ).toList(),
      // ),
    );
  }
}
