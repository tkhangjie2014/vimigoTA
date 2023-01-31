import 'dart:convert';

Attendance usersFromJson(String str) => Attendance.fromJson(json.decode(str));

String usersToJson(Attendance data) => json.encode(data.toJson());

class Attendance {
  Attendance({
    this.id,
    required this.user,
    required this.phone,
    this.checkIn,
  });

  String? id;
  final String user;
  final String phone;
  String? checkIn;

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    user: json["user"],
    phone: json["phone"],
    checkIn: json["checkIn"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "phone": phone,
    "checkIn": checkIn,
  };
}
