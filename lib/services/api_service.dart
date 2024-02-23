import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieflix/models/movie_detail_model.dart';
import 'package:movieflix/models/movie_model.dart';

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String popular = "popular";
  static const String nowplaying = "now-playing";
  static const String comingsoon = "coming-soon";

  static Future<List<MovieModel>> getPopularMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse("$baseUrl/$popular");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)["results"];
      for (var movie in movies) {
        // final mv = MovieModel.fromJson(movie);
        // print(mv);
        movieInstances.add(MovieModel.fromJson(movie));
      }

      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getNowMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse("$baseUrl/$nowplaying");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)["results"];
      for (var movie in movies) {
        // final mv = MovieModel.fromJson(movie);
        // print(mv);
        movieInstances.add(MovieModel.fromJson(movie));
      }

      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getComingMovies() async {
    List<MovieModel> movieInstances = [];

    final url = Uri.parse("$baseUrl/$comingsoon");
    final response = await http.get(url);
    // await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)["results"];
      for (var movie in movies) {
        movieInstances.add(MovieModel.fromJson(movie));
      }
      // print(response.body);
      return movieInstances;
    }
    throw Error();
  }

  static Future<MovieDetailModel> getMovieById(String id) async {
    // List<MovieDetailModel> movieInstances = [];

    final url = Uri.parse("$baseUrl/movie?id=$id");
    final response = await http.get(url);
    // await http.get(url);
    if (response.statusCode == 200) {
      // print("body: ${response.body}");
      final detail = jsonDecode(response.body);
      // print("FF##detail: $detail");
      // print("FF##detail.overview: ${detail["overview"]}");
      return MovieDetailModel.fromJson(detail);
    }
    throw Error();
  }
}
