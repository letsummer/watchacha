class MovieDetailModel {
  final String title, overview, voteAverage, releasedYear, tagline, screenshot;
  final List genres;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        overview = json["overview"],
        releasedYear = json["release_date"],
        voteAverage = (json["vote_average"] / 2).toStringAsFixed(1),
        tagline = json["tagline"],
        screenshot = json["backdrop_path"],
        genres = json["genres"];
}
