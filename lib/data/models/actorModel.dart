class ActorModel {
  final String name;
  final String image;

  ActorModel({required this.name, required this.image});

  factory ActorModel.fromJson(Map<String, dynamic> json) {
    return ActorModel(
      name: json['name'] ?? 'Unknown',
      image: json['image'] ?? '',
    );
  }

}
