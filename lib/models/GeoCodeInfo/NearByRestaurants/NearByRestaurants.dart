// nearby restaurants provided by geocode

// import '../NearByRestaurants/Restaurants.dart/Restaurants.dart';

import 'package:bhukkd/models/GeoCodeInfo/NearByRestaurants/ZomatoEvents/ZomatoEvents.dart';

import '../../Restruant/UserRating/UserRating.dart';
import '../../Restruant/location/location.dart';


class NearByRestaurants{
  String id;
  String name;
  String url;
  Map<String, dynamic> near_by_restaurants_location;
  String cuisines;
  int average_cost_for_two;
  int price_range;
  String currency;
  List<dynamic> offers;
  List<ZomatoEvents> zomato_events;
  int opentable_support;
  int is_zomato_book_res;
  String mezzo_provider;
  String book_form_web_view_url;
  String book_again_url;
  String thumb;
  UserRating user_rating;
  String menu_url;
  String photo_url;
  String featured_image;
  String medio_provider;
  int has_online_delivery;
  int is_delivery_now;
  bool include_bogo_offers;
  String deeplink;
  int is_table_reservation_supported;
  int has_table_booking;
  String book_url;
  String events_url;
  List<dynamic> all_reviews;

  NearByRestaurants({this.id, this.name,
    this.near_by_restaurants_location,
      this.cuisines, this.average_cost_for_two, this.price_range, this.currency,
      this.offers, this.opentable_support,
      this.is_zomato_book_res, this.mezzo_provider, this.book_form_web_view_url,
      this.book_again_url, this.thumb, this.menu_url,
      this.photo_url, this.featured_image, this.medio_provider,
      this.has_online_delivery, this.is_delivery_now, this.include_bogo_offers,
      this.deeplink, this.is_table_reservation_supported,
      this.has_table_booking, this.book_url, this.events_url, this.url, this.all_reviews, this.user_rating, this.zomato_events});


  // ignore: missing_return
  factory NearByRestaurants.fromJson(Map<String, dynamic> _json) {
    Map<String, dynamic> loc = _json["restaurant"]["location"];
    var event = _json["restaurant"]['zomato_events'] as List;
    Map<String, dynamic> user_rate = _json["restaurant"]['user_rating'];
    location l;
    List<ZomatoEvents> zomatoEvents = [];
    UserRating rate;

    if (loc != null) {
      l = location.fromJson(loc);
    }else{
      print("error in location in NearByrest:$l");
    }


    if (event != null) {
      zomatoEvents = event.map((i) => ZomatoEvents.fromJson(i)).toList();
      //zomatoEvents = ZomatoEvents.fromJson(event);
      //print("image  + " + zomatoEvents[0].photos[0].url.toString());
    } else {
      zomatoEvents.add(null);
      //print("error in zomatoEvents in NearByrest:$zomatoEvents");
    }


    if(user_rate!=null){
      rate =UserRating.fromJson(user_rate);
    }


    return NearByRestaurants(
      id: _json["restaurant"]['id'],
      name: _json["restaurant"]['name'],
      url: _json["restaurant"]['url'],
      near_by_restaurants_location: loc,
      cuisines: _json["restaurant"]['cuisines'],
      average_cost_for_two: _json["restaurant"]['average_cost_for_two'],
      price_range: _json["restaurant"]['price_range'],
      currency: _json["restaurant"]['currency'],
      offers: _json["restaurant"]['offers'],
      book_again_url: _json["restaurant"]['book_again_url'],
      book_form_web_view_url: _json["restaurant"]['book_form_web_view_url'],
      book_url: _json["restaurant"]['book_url'],
      deeplink: _json["restaurant"]['deeplink'],
      events_url: _json["restaurant"]['events_url'],
      featured_image: _json["restaurant"]['featured_image'],
      has_online_delivery: _json["restaurant"]['has_online_delivery'],
      has_table_booking: _json["restaurant"]['has_table_booking'],
      include_bogo_offers: _json["restaurant"]['include_bogo_offers'],
      is_delivery_now: _json["restaurant"]['is_delivery_now'],
      is_table_reservation_supported: _json["restaurant"]['is_table_reservation_supported'],
      is_zomato_book_res: _json["restaurant"]['is_zomato_book_res'],
      medio_provider: _json["restaurant"]['medio_provider'].toString(),
      menu_url: _json["restaurant"]['menu_url'],
      mezzo_provider: _json["restaurant"]['mezzo_provider'],
      opentable_support: _json["restaurant"]['opentable_support'],
      photo_url: _json["restaurant"]['photo_url'],
      thumb: _json["restaurant"]['thumb'],
      user_rating: rate,
      zomato_events: zomatoEvents,
    );



  }
}