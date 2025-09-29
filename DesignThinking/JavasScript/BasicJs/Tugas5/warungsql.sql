CREATE DATABASE IF NOT EXISTS Warung;
USE Warung;

CREATE TABLE IF NOT EXISTS Kota (
    KodeKota VARCHAR(10) PRIMARY KEY,
    NamaKota VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Jenis_Kelamin (
    Kode_JK VARCHAR(10) PRIMARY KEY,
    Gender VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS Detail_Produk (
    Kode_DP INT AUTO_INCREMENT PRIMARY KEY,
    NamaSatuan VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Produk (
    KodeProduk VARCHAR(10) PRIMARY KEY,
    Nama VARCHAR(100) NOT NULL,
    Kode_DP INT NOT NULL,
    Stok INT DEFAULT 0,
    Harga INT NOT NULL,
    FOREIGN KEY (Kode_DP) REFERENCES Detail_Produk(Kode_DP)
);

CREATE TABLE IF NOT EXISTS Pelanggan (
    KodePelanggan VARCHAR(10) PRIMARY KEY,
    Nama VARCHAR(100) NOT NULL,
    Kode_JK VARCHAR(10) NOT NULL,
    Alamat VARCHAR(150),
    KodeKota VARCHAR(10),
    FOREIGN KEY (KodeKota) REFERENCES Kota(KodeKota),
    FOREIGN KEY (Kode_JK) REFERENCES Jenis_Kelamin(Kode_JK)
);

CREATE TABLE IF NOT EXISTS Penjualan (
    No_Jual VARCHAR(10) PRIMARY KEY,
    Tgl_Jual DATE NOT NULL,
    KodePelanggan VARCHAR(10) NOT NULL,
    FOREIGN KEY (KodePelanggan) REFERENCES Pelanggan(KodePelanggan)
);


CREATE TABLE IF NOT EXISTS Detail_Penjualan (
    No_Jual VARCHAR(10),
    KodeProduk VARCHAR(10),
    Jumlah INT NOT NULL,
    PRIMARY KEY (No_Jual, KodeProduk),
    FOREIGN KEY (No_Jual) REFERENCES Penjualan(No_Jual),
    FOREIGN KEY (KodeProduk) REFERENCES Produk(KodeProduk)
);

-- 1. PROCEDURES UNTUK TABEL KOTA

DROP PROCEDURE sp_upd_Detail_Produk;

DELIMITER //

CREATE PROCEDURE sp_ins_Kota(
    IN p_KodeKota VARCHAR(10),
    IN p_NamaKota VARCHAR(50)
)
BEGIN
    INSERT INTO Kota (KodeKota, NamaKota) 
    VALUES (p_KodeKota, p_NamaKota);
END //

-- PROCEDURES UNTUK TABEL JENIS_KELAMIN
CREATE PROCEDURE sp_ins_Jenis_Kelamin(
    IN p_Kode_JK VARCHAR(10),
    IN p_Gender VARCHAR(10)
)
BEGIN
    INSERT INTO Jenis_Kelamin (Kode_JK, Gender) 
    VALUES (p_Kode_JK, p_Gender);
END //

CREATE PROCEDURE sp_upd_Jenis_Kelamin(
    IN p_Kode_JK VARCHAR(10),
    IN p_Gender VARCHAR(10)
)
BEGIN
    UPDATE Jenis_Kelamin 
    SET Gender = p_Gender 
    WHERE Kode_JK = p_Kode_JK;
END //

CREATE PROCEDURE sp_del_Jenis_Kelamin(
    IN p_Kode_JK VARCHAR(10)
)
BEGIN
    DELETE FROM Jenis_Kelamin WHERE Kode_JK = p_Kode_JK;
END //

CREATE PROCEDURE sp_sel_Jenis_Kelamin()
BEGIN
    SELECT * FROM Jenis_Kelamin ORDER BY Kode_JK;
END //

-- PROCEDURES UNTUK TABEL DETAIL_PRODUK
CREATE PROCEDURE sp_ins_Detail_Produk(
    IN p_NamaSatuan VARCHAR(50)
)
BEGIN
    INSERT INTO Detail_Produk (NamaSatuan) 
    VALUES (p_NamaSatuan);
END //

CREATE PROCEDURE sp_upd_Detail_Produk(
    IN p_Kode_DP INT,
    IN p_NamaSatuan VARCHAR(50)
)
BEGIN
    UPDATE Detail_Produk 
    SET NamaSatuan = p_NamaSatuan 
    WHERE Kode_DP = p_Kode_DP;
END //

CREATE PROCEDURE sp_del_Detail_Produk(
    IN p_Kode_DP INT
)
BEGIN
    DELETE FROM Detail_Produk WHERE Kode_DP = p_Kode_DP;
END //

CREATE PROCEDURE sp_sel_Detail_Produk()
BEGIN
    SELECT * FROM Detail_Produk ORDER BY Kode_DP;
END //

CREATE PROCEDURE sp_upd_Kota(
    IN p_KodeKota VARCHAR(10),
    IN p_NamaKota VARCHAR(50)
)
BEGIN
    UPDATE Kota 
    SET NamaKota = p_NamaKota 
    WHERE KodeKota = p_KodeKota;
END //

CREATE PROCEDURE sp_del_Kota(
    IN p_KodeKota VARCHAR(10)
)
BEGIN
    DELETE FROM Kota WHERE KodeKota = p_KodeKota;
END //

CREATE PROCEDURE sp_sel_Kota()
BEGIN
    SELECT * FROM Kota ORDER BY KodeKota;
END //

-- 2. PROCEDURES UNTUK TABEL PRODUK
CREATE PROCEDURE sp_ins_Produk(
    IN p_KodeProduk VARCHAR(10),
    IN p_Nama VARCHAR(100),
    IN p_Kode_DP INT,
    IN p_Stok INT,
    IN p_Harga INT
)
BEGIN
    INSERT INTO Produk (KodeProduk, Nama, Kode_DP, Stok, Harga) 
    VALUES (p_KodeProduk, p_Nama, p_Kode_DP, p_Stok, p_Harga);
END //

CREATE PROCEDURE sp_upd_Produk(
    IN p_KodeProduk VARCHAR(10),
    IN p_Nama VARCHAR(100),
    IN p_Kode_DP INT,
    IN p_Stok INT,
    IN p_Harga INT
)
BEGIN
    UPDATE Produk 
    SET Nama = p_Nama, 
        Kode_DP = p_Kode_DP, 
        Stok = p_Stok, 
        Harga = p_Harga 
    WHERE KodeProduk = p_KodeProduk;
END //

CREATE PROCEDURE sp_del_Produk(
    IN p_KodeProduk VARCHAR(10)
)
BEGIN
    DELETE FROM Produk WHERE KodeProduk = p_KodeProduk;
END //

CREATE PROCEDURE sp_sel_Produk()
BEGIN
    SELECT p.*, dp.NamaSatuan 
    FROM Produk p 
    JOIN Detail_Produk dp ON p.Kode_DP = dp.Kode_DP 
    ORDER BY p.KodeProduk;
END //

-- 3. PROCEDURES UNTUK TABEL PELANGGAN
CREATE PROCEDURE sp_ins_Pelanggan(
    IN p_KodePelanggan VARCHAR(10),
    IN p_Nama VARCHAR(100),
    IN p_Kode_JK VARCHAR(10),
    IN p_Alamat VARCHAR(150),
    IN p_KodeKota VARCHAR(10)
)
BEGIN
    INSERT INTO Pelanggan (KodePelanggan, Nama, Kode_JK, Alamat, KodeKota) 
    VALUES (p_KodePelanggan, p_Nama, p_Kode_JK, p_Alamat, p_KodeKota);
END //

CREATE PROCEDURE sp_upd_Pelanggan(
    IN p_KodePelanggan VARCHAR(10),
    IN p_Nama VARCHAR(100),
    IN p_Kode_JK VARCHAR(10),
    IN p_Alamat VARCHAR(150),
    IN p_KodeKota VARCHAR(10)
)
BEGIN
    UPDATE Pelanggan 
    SET Nama = p_Nama, 
        Kode_JK = p_Kode_JK, 
        Alamat = p_Alamat, 
        KodeKota = p_KodeKota 
    WHERE KodePelanggan = p_KodePelanggan;
END //

CREATE PROCEDURE sp_del_Pelanggan(
    IN p_KodePelanggan VARCHAR(10)
)
BEGIN
    DELETE FROM Pelanggan WHERE KodePelanggan = p_KodePelanggan;
END //

CREATE PROCEDURE sp_sel_Pelanggan()
BEGIN
    SELECT p.*, jk.Gender, k.NamaKota 
    FROM Pelanggan p 
    JOIN Jenis_Kelamin jk ON p.Kode_JK = jk.Kode_JK 
    JOIN Kota k ON p.KodeKota = k.KodeKota 
    ORDER BY p.KodePelanggan;
END //

-- 4. PROCEDURES UNTUK PENJUALAN
CREATE PROCEDURE sp_ins_Penjualan(
    IN p_No_Jual VARCHAR(10),
    IN p_Tgl_Jual DATE,
    IN p_KodePelanggan VARCHAR(10)
)
BEGIN
    INSERT INTO Penjualan (No_Jual, Tgl_Jual, KodePelanggan) 
    VALUES (p_No_Jual, p_Tgl_Jual, p_KodePelanggan);
END //

CREATE PROCEDURE sp_upd_Penjualan(
    IN p_No_Jual VARCHAR(10),
    IN p_Tgl_Jual DATE,
    IN p_KodePelanggan VARCHAR(10)
)
BEGIN
    UPDATE Penjualan 
    SET Tgl_Jual = p_Tgl_Jual, 
        KodePelanggan = p_KodePelanggan 
    WHERE No_Jual = p_No_Jual;
END //

CREATE PROCEDURE sp_del_Penjualan(
    IN p_No_Jual VARCHAR(10)
)
BEGIN
    DELETE FROM Detail_Penjualan WHERE No_Jual = p_No_Jual;
    DELETE FROM Penjualan WHERE No_Jual = p_No_Jual;
END //

CREATE PROCEDURE sp_sel_Penjualan()
BEGIN
    SELECT p.*, pel.Nama as NamaPelanggan 
    FROM Penjualan p 
    JOIN Pelanggan pel ON p.KodePelanggan = pel.KodePelanggan 
    ORDER BY p.No_Jual;
END //

-- 5. PROCEDURES UNTUK DETAIL PENJUALAN
CREATE PROCEDURE sp_ins_Detail_Penjualan(
    IN p_No_Jual VARCHAR(10),
    IN p_KodeProduk VARCHAR(10),
    IN p_Jumlah INT
)
BEGIN
    INSERT INTO Detail_Penjualan (No_Jual, KodeProduk, Jumlah) 
    VALUES (p_No_Jual, p_KodeProduk, p_Jumlah);
    
    -- Update stok produk
    UPDATE Produk 
    SET Stok = Stok - p_Jumlah 
    WHERE KodeProduk = p_KodeProduk;
END //

CREATE PROCEDURE sp_upd_Detail_Penjualan(
    IN p_No_Jual VARCHAR(10),
    IN p_KodeProduk VARCHAR(10),
    IN p_Jumlah_Lama INT,
    IN p_Jumlah_Baru INT
)
BEGIN
    UPDATE Detail_Penjualan 
    SET Jumlah = p_Jumlah_Baru 
    WHERE No_Jual = p_No_Jual AND KodeProduk = p_KodeProduk;
    
    UPDATE Produk 
    SET Stok = Stok + p_Jumlah_Lama - p_Jumlah_Baru 
    WHERE KodeProduk = p_KodeProduk;
END //

CREATE PROCEDURE sp_del_Detail_Penjualan(
    IN p_No_Jual VARCHAR(10),
    IN p_KodeProduk VARCHAR(10)
)
BEGIN
    DECLARE v_Jumlah INT;
    
    SELECT Jumlah INTO v_Jumlah 
    FROM Detail_Penjualan 
    WHERE No_Jual = p_No_Jual AND KodeProduk = p_KodeProduk;
    
    DELETE FROM Detail_Penjualan 
    WHERE No_Jual = p_No_Jual AND KodeProduk = p_KodeProduk;
    
    -- Kembalikan stok
    UPDATE Produk 
    SET Stok = Stok + v_Jumlah 
    WHERE KodeProduk = p_KodeProduk;
END //

CREATE PROCEDURE sp_sel_Detail_Penjualan(
    IN p_No_Jual VARCHAR(10)
)
BEGIN
    SELECT dp.*, pr.Nama as NamaProduk, pr.Harga, 
           (dp.Jumlah * pr.Harga) as Subtotal 
    FROM Detail_Penjualan dp 
    JOIN Produk pr ON dp.KodeProduk = pr.KodeProduk 
    WHERE dp.No_Jual = p_No_Jual;
END //


CALL sp_ins_Kota('JKT', 'Jakarta');
CALL sp_ins_Kota('BDG', 'Bandung');
CALL sp_ins_Kota('SBY', 'Surabaya');

CALL sp_ins_Jenis_Kelamin('JK01', 'Pria');
CALL sp_ins_Jenis_Kelamin('JK02', 'Wanita');

CALL sp_ins_Detail_Produk('Bungkus');
CALL sp_ins_Detail_Produk('Pak');
CALL sp_ins_Detail_Produk('Botol');

CALL sp_ins_Produk('PD001', 'Indomie', 1, 10, 3000);
CALL sp_ins_Produk('PD002', 'Roti', 2, 3, 18000);
CALL sp_ins_Produk('PD003', 'Kecap', 3, 8, 4700);
CALL sp_ins_Produk('PD004', 'Saus Tomat', 3, 8, 5800);
CALL sp_ins_Produk('PD005', 'Bihun', 1, 5, 3500);
CALL sp_ins_Produk('PD006', 'Sikat Gigi', 2, 5, 15000);
CALL sp_ins_Produk('PD007', 'Pasta Gigi', 2, 7, 10000);
CALL sp_ins_Produk('PD008', 'Saus Sambal', 3, 5, 7300);

CALL sp_ins_Pelanggan('PLG01', 'Mohammad', 'JK01', 'Priok', 'JKT');
CALL sp_ins_Pelanggan('PLG02', 'Naufal', 'JK01', 'Cilincing', 'JKT');
CALL sp_ins_Pelanggan('PLG03', 'Atila', 'JK01', 'Bojongsoang', 'BDG');
CALL sp_ins_Pelanggan('PLG04', 'Tsalsa', 'JK02', 'Buah Batu', 'BDG');
CALL sp_ins_Pelanggan('PLG05', 'Damay', 'JK02', 'Gubeng', 'SBY');
CALL sp_ins_Pelanggan('PLG06', 'Tsaniy', 'JK01', 'Darmo', 'SBY');
CALL sp_ins_Pelanggan('PLG07', 'Nabila', 'JK02', 'Lebak Bulus', 'JKT');

CALL sp_ins_Penjualan('J001', '2025-09-08', 'PLG03');
CALL sp_ins_Penjualan('J002', '2025-09-08', 'PLG07');
CALL sp_ins_Penjualan('J003', '2025-09-09', 'PLG02');
CALL sp_ins_Penjualan('J004', '2025-09-10', 'PLG06');

CALL sp_ins_Detail_Penjualan('J001', 'PD001', 2);
CALL sp_ins_Detail_Penjualan('J001', 'PD003', 1);
CALL sp_ins_Detail_Penjualan('J001', 'PD004', 1);

CALL sp_ins_Detail_Penjualan('J002', 'PD006', 3);
CALL sp_ins_Detail_Penjualan('J002', 'PD007', 1);

CALL sp_ins_Detail_Penjualan('J003', 'PD001', 5);
CALL sp_ins_Detail_Penjualan('J003', 'PD004', 2);
CALL sp_ins_Detail_Penjualan('J003', 'PD008', 2);
CALL sp_ins_Detail_Penjualan('J003', 'PD003', 1);

CALL sp_ins_Detail_Penjualan('J004', 'PD002', 3);
CALL sp_ins_Detail_Penjualan('J004', 'PD004', 2);
CALL sp_ins_Detail_Penjualan('J004', 'PD008', 2);
CALL sp_ins_Detail_Penjualan('J004', 'PD006', 2);
CALL sp_ins_Detail_Penjualan('J004', 'PD007', 1);

-- Menampilkan Tabel
CALL sp_sel_Kota();
CALL sp_sel_Jenis_Kelamin();
CALL sp_sel_Pelanggan();
CALL sp_sel_Produk();
CALL sp_sel_Detail_Produk();
CALL sp_sel_Penjualan();
CALL sp_sel_Detail_Penjualan('J003');


-- function untuk menghitung penjualan pelanggan
DROP FUNCTION IF EXISTS total_penjualan;
DELIMITER $$

CREATE FUNCTION total_penjualan(
    p_no_jual VARCHAR(10)
) 
RETURNS DECIMAL(15,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(15,2) DEFAULT 0;

    SELECT COALESCE(SUM(dp.Jumlah * p.Harga), 0)
    INTO v_total
    FROM Detail_Penjualan dp
    JOIN Produk p ON dp.KodeProduk = p.KodeProduk
    WHERE dp.No_Jual = p_no_jual;

    RETURN v_total;
END $$
DELIMITER ;

SELECT total_penjualan('J001') as TotalTransaksiJ001;

DROP PROCEDURE IF EXISTS sp_cari_penjualan_by_kode_pelanggan;
DELIMITER $$

CREATE PROCEDURE sp_cari_penjualan_by_kode_pelanggan(
    IN p_kode_pelanggan VARCHAR(10)
)
BEGIN
    -- Daftar transaksi pelanggan
    SELECT 
        pj.No_Jual,
        pj.Tgl_Jual,
        pel.Nama AS NamaPelanggan,
        pel.Alamat,
        k.NamaKota,
        total_penjualan(pj.No_Jual) AS TotalTransaksi
    FROM Penjualan pj
    JOIN Pelanggan pel ON pj.KodePelanggan = pel.KodePelanggan
    JOIN Kota k ON pel.KodeKota = k.KodeKota
    WHERE pj.KodePelanggan = p_kode_pelanggan
    ORDER BY pj.Tgl_Jual DESC;

    SELECT 
        COUNT(*) AS JumlahTransaksi,
        COALESCE(SUM(total_penjualan(pj.No_Jual)), 0) AS TotalPembelian,
        COALESCE(AVG(total_penjualan(pj.No_Jual)), 0) AS RataPerTransaksi,
        MIN(pj.Tgl_Jual) AS TransaksiPertama,
        MAX(pj.Tgl_Jual) AS TransaksiTerakhir
    FROM Penjualan pj
    WHERE pj.KodePelanggan = p_kode_pelanggan;
END $$
DELIMITER ;

CALL sp_cari_penjualan_by_kode_pelanggan('PLG03');

-- Menampilkan Tabel Penjualan
SELECT 
    pj.No_Jual, 
    pj.Tgl_Jual, 
    pel.Nama AS NamaPelanggan,
    pr.Nama AS NamaProduk,
    dp.Jumlah
FROM Penjualan pj
INNER JOIN Pelanggan pel 
    ON pj.KodePelanggan = pel.KodePelanggan
INNER JOIN Detail_Penjualan dp 
    ON pj.No_Jual = dp.No_Jual
INNER JOIN Produk pr 
    ON dp.KodeProduk = pr.KodeProduk;
    
SELECT 
    pj.No_Jual,
    pj.Tgl_Jual,
    pel.KodePelanggan,
    pel.Nama AS NamaPelanggan,
    pel.Alamat,
    dp.KodeProduk,
    pr.Nama AS NamaProduk,
    dp.Jumlah,
    pr.Harga,
    (dp.Jumlah * pr.Harga) AS Subtotal
FROM Penjualan pj
INNER JOIN Pelanggan pel 
    ON pj.KodePelanggan = pel.KodePelanggan
INNER JOIN Detail_Penjualan dp 
    ON pj.No_Jual = dp.No_Jual
INNER JOIN Produk pr 
    ON dp.KodeProduk = pr.KodeProduk;



