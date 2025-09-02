import 'package:flutter/material.dart';
import 'package:movie_plex/data/models/movie_model.dart';

class PosterWidget extends StatelessWidget {
  final Movie_Model items;
  bool highlight;
  final int index;
  PosterWidget({super.key, required this.index, required this.items, required this.highlight});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Hero(
          tag: items.img,
          child: GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) =>
              //           DetailScreen(itme: items, actorslist: items.actorList),
              //     ));
            },
            child: Container(
              height: h * 0.50,
              width: w * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(image: AssetImage(items.img), fit: BoxFit.fill),
              ),
            ),
          ),
        ),
        SizedBox(height: h * 0.03),
        Text(
          items.title,
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 2,
            color: Color.fromARGB(255, 205, 137, 42),
          ),
        ),
        const SizedBox(height: 0.03),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Genre: ',
              style: textTheme.headlineMedium?.copyWith(fontSize: 15, letterSpacing: 2),
            ),
            Text(items.genre, style: textTheme.bodyMedium?.copyWith(fontSize: 14)),
          ],
        ),
      ],
    );
  }
}
