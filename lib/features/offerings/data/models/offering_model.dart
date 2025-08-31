import '../../domain/entities/offering.dart';

class OfferingModel extends Offering {
  OfferingModel({
    super.id,
    required super.practitionerName,
    required super.title,
    required super.description,
    required super.category,
    required super.duration,
    required super.type,
    required super.price,
    required super.createdAt,
  });

  factory OfferingModel.fromMap(Map<String, dynamic> map) {
    return OfferingModel(
      id: map['id'],
      practitionerName: map['practitionerName'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      duration: map['duration'],
      type: map['type'],
      price: map['price'].toDouble(),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'practitionerName': practitionerName,
      'title': title,
      'description': description,
      'category': category,
      'duration': duration,
      'type': type,
      'price': price,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}