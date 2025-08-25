import 'package:bar_stock/core/constants/state_status.dart';

enum LoginField { email, password, general }

typedef LoginState = FormState<LoginField>;

class FormState<TField> {
  final Map<TField, String?> errors;
  final StateStatus status;

  String? errorOf(TField field) => errors[field];

  const FormState({this.errors = const {}, this.status = StateStatus.initial});

  FormState<TField> copyWith({
    Map<TField, String?>? errors,
    StateStatus? status,
  }) {
    return FormState<TField>(
      errors: errors ?? this.errors,
      status: status ?? this.status,
    );
  }
}
