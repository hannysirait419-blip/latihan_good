/// Nomor WhatsApp tujuan order (format internasional, tanpa + dan tanpa 0 di depan).
/// Contoh: 08123456789 -> 628123456789
/// Ganti sesuai kebutuhan (anggap ini "backend" toko).
const String kWhatsAppNumber = '62822157440';

/// Awal pesan yang dikirim ke WhatsApp; nama produk ditambahkan di belakangnya.
const String kWhatsAppMessage = 'Halo, saya mau order ';
