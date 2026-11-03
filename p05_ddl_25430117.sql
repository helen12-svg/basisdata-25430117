-- P05_DDL_<NIM>.sql
-- Skrip DDL Basis Data Toko Daring (Milestone Proyek 5)

-- Hapus tabel terlebih dahulu dengan urutan yang benar untuk menghindari konflik Foreign Key
DROP TABLE IF EXISTS detail_penjualan;
DROP TABLE IF EXISTS penjualan;
DROP TABLE IF EXISTS produk;
DROP TABLE IF EXISTS kategori;
DROP TABLE IF EXISTS pelanggan;

-- 1. Tabel Pelanggan (Anggota)
CREATE TABLE pelanggan (
    id_pelanggan INT AUTO_INCREMENT PRIMARY KEY,
    nama_pelanggan VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telepon VARCHAR(20),
    alamat TEXT
);

-- 2. Tabel Kategori Produk
CREATE TABLE kategori (
    id_kategori INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(50) NOT NULL
);

-- 3. Tabel Produk
-- Mengakomodasi latihan: constraint CHECK untuk stok minimal tidak negatif (AB-xx)
CREATE TABLE produk (
    id_produk INT AUTO_INCREMENT PRIMARY KEY,
    id_kategori INT NOT NULL,
    nama_produk VARCHAR(100) NOT NULL,
    harga DECIMAL(12, 2) NOT NULL,
    stok INT NOT NULL,
    stok_min_barang INT NOT NULL,
    CONSTRAINT fk_produk_kategori FOREIGN KEY (id_kategori) REFERENCES kategori(id_kategori)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_stok_min_non_negative CHECK (stok_min_barang >= 0) -- AB-01: Aturan bisnis stok minimum tidak negatif
);

-- 4. Tabel Penjualan (Transaksi Utama)
CREATE TABLE penjualan (
    id_penjualan INT AUTO_INCREMENT PRIMARY KEY,
    id_pelanggan INT NULL, -- Dapat bernilai NULL jika anggota dihapus (ON DELETE SET NULL sesuai instruksi latihan)
    tanggal_penjualan DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_harga DECIMAL(12, 2) NOT NULL,
    CONSTRAINT fk_penjualan_pelanggan FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan)
        ON UPDATE CASCADE ON DELETE SET NULL -- AB-02: Kebijakan penghapusan anggota
);

-- 5. Tabel Detail Penjualan
-- Mengakomodasi batas P + 2 untuk qty per item menggunakan CHECK
CREATE TABLE detail_penjualan (
    id_penjualan INT NOT NULL,
    id_produk INT NOT NULL,
    qty INT NOT NULL,
    subtotal DECIMAL(12, 2) NOT NULL,
    PRIMARY KEY (id_penjualan, id_produk),
    CONSTRAINT fk_detail_penjualan FOREIGN KEY (id_penjualan) REFERENCES penjualan(id_penjualan)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_detail_produk FOREIGN KEY (id_produk) REFERENCES produk(id_produk)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_qty_positif CHECK (qty > 0) -- Batas P+2: Qty per item harus bernilai positif (> 0)
);