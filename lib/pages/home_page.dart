import 'package:flutter/material.dart';
import '../data/protein_data.dart';
import '../state/app_state.dart';
import '../widgets/app_bottom_bar.dart';
import '../widgets/app_image.dart';
import '../widgets/category_icon.dart';
import 'protein_page.dart';

/// Home: AppBar (menu + search), nama toko, ikon kategori (WAJIB),
/// banner pengiriman + produk promo (BONUS), bottom navigation (WAJIB).
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _inactive(BuildContext c) => ScaffoldMessenger.of(c).showSnackBar(
      const SnackBar(content: Text('Fitur ini belum aktif')));

  @override
  Widget build(BuildContext context) {
    final cats = [catBaru, catBeliLagi, catClearance, catSayur, catBuah, catProtein];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () => _inactive(context), icon: const Icon(Icons.search)),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListTile(
            leading: const Icon(Icons.store),
            title: Text(AppState.storeName),
            subtitle: Text(AppState.businessType),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(AppState.storeName,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          // ---- Komponen wajib: ikon kategori
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final c in cats)
                  CategoryIcon(
                    item: c,
                    onTap: () {
                      if (c == catProtein) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const ProteinPage()));
                      } else {
                        _inactive(context); // ikon lain boleh tidak aktif
                      }
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // ---- Komponen bonus: banner pengiriman
          Container(
            height: 64,
            color: Colors.orange,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Dikirim Besok',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Text('ke Pilih Lokasi  ⌄', style: TextStyle(fontSize: 11)),
                  ],
                ),
                const Spacer(),
                const AppImage('assets/images/banner_kirim.png',
                    height: 56, fit: BoxFit.contain),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: Text('Lihat Lebih Banyak  ⌄',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w600)),
            ),
          ),
          // ---- Komponen bonus: produk promo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                for (final p in promoProducts)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: AspectRatio(
                              aspectRatio: 0.8,
                              child: AppImage(p.image),
                            ),
                          ),
                          Positioned(
                            top: 6,
                            right: 6,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.red,
                              child: const Text('100%',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Positioned(
                            right: 6,
                            bottom: 6,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(rupiah(p.price),
                                  style: const TextStyle(
                                      fontSize: 11, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
      bottomNavigationBar: const AppBottomBar(current: 0),
    );
  }
}
