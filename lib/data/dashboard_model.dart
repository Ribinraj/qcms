class DashboardModel {
  final String totalComplaints;
  final String openComplaints;
  final String wipComplaints;
  final String completedComplaints;
  final List<dynamic>? feedbackList;
  final String feedbackCount;

  DashboardModel({
    required this.totalComplaints,
    required this.openComplaints,
    required this.wipComplaints,
    required this.completedComplaints,
    this.feedbackList,
    required this.feedbackCount,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      totalComplaints: json['totalComplaints'] ?? '0',
      openComplaints: json['openComplaints'] ?? '0',
      wipComplaints: json['wipComplaints'] ?? '0',
      completedComplaints: json['completedComplaints'] ?? '0',
      feedbackList: json['feedbackList'],
      feedbackCount: json['feedbackCount'] ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalComplaints': totalComplaints,
      'openComplaints': openComplaints,
      'wipComplaints': wipComplaints,
      'completedComplaints': completedComplaints,
      'feedbackList': feedbackList,
      'feedbackCount': feedbackCount,
    };
  }
}
