/*
 * @author admin.
 * @date: 2021/8/2 1:39 下午
 * @description: flutter
 */

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// WebSocket地址
const String _SOCKET_URL = 'ws://192.168.121.15:2122';

/// WebSocket状态
enum SocketStatus {
  SocketStatusConnected, // 已连接
  SocketStatusFailed, // 失败
  SocketStatusClosed, // 连接关闭
}

class WebSocketUtil {
  /// 单例对象
  static WebSocketUtil? _socket;

  /**
   * 内部构造方法，可避免外部暴露构造函数，进行实例化
   */
  WebSocketUtil._();

  /// 获取单例内部方法
  factory WebSocketUtil() {
    // 只能有一个实例
    if (_socket == null) {
      _socket = new WebSocketUtil._();
    }
    return _socket!;
  }

  IOWebSocketChannel? _webSocket; // WebSocket
  late SocketStatus _socketStatus; // socket状态
  Timer? _heartBeat; // 心跳定时器
  int _heartTimes = 3000; // 心跳间隔(毫秒)
  num _reconnectCount = 5; // 重连次数，默认60次
  num _reconnectTimes = 0; // 重连计数器
  Timer? _reconnectTimer; // 重连定时器
  late Function onError; // 连接错误回调
  // late Function onOpen; // 连接开启回调
  late Function onMessage; // 接收消息回调

  /// 初始化WebSocket
  void initWebSocket(
      // {required Function onOpen,
      {required Function onMessage,
      required Function onError}) {
    // this.onOpen = onOpen;
    this.onMessage = onMessage;
    this.onError = onError;
    openSocket();
  }

  /// 开启WebSocket连接
  void openSocket() async {
    closeSocket();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid') ?? '';
    String token = prefs.getString('token') ?? '';
    _webSocket = IOWebSocketChannel.connect(
      _SOCKET_URL,
      pingInterval: Duration(milliseconds: _heartTimes),
      headers: {
        "UID": uid,
        "Token": token,
      },
    );
    print('WebSocket连接成功: $_SOCKET_URL');
    // 连接成功，返回WebSocket实例
    _socketStatus = SocketStatus.SocketStatusConnected;
    // 连接成功，重置重连计数器
    _reconnectTimes = 0;
    if (_reconnectTimer != null) {
      _reconnectTimer!.cancel();
      _reconnectTimer = null;
    }

    // initHeartBeat();
    sendMessage({
      'PING': {
        'Packet Type': '7',
        'Flag': '1',
      }
    });
    // 接收消息
    _webSocket!.stream.listen((data) => webSocketOnMessage(data),
        onError: webSocketOnError, onDone: webSocketOnDone);
  }

  /// WebSocket接收消息回调
  webSocketOnMessage(data) {
    onMessage(data);
    print('收到data------$data');
  }

  /// WebSocket关闭连接回调
  webSocketOnDone() {
    print('closed');
    reconnect();
  }

  /// WebSocket连接错误回调
  webSocketOnError(e) {
    WebSocketChannelException ex = e;
    _socketStatus = SocketStatus.SocketStatusFailed;
    onError(ex.message);
    closeSocket();
  }

  /// 初始化心跳
  void initHeartBeat() {
    destroyHeartBeat();
    _heartBeat =
        new Timer.periodic(Duration(milliseconds: _heartTimes), (timer) {
      sentHeart();
    });
  }

  /// 心跳
  void sentHeart() {
    // sendMessage('PING');
    // sendMessage("PING");
    // sendMessage(message)
  }

  /// 销毁心跳
  void destroyHeartBeat() {
    if (_heartBeat != null) {
      _heartBeat!.cancel();
      _heartBeat = null;
    }
  }

  /// 关闭WebSocket
  void closeSocket() {
    if (_webSocket != null) {
      print('WebSocket连接关闭');
      _webSocket!.sink.close();
      destroyHeartBeat();
      _socketStatus = SocketStatus.SocketStatusClosed;
    }
  }

  /// 发送WebSocket消息
  void sendMessage(message) {
    if (_webSocket != null) {
      switch (_socketStatus) {
        case SocketStatus.SocketStatusConnected:
          print('发送中：' + message);
          _webSocket!.sink.add(message);
          break;
        case SocketStatus.SocketStatusClosed:
          print('连接已关闭');
          break;
        case SocketStatus.SocketStatusFailed:
          print('发送失败');
          break;
        default:
          break;
      }
    }
  }

  /// 重连机制
  void reconnect() {
    print('重连');
    if (_reconnectTimes < _reconnectCount) {
      print('重连次数 $_reconnectTimes-----最大次数$_reconnectCount');
      _reconnectTimes++;
      _reconnectTimer =
          new Timer.periodic(Duration(milliseconds: _heartTimes), (timer) {
        openSocket();
      });
    } else {
      if (_reconnectTimer != null) {
        print('重连次数超过最大次数');
        _reconnectTimer!.cancel();
        _reconnectTimer = null;
      }
      return;
    }
  }
}
