import 'package:bhukkd/models/Restruant/Photos/User.dart';
class Photos {
  var id;
  var url;
  var thumb_url;
  var user;
  var res_id;
  var caption;
  var timestamp;
  var friendly_time;
  var width;
  var height;
  var comments_count;
  var likes_count;

  Photos({this.id, this.url, this.thumb_url, this.res_id, this.caption,
      this.timestamp, this.friendly_time, this.width, this.height,
      this.comments_count, this.likes_count});

  void photo_print() {
    print("...................................photo_caption: $caption");
  }

  factory Photos.fromJson(var parsedJson){
    Map<String,dynamic> u = parsedJson['user'];
    User user = User.fromJson(u);
    user.urserprint();

    return Photos(
      id: parsedJson['id'],
      url: parsedJson['url'],
      thumb_url: parsedJson ['thumb_url'],
      res_id: parsedJson['res_id'],
      caption: parsedJson['caption'],
      timestamp: parsedJson ['timestamp'],
      friendly_time: parsedJson['friendly_time'],
      width: parsedJson['width'],
      height: parsedJson ['height'],
      comments_count: parsedJson['comments_count'],
      likes_count: parsedJson['likes_count'],
    );
  }


}