// nearby restaurants provided by geocode

import 'package:bhukkd/models/Restruant/location/location.dart';
import 'package:bhukkd/models/GeoCodeInfo/NearByRestaurants/ZomatoEvents/ZomatoEvents.dart';

import '../Restruant/location/location.dart';

class NearByRestaurants{
  String id;
  String name;
  List<dynamic> near_by_restaurants_location;
  String cuisines;
  String average_cost_for_two;
  int price_range;
  String currency;
  List<String> offers;
  List<dynamic> zomato_offers;
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


  NearByRestaurants( this.id, this.name,
      this.cuisines, this.average_cost_for_two, this.price_range, this.currency,
      this.offers, this.zomato_offers, this.opentable_support,
      this.is_zomato_book_res, this.mezzo_provider, this.book_form_web_view_url,
      this.book_again_url, this.thumb, this.user_rating, this.menu_url,
      this.photo_url, this.featured_image, this.medio_provider,
      this.has_online_delivery, this.is_delivery_now, this.include_bogo_offers,
      this.deeplink, this.is_table_reservation_supported,
      this.has_table_booking, this.book_url, this.events_url);


  factory NearByRestaurants.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> loc = json['location'];
    Map<String, dynamic> z_offers = json['zomato_events'];

    location l;
    ZomatoEvents zomatoEvents;

    if (loc != null) {
      l = location.fromJson(loc);
    }

    if (z_offers != null) {
      zomatoEvents = ZomatoEvents.fromJson(loc);
    }

    return NearByRestaurants(
      id:json['id'],
      name:json['name'],
      cuisines:json[''],
      average_cost_for_two:json[''],
      price_range:json[''],
      currency:json[''],
      //offers:json[''],


    );
  }

}