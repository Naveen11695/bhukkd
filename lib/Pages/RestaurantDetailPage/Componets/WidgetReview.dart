import 'package:bhukkd/Constants/app_constant.dart';
import 'package:bhukkd/Pages/TrendingPage/Componets/CustomHorizontalScroll.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget buildReviews(AsyncSnapshot snapShot, double c_width) {
  return ListView.separated(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: ((snapShot.data.reviews_count > 5)
        ? 5
        : snapShot.data.user_reviews.length),
    separatorBuilder: (BuildContext context, int index) {
      return Divider(
        color: Colors.black54,
      );
    },
    itemBuilder: (BuildContext context, int index) {
      return Card(
        elevation: 5,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(5.0, 5.0),
                        blurRadius: 5)
                  ],
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: snapShot
                        .data.user_reviews[index].review.user.profile_image,
                    fit: BoxFit.fitHeight,
                    height: MediaQuery.of(context).size.height * 0.14,
                    placeholder: (context, url) => Image.asset(
                      "assets/images/icons/default_userImage.png",
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              snapShot
                                  .data.user_reviews[index].review.user.name,
                              textAlign: TextAlign.justify,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: TEXT_PRIMARY_COLOR,
                                fontFamily: FONT_TEXT_EXTRA,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        snapShot.data.user_reviews[index].review.review_text
                                    .toString()
                                    .length ==
                                0
                            ? "Great."
                            : snapShot
                                .data.user_reviews[index].review.review_text,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: FONT_TEXT_SECONDARY,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ),
                    getStarWidgets(snapShot
                        .data.user_reviews[index].review.rating
                        .toString()),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Text(
                                      snapShot
                                          .data.user_reviews[index].review.likes
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontFamily: FONT_TEXT_SECONDARY,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Icon(FontAwesomeIcons.thumbsUp),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Text(
                                      "0",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontFamily: FONT_TEXT_SECONDARY,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Icon(FontAwesomeIcons.thumbsDown),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Text(
                                      snapShot.data.user_reviews[index].review
                                          .comments_count
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontFamily: FONT_TEXT_SECONDARY,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Icon(FontAwesomeIcons.comment),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  snapShot.data.user_reviews[index].review.review_time_friendly,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: FONT_TEXT_SECONDARY,
                    fontWeight: FontWeight.w200,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget buildRatingWaiting(double c_width) {
  return Container(
    height: 10,
    width: 10,
  );
}
