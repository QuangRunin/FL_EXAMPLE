import 'dart:ui';

class SpinData {
  int? id;
  String? name;
  Color? color;
  SpinData({
    this.id,
    this.name,
    this.color,
  });

  SpinData copyWith({
    int? id,
    String? name,
  }) {
    return SpinData(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory SpinData.fromMap(Map<String, dynamic> map) {
    return SpinData(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }
}
