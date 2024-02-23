import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/services/api_service.dart';
import 'package:movieflix/widgets/home_listview_widget.dart';
import 'package:movieflix/widgets/home_thumb_widget.dart';

class HomeScreen extends StatelessWidget {
  // List<MovieModel> popularMovies = [];
  HomeScreen({super.key});

  Future<List<MovieModel>> popularMovies = ApiService.getPopularMovies();
  Future<List<MovieModel>> nowMovies = ApiService.getNowMovies();
  Future<List<MovieModel>> comingMovies = ApiService.getComingMovies();

  @override
  Widget build(BuildContext context) {
    // print(movies);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.pink,
        title: const Text(
          "Watchacha!",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HomeThumb(
                title: "실시간 인기",
                fontSize: 28,
                futureBuilder: FutureBuilder(
                  future: popularMovies, //이거
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: makePolularMovieList(snapshot), //이거
                      );
                    }
                    return const Text("loading...");
                  },
                ),
              ),
              HomeThumb(
                title: "현재 상영작",
                fontSize: 28,
                futureBuilder: FutureBuilder(
                  future: nowMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: makeNowMovieList(snapshot), //이거
                      );
                    }
                    return const Text("loading...");
                  },
                ),
              ),
              HomeThumb(
                title: "개봉 예정작",
                fontSize: 28,
                futureBuilder: FutureBuilder(
                  future: comingMovies, //이거
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: makeNowMovieList(snapshot), //이거
                      );
                    }
                    return const Text("loading...");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  HomeListview makePolularMovieList(AsyncSnapshot<List<MovieModel>> snapshot) {
    return HomeListview(
      thumbWidth: 370,
      snapshot: snapshot,
      usePoster: false,
    );
  }

  HomeListview makeNowMovieList(AsyncSnapshot<List<MovieModel>> snapshot) {
    return HomeListview(
      thumbWidth: 150,
      snapshot: snapshot,
      usePoster: true,
    );
  }

  HomeListview makeComingMovieList(AsyncSnapshot<List<MovieModel>> snapshot) {
    return HomeListview(
      thumbWidth: 150,
      snapshot: snapshot,
      usePoster: true,
    );
  }
}
