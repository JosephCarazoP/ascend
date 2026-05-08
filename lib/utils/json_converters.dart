import 'package:cloud_firestore/cloud_firestore.dart';

DateTime? dateTimeFromJson(Object? value) {
  if (value == null) {
    return null;
  }

  if (value is Timestamp) {
    return value.toDate();
  }

  if (value is DateTime) {
    return value;
  }

  if (value is String) {
    return DateTime.tryParse(value);
  }

  return null;
}

double? doubleFromJson(Object? value) {
  if (value == null) {
    return null;
  }

  if (value is num) {
    return value.toDouble();
  }

  if (value is String) {
    return double.tryParse(value);
  }

  return null;
}

List<String> stringListFromJson(Object? value) {
  if (value is Iterable) {
    return value.whereType<String>().toList();
  }

  return const [];
}

List<Map<String, dynamic>> mapListFromJson(Object? value) {
  if (value is Iterable) {
    return value.whereType<Map>().map(Map<String, dynamic>.from).toList();
  }

  return const [];
}
