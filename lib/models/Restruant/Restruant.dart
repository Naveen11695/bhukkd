import 'package:scoped_model/scoped_model.dart';
import 'package:bhukkd/models/Restruant/location/location.dart';
import 'package:bhukkd/models/Restruant/UserRating/UserRating.dart';
import 'package:bhukkd/models/Restruant/Photos/Photos.dart';

class Restaurant extends Model{
    String restruant_Id;
    String restruant_Name;
    List<dynamic> restruant_Location;
    int restruant_Avg_cost_for_two;
    int restruant_Price_range;
    String restruant_Thumb;
    String restruant_Feature_image;
    String restruant_Photo_url;
    String restruant_Menu;
    String restruant_Event_url;
    List<String> restruant_User_rating;
    String restruant_photos_url;
    int restruant_Has_online_delivery;
    int restruant_Is_delivery_now;
    int restruant_Has_table_booking;
    int restruant_Is_table_reservation_supported;
    String restruant_Cuisines;
    List<Photos> restruant_Photos;


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
        this.restruant_Photos, this.restruant_Location, this.restruant_photos_url, this.restruant_User_rating
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
            restruant_Id : json['res_id'],
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
        );
    }


    void print_res() {

        print(".......................Restruant.......................");
            print("restruant_Name: " + this.restruant_Name);
            print("restruant_Avg_cost_for_two: " + this.restruant_Avg_cost_for_two.toString());
            print("restruant_Price_range: " + this.restruant_Price_range.toString());
            print("restruant_Thumb: " + this.restruant_Thumb);
            print("restruant_Feature_image: " + this.restruant_Feature_image);
            print("restruant_Photo_url: " + this.restruant_Photo_url);
            print("restruant_Menu: " + this.restruant_Menu);
            print("restruant_Event_url: " + this.restruant_Event_url);
            print("restruant_Has_online_delivery: " + this.restruant_Has_online_delivery.toString());
            print("restruant_Is_delivery_now: " + this.restruant_Is_delivery_now.toString());
            print("restruant_Has_table_booking: " + this.restruant_Has_table_booking.toString());
            print("restruant_Is_table_reservation_supported: " + this.restruant_Is_table_reservation_supported.toString());
            print("restruant_Cuisines: " + this.restruant_Cuisines);
        print(".......................Restruant.......................");
    }

}