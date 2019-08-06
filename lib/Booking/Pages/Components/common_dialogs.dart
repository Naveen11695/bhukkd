import 'package:bhukkd/Constants/app_constant.dart';
import 'package:flutter/material.dart';

fetchApiResult(BuildContext context, NetworkServiceResponse snapshot) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(Error),
      content: Text(snapshot.message),
      actions: <Widget>[
        FlatButton(
          child: Text(OK),
          onPressed: () => Navigator.pop(context),
        )
      ],
    ),
  );
}

class NetworkServiceResponse<T> {
  T content;
  bool success;
  String message;

  NetworkServiceResponse({this.content, this.success, this.message});
}

class MappedNetworkServiceResponse<T> {
  dynamic mappedResult;
  NetworkServiceResponse<T> networkServiceResponse;

  MappedNetworkServiceResponse(
      {this.mappedResult, this.networkServiceResponse});
}

showSuccess(BuildContext context, String message, IconData icon) {
  showDialog(
      context: context,
      builder: (context) => Center(
            child: Material(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.black,
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.green,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      message,
                      style: TextStyle(
                          fontFamily: FONT_TEXT_PRIMARY, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ));
}

showProgress(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.yellow,
            ),
          ));
}

hideProgress(BuildContext context) {
  Navigator.pop(context);
}
