import 'package:flutter/foundation.dart';
import '../models/product.dart';

/// Data hasil registrasi (dipakai di halaman berikutnya).
class AppState {
  static String storeName = '';
  static String ownerName = '';
  static String businessType = '';
  static String address = '';
  static String contact = '';
}

/// Keranjang sederhana untuk komponen bonus "Lihat Keranjang".
class CartState extends ChangeNotifier {
  CartState._();
  static final CartState instance = CartState._();

  final Map<Product, int> items = {};

  int get totalItems => items.values.fold(0, (a, b) => a + b);
  int get totalPrice =>
      items.entries.fold(0, (sum, e) => sum + e.key.price * e.value);

  void add(Product p) {
    items[p] = (items[p] ?? 0) + 1;
    notifyListeners();
  }

  void clear() {
    items.clear();
    notifyListeners();
  }
}

/// 51900 -> "Rp51.900"
String rupiah(int v) {
  final s = v.toString();
  final b = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) b.write('.');
    b.write(s[i]);
  }
  return 'Rp$b';
}
