import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movieflix/models/movie_detail_model.dart';
import 'package:movieflix/services/api_service.dart';
import 'package:movieflix/widgets/button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  static const _wishedWatch = "wishedWatch";
  late Future<MovieDetailModel> detail;
  late SharedPreferences wishWatch;
  bool isWished = false;

  Future initWish() async {
    wishWatch = await SharedPreferences.getInstance();
    final wishedWatchList = wishWatch.getStringList(_wishedWatch);

    if (wishedWatchList != null) {
      if (wishedWatchList.contains(widget.id) == true) {
        setState(() {
          isWished = true;
        });
      }
    } else {
      await wishWatch.setStringList(_wishedWatch, []);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detail = ApiService.getMovieById(widget.id);
    initWish();
  }

  onWishTap() async {
    final wishedWatchList = wishWatch.getStringList(_wishedWatch);
    if (wishedWatchList != null) {
      if (isWished) {
        wishedWatchList.remove(widget.id);
      } else {
        wishedWatchList.add(widget.id);
      }
      await wishWatch.setStringList(_wishedWatch, wishedWatchList);
      setState(() {
        isWished = !isWished;
      });
      // print("on wish Tap!!");
    }
  }

  onButton() async {
    final url = Uri.parse("https://www.themoviedb.org/movie/${widget.id}");
    await launchUrl(url);
    print("url: $url");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).textTheme.displayLarge!.color,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              FutureBuilder(
                future: detail,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      width: 500,
                      child: Image.network(
                          fit: BoxFit.cover,
                          "https://image.tmdb.org/t/p/w300${snapshot.data!.screenshot}"),
                    );
                  }
                  return Container(
                    width: 500,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(0.8),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 8,
                child: Container(
                  width: 500,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 40,
                        spreadRadius: 25,
                        offset: Offset(0, 20),
                      ),
                    ],
                  ),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.displayLarge!.color,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: detail,
            builder: (context, snapshot) {
              // print("detail: $detail");
              if (snapshot.hasData) {
                // print("snapshot.data: ${snapshot.data}");
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // const Text("15세 이용가"),
                        Text(
                          "평균 ${snapshot.data!.voteAverage} ",
                          style: const TextStyle(
                            color: Colors.amber,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          snapshot.data!.releasedYear.substring(0, 4),
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < snapshot.data!.genres.length; i++)
                          if (i < snapshot.data!.genres.length - 1)
                            Text(
                              "${snapshot.data!.genres[i]["name"]} | ",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .color,
                              ),
                            )
                          else
                            Text(
                              "${snapshot.data!.genres[i]["name"]}",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .color,
                              ),
                            )
                      ],
                    ),
                  ],
                );
              }
              return const Text("...");
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: GestureDetector(
              onTap: onButton,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.play_arrow,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    Text(
                      "감상하기",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                  func: onWishTap,
                  name: "보고싶어요",
                  defaultIcon: Icons.add,
                  checkedIcon: Icons.check,
                  isChecked: isWished,
                ),
                Button(
                  func: () {},
                  name: "평가하기",
                  defaultIcon: Icons.star_border,
                  checkedIcon: Icons.star_border,
                  isChecked: false,
                ),
                Button(
                  func: () {},
                  name: "왓챠파티",
                  defaultIcon: Icons.chat,
                  checkedIcon: Icons.chat,
                  isChecked: false,
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: detail,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data!.overview,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge!.color,
                  ),
                );
              }
              return const Text("...");
            },
          ),
        ],
      ),
    );
  }
}
