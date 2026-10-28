import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/app_config.dart';
import '../models/product.dart';
import '../state/app_state.dart';
import '../widgets/app_bottom_bar.dart';
import '../widgets/app_image.dart';

/// Halaman "Pesan": nama produk, gambar, harga, tombol Order via WhatsApp.
class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  Future<void> _orderWhatsApp(BuildContext context) async {
    final text = Uri.encodeComponent('$kWhatsAppMessage${product.name}');
    final uri = Uri.parse('https://wa.me/$kWhatsAppNumber?text=$text');
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak bisa membuka WhatsApp')));
    }
  }

  @override
  Widget build(BuildContext context) {
    const red = TextStyle(
        color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Pesan'),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_none)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(product.name, textAlign: TextAlign.center, style: red),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: AspectRatio(
                aspectRatio: 1.6,
                child: AppImage(product.image, width: double.infinity),
              ),
            ),
            const SizedBox(height: 12),
            Text(rupiah(product.price), style: red.copyWith(fontSize: 16)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _orderWhatsApp(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5CB85C),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.chat, size: 28),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order via WhatsApp',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Klik di Sini!', style: TextStyle(fontSize: 10)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomBar(current: 0),
    );
  }
}
