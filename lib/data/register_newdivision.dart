class RegisterNewdivisionModel {
  final String divisionName;
  final String quartersName;
  final String occupantName;
  final String occupantMobile;

  RegisterNewdivisionModel({
    required this.divisionName,
    required this.quartersName,
    required this.occupantName,
    required this.occupantMobile,
  });

  // Convert Dart object to JSON
  Map<String, dynamic> toJson() {
    return {
      'divisionName': divisionName,
      'quartersName': quartersName,
      'occupantName': occupantName,
      'occupantMobile': occupantMobile,
    };
  }

  // (Optional) Create Dart object from JSON
  factory RegisterNewdivisionModel.fromJson(Map<String, dynamic> json) {
    return RegisterNewdivisionModel(
      divisionName: json['divisionName'],
      quartersName: json['quartersName'],
      occupantName: json['occupantName'],
      occupantMobile: json['occupantMobile'],
    );
  }
}
