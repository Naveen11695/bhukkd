
import 'package:bhukkd/models/GeoCodeInfo/NearByRestaurants/ZomatoEvents/ZomatoEvents.dart';

import '../../../Restruant/location/location.dart';
import '../../../Restruant/UserRating/UserRating.dart';

class Restaurants{  
  String id;
  String name;
  List<dynamic> near_by_restaurants_location;
  String cuisines;
  int average_cost_for_two;
  int price_range;
  String currency;
  List<dynamic> offers;
  List<dynamic> zomato_events;
  int opentable_support;
  int is_zomato_book_res;
  String mezzo_provider;
  String book_form_web_view_url;
  String book_again_url;
  String thumb;
  List<dynamic> user_rating;
  String menu_url;
  String photo_url;
  String featured_image;
  int medio_provider;
  int has_online_delivery;
  int is_delivery_now;
  bool include_bogo_offers;
  String deeplink;
  int is_table_reservation_supported;
  int has_table_booking;
  String book_url;
  String events_url;


  Restaurants({this.id, this.name,
      this.cuisines, this.average_cost_for_two, this.price_range, this.currency,
      this.offers, this.opentable_support,
      this.is_zomato_book_res, this.mezzo_provider, this.book_form_web_view_url,
      this.book_again_url, this.thumb, this.menu_url,
      this.photo_url, this.featured_image, this.medio_provider,
      this.has_online_delivery, this.is_delivery_now, this.include_bogo_offers,
      this.deeplink, this.is_table_reservation_supported,
      this.has_table_booking, this.book_url, this.events_url});


  factory Restaurants.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> loc = json["location"];
    Map<String, dynamic> event = json['zomato_events'];
    Map<String, dynamic> user_rate = json['user_rating'];

    location l;
    ZomatoEvents zomatoEvents;
    UserRating rate;

    if (loc != null) {
      // printing the location of the restraunts
      print("-----------Location of the NearByRest------------");
      print(loc);
      print("-----------End------------");
      l = location.fromJson(loc);
    }else{
      print("error in location in NearByrest:$l");
    }

    // error in zomatoEvents

    // if (event != null) {
    //   print(event);
    //   zomatoEvents = ZomatoEvents.fromJson(event);
    // }else{
    //   print("error in zomatoEvents in NearByrest:$zomatoEvents");
    // }

    if(user_rate!=null){
      // printing the user rating
      print("-----------User Rating------------");
      print(user_rate);
      print("-----------End--------------------");
      rate =UserRating.fromJson(user_rate);
    }else{
      print("error in userRating in NearByrest:$rate");
    }

    return Restaurants(
      id:json['id'],
      name:json['name'],
      cuisines:json['cuisines'],
      average_cost_for_two:json['average_cost_for_two'],
      price_range:json['price_range'],
      currency:json['currency'],
      offers:json['offers'],
      book_again_url: json['book_again_url'],
      book_form_web_view_url: json['book_form_web_view_url'],
      book_url: json['book_url'],
      deeplink: json['deeplink'],
      events_url: json['events_url'],
      featured_image: json['featured_image'],
      has_online_delivery: json['has_online_delivery'],
      has_table_booking: json['has_table_booking'],
      include_bogo_offers: json['include_bogo_offers'],
      is_delivery_now: json['is_delivery_now'],
      is_table_reservation_supported: json['is_table_reservation_supported'],
      is_zomato_book_res: json['is_zomato_book_res'],
      medio_provider: json['medio_provider'],
      menu_url: json['menu_url'],
      mezzo_provider: json['mezzo_provider'],
      opentable_support: json['opentable_support'],
      photo_url: json['photo_url'],
      thumb: json['thumb']
    );

  }
}