// nearby restaurants provided by geocode

import '../NearByRestaurants/Restaurants.dart/Restaurants.dart';

class NearByRestaurants{
  // List<Restaurants> restaurants;
  

  NearByRestaurants.fromJson(Map<String, dynamic>jsonParsed){
    Map<String, dynamic> rest=jsonParsed["restaurant"];
    
    if(rest!=null){
      Restaurants.fromJson(rest);
    }
  }
}