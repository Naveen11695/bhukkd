// nearby restaurants provided by geocode

// import '../NearByRestaurants/Restaurants.dart/Restaurants.dart';

import 'package:bhukkd/models/GeoCodeInfo/NearByRestaurants/ZomatoEvents/ZomatoEvents.dart';

import '../../Restruant/location/location.dart';
import '../../Restruant/UserRating/UserRating.dart';

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


  factory NearByRestaurants.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> loc = json["restaurant"]["location"];
    //Map<String, dynamic> event = json["restaurant"]['zomato_events'];
    Map<String, dynamic> user_rate = json["restaurant"]['user_rating'];
    location l;
    ZomatoEvents zomatoEvents;
    UserRating rate;

    if (loc != null) {
      // printing the location of the restraunts
   /*   print("-----------Location of the NearByRest------------");
      print(loc);
      print("-----------End------------");*/
      l = location.fromJson(loc);
    }else{
      print("error in location in NearByrest:$l");
    }

  /*  print("restaurants:"+json['restaurant'].toString());*/

    // error in zomatoEvents

    // if (event != null) {
    //   print(event);
    //   zomatoEvents = ZomatoEvents.fromJson(event);
    // }else{
    //   print("error in zomatoEvents in NearByrest:$zomatoEvents");
    // }

    if(user_rate!=null){
      // printing the user rating
    /*  print("-----------User Rating------------");
      print(user_rate);
      print("-----------End--------------------");*/
      rate =UserRating.fromJson(user_rate);
    }else{
  /*    print("error in userRating in NearByrest:$rate");*/
    }

//    print(json.toString());


    return NearByRestaurants(
      id:json["restaurant"]['id'],
      name:json["restaurant"]['name'],
      url:json["restaurant"]['url'],
      near_by_restaurants_location: loc,
      cuisines:json["restaurant"]['cuisines'],
      average_cost_for_two:json["restaurant"]['average_cost_for_two'],
      price_range:json["restaurant"]['price_range'],
      currency:json["restaurant"]['currency'],
      offers:json["restaurant"]['offers'],
      book_again_url: json["restaurant"]['book_again_url'],
      book_form_web_view_url: json["restaurant"]['book_form_web_view_url'],
      book_url: json["restaurant"]['book_url'],
      deeplink: json["restaurant"]['deeplink'],
      events_url: json["restaurant"]['events_url'],
      featured_image: json["restaurant"]['featured_image'],
      has_online_delivery: json["restaurant"]['has_online_delivery'],
      has_table_booking: json["restaurant"]['has_table_booking'],
      include_bogo_offers: json["restaurant"]['include_bogo_offers'],
      is_delivery_now: json["restaurant"]['is_delivery_now'],
      is_table_reservation_supported: json["restaurant"]['is_table_reservation_supported'],
      is_zomato_book_res: json["restaurant"]['is_zomato_book_res'],
      medio_provider: json["restaurant"]['medio_provider'].toString(),
      menu_url: json["restaurant"]['menu_url'],
      mezzo_provider: json["restaurant"]['mezzo_provider'],
      opentable_support: json["restaurant"]['opentable_support'],
      photo_url: json["restaurant"]['photo_url'],
      thumb: json["restaurant"]['thumb']
    );

  }
}