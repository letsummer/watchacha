import 'package:flutter/material.dart';
import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/screens/detail_screen.dart';

class HomeListview extends StatelessWidget {
  final double thumbWidth;
  final bool usePoster;
  final AsyncSnapshot<List<MovieModel>> snapshot;

  const HomeListview({
    super.key,
    required this.thumbWidth,
    required this.usePoster,
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      // shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var movie = snapshot.data![index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  title: movie.title,
                  thumb: movie.thumb,
                  id: movie.id,
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: thumbWidth,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                      fit: BoxFit.cover,
                      "https://image.tmdb.org/t/p/w300${usePoster ? movie.poster : movie.thumb}"),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 20,
      ),
    );
  }
}
