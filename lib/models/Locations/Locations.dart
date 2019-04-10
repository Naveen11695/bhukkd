

class Locations{
  String entity_type;
  int entity_id;
  String title;
  double latitude;
  double longitude;
  int city_id;
  String city_name;
  int country_id;
  String country_name;

  String get entityType{
    return entity_type;
  }

  int get entityId{
    return entity_id;
  }
  
  
  Locations({this.city_id, this.city_name, this.country_id, this.country_name,this.entity_id, this.entity_type, this.latitude, this.longitude, this.title});

}