import '../models/product.dart';

// Ganti nama file di bawah ini sesuai nama gambar yang diberikan saat ujian.
const String _img = 'assets/images/protein/';

const List<Product> proteinProducts = [
  Product(id: 'p1', name: 'Sayurbox Daging Giling Segar 250g', price: 51900, image: '${_img}daging_giling.jpg', stock: 3),
  Product(id: 'p2', name: 'Daging Has Luar Segar 250g', price: 49900, image: '${_img}has_luar.jpg', stock: 1),
  Product(id: 'p3', name: 'Sayurbox Daging Sengkel Segar 250g', price: 49900, image: '${_img}sengkel.jpg', stock: 3),
  Product(id: 'p4', name: 'Daging Has Dalam Segar', price: 62900, image: '${_img}has_dalam.jpg', stock: 3),
  Product(id: 'p5', name: 'Sayurbox Iga Sapi Segar 250g', price: 64900, image: '${_img}iga_sapi.jpg', stock: 3),
  Product(id: 'p6', name: 'Teri Nasi Basah Tidak Beku', price: 26100, image: '${_img}teri_nasi.jpg', stock: 3),
];

/// Produk promo di beranda (komponen bonus).
const String _promo = 'assets/images/promo/';

const List<Product> promoProducts = [
  Product(id: 'm1', name: 'Kaldu Jamur Shiitake Non MSG 50g', price: 22500, image: '${_promo}promo1.jpg', stock: 5),
  Product(id: 'm2', name: 'Kaldu Jamur Shiitake Non MSG 50g', price: 22500, image: '${_promo}promo2.jpg', stock: 5),
];
