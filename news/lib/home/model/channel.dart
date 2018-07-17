
class Channel {
  String channelId;
  String channelName;

  Channel(this.channelId, this.channelName);

  Channel.fromJson(Map<String, dynamic> json)
      : channelId = json['channelId'],
        channelName = json['name'];
}

class ChannelList {
  List<Channel> channels = [];
  ChannelList.fromJson(Map<String,dynamic> j) {
    int count = 0;
    for (var item in j['showapi_res_body']['channelList']) {
      if (count < 5) {
      channels.add(Channel.fromJson(item));
      }
      count = count + 1;
    }
  }
}


