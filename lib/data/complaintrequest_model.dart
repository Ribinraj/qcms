class ComplaintRequestModel {
  final int departmentId;
  final int categoryId;
  final String? complaintRemarks;
  final String? picture; // Base64 string

  ComplaintRequestModel({
    required this.departmentId,
    required this.categoryId,
     this.complaintRemarks,
     this.picture,
  });

  Map<String, dynamic> toJson() {
    return {
      'departmentId': departmentId,
      'categoryId': categoryId,
      'complaintremarks': complaintRemarks??'',
      'picture': picture??'',
    };
  }
}
