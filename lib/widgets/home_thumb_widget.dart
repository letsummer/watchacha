import 'package:flutter/material.dart';
import 'package:movieflix/models/movie_model.dart';

class HomeThumb extends StatelessWidget {
  final String title;
  final double fontSize;
  final FutureBuilder<List<MovieModel>> futureBuilder;

  const HomeThumb({
    super.key,
    required this.title,
    required this.fontSize,
    required this.futureBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).textTheme.displayLarge!.color,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          futureBuilder,
        ],
      ),
    );
  }
}
