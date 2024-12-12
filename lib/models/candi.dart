class Candi {
  final String name;
  final String location;
  final String description;
  final String built;
  final String type;
  final String imageAsset;
  final List<String> imageUrls;
  final bool isFavorite;

  Candi({
    required this.name,
    required this.location,
    required this.description,
    required this.built,
    required this.type,
    required this.imageAsset,
    required this.imageUrls,
    required this.isFavorite,
  });

  factory Candi.fromJson(Map<String, dynamic> json) {
    return Candi(
      name: json['name'],
      location: json['location'],
      description: json['description'],
      built: json['built'],
      type: json['type'],
      imageAsset: json['imageAsset'],
      imageUrls: List<String>.from(json['imageUrls']),
      isFavorite: json['isFavorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'description': description,
      'built': built,
      'type': type,
      'imageAsset': imageAsset,
      'imageUrls': imageUrls,
      'isFavorite': isFavorite,
    };
  }
}

