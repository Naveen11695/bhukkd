import 'package:scoped_model/scoped_model.dart';
import 'package:bhukkd/models/Restruant/location/location.dart';
import 'package:bhukkd/models/Restruant/UserRating/UserRating.dart';
import 'package:bhukkd/models/Restruant/Photos/Photos.dart';

/*
{
  "R": {
    "res_id": 16774318
  },
  "apikey": "021a533947da652345753f4825586fd4",
  "id": "16774318",
  "name": "Otto Enoteca Pizzeria",
  "url": "https://www.zomato.com/new-york-city/otto-enoteca-pizzeria-greenwich-village?utm_source=api_basic_user&utm_medium=api&utm_campaign=v2.1",
  "location": {
    "address": "One Fifth Avenue at 8th Street, Greenwich Village 10003",
    "locality": "Greenwich Village",
    "city": "New York City",
    "city_id": 280,
    "latitude": "40.7318200000",
    "longitude": "-73.9965400000",
    "zipcode": "10003",
    "country_id": 216,
    "locality_verbose": "Greenwich Village"
  },
  "switch_to_order_menu": 0,
  "cuisines": "Pizza, Italian",
  "average_cost_for_two": 40,
  "price_range": 3,
  "currency": "$",
  "offers": [],
  "opentable_support": 0,
  "is_zomato_book_res": 0,
  "mezzo_provider": "OTHER",
  "is_book_form_web_view": 0,
  "book_form_web_view_url": "",
  "book_again_url": "",
  "thumb": "https://b.zmtcdn.com/data/pictures/8/16774318/b16e382e9f6696f911b600b7e5ca6839.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A",
  "user_rating": {
    "aggregate_rating": "4.4",
    "rating_text": "Very Good",
    "rating_color": "5BA829",
    "votes": "579",
    "has_fake_reviews": 0
  },
  "photos_url": "https://www.zomato.com/new-york-city/otto-enoteca-pizzeria-greenwich-village/photos?utm_source=api_basic_user&utm_medium=api&utm_campaign=v2.1#tabtop",
  "menu_url": "https://www.zomato.com/new-york-city/otto-enoteca-pizzeria-greenwich-village/menu?utm_source=api_basic_user&utm_medium=api&utm_campaign=v2.1&openSwipeBox=menu&showMinimal=1#tabtop",
  "featured_image": "https://b.zmtcdn.com/data/pictures/8/16774318/b16e382e9f6696f911b600b7e5ca6839.jpg",
  "has_online_delivery": 0,
  "is_delivering_now": 0,
  "has_fake_reviews": 0,
  "include_bogo_offers": true,
  "deeplink": "zomato://restaurant/16774318",
  "is_table_reservation_supported": 0,
  "has_table_booking": 0,
  "events_url": "https://www.zomato.com/new-york-city/otto-enoteca-pizzeria-greenwich-village/events#tabtop?utm_source=api_basic_user&utm_medium=api&utm_campaign=v2.1"
}
*/


class Restaurant extends Model{
    String restruant_Id;
    String restruant_Name;
    location restruant_Location;
    int restruant_Avg_cost_for_two;
    int restruant_Price_range;
    String restruant_Thumb;
    String restruant_Feature_image;
    String restruant_Photo_url;
    String restruant_Menu;
    String restruant_Event_url;
    UserRating restruant_User_rating;
    String restruant_photos_url;
    int restruant_Has_online_delivery;
    int restruant_Is_delivery_now;
    int restruant_Has_table_booking;
    int restruant_Is_table_reservation_supported;
    String restruant_Cuisines;
    String currency;

  // "switch_to_order_menu"
  // "cuisines"
  // "average_cost_for_two"
  // "price_range"
  // "currency"
  // "offers"
  // "opentable_support"
  // "is_zomato_book_res"
  // "mezzo_provider"
  // "is_book_form_web_view"
  // "book_form_web_view_url"
  // "book_again_url"
  // "thumb"
  // "user_rating"
  // "photos_url"
  // "menu_url"
  // "featured_image"
  // "has_online_delivery"
  // "is_delivering_now"
  // "has_fake_reviews"
  // "include_bogo_offers"
  // "deeplink" 
  // "is_table_reservation_supported"
  // "has_table_booking"
  // "events_url"


    Restaurant({this.restruant_Id,
        this.restruant_Name,
        this.restruant_Avg_cost_for_two,
        this.restruant_Price_range,
        this.restruant_Thumb,
        this.restruant_Feature_image,
        this.restruant_Photo_url,
        this.restruant_Menu,
        this.restruant_Event_url,
        this.restruant_Has_online_delivery,
        this.restruant_Is_delivery_now,
        this.restruant_Has_table_booking,
        this.restruant_Is_table_reservation_supported,
        this.restruant_Cuisines,
        this.restruant_Location, this.restruant_photos_url, this.restruant_User_rating,
        this.currency,
    });


    factory Restaurant.fromJson(Map<String, dynamic> json) {
        Map<String,dynamic> loc = json['location'];
        Map<String,dynamic> ur = json['user_rating'];
        Map<String,dynamic> photos = json['photos'];

        location l;
        UserRating u;
        Photos p;

        if(loc != null){
            l = location.fromJson(loc);
            //l.location_print();
        }
        if(ur != null){
            u = UserRating.fromJson(ur);
            //u.urprint();
        }
        if(photos != null){
            p = Photos.fromJson(photos);
            p.photo_print();
        }

        return Restaurant(
            restruant_Id : json['id'],
            restruant_Name : json['name'],
            restruant_Avg_cost_for_two : json['average_cost_for_two'],
            restruant_Price_range : json['price_range'],
            restruant_Thumb: json['thumb'],
            restruant_Feature_image : json['featured_image'],
            restruant_Photo_url : json['photos_url'],
            restruant_Menu : json['menu_url'],
            restruant_Event_url : json['events_url'],
            restruant_Has_online_delivery : json['has_online_delivery'],
            restruant_Is_delivery_now: json['is_delivering_now'],
            restruant_Has_table_booking : json['has_table_booking'],
            restruant_Is_table_reservation_supported: json['is_table_reservation_supported'],
            restruant_Cuisines : json['cuisines'],
            restruant_Location: l,
            currency: json['currency'],
            restruant_User_rating: u,
        );
    }



}