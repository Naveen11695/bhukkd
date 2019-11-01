
class Photos {
  String url;
  String thumb_url;
  int order;
  String md5sum;
  int id;
  int photos_id;
  int uuid;
  String type;

  Photos({this.url, this.thumb_url, this.order, this.md5sum, this.id,
      this.photos_id, this.uuid, this.type});

  factory Photos.fromJson(Map<String, dynamic> jsonParsed){
    return Photos(
      url: jsonParsed['photo']['url'],
      thumb_url: jsonParsed['photo']['thumb_url'],
      order: jsonParsed['photo']['order'],
      md5sum: jsonParsed['photo']['md5sum'],
      id: jsonParsed['photo']['id'],
      photos_id: jsonParsed['photo']['photo_id'],
      uuid: jsonParsed['photo']['uuid'],
      type: jsonParsed['photo']['type'],
    );

  }


}