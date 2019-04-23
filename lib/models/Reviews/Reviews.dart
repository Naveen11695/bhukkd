import 'package:scoped_model/scoped_model.dart';

/* "reviews_count": 5,
  "reviews_start": 0,
  "reviews_shown": 5,
  "user_reviews": [
    {
      "review": {
        "rating": 4,
        "review_text": "Do you know that Departure Lounge has recently just converted its café at Solaris Mont Kiara to a new restaurant called Wanderlust? The dep...",
        "id": 25342639,
        "rating_color": "5BA829",
        "review_time_friendly": "Mar 29, 2015",
        "rating_text": "Great!",
        "timestamp": 1427567400,
        "likes": 6,
        "user": {
          "name": "AppleFoodees",
          "foodie_level": "Big Foodie",
          "foodie_level_num": 6,
          "foodie_color": "ffae4f",
          "profile_url": "https://www.zomato.com/users/applefoodees-16061101?utm_source=api_basic_user&utm_medium=api&utm_campaign=v2.1",
          "profile_image": "https://b.zmtcdn.com/data/user_profile_pictures/663/838613a4ec1917659361603370f37663.jpg?fit=around%7C100%3A100&crop=100%3A100%3B%2A%2C%2A",
          "profile_deeplink": "zomato://u/16061101"
        },
        "comments_count": 0
      }
    },
 */

class Reviews extends Model {
  int reviews_count;
  int reviews_start;
  int reviews_shown;
  List<UserReviews> user_reviews;

  Reviews({this.user_reviews, this.reviews_count, this.reviews_shown, this.reviews_start});

  factory Reviews.fromJson(Map<String, dynamic> json){
    //print(json['user_reviews']);
    var listOfReviews = json['user_reviews'] as List;
    List<UserReviews> user_review;
    if(listOfReviews!=null){
      user_review = listOfReviews.map((review)=>UserReviews.fromJson(review)).toList();
    }
    return Reviews(
      reviews_count: json['reviews_count'],
      reviews_shown: json['reviews_shown'],
      reviews_start: json['reviews_start'],
      user_reviews: user_review
    );
  }
}

class UserReviews extends Model {
  Review review;
  UserReviews({this.review});

  factory UserReviews.fromJson(Map<String, dynamic> json){
    Review r = Review.fromJson(json['review']);
    return UserReviews(
      review: r,
    );
  }
}

class Review extends Model {
  int rating;
  String review_text;
  int id;
  String rating_color;
  String review_time_friendly;
  String rating_text;
  int timestamp;
  int likes;
  User user;
  int comments_count;

  Review({this.comments_count, this.id, this.likes, this.rating, this.rating_color, this.rating_text, this.review_text, this.review_time_friendly, this.timestamp, this.user});

  factory Review.fromJson(Map<String, dynamic> json){

    User u = User.fromJson(json['user']);

    return Review(
      comments_count: json['comments_count'],
      id: json['id'],
      likes: json['likes'], 
      rating: json['rating'], 
      rating_color: json['rating_color'],
      rating_text: json['rating_text'],
      review_text: json['review_text'],
      review_time_friendly: json['review_time_friendly'],
      timestamp: json['timestamp'],
      user: u,
    );
  }
}

class User extends Model {
  String name;
  String foodie_level;
  int foodie_level_num;
  String foodie_color;
  String profile_url;
  String profile_image;
  String profile_deeplink;

  User({this.foodie_color, this.foodie_level, this.foodie_level_num, this.name, this.profile_deeplink, this.profile_image, this.profile_url});


  factory User.fromJson(Map<String, dynamic> json){
    return User(
      foodie_color: json['foodie_color'],
      foodie_level: json['foodie_level'], 
      foodie_level_num: json['foodie_level_num'],
      name: json['name'], 
      profile_deeplink: json['profile_deeplink'],
      profile_image: json['profile_image'], 
      profile_url: json['profile_url']
    );
  }
}
