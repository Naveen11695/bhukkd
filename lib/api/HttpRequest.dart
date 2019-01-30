import 'package:http/http.dart' as http;
// import 'config.json';
// import 'dart:convert';
// import 'dart:async';

String url = "https://developers.zomato.com/api/v2.1/categories";
void jsonRequest() async{
  final requestUrl =  "$url";
  final response= await http.get(Uri.encodeFull(requestUrl), headers: {"user-key":"0bc8d74fdefd3601d84a0d52ffa01901"});
  if(response.statusCode == 200){
    print(response.body);
  }
}


// Post postFromJson(String str) {    
//    final jsonData = json.decode(str);    
//    return Post.fromJson(jsonData);
// }
// factory Post.fromJson(Map<String, dynamic> json){
//    ...
// }

// String url = 'https://jsonplaceholder.typicode.com/posts';

// Future<Post> getPost() async{
//   final response = await http.get('$url/1');
//   return postFromJson(response.body);
// }

// FutureBuilder<Post>(
//     future: getPost(),
//     builder: (context, snapshot) {
//         return Text('${snapshot.data.title}');
//     }
// )


// class ApiRequest{
//   final String api_key;
//   final String restraunt_id;

//   ApiRequest(this.api_key, this.restraunt_id);

//   factory ApiRequest.formJson(Map<String, dynamic> json){
//     return ApiRequest(
//       restraunt_id:json['res_id'],
      
//     );
//   }
// }