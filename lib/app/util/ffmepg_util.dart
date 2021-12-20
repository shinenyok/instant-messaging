/*
 * @author admin.
 * @date: 2021/10/13 11:18 上午
 * @description: flutter
 */
import 'dart:io';
import 'package:flutter_ffmpeg/media_information.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

 FlutterFFmpeg? _flutterFFmpeg;
late FlutterFFprobe _probe;
late String _path;
///初始化ffmpeg
void initFFmpegWrap() async{
  if(_flutterFFmpeg == null){
    _flutterFFmpeg = new FlutterFFmpeg();
    _probe = new FlutterFFprobe();
  }else{
    return;
  }
  try{
    Directory extDir = await getApplicationDocumentsDirectory();
    String dirPath = '${extDir.path}/Pictures/videoEdit';
    Directory sonDir = Directory(dirPath);
    bool exist = await sonDir.exists();
    if (!exist) {
      await sonDir.create(recursive: true);
    }
    _path = sonDir.path;
  }catch(e){
    print('ffmpeg create dir:$e');
  }
}
///获取视频时长（毫秒）
Future<int> getVideoDuration(String pathInput) async{
  if(_flutterFFmpeg == null){
    print('Please init FFmpegWrap first.');
    return 0;
  }
  MediaInformation videoInfo = await _probe.getMediaInformation(pathInput);
  return videoInfo.getMediaProperties()!['duration'];
}
///获取视频帧数组（规则可以通过命令行自定义）
void getVideoFrames(pathInput, totalTime, count, callback, {imgSize}){
  if(_flutterFFmpeg == null){
    print('Please init FFmpegWrap first.');
    return;
  }
  if(count < 5)count = 5;
  String size = '50x80';
  if(imgSize != null)size = imgSize;
  var now = DateTime.now();
  var timeStamp = now.millisecondsSinceEpoch;
  String pathOutput = '$_path/${timeStamp}out%08d.png';
  _flutterFFmpeg!.execute('-i $pathInput -y -f image2 -vf fps=fps=$count/$totalTime -s $size $pathOutput').then((rc){
    print("FFmpeg process exited with rc $rc");
    if(rc == 0){
      List<String> results = [];
      for(int i=1; i<= count; i++){
        String tempIndex = i.toString().padLeft(8, '0');
        results.add('$_path/${timeStamp}out$tempIndex.png');
      }
      callback(results);
    }else{
      callback([]);
    }
  });
}