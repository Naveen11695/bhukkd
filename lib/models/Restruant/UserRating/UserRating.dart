class UserRating {
  var aggregate_rating;
  String rating_text;
  String rating_color;
  var votes;

  UserRating({this.aggregate_rating, this.rating_text, this.rating_color,
      this.votes});



  factory UserRating.fromJson(var parsedJson){
    return UserRating(
      aggregate_rating: parsedJson['aggregate_rating'],
      rating_text: parsedJson['rating_text'],
      rating_color: parsedJson ['rating_color'],
      votes: parsedJson['votes'],
    );
  }

}