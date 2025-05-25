class Zekr {
  final int id;
  final String text;
  final int count;
  final String audio;
  final String filename;

  Zekr({required this.id, required this.text, required this.count, required this.audio, required this.filename});

  factory Zekr.fromJson(Map<String, dynamic> json) => Zekr(
    id: json['id'],
    text: json['text'],
    count: json['count'],
    audio: json['audio'],
    filename: json['filename'],
  );
}

class ZekrCategory {
  final int id;
  final String category;
  final String audio;
  final String filename;
  final List<Zekr> array;

  ZekrCategory({required this.id, required this.category, required this.audio, required this.filename, required this.array});

  factory ZekrCategory.fromJson(Map<String, dynamic> json) => ZekrCategory(
    id: json['id'],
    category: json['category'],
    audio: json['audio'],
    filename: json['filename'],
    array: List<Zekr>.from(json['array'].map((x) => Zekr.fromJson(x))),
  );
}
