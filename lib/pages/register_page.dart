import 'package:flutter/material.dart';
import '../state/app_state.dart';
import 'home_page.dart';

/// Form registrasi (WAJIB). Submit hanya bisa jika semua isian terisi
/// dan checkbox syarat & ketentuan dicentang.
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _toko = TextEditingController();
  final _pemilik = TextEditingController();
  final _alamat = TextEditingController();
  final _kontak = TextEditingController();

  static const List<String> _jenisUsaha = [
    'Makanan & Minuman',
    'Sayur & Sembako',
    'Lainnya',
  ];
  String _jenis = _jenisUsaha.first;
  bool _agree = false;

  @override
  void dispose() {
    _toko.dispose();
    _pemilik.dispose();
    _alamat.dispose();
    _kontak.dispose();
    super.dispose();
  }

  String? _required(String? v, String label) =>
      (v == null || v.trim().isEmpty) ? '$label wajib diisi' : null;

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (!_agree) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Anda harus menyetujui syarat dan ketentuan')));
      return;
    }
    AppState.storeName = _toko.text.trim();
    AppState.ownerName = _pemilik.text.trim();
    AppState.businessType = _jenis;
    AppState.address = _alamat.text.trim();
    AppState.contact = _kontak.text.trim();

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Registrasi Pemilik Toko'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _toko,
                decoration: const InputDecoration(labelText: 'Nama Toko'),
                validator: (v) => _required(v, 'Nama Toko'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _pemilik,
                decoration: const InputDecoration(labelText: 'Nama Pemilik'),
                validator: (v) => _required(v, 'Nama Pemilik'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _jenis,
                decoration: const InputDecoration(labelText: 'Jenis Usaha'),
                items: _jenisUsaha
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _jenis = v ?? _jenis),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _alamat,
                decoration: const InputDecoration(labelText: 'Alamat Toko'),
                validator: (v) => _required(v, 'Alamat Toko'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _kontak,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Kontak'),
                validator: (v) => _required(v, 'Kontak'),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _agree,
                    onChanged: (v) => setState(() => _agree = v ?? false),
                  ),
                  const Expanded(
                      child: Text('Saya menyetujui syarat dan ketentuan')),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: FilledButton.tonal(
                    onPressed: _submit, child: const Text('Submit')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
