/*
 * @author admin.
 * @date: 2021/7/30 2:55 下午
 * @description: flutter
 */
class conversationMode {
  String? channelId;
  int? channelType;
  int? unread;
  int? timestamp;
  int? lastMsgSeq;
  String? lastClientMsgNo;
  int? version;
  List<Recents>? recents;

  conversationMode(
      {this.channelId,
        this.channelType,
        this.unread,
        this.timestamp,
        this.lastMsgSeq,
        this.lastClientMsgNo,
        this.version,
        this.recents});

  conversationMode.fromJson(Map<String, dynamic> json) {
    channelId = json['channel_id'];
    channelType = json['channel_type'];
    unread = json['unread'];
    timestamp = json['timestamp'];
    lastMsgSeq = json['last_msg_seq'];
    lastClientMsgNo = json['last_client_msg_no'];
    version = json['version'];
    if (json['recents'] != null) {
      recents = <Recents>[];
      json['recents'].forEach((v) {
        recents!.add(new Recents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channel_id'] = this.channelId;
    data['channel_type'] = this.channelType;
    data['unread'] = this.unread;
    data['timestamp'] = this.timestamp;
    data['last_msg_seq'] = this.lastMsgSeq;
    data['last_client_msg_no'] = this.lastClientMsgNo;
    data['version'] = this.version;
    if (this.recents != null) {
      data['recents'] = this.recents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Recents {
  Header? header;
  int? messageId;
  int? messageSeq;
  String? fromUid;
  String? toUid;
  String? channelId;
  int? channelType;
  int? timestamp;
  String? payload;

  Recents(
      {this.header,
        this.messageId,
        this.messageSeq,
        this.fromUid,
        this.toUid,
        this.channelId,
        this.channelType,
        this.timestamp,
        this.payload});

  Recents.fromJson(Map<String, dynamic> json) {
    header =
    json['header'] != null ? new Header.fromJson(json['header']) : null;
    messageId = json['message_id'];
    messageSeq = json['message_seq'];
    fromUid = json['from_uid'];
    toUid = json['to_uid'];
    channelId = json['channel_id'];
    channelType = json['channel_type'];
    timestamp = json['timestamp'];
    payload = json['payload'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['header'] = this.header!.toJson();
    }
    data['message_id'] = this.messageId;
    data['message_seq'] = this.messageSeq;
    data['from_uid'] = this.fromUid;
    data['to_uid'] = this.toUid;
    data['channel_id'] = this.channelId;
    data['channel_type'] = this.channelType;
    data['timestamp'] = this.timestamp;
    data['payload'] = this.payload;
    return data;
  }
}

class Header {
  int? noPersist;
  int? redDot;
  int? syncOnce;

  Header({this.noPersist, this.redDot, this.syncOnce});

  Header.fromJson(Map<String, dynamic> json) {
    noPersist = json['no_persist'];
    redDot = json['red_dot'];
    syncOnce = json['sync_once'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_persist'] = this.noPersist;
    data['red_dot'] = this.redDot;
    data['sync_once'] = this.syncOnce;
    return data;
  }
}
