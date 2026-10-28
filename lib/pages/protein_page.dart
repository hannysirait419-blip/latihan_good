import 'package:flutter/material.dart';
import '../data/protein_data.dart';
import '../models/product.dart';
import '../state/app_state.dart';
import '../widgets/app_bottom_bar.dart';
import '../widgets/app_image.dart';
import '../widgets/category_icon.dart';
import 'product_detail_page.dart';

/// List produk protein (WAJIB). Tombol + dan bar "Lihat Keranjang" = BONUS.
class ProteinPage extends StatelessWidget {
  const ProteinPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cats = [catBaru, catBeliLagi, catProtein, catSayur, catBuah];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Baris atas: back + search
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 4, 12, 4),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Cari lebih banyak di Terjadwal...',
                        hintStyle: const TextStyle(fontSize: 12),
                        prefixIcon: const Icon(Icons.search, size: 18),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Ikon kategori (Protein terpilih)
            SizedBox(
              height: 84,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  for (final c in cats)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: CategoryIcon(
                          item: c, selected: c == catProtein, onTap: () {}),
                    ),
                ],
              ),
            ),
            // Chip filter
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: const [
                  Chip(
                      avatar: Icon(Icons.tune, size: 14),
                      label: Text('Filter', style: TextStyle(fontSize: 11))),
                  SizedBox(width: 8),
                  Chip(
                      backgroundColor: Colors.green,
                      label: Text('Semua',
                          style: TextStyle(fontSize: 11, color: Colors.white))),
                  SizedBox(width: 8),
                  Chip(
                      label: Text('Aneka Protein Segar',
                          style: TextStyle(fontSize: 11))),
                  SizedBox(width: 8),
                  Chip(label: Text('Baru', style: TextStyle(fontSize: 11))),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
              child: const Text('Aneka Protein Segar',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            ),
            // Grid produk (lazy)
            Expanded(
              child: Container(
                color: Colors.white,
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 190,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: proteinProducts.length,
                  itemBuilder: (context, i) =>
                      _ProductTile(product: proteinProducts[i]),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [_CartBar(), AppBottomBar(current: 0)],
      ),
    );
  }
}

class _ProductTile extends StatelessWidget {
  final Product product;
  const _ProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // klik produk -> halaman detail (harga + order WhatsApp)
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ProductDetailPage(product: product))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: AppImage(product.image, height: 90, width: double.infinity),
              ),
              Positioned(
                right: 4,
                top: 4,
                child: InkWell(
                  onTap: () {
                    CartState.instance.add(product);
                  },
                  child: const CircleAvatar(
                    radius: 11,
                    backgroundColor: Colors.green,
                    child: Icon(Icons.add, size: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(rupiah(product.price),
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          Text(product.name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10)),
          const Spacer(),
          Center(
            child: Text('Sisa ${product.stock}',
                style: const TextStyle(fontSize: 10, color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

/// Bar hijau "Lihat Keranjang  0 Barang  Rp0" (BONUS).
class _CartBar extends StatelessWidget {
  const _CartBar();

  @override
  Widget build(BuildContext context) {
    final cart = CartState.instance;
    return ListenableBuilder(
      listenable: cart,
      builder: (context, _) => Container(
        margin: const EdgeInsets.fromLTRB(12, 4, 12, 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.green.shade700,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Lihat Keranjang',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
                Text('${cart.totalItems} Barang',
                    style: const TextStyle(color: Colors.white, fontSize: 10)),
              ],
            ),
            const Spacer(),
            Text(rupiah(cart.totalPrice),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
