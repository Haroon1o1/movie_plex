class TicketModel {
  final String movieId;
  final String userName;
  final String phone;
  final DateTime createdDate;
  final String seatNumber;
  final bool paid;
  final double price;
  final DateTime movie_time; // parsed from string

  TicketModel({
    required this.movieId,
    required this.userName,
    required this.phone,
    required this.createdDate,
    required this.seatNumber,
    required this.paid,
    required this.price,
    required this.movie_time,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      movieId: json['movie_id'],
      userName: json['user_name'],
      phone: json['phone'],
      createdDate: DateTime.parse(json['created_date']),
      seatNumber: json['seat_number'],
      paid: json['paid'],
      price: (json['price'] as num).toDouble(),
      movie_time: DateTime.parse(json['movie_time']), // ✅ parse string
    );
  }
}
