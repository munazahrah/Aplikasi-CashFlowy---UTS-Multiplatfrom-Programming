CashFlowy 💸

CashFlowy adalah aplikasi mobile pencatatan keuangan pribadi yang dirancang dengan antarmuka modern dan ringan, sangat cocok untuk mahasiswa atau anak muda yang ingin melacak arus kas harian mereka. Aplikasi ini berjalan 100% secara offline, mengimplementasikan konsep Asynchronous Programming, dan memanfaatkan dua teknik penyimpanan data lokal (Data Persistence).

Proyek ini dikembangkan untuk memenuhi tugas Ujian Tengah Semester (UTS) mata kuliah Pemrograman Multiplatform.

✨ Fitur Utama

📊 Dashboard Ringkasan: Menampilkan total saldo, pemasukan, dan pengeluaran bulan ini secara real-time.

📝 Pencatatan Transaksi: Catat arus kas masuk dan keluar dengan mudah beserta kategori dan catatan tambahan.

🕰️ Riwayat Transaksi: Pantau riwayat keuangan masa lalu dengan fitur swipe-to-delete untuk menghapus data.

🎨 Personalisasi Profil & Tema: Ganti nama sapaan pengguna dan beralih antara Mode Terang (Light Mode) dan Mode Gelap (Dark Mode).

📶 Offline First: Tidak membutuhkan koneksi internet maupun proses login yang rumit.

🛠️ Teknologi & Package yang Digunakan

Aplikasi ini dibangun menggunakan Flutter dan bahasa pemrograman Dart.

Berikut adalah package pendukung yang digunakan:

sqflite (^2.3.0) - Mengelola penyimpanan database lokal yang terstruktur untuk menyimpan ribuan data transaksi harian (Teknik Data Persistence 1).

shared_preferences (^2.2.2) - Menyimpan data key-value sederhana untuk mengingat preferensi nama pengguna dan status tema aplikasi (Teknik Data Persistence 2).

intl (^0.18.1) - Membantu proses formatting angka ke dalam format mata uang Rupiah (Rp) dan merapikan format tanggal.

path (^1.8.3) - Digunakan bersama SQLite untuk menentukan jalur/lokasi direktori database secara dinamis di berbagai perangkat genggam.

cupertino_icons (^1.0.6) - Ikon standar Material Design dan iOS.

🚀 Langkah-langkah Menjalankan Aplikasi

Pastikan Anda sudah menginstal Flutter SDK di perangkat atau komputer Anda.

Clone repositori ini ke komputer lokal Anda:
git clone https://github.com/munazahrah/Aplikasi-CashFlowy---UTS-Multiplatfrom-Programming.git

Masuk ke dalam direktori project:
cd cashflowy

Unduh seluruh package / dependensi:
flutter pub get


Jalankan aplikasi di emulator atau perangkat fisik yang sudah terhubung:

flutter run


👨‍💻 Pengembang
Dikembangkan oleh:
Nama: Siti Munawaroh Yusminnu Zahrah
NIM: 230605110198
Mata Kuliah: MULTIPLATFROM PROGRAMMING
Dibuat dengan menggunakan Flutter.