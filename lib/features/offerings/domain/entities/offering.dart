class Offering {
  final int? id;
  final String practitionerName;
  final String title;
  final String description;
  final String category;
  final String duration;
  final String type;
  final double price;
  final DateTime createdAt;

  Offering({
    this.id,
    required this.practitionerName,
    required this.title,
    required this.description,
    required this.category,
    required this.duration,
    required this.type,
    required this.price,
    required this.createdAt,
  });

  Offering copyWith({
    int? id,
    String? practitionerName,
    String? title,
    String? description,
    String? category,
    String? duration,
    String? type,
    double? price,
    DateTime? createdAt,
  }) {
    return Offering(
      id: id ?? this.id,
      practitionerName: practitionerName ?? this.practitionerName,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      duration: duration ?? this.duration,
      type: type ?? this.type,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}