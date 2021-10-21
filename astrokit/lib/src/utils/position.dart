class Position {
  final double latitude;
  final double longitude;
  final String streetNumber;
  final String street;
  final String country;
  final String state;
  final String city;
  final String postalCode;
  String creation = DateTime.now().toString();

  Position(
      {required this.latitude,
      required this.longitude,
      required this.streetNumber,
      required this.street,
      required this.country,
      required this.state,
      required this.city,
      required this.postalCode});

  Position.wthDtm(this.latitude, this.longitude, this.street, this.country,
      this.state, this.city, this.postalCode, this.creation, this.streetNumber);

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position.wthDtm(
        json["latitude"],
        json["longitude"],
        json["street"],
        json["country"],
        json["state"],
        json["city"],
        json["postalCode"],
        json["creation"],
        json["streetNumber"]);
  }

  @override
  String toString() {
    return "$streetNumber $street, $postalCode, $city, $state, $country";
  }

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "streetNumber": streetNumber,
        "street": street,
        "country": country,
        "state": state,
        "city": city,
        "postalCode": postalCode,
        "creation": creation,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is Position && creation == other.creation;
  }

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
}
