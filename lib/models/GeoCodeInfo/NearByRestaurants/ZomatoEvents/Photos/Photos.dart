

/*photos": [
//                 {
//                   "photo": {
//                     "url": "https://b.zmtcdn.com/data/zomato_events/photos/9a1/b65cecf6328bb25b304de2132e9c59a1_1550326402.png",
//                     "thumb_url": "https://b.zmtcdn.com/data/zomato_events/photos/9a1/b65cecf6328bb25b304de2132e9c59a1_1550326402.png?fit=around%7C100%3A100&crop=100%3A100%3B%2A%2C%2A",
//                     "order": 0,
//                     "md5sum": "b65cecf6328bb25b304de2132e9c59a1",
//                     "id": 424445,
//                     "photo_id": 424445,
//                     "uuid": 1550326179929333,
//                     "type": "NORMAL"
//                   }
//                 }
//               ],*/
class Photos {
  String url;
  String thumb_url;
  String order;
  String md5sum;
  String id;
  String photos_id;
  String uuid;
  String type;

  Photos({this.url, this.thumb_url, this.order, this.md5sum, this.id,
      this.photos_id, this.uuid, this.type});

  factory Photos.fromJson(Map<String, dynamic> jsonParsed){
    return Photos(
      url:jsonParsed[''],
      thumb_url:jsonParsed[''],
      order:jsonParsed[''],
      md5sum:jsonParsed[''],
      id:jsonParsed[''],
      photos_id:jsonParsed[''],
      uuid:jsonParsed[''],
      type:jsonParsed[''],
    );

  }


}