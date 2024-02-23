class MovieModel {
  final String title, thumb, poster, id;

  // MovieModel({
  //   required this.title,
  //   required this.thumb,
  //   required this.id,
  // });

  MovieModel.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        thumb = json["backdrop_path"],
        poster = json["poster_path"],
        // tagline = json["tagline"],
        id = json["id"].toString();
}
