Penyebabnya adalah adanya **konflik tanda tiga *backtick*** (`````) pada contoh nota di Bagian 8, sehingga sistem menganggap blok kodenya sudah selesai lebih awal dan terpotong.

Berikut adalah **seluruh isi Markdown (Bagian 1 sampai 8)** yang sudah diperbaiki formatnya agar tidak terpotong lagi. Anda bisa langsung salin tombol *copy* pada blok di bawah ini:

```markdown
# Dokumen Kebutuhan Data - Milestone Proyek 02
**Nama Organisasi Fiktif:** HAS Online Store (Helen Awanda Saumitha Shop)  
**Tema Proyek:** Toko Daring (`toko`)  
**Nama:** Helen Awanda Saumitha  
**NIM:** 25430117  
**Kelas:** D  

```

---

## 1. Daftar Proses Bisnis

1. **Pendaftaran & Pengelolaan Profil Pelanggan:** Pelanggan mendaftarkan akun baru, mencantumkan alamat pengiriman, dan mengelola informasi kontak pribadi.
2. **Manajemen Katalog Produk & Stok:** Pengelola toko menambahkan produk baru, mengelompokkannya ke dalam kategori, memperbarui harga, serta memantau jumlah stok barang.
3. **Pemrosesan Pesanan & Transaksi Checkout:** Pelanggan memilih barang, memasukkannya ke keranjang belanja, menetapkan alamat pengiriman, dan membuat pesanan resmi.
4. **Pembayaran & Pengiriman Pesanan:** Pelanggan melakukan konfirmasi pembayaran, pengelola memverifikasi dana, dan bagian logistik menerbitkan resi pengiriman barang.

---

## 2. Entitas Kandidat

1. **`Pelanggan`** – Menyimpan informasi identitas dan akun pembeli.
2. **`Kategori`** – Menyimpan pengelompokan jenis produk.
3. **`Produk`** – Menyimpan data barang dagangan yang dijual beserta stok dan harga saat ini.
4. **`Pesanan`** – Menyimpan data transaksi utama pesanan yang dibuat pelanggan.
5. **`Detail_Pesanan`** – Menyimpan rincian item produk yang dibeli pada suatu pesanan beserta harga historis per item.
6. **`Pembayaran`** – Menyimpan catatan verifikasi transaksi pembayaran pesanan.

---

## 3. Aturan Bisnis (Business Rules)

1. **BR-01:** Setiap pelanggan harus terdaftar dengan alamat email yang unik dan aktif.
2. **BR-02:** Satu produk harus terikat pada tepat satu kategori produk.
3. **BR-03:** Pelanggan dapat membuat banyak pesanan, namun setiap pesanan hanya dimiliki oleh satu pelanggan.
4. **BR-04:** Satu pesanan dapat terdiri dari satu atau banyak item produk (`Detail_Pesanan`).
5. **BR-05:** Harga unit pada `Detail_Pesanan` harus mengunci (mengisi) harga historis saat pesanan dibuat, tidak boleh berubah mengikuti naik/turunnya harga pada entitas `Produk` di kemudian hari.
6. **BR-06:** Total pembayaran pada entitas `Pembayaran` harus bernilai sama persis dengan total tagihan pesanan ditambah ongkos kirim pada entitas `Pesanan`.
7. **BR-07:** Stok produk pada entitas `Produk` akan otomatis berkurang sesuai jumlah kuantitas dibeli ketika pesanan berhasil dikonfirmasi.
8. **BR-08:** Status pesanan secara berurutan harus melalui tahapan: *Menunggu Pembayaran* -> *Diverifikasi* -> *Dikirim* -> *Selesai* (atau *Dibatalkan*).

---

## 4. Kebutuhan Informasi

1. **K-01 (Laporan Penjualan Harian):** Menampilkan total pendapatan, jumlah pesanan masuk, dan daftar produk terlaris dalam rentang tanggal tertentu.
2. **K-02 (Katalog Produk Aktif):** Menampilkan daftar produk beserta kategori, harga, dan sisa stok yang tersedia untuk pembeli.
3. **K-03 (Riwayat Transaksi Pelanggan):** Menampilkan riwayat pesanan lengkap pelanggan tertentu beserta status pembayaran dan nomor resi pengiriman.
4. **K-04 (Peringatan Stok Menipis):** Menampilkan daftar produk yang jumlah stoknya kurang dari batas minimum (kurang dari 10 unit) untuk dipesan ulang.
5. **K-05 (Rekapitulasi Pembayaran):** Menampilkan rekap metode pembayaran yang digunakan pelanggan beserta status verifikasi pembayaran oleh admin.

---

## 5. Matriks CRUD (Create, Read, Update, Delete)

| Entitas | Proses 1: Registrasi Pelanggan | Proses 2: Manajemen Katalog | Proses 3: Checkout Pesanan | Proses 4: Pembayaran & Pengiriman |
| --- | --- | --- | --- | --- |
| **`Pelanggan`** | **C, R, U** | R | R | R |
| **`Kategori`** | - | **C, R, U, D** | R | - |
| **`Produk`** | - | **C, R, U, D** | **R, U** *(Potong Stok)* | R |
| **`Pesanan`** | - | - | **C, R, U** | **R, U** *(Ubah Status)* |
| **`Detail_Pesanan`** | - | - | **C, R** | R |
| **`Pembayaran`** | - | - | - | **C, R, U** |

*Catatan Kepatuhan Matriks CRUD:* Seluruh 6 entitas kandidat memiliki minimal satu operasi **Create (C)** pada rantai proses bisnis di atas.

---

## 6. Kamus Data Awal (20 Elemen Data)

| No | Nama Elemen Data | Entitas | Tipe Data | Keterangan / Deskripsi | Penanggung Jawab |
| --- | --- | --- | --- | --- | --- |
| 1 | `id_pelanggan` | Pelanggan | INT (PK) | ID unik identitas pelanggan | Tim Database Admin |
| 2 | `nama_lengkap` | Pelanggan | VARCHAR(100) | Nama lengkap pelanggan | Tim Customer Service |
| 3 | `email` | Pelanggan | VARCHAR(100) | Email aktif untuk login pelanggan | Tim Security / IT |
| 4 | `no_telepon` | Pelanggan | VARCHAR(15) | Nomor HP/WhatsApp aktif pelanggan | Tim Customer Service |
| 5 | `alamat_pengiriman` | Pelanggan | TEXT | Alamat lengkap tujuan pengiriman | Tim Logistik |
| 6 | `id_kategori` | Kategori | INT (PK) | ID unik pengelompokan kategori | Tim Content/Product |
| 7 | `nama_kategori` | Kategori | VARCHAR(50) | Nama kelompok barang (misal: Baju) | Tim Content/Product |
| 8 | `id_produk` | Produk | INT (PK) | ID unik produk barang | Tim Gudang |
| 9 | `nama_produk` | Produk | VARCHAR(150) | Nama barang yang dijual | Tim Content/Product |
| 10 | `harga_produk` | Produk | DECIMAL(12,2) | Harga jual resmi saat ini | Tim Keuangan |
| 11 | `stok_produk` | Produk | INT | Sisa jumlah unit barang di gudang | Tim Gudang |
| 12 | `id_pesanan` | Pesanan | INT (PK) | ID unik transaksi pesanan | Tim Operational |
| 13 | `tgl_pesanan` | Pesanan | DATETIME | Waktu dan tanggal pesanan dibuat | Tim System Automation |
| 14 | `total_harga` | Pesanan | DECIMAL(12,2) | Total harga seluruh barang dibeli | Tim Keuangan |
| 15 | `ongkos_kirim` | Pesanan | DECIMAL(10,2) | Biaya pengiriman ekspedisi | Tim Logistik |
| 16 | `status_pesanan` | Pesanan | VARCHAR(30) | Status posisi pesanan saat ini | Tim Logistik |
| 17 | `jumlah_beli` | Detail_Pesanan | INT | Kuantitas barang yang dipesan | Tim Operational |
| 18 | `harga_snapshot` | Detail_Pesanan | DECIMAL(12,2) | Harga jual satuan saat checkout | Tim Keuangan |
| 19 | `metode_bayar` | Pembayaran | VARCHAR(50) | Metode transfer (BCA/QRIS/Mandiri) | Tim Keuangan |
| 20 | `bukti_transfer` | Pembayaran | VARCHAR(255) | Nama file image bukti pembayaran | Tim Keuangan / CS |

---

## 7. Kebutuhan Non-Fungsional & Keamanan Data Pribadi

### A. Identifikasi Data Pribadi (PII - Personally Identifiable Information)

Elemen data berikut dikategorikan sebagai **Data Pribadi Sensitif**:

* `nama_lengkap`, `email`, `no_telepon`, `alamat_pengiriman`, dan `bukti_transfer`.

### B. Matriks Hak Akses Data Pribadi

1. **Pelanggan:** Hanya dapat membaca dan memperbarui data pribadi milik akunnya sendiri.
2. **Tim Logistik & Kurir:** Hanya dapat membaca `nama_lengkap`, `no_telepon`, dan `alamat_pengiriman` untuk keperluan pengiriman barang.
3. **Tim Customer Service:** Dapat membaca seluruh data kontak pelanggan untuk menyelesaikan komplain transaksi.
4. **Tim Keuangan:** Dapat mengakses `bukti_transfer` untuk validasi pembayaran.
5. **Pengembang (`helen_117`):** Dilarang melihat data asli pelanggan pada lingkungan *production*; wajib dilakukan penyamaran (*data masking*) pada lingkungan pengujian (*development*).

---

## 8. Dokumen Sumber Fiktif & Pembedahannya

### A. Contoh Dokumen Sumber Fiktif (Halaman Pesanan & Resi Pengiriman)

Sesuai tema Toko Daring, harga, ongkos kirim, dan alamat pengiriman disimpan per pesanan.

```
====================================================================
                        HAS ONLINE STORE
                 Bukti Pesanan Resmi (Invoice)
====================================================================
No. Pesanan   : INV/20261006/117
Tanggal       : 06 Oktober 2026
Pelanggan     : Helen Awanda Saumitha (0812-3456-7890)
Alamat Kirim  : Jl. Metro Lampung No. 117, Kota Metro

```

---

No  Nama Barang           Qty    Harga Satuan     Subtotal

---

1. Kemeja Oversize Cokelat 2     Rp 120.000       Rp 240.000
2. Celana Kulot Hitam      1     Rp 150.000       Rp 150.000

---

```
Subtotal Produk : Rp 390.000
Ongkos Kirim    : Rp  20.000
TOTAL BAYAR     : Rp 410.000
Status          : LUNAS (Via Transfer QRIS)
====================================================================

```

### B. Pembedahan Dokumen Sumber ke Entitas Data

* **Header Nota** -> Ditempatkan pada entitas **`Pesanan`** (`id_pesanan`, `tgl_pesanan`, `total_harga`, `ongkos_kirim`, `status_pesanan`).
* **Data Pelanggan** -> Merujuk ke entitas **`Pelanggan`** (`id_pelanggan`, `nama_lengkap`, `no_telepon`, `alamat_pengiriman`).
* **Rincian Item Tabel** -> Ditempatkan pada entitas **`Detail_Pesanan`** (`jumlah_beli`, `harga_snapshot`).
* **Nama Item Barang** -> Merujuk ke entitas **`Produk`** (`id_produk`, `nama_produk`).
* **Status Lunas & QRIS** -> Ditempatkan pada entitas **`Pembayaran`** (`metode_bayar`).

```

```