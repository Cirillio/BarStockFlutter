/// Базовая информация о категории для отображения в списках выбора
/// Используется в dropdown меню для выбора категории
class CategoryInfo {
  const CategoryInfo({required this.id, required this.name, this.iconUrl});

  /// Уникальный идентификатор категории
  final int id;

  /// Отображаемое название категории
  final String name;

  /// URL иконки для отображения в UI
  final String? iconUrl;

  @override
  String toString() => 'CategoryInfo(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CategoryInfo && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
