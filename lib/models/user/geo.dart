class Geo {
  String? lat;
  String? lng;

  Geo(this.lat, this.lng);

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(
      json['lat'],
      json['lng'],
    );
  }

  Geo copyWith({
    String? lat,
    String? lng,
  }) {
    return Geo(
      lat ?? this.lat,
      lng ?? this.lng,
    );
  }
}
