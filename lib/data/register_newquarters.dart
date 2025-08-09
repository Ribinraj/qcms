class RegisterNewquartersModel {
  final int cityId;
  final int quarterId;
  final String quarterNo;
  final String quarterType;
  final String quarterRoofType;
  final String quarterStatus;
  final String occupantName;
  final String occupantMobile;
  final String occupantDesignation;

  RegisterNewquartersModel({
    required this.cityId,
    required this.quarterId,
    required this.quarterNo,
    required this.quarterType,
    required this.quarterRoofType,
    required this.quarterStatus,
    required this.occupantName,
    required this.occupantMobile,
    required this.occupantDesignation,
  });

  Map<String, dynamic> toJson() {
    return {
      "cityId": cityId,
      "quarterId": quarterId,
      "quarterNo": quarterNo,
      "quarterType": quarterType,
      "quarterRoofType": quarterRoofType,
      "quarterStatus": quarterStatus,
      "occupantName": occupantName,
      "occupantMobile": occupantMobile,
      "occupantDesignation": occupantDesignation,
    };
  }
}
