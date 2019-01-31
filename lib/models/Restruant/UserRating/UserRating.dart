class UserRating {
  String aggregate_rating;
  String rating_text;
  String rating_color;
  String votes;

  UserRating({this.aggregate_rating, this.rating_text, this.rating_color,
      this.votes});

  void urprint() {
    print(".......................UserRating.......................");
    print("aggregate_rating: "+ aggregate_rating);
    print("rating_text: "+ rating_text);
    print("rating_color: "+ rating_color);
    print("votes: "+ votes);
    print(".......................UserRating.......................");
  }

  factory UserRating.fromJson(Map<String, dynamic> parsedJson){
    return UserRating(
      aggregate_rating: parsedJson['aggregate_rating'],
      rating_text: parsedJson['rating_text'],
      rating_color: parsedJson ['rating_color'],
      votes: parsedJson['votes'],
    );
  }

}