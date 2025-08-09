import 'package:flutter/material.dart';

class Meeting {
  final String id;
  final String title;
  final String startTime;
  final String endTime;
  final String type;
  final Color color;
  final IconData icon;

  Meeting({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.type,
    required this.color,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'startTime': startTime,
      'endTime': endTime,
      'type': type,
      'color': color.value,
      'icon': icon.codePoint,
    };
  }

  factory Meeting.fromMap(Map<String, dynamic> map) {
    return Meeting(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      startTime: map['startTime'] ?? '',
      endTime: map['endTime'] ?? '',
      type: map['type'] ?? '',
      color: Color(map['color'] ?? 0xFF4A90E2),
      icon: IconData(map['icon'] ?? Icons.event.codePoint,
          fontFamily: 'MaterialIcons'),
    );
  }

  Meeting copyWith({
    String? id,
    String? title,
    String? startTime,
    String? endTime,
    String? type,
    Color? color,
    IconData? icon,
  }) {
    return Meeting(
      id: id ?? this.id,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      type: type ?? this.type,
      color: color ?? this.color,
      icon: icon ?? this.icon,
    );
  }

  String toString() {
    return 'Meeting{id: $id, title: $title, startTime: $startTime, endTime: $endTime, type: $type}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Meeting &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          type == other.type;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      type.hashCode;
}
