// class Leave {
//   String name;
//   String email;
//   String reason;
//   DateTime startDate;
//   DateTime endDate;
//   bool isApproved;

//   Leave({
//     required this.name,
//     required this.email,
//     required this.reason,
//     required this.startDate,
//     required this.endDate,
//     this.isApproved = false,
//   });
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class Leave {
  String id;
  String name;
  String email;
  String reason;
  DateTime startDate;
  DateTime endDate;
  bool isApproved;

  Leave({
    required this.id,
    required this.name,
    required this.email,
    required this.reason,
    required this.startDate,
    required this.endDate,
    this.isApproved = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'reason': reason,
      'startDate': startDate,
      'endDate': endDate,
      'isApproved': isApproved,
    };
  }

  static Leave fromMap(Map<String, dynamic> map) {
    return Leave(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      reason: map['reason'],
      startDate: (map['startDate'] as Timestamp).toDate(),
      endDate: (map['endDate'] as Timestamp).toDate(),
      isApproved: map['isApproved'],
    );
  }
}
