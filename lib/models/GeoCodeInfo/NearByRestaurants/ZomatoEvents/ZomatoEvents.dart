import 'package:bhukkd/models/GeoCodeInfo/NearByRestaurants/ZomatoEvents/Photos/Photos.dart';


class ZomatoEvents{
  int event_id;
  String friendly_start_date;
  String friendly_end_date;
  String friendly_timing_str;
  String start_date;
  String end_date;
  String start_time;
  int isActive;
  String date_added;
  List<Photos> photos;
  List<dynamic> restaurants;  // empty please check before using
  int is_valid;
  String share_url;
  int show_share_url;
  String title;
  String description;
  String display_time;
  String display_date;
  int is_end_time_set;
  String disclaimer;
  int event_category;
  String event_category_name;
  String book_link;
  List<dynamic> types; // empty please check before using
  List<dynamic> share_data;


  ZomatoEvents({this.event_id, this.friendly_start_date, this.friendly_end_date,
      this.friendly_timing_str, this.start_date, this.end_date, this.start_time,
    this.isActive, this.date_added, this.restaurants,
      this.is_valid, this.share_url, this.show_share_url, this.title,
      this.description, this.display_time, this.display_date,
      this.is_end_time_set, this.disclaimer, this.event_category,
    this.event_category_name, this.book_link, this.photos});

  factory ZomatoEvents.fromJson(Map<String, dynamic> jsonParsed){
    var json_photos = jsonParsed['event']['photos'] as List;

    Map<String, dynamic> share = jsonParsed['event']['share_data'];
    //types
    List<Photos> _photos = [];

    if(json_photos != null) {
      _photos = json_photos.map((i) => Photos.fromJson(i)).toList();
    }


    return ZomatoEvents(
      event_id: jsonParsed['event']['event_id'],
      friendly_start_date: jsonParsed['event']['friendly_start_date'],
      friendly_end_date: jsonParsed['event']['friendly_end_date'],
      friendly_timing_str: jsonParsed['event']['friendly_timing_str'],
      start_date: jsonParsed['event']['start_date'],
      end_date: jsonParsed['event']['end_date'],
      start_time: jsonParsed['event']['start_time'],
      isActive: jsonParsed['event']['isActive'],
      is_valid: jsonParsed['event']['is_valid'],
      share_url: jsonParsed['event']['share_url'],
      show_share_url: jsonParsed['event']['show_share_url'],
      title: jsonParsed['event']['title'],
      book_link: jsonParsed['event']['book_link'],
      date_added: jsonParsed['event']['date_added'],
      description: jsonParsed['event']['description'],
      disclaimer: jsonParsed['event']['disclaimer'],
      display_date: jsonParsed['event']['display_date'],
      display_time: jsonParsed['event']['display_time'],
      event_category: jsonParsed['event']['event_category'],
      event_category_name: jsonParsed['event']['event_category_name'],
      is_end_time_set: jsonParsed['event']['is_end_time_set'],
      photos: _photos,
    );
   }
}
