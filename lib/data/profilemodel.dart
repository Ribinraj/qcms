class Profilemodel {
  final String flatId;
  final String quarterId;
  final String quarterNo;
  final String quarterType;
  final String quarterRoofType;
  final String quarterStatus;
  final String occupantName;
  final String occupantMobile;
  final String occupantDesignation;
  final String dateOfOccupation;
  final String dateOfVacation;
  final String verifyOtp;
  final String poolOfQuarters;
  final String quartersStatus;
  final String enrollmentStatus;
  final String pushToken;
  final String constructionDate;
  final String additionalInfo;
  final String lastModified;

  Profilemodel({
    required this.flatId,
    required this.quarterId,
    required this.quarterNo,
    required this.quarterType,
    required this.quarterRoofType,
    required this.quarterStatus,
    required this.occupantName,
    required this.occupantMobile,
    required this.occupantDesignation,
    required this.dateOfOccupation,
    required this.dateOfVacation,
    required this.verifyOtp,
    required this.poolOfQuarters,
    required this.quartersStatus,
    required this.enrollmentStatus,
    required this.pushToken,
    required this.constructionDate,
    required this.additionalInfo,
    required this.lastModified,
  });

  factory Profilemodel.fromJson(Map<String, dynamic> json) {
    return Profilemodel(
      flatId: json['flatId'] ?? "",
      quarterId: json['quarterId'] ?? "",
      quarterNo: json['quarterNo'] ?? "",
      quarterType: json['quarterType'] ?? "",
      quarterRoofType: json['quarterRoofType'] ?? "",
      quarterStatus: json['quarterStatus'] ?? "",
      occupantName: json['occupantName'] ?? "",
      occupantMobile: json['occupantMobile'] ?? "",
      occupantDesignation: json['occupantDesignation'] ?? "",
      dateOfOccupation: json['dateOfOccupation'] ?? "",
      dateOfVacation: json['dateOfVacation'] ?? "",
      verifyOtp: json['verifyOtp'] ?? "",
      poolOfQuarters: json['poolOfQuarters'] ?? "",
      quartersStatus: json['quartersStatus'] ?? "",
      enrollmentStatus: json['enrollmentStatus'] ?? "",
      pushToken: json['pushToken'] ?? "",
      constructionDate: json['constructionDate'] ?? "",
      additionalInfo: json['additionalInfo'] ?? "",
      lastModified: json['lastModified'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "flatId": flatId,
      "quarterId": quarterId,
      "quarterNo": quarterNo,
      "quarterType": quarterType,
      "quarterRoofType": quarterRoofType,
      "quarterStatus": quarterStatus,
      "occupantName": occupantName,
      "occupantMobile": occupantMobile,
      "occupantDesignation": occupantDesignation,
      "dateOfOccupation": dateOfOccupation,
      "dateOfVacation": dateOfVacation,
      "verifyOtp": verifyOtp,
      "poolOfQuarters": poolOfQuarters,
      "quartersStatus": quartersStatus,
      "enrollmentStatus": enrollmentStatus,
      "pushToken": pushToken,
      "constructionDate": constructionDate,
      "additionalInfo": additionalInfo,
      "lastModified": lastModified,
    };
  }
}
