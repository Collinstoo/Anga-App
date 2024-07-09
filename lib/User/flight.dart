class Flight {
  final String id; // Add id property
  final String airline;
  final String flightNumber;
  final String departureAirport;
  final String arrivalAirport;
  final String departureTime;
  final String arrivalTime;
  final double price;

  Flight({
    required this.id,
    required this.airline,
    required this.flightNumber,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      id: json['id'], // Initialize id from JSON
      airline: json['airline'],
      flightNumber: json['flightNumber'],
      departureAirport: json['departureAirport'],
      arrivalAirport: json['arrivalAirport'],
      departureTime: json['departureTime'],
      arrivalTime: json['arrivalTime'],
      price: json['price'].toDouble(),
    );
  }
}
