  import 'package:http/http.dart' as http;
  import 'package:dio/dio.dart';
  import 'dart:io';
  
Future<http.Response> handleLogin(String username, String password){
  String query = "?username=$username&password=$password";
  String url = "http://serene-beach-48273.herokuapp.com/api/login$query";
  return http.get(url);
}

Future<http.Response> fetchPosts(String token){
  String url = "http://serene-beach-48273.herokuapp.com/api/v1/posts";
  return http.get(url, headers: {'Authorization': 'Bearer $token'});
}
Future<http.Response> fetchUser(String token, String id){
  String url = "http://serene-beach-48273.herokuapp.com/api/v1/users/$id";
  return http.get(url, headers: {'Authorization': 'Bearer $token'});
}

Future<http.Response> likePost(String token, int id, bool liked){
  String url = "http://serene-beach-48273.herokuapp.com/api/v1/posts/$id/likes";
  if(liked)
    return http.delete(url, headers: {'Authorization': 'Bearer $token'});
  
  return http.post(url, headers: {'Authorization': 'Bearer $token'});
}

Future<http.Response> fetchAccount(String token){
  String url = "http://serene-beach-48273.herokuapp.com/api/v1/my_account";
  return http.get(url, headers: {'Authorization': 'Bearer $token'});
}

Future<http.Response> fetchProfile(String token, int id){
  String url = "http://serene-beach-48273.herokuapp.com/api/v1/users/$id";
  return http.get(url, headers: {'Authorization': 'Bearer $token'});
}

Future<http.Response> fetchUserPosts(String token, int id){
  String url = "http://serene-beach-48273.herokuapp.com/api/v1/users/$id/posts";
  return http.get(url, headers: {'Authorization': 'Bearer $token'});
}

Future<http.Response> fetchComments(String token, int id){
  String url = "http://serene-beach-48273.herokuapp.com/api/v1/posts/$id/comments";
  return http.get(url, headers: {'Authorization': 'Bearer $token'});
}

Future<http.Response> fetchLikes(String token, int id){
  String url = "http://serene-beach-48273.herokuapp.com/api/v1/posts/$id/likes";
  return http.get(url, headers: {'Authorization': 'Bearer $token'});
}

Future<http.Response> commentPost(String token, int id, String text){
  String url = "http://serene-beach-48273.herokuapp.com/api/v1/posts/$id/comments?text=$text";  
  return http.post(url, headers: {'Authorization': 'Bearer $token'});
}

Future<Response> postPost(String token, var image, String caption){
  String url = "http://serene-beach-48273.herokuapp.com/api/v1/posts";  
  FormData fr = FormData();
  fr.add('image', UploadFileInfo(image, image.path));
  fr.add('caption', caption);
  return Dio().post(url, data:fr, options: Options(headers: {'Authorization': 'Bearer $token'}));
}

Future<Response> patchProfileImage(String token, File image){
  String url = "http://serene-beach-48273.herokuapp.com/api/v1/my_account/profile_image";  
  FormData fr = FormData();
  fr.add('image', UploadFileInfo(image, image.path));
  return Dio().patch(url, data:fr, options: Options(headers: {'Authorization': 'Bearer $token'}));
}

Future<http.Response> patchBio(String token, String bio){
  String url = "http://serene-beach-48273.herokuapp.com/api/v1/my_account?bio=$bio";
  return http.patch(url, headers: {'Authorization': 'Bearer $token'});
}