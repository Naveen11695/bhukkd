import 'package:bhukkd/models/GeoCodeInfo/NearByRestaurants/ZomatoEvents/Photos/Photos.dart';

class ZomatoEvents{
  String event_id;
  String friendly_start_date;
  String friendly_end_date;
  String friendly_timing_str;
  String start_date;
  String end_date;
  String start_time;
  int isActive;
  String date_added;
  List<dynamic> photos;
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
      this.isActive, this.date_added, this.photos, this.restaurants,
      this.is_valid, this.share_url, this.show_share_url, this.title,
      this.description, this.display_time, this.display_date,
      this.is_end_time_set, this.disclaimer, this.event_category,
      this.event_category_name, this.book_link});

  factory ZomatoEvents.fromJson(Map<String, dynamic> jsonParsed){
    Map<String, dynamic> json_photos = jsonParsed['photos'];
    Map<String, dynamic> share= jsonParsed['share_data'];
    //types
    Photos photos;

    if(json_photos != null) {
      photos = Photos.fromJson(json_photos);
    }

    return ZomatoEvents(
      event_id:jsonParsed['event_id'],
      friendly_start_date:jsonParsed['friendly_start_date'],
      friendly_end_date:jsonParsed['friendly_end_date'],
      friendly_timing_str:jsonParsed['friendly_timing_str'],
      start_date:jsonParsed['start_date'],
      end_date:jsonParsed['end_date'],
      start_time:jsonParsed['start_time'],
      isActive:jsonParsed['isActive'],
      is_valid:jsonParsed['is_valid'],
      share_url:jsonParsed['share_url'],
      show_share_url:jsonParsed['show_share_url'],
      title:jsonParsed['title'],
      book_link: jsonParsed['book_link'],
      date_added: jsonParsed['date_added'],
      description: jsonParsed['description'],
      disclaimer: jsonParsed['disclaimer'],
      display_date: jsonParsed['display_date'],
      display_time: jsonParsed['display_time'],
      event_category: jsonParsed['event_category'],
      event_category_name: jsonParsed['event_category_name'],
      is_end_time_set: jsonParsed['is_end_time_set'],
    );
   }
}
