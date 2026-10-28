import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../state/app_state.dart';

/// Navigation bottom: home, search, (celah), keranjang, akun.
class AppBottomBar extends StatelessWidget {
  final int current; // 0 = home, 1 = search, 2 = keranjang, 3 = akun
  const AppBottomBar({super.key, this.current = 0});

  static const Color _active = Color(0xFFE8590C);

  void _goHome(BuildContext c) => Navigator.of(c).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomePage()), (r) => false);

  void _showCart(BuildContext c) {
    final cart = CartState.instance;
    showDialog(
      context: c,
      builder: (_) => AlertDialog(
        title: const Text('Keranjang'),
        content: Text(cart.totalItems == 0
            ? 'Keranjang masih kosong'
            : '${cart.totalItems} barang\nTotal ${rupiah(cart.totalPrice)}'),
        actions: [
          if (cart.totalItems > 0)
            TextButton(
                onPressed: () {
                  cart.clear();
                  Navigator.pop(c);
                },
                child: const Text('Kosongkan')),
          TextButton(onPressed: () => Navigator.pop(c), child: const Text('Tutup')),
        ],
      ),
    );
  }

  void _showAccount(BuildContext c) {
    showDialog(
      context: c,
      builder: (_) => AlertDialog(
        title: Text(AppState.storeName),
        content: Text('Pemilik: ${AppState.ownerName}\n'
            'Jenis usaha: ${AppState.businessType}\n'
            'Alamat: ${AppState.address}\n'
            'Kontak: ${AppState.contact}'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c), child: const Text('Tutup'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget btn(int idx, IconData icon, VoidCallback onTap) => IconButton(
          onPressed: onTap,
          icon: Icon(icon, color: current == idx ? _active : Colors.grey.shade700),
        );

    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 4, 12, 8),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFFFFF0F8),
          borderRadius: BorderRadius.circular(26),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Row(
          children: [
            btn(0, Icons.home, () => _goHome(context)),
            btn(1, Icons.search, () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fitur pencarian belum aktif')));
            }),
            const Spacer(),
            btn(2, Icons.shopping_basket_outlined, () => _showCart(context)),
            btn(3, Icons.person_outline, () => _showAccount(context)),
          ],
        ),
      ),
    );
  }
}
