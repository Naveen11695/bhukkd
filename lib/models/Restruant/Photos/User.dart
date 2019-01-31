class User {
  String name;
  String zomato_handle;
  String foodie_level;
  String foodie_level_num;
  String foodie_color;
  String profile_url;
  String profile_deeplink;
  String profile_image;

  User({this.name, this.zomato_handle, this.foodie_level, this.foodie_level_num,
      this.foodie_color, this.profile_url, this.profile_deeplink,
      this.profile_image});

  void urserprint() {
    print("..............................user: $name");
  }

  factory User.fromJson(Map<String, dynamic> parsedJson){
    return User(
      name: parsedJson['name'],
      zomato_handle: parsedJson['zomato_handle'],
      foodie_level: parsedJson ['foodie_level'],
      foodie_level_num: parsedJson['foodie_level_num'],
      profile_url: parsedJson['profile_url'],
      profile_deeplink: parsedJson ['profile_deeplink'],
      profile_image: parsedJson['profile_image'],
    );
  }


}