LANGKAH PASANG
1. flutter create toko_tegar
2. Ganti folder lib/ dengan lib/ dari zip ini, dan taruh folder assets/ di root project.
3. flutter pub add url_launcher
4. Di pubspec.yaml bagian flutter: tambahkan
     assets:
       - assets/images/
       - assets/images/protein/
       - assets/images/promo/
5. android/app/src/main/AndroidManifest.xml, tepat di dalam <manifest> (di luar <application>):
     <queries>
       <intent>
         <action android:name="android.intent.action.VIEW" />
         <data android:scheme="https" />
       </intent>
     </queries>
6. flutter pub get, lalu stop & flutter run ulang.

GANTI NOMOR WA : lib/config/app_config.dart  (kWhatsAppNumber)
GANTI NAMA GAMBAR: lib/data/protein_data.dart
