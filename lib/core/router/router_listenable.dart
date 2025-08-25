import 'dart:async';
import 'package:flutter/foundation.dart';

class AuthListenable extends ChangeNotifier {
  AuthListenable(Stream<dynamic> stream) {
    _sub = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription _sub;

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
