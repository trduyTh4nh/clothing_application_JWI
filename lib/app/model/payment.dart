import 'dart:convert';

import 'package:intl/intl.dart';

class Payment {
  String? id;
  String? fullName;
  DateTime? dateCreated;
  int? total;

  Payment({this.id, this.fullName, this.dateCreated, this.total});

  // factory Payment.fromMap(Map<String, dynamic> map) {
  //   return Payment(
  //       id: map['id']?.toInt() ?? 0,
  //       fullName: map['fullName'] ?? '',
  //       dateCreated: map['dateCreated'] ?? '',
  //       total: map['total']?.toInt() ?? '');
  // }
  // factory Payment.fromJson(String source) =>
  //     Payment.fromMap(json.decode(source));

  factory Payment.fromMap(Map<String, dynamic> map) {
    DateTime? parseDate(String dateStr) {
      try {
        return DateFormat('dd/MM/yyyy').parse(dateStr);
      } catch (e) {
        print('Error parsing date: $e');
        return null;
      }
    }

    return Payment(
      id: map['id'],
      fullName: map['fullName'] ?? '',
      dateCreated:
          map['dateCreated'] != null ? parseDate(map['dateCreated']) : null,
      total: map['total']?.toInt() ?? 0,
    );
  }

  factory Payment.fromJson(String source) =>
      Payment.fromMap(json.decode(source));
}
