import 'package:scoped_model/scoped_model.dart';
import '../Popularity/Popularity.dart';
import '../Locations/Locations.dart';
import '../GeoCodeInfo/NearByRestaurants/NearByRestaurants.dart';

class LocationDetails extends Model{

    Popularity popularity;
    Locations locationsApi;
    int num_restaurant;
    List<NearByRestaurants> best_rated_restaurant;


    LocationDetails({this.best_rated_restaurant, this.locationsApi, this.num_restaurant, this.popularity});
    

    factory LocationDetails.fromJson(){
      return null;
    }
}
