class LocationModel {
  int? id;
  final String latitude;
  final String longitude;
  final String postalCode;
  final String street;
  final String subLocality;
  final String country;

  LocationModel({
    this.id,
    required this.latitude,
    required this.longitude,
    required this.postalCode,
    required this.street,
    required this.subLocality,
    required this.country,
  });

  static LocationModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int?;
    final latitude = map['latitude'] as String;
    final longitude = map['longitude'] as String;
    final postalCode = map['postalCode'] as String;
    final street = map['street'] as String;
    final subLocality = map['subLocality'] as String;
    final country = map['country'] as String;

    return LocationModel(
      id: id,
      latitude: latitude,
      longitude: longitude,
      postalCode: postalCode,
      street: street,
      subLocality: subLocality,
      country: country,
    );
  }
}
