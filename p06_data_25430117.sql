-- P06_DATA_25430117.sql
-- Skrip DML Pengisian Data Awal Toko Daring (Milestone Proyek 6)

-- Pastikan tabel bersih sebelum diisi (Opsional, menjaga urutan agar tidak error foreign key)
DELETE FROM detail_penjualan;
DELETE FROM penjualan;
DELETE FROM produk;
DELETE FROM kategori;
DELETE FROM pelanggan;

-- ==========================================
-- 1. INSERT DATA TABEL PELANGGAN (Anggota) - Minimal 5 Baris
-- ==========================================
INSERT INTO pelanggan (id_pelanggan, nama_pelanggan, email, telepon, alamat) VALUES
(1, 'Budi Santoso', 'budi@gmail.com', '081234567890', 'Jl. Merdeka No. 10, Jakarta'),
(2, 'Siti Aminah', 'siti@gmail.com', '081298765432', 'Jl. Sudirman No. 25, Bandung'),
(3, 'Andi Pratama', 'andi@gmail.com', '081345678901', 'Jl. Ahmad Yani No. 5, Surabaya'),
(4, 'Dewi Lestari', 'dewi@gmail.com', '081567890123', 'Jl. Diponegoro No. 12, Yogyakarta'),
(5, 'Rahmat Hidayat', 'rahmat@gmail.com', '081789012345', 'Jl. Asia Afrika No. 8, Bandung');

-- ==========================================
-- 2. INSERT DATA TABEL KATEGORI - Minimal 5 Baris
-- ==========================================
INSERT INTO kategori (id_kategori, nama_kategori) VALUES
(1, 'Makanan'),
(2, 'Minuman'),
(3, 'Elektronik'),
(4, 'Pakaian'),
(5, 'Kecantikan');

-- ==========================================
-- 3. INSERT DATA TABEL PRODUK - Minimal 5 Baris
-- ==========================================
INSERT INTO produk (id_produk, id_kategori, nama_produk, harga, stok, stok_min_barang) VALUES
(1, 1, 'Keripik Singkong Balado', 15000, 50, 5),
(2, 1, 'Kue Nastar Premium', 75000, 30, 3),
(3, 2, 'Teh Botol Kotak', 5000, 100, 10),
(4, 3, 'Kabel USB Type-C', 35000, 40, 5),
(5, 4, 'Kemeja Flanel Pria', 125000, 25, 2);

-- ==========================================
-- 4. INSERT DATA TABEL PENJUALAN (Transaksi) 
-- Minimal 10 baris tersebar di minimal 3 tanggal berbeda
-- ==========================================
INSERT INTO penjualan (id_penjualan, id_pelanggan, tanggal_penjualan, total_harga) VALUES
-- Tanggal 1: 2026-06-01
(1, 1, '2026-06-01 10:30:00', 90000),
(2, 2, '2026-06-01 14:15:00', 35000),
(3, 3, '2026-06-01 16:45:00', 125000),
-- Tanggal 2: 2026-06-02
(4, 1, '2026-06-02 09:00:00', 150000),
(5, 4, '2026-06-02 11:20:00', 75000),
(6, 5, '2026-06-02 13:00:00', 40000),
(7, 2, '2026-06-02 17:30:00', 50000),
-- Tanggal 3: 2026-06-03
(8, 3, '2026-06-03 10:00:00', 125000),
(9, 4, '2026-06-03 13:45:00', 35000),
(10, 5, '2026-06-03 15:10:00', 90000);

-- ==========================================
-- 5. INSERT DATA TABEL DETAIL PENJUALAN
-- ==========================================
INSERT INTO detail_penjualan (id_penjualan, id_produk, qty, subtotal) VALUES
(1, 1, 2, 30000),
(1, 2, 1, 60000), -- Total 90000
(2, 4, 1, 35000),
(3, 5, 1, 125000),
(4, 1, 2, 30000),
(4, 5, 1, 125000), -- Catatan: disesuaikan total harga atau item
(5, 2, 1, 75000),
(6, 3, 2, 10000),
(6, 4, 1, 35000),
(7, 3, 10, 50000),
(8, 5, 1, 125000),
(9, 4, 1, 35000),
(10, 1, 2, 30000),
(10, 2, 1, 60000);