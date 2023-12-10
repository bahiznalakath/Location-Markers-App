class LocationModel {
  int? id;
  String latitude;
  String longitude;
  String postalCode;
  String street;
  String subLocality;
  String country;

  LocationModel({
    this.id,
    required this.latitude,
    required this.longitude,
    required this.postalCode,
    required this.street,
    required this.subLocality,
    required this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id?.toString(),
      'latitude': latitude,
      'longitude': longitude,
      'postalCode': postalCode,
      'street': street,
      'subLocality': subLocality,
      'country': country,
    };
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] != null ? int.parse(json['id']) : null,
      latitude: json['latitude'],
      longitude: json['longitude'],
      postalCode: json['postalCode'],
      street: json['street'],
      subLocality: json['subLocality'],
      country: json['country'],
    );
  }

  LocationModel copyWith({
    int? id,
    String? latitude,
    String? longitude,
    String? postalCode,
    String? street,
    String? subLocality,
    String? country,
  }) {
    return LocationModel(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      postalCode: postalCode ?? this.postalCode,
      street: street ?? this.street,
      subLocality: subLocality ?? this.subLocality,
      country: country ?? this.country,
    );
  }
}
