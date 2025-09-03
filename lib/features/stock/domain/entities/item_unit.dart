enum ItemUnit { bottle, ml, portion, g }

extension ItemUnitExtension on ItemUnit {
  static ItemUnit fromString(String value) {
    switch (value.toLowerCase()) {
      case 'bottle':
        return ItemUnit.bottle;
      case 'ml':
        return ItemUnit.ml;
      case 'portion':
        return ItemUnit.portion;
      case 'g':
        return ItemUnit.g;
      default:
        return ItemUnit.bottle; // default fallback
    }
  }
  
  String get displayName {
    switch (this) {
      case ItemUnit.bottle:
        return 'бут.';
      case ItemUnit.ml:
        return 'мл';
      case ItemUnit.portion:
        return 'шт.';
      case ItemUnit.g:
        return 'г';
    }
  }
}
