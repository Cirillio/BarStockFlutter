class StockState {
  final Map<String, String> errors;

  const StockState({this.errors = const {}});

  bool get hasErrors => errors.isNotEmpty;
}
