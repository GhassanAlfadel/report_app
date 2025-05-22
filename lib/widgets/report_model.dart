// ignore_for_file: public_member_api_docs, sort_constructors_first
class ReportModel {
  final String name;
  final String location;
  final String status;
  final String userId;
  final String devison;
  final String time;
  final String type;

  ReportModel({
    required this.name,
    required this.location,
    required this.status,
    required this.userId,
    required this.devison,
    required this.time,
    required this.type,
  });

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
        name: map['name'] ?? '',
        location: map['location'] ?? '',
        status: map['status'] ?? '',
        userId: map['userId'] ?? '',
        devison: map['devison'] ?? "",
        time: map['time'] ?? "",
        type: map['type'] ?? "");
  }
}
