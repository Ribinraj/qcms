class QuartersModel {
  final String quarterId;
  final String quarterName;

  QuartersModel({
    required this.quarterId,
    required this.quarterName,
  });

  factory QuartersModel.fromJson(Map<String, dynamic> json) {
    return QuartersModel(
      quarterId: json['quarterId'] ?? '',
      quarterName: json['quarterName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quarterId': quarterId,
      'quarterName': quarterName,
    };
  }
}