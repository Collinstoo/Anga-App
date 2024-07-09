class Flight {
  final String airline;
  final String flightNumber;
  final String departureTime;
  final String arrivalTime;
  final double price;

  Flight({
    required this.airline,
    required this.flightNumber,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      airline: json['airline'] ?? '',
      flightNumber: json['flightNumber'] ?? '',
      departureTime: json['departureTime'] ?? '',
      arrivalTime: json['arrivalTime'] ?? '',
      price: json['price'] != null ? double.parse(json['price'].toString()) : 0.0,
    );
  }
}
