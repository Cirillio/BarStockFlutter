/// Статус критичности товара для UI
enum StockStatus {
  /// Остаток в норме (больше минимального)
  normal,

  /// Остаток на минимуме (равен минимальному)
  warning,

  /// Остаток критичный (меньше минимального)
  critical,

  /// Товар закончился
  outOfStock;

  /// Определяет статус на основе текущего и минимального остатка
  static StockStatus fromStock(double currentStock, double minStock) {
    if (currentStock <= 0) return StockStatus.outOfStock;
    if (currentStock < minStock) return StockStatus.critical;
    if (currentStock == minStock) return StockStatus.warning;
    return StockStatus.normal;
  }
}
