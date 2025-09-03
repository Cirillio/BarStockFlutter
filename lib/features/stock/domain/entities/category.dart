class Category {
  final int id;
  final String name;
  final String iconUrl;

  const Category({required this.id, required this.name, required this.iconUrl});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String,
      iconUrl: json['icon_url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'icon_url': iconUrl};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Category(id: $id, name: $name, iconUrl: $iconUrl)';
  }
}
