# Study Planner App

Aplikasi Study Planner pribadi yang dibuat menggunakan framework Flutter untuk membantu mengelola jadwal belajar, tugas, dan aktivitas harian dengan lebih praktis.

---

## Tech Stack dan Dependensi Utama

Berikut adalah package dan library utama yang digunakan pada proyek ini:

- Flutter SDK: >=3.0.0
- provider: Pengelolaan state lokal dan pembaruan data tampilan secara langsung
- go_router: Pengaturan navigasi dan perpindahan antar-halaman

---

## Pemilik State dan Alur Data

### Pemilik State (State Owner)
Penyimpanan data utama di aplikasi ini dipegang sama ActivityProvider yang terhubung ke class ChangeNotifier. Kelas inilah yang nyimpen seluruh daftar tugas (List<Activity> _activities) sekaligus ngatur semua logika aplikasi, kayak nambah, ngedit, ngapus, nyaring filter, sampai tandai favorit.

### Alur Data pada Fitur Tambah Tugas
- User ngisi form di halaman AddActivityScreen terus menekan tombol Simpan.
- Tampilan UI bakal ngirim data tugas baru tersebut ke Provider lewat perintah context.read<ActivityProvider>().addActivity(newActivity).
- Di dalam Provider, fungsi addActivity bakal masukin data tugas baru itu ke dalam daftar _activities.
- Habis data masuk, Provider langsung manggil notifyListeners() buat ngasih tahu ke UI kalau ada data yang berubah.
- Tampilan UI yang terhubung sama Provider bakal otomatis ke-refresh sendiri, jadi tugas yang baru ditambahin langsung muncul di layar utama tanpa perlu reload manual.

---

## Cara Menjalankan Aplikasi

Ikuti langkah-langkah di bawah ini untuk menjalankan aplikasi di perangkat Anda:

### 1. Prasyarat
- Flutter SDK sudah terinstal di komputer (jalankan flutter doctor).
- Emulator atau HP fisik sudah terhubung dengan baik.

### 2. Unduh Repository
git clone https://github.com/akhairanii/study_planner.git
cd study_planner

### 3. Pasang Package
Jalankan perintah berikut di terminal untuk mengunduh semua kebutuhan proyek:
flutter pub get

### 4. Jalankan Proyek
flutter run

---

## Tampilan Aplikasi dan Video Demo

### Screenshots Tampilan
Gambar tampilan layar aplikasi dapat dilihat pada folder assets/ atau melalui tabel berikut:
Link Screenshoot: https://drive.google.com/drive/folders/19qoaXarUbWxJqLY3vzRmB2jkt4SrweA3?usp=drive_link

### Video Demonstrasi Aplikasi
Video penjelasan dan demonstrasi pengujian fitur aplikasi berdurasi 4-6 menit dapat diakses melalui tautan berikut:
Link Video Demo: https://drive.google.com/drive/folders/1M43Y1A9oUbQ9dTW8s1fn4Z2zQ-pG13fD
---

## Struktur Folder Proyek

lib/
├── models/         # Model data aplikasi (Activity)
├── providers/      # Manajemen state (ActivityProvider)
├── routes/         # Pengaturan navigasi halaman (AppRouter)
├── screens/        # Tampilan utama/halaman aplikasi
├── widgets/        # Komponen UI yang bisa dipakai ulang (ActivityCard)
└── main.dart       # Titik awal jalurnya aplikasi Flutter

---

## Hasil Pengujian Aplikasi (13 Test Cases)

Berikut adalah tabel hasil pengujian fitur (Black Box Testing) untuk memastikan seluruh fungsi aplikasi berjalan dengan baik:

| No | Skenario Pengujian | Input (Aksi) | Ekspektasi Hasil | Hasil Aktual | Status |
| :---: | :--- | :--- | :--- | :--- | :---: |
| 1 | Tambah tugas (Valid) | Ngisi judul, kategori, dan deskripsi, lalu tekan simpan | Data berhasil disimpan dan muncul di daftar | Tugas baru tampil dihalaman | PASS |
| 2 | Tambah tugas (Input kosong) | Tekan tombol simpan pada form tambah tugas tanpa ngisi judul | System nolak simpan dan nampilin pesan “Judul tidak boleh kosong” | Pesan error/validasi merah muncul di bawah field judul | PASS |
| 3 | Tandai favorit | Tekan ikon hati di salah satu kartu tugas daftar aktivitas | Status tugas berubah jadi favorit dan warna ikon hati aktif | Ikon hati berubah warna dan data terupdate di provider | PASS |
| 4 | Hapus Status favorit | Tekan Kembali ikon hati yang udah aktif di kartu tugas | Status aktif dibatalkan danwarna ikon Kembali ke kondisi semula | Status favorit dilepas dan warna ikon Kembali normal | PASS |
| 5 | Filter khusus(semua) | Pilih opsi filter “semua” di bar bagian atas sebelah kategori | Cuma tugas yg ditandai centang | Layar Cuma nampilin tugas yang sudah dicentang | PASS |
| 6 | Reset filter | Milih opsi filter “semua” setelah memfilter data | Seluruh daftar tugas Kembali ditamplkan | Semua tugas muncul Kembali secara utuh | PASS |
| 7 | Edit Tugas (valid) | Ngubah judul lalu tekan simpan | Data tugas berhasil diperbarui dan tampilan daftar utama berubah | Nama tugas dihalaman berubah sesuai input baru | PASS |
| 8 | Edit tugas (batal simpan) | Ngubah teks judul from edit lalu tekan batal | Formular tertutup dan data lama ga berubah | Form tertutup, judul tugas tetep make nama lama | PASS |
| 9 | Batal tambah | Ngisi formular tambah tugas setengah jalan lalu tekan tombol batal | Halaman form tertutup dan ga ada data baru yg tersimpan | Kembali ke layar sebelumnya tanpa penambahan data | PASS |
| 10 | Hapus tugas (konfirmasi ya) | Tekan ikon tempat sampah di kartu tugas lalu pilih hapus di konfirmasi/dialog | Data tugas terhapus secara permanen dari daftar | Tugas terhapus dan hilang dari tampilan view | PASS |
| 11 | Hapus tugas (batal hapus) | Tekan ikon tempat sampah lalu pilih opsi batal di dialog konfirmasi | Dialog konfirmasi tertutup dan data tigas ga terhapus | Dialog tertutup, tugas tete pada di dalam daftar | PASS |
| 12 | Pencarian data | Masukkan kata kunci judul tugas di kolom pencarian | Daftar tugas otomatis nyaring dan Cuma nampilin tugas yg mengandung kata kunci itu | Cuma tugas dengan nama yang dicari yang muncul dilayar | PASS |
| 13 | Tampilan data kosong | Buka apk saat belum ada tugas, atau pilih filter yang ga punya data | Tampilan layar nampilin pesan | Layar nampilin teks yang ngasih tahu datakosong | PASS |