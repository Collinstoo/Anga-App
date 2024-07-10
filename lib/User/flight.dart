class Flight {
  int airplaneId;
  String arrivalAirport;
  String arrivalAirportName;
  String arrivalCity;
  String arrivalCountry;
  DateTime arrivalDateTime;
  int capacity;
  String departureAirport;
  String departureAirportName;
  String departureCity;
  String departureCountry;
  DateTime departureDateTime;
  int flightId;
  String flightNumber;
  double price;

  Flight({
    required this.airplaneId,
    required this.arrivalAirport,
    required this.arrivalAirportName,
    required this.arrivalCity,
    required this.arrivalCountry,
    required this.arrivalDateTime,
    required this.capacity,
    required this.departureAirport,
    required this.departureAirportName,
    required this.departureCity,
    required this.departureCountry,
    required this.departureDateTime,
    required this.flightId,
    required this.flightNumber,
    required this.price,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      airplaneId: json['airplane_id'],
      arrivalAirport: json['arrival_airport'],
      arrivalAirportName: json['arrival_airport_name'],
      arrivalCity: json['arrival_city'],
      arrivalCountry: json['arrival_country'],
      arrivalDateTime: DateTime.parse(json['arrival_date_time']),
      capacity: json['capacity'],
      departureAirport: json['departure_airport'],
      departureAirportName: json['departure_airport_name'],
      departureCity: json['departure_city'],
      departureCountry: json['departure_country'],
      departureDateTime: DateTime.parse(json['departure_date_time']),
      flightId: json['flight_id'],
      flightNumber: json['flight_number'],
      price: json['price'].toDouble(),
    );
  }


}