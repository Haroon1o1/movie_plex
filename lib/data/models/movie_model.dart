import 'package:movie_plex/data/models/actorModel.dart';

class MovieModel {
  final String img;
  final String id;
  final String title;
  final String videoLink;
  final List<String> genre;
  final List<String> images;
  final String description;
  final String rating;
  final String duration;
  final int price;
  final List<ActorModel> actorList;
  final Map<String, Map<String, List<String>>> dates; // added dates

  MovieModel({
    required this.img,
    required this.id,
    required this.title,
    required this.videoLink,
    required this.genre,
    required this.images,
    required this.description,
    required this.rating,
    required this.duration,
    required this.price,
    required this.actorList,
    required this.dates, // add to constructor
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    var actorsJson = json['actorList'] as List<dynamic>? ?? [];
    List<ActorModel> actors =
        actorsJson.map((a) => ActorModel.fromJson(a)).toList();

    // Parse dates
    Map<String, Map<String, List<String>>> parsedDates = {};
    if (json['dates'] != null) {
      json['dates'].forEach((key, value) {
        parsedDates[key] = {};
        (value as Map<String, dynamic>).forEach((date, times) {
          parsedDates[key]![date] = List<String>.from(times);
        });
      });
    }

    return MovieModel(
      img: json['img'] ?? '',
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      videoLink: json['videoLink'] ?? '',
      genre: List<String>.from(json['genre'] ?? []),
      images: List<String>.from(json['images'] ?? []),
      description: json['description'] ?? '',
      rating: json['rating'] ?? '',
      duration: json['duration'] ?? '',
      price: json['price'] ?? 0,
      actorList: actors,
      dates: parsedDates,
    );
  }
}
