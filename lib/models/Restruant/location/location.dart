class location {
  String address;
  String locality;
  String city;
  String latitude;
  String longitude;
  String zipcode;
  int country_id;
  String locality_verbose;

  location({this.address,
    this.locality,
    this.city,
    this.latitude,
    this.longitude,
    this.zipcode,
    this.country_id,
    this.locality_verbose});

  factory location.fromJson(var parsedJson) {
    return location(
      address: parsedJson['address'],
      locality: parsedJson['locality'],
      city: parsedJson['city'],
      latitude: parsedJson['latitude'],
      longitude: parsedJson['longitude'],
      zipcode: parsedJson['zipcode'],
      country_id: parsedJson['country_id'],
      locality_verbose: parsedJson['locality_verbose'],
    );
  }
}
