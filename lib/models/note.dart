// To parse this JSON data, do
//
//     final note = noteFromMap(jsonString);

import 'dart:convert';

Note noteFromMap(String str) => Note.fromMap(json.decode(str));

String noteToMap(Note data) => json.encode(data.toMap());

class Note {
  Note({
    this.id,
    this.title,
    this.note,
    this.date,
  });

  int id;
  String title;
  String note;
  String date;

  factory Note.fromMap(Map<String, dynamic> json) => Note(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        note: json["note"] == null ? null : json["note"],
        date: json["date"] == null ? null : json["date"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "note": note == null ? null : note,
        "date": date == null ? null : date,
      };
}
