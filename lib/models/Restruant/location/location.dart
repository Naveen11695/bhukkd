class location {
  String address;
  String locality;
  String city;
  String latitude;
  String longitude;
  String zipcode;
  int country_id;
  String locality_verbose;


  location({this.address, this.locality, this.city, this.latitude,
    this.longitude, this.zipcode, this.country_id, this.locality_verbose});

  void  location_print() {
    print(".......................location.......................");
        print("address: "+ address);
        print("locality: "+ locality);
        print("city: "+ city);
        print("latitude: "+ latitude);
        print("longitude: "+ longitude);
        print("zipcode: "+ zipcode);
        print("country_id: "+ country_id.toString());
        print("locality_verbose: "+locality_verbose);
    print(".......................location.......................");
  }

  factory location.fromJson(Map<String, dynamic> parsedJson){
    return location(
      address: parsedJson['address'],
      locality: parsedJson['locality'],
      city: parsedJson ['city'],
      latitude: parsedJson['latitude'],
      longitude: parsedJson ['longitude'],
      zipcode: parsedJson['zipcode'],
      country_id: parsedJson['country_id'],
      locality_verbose: parsedJson['locality_verbose'],
    );
  }
}
