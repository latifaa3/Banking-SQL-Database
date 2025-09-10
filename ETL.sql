-- Tabel Dimensi Karyawan
USE tubesdwh;
CREATE TABLE dimensi_karyawan (
  karyawan_id INT NOT NULL,
  nama_karyawan VARCHAR(100) NOT NULL,
  jabatan VARCHAR(100) NOT NULL
);

-- ETL
INSERT INTO dimensi_karyawan (
    karyawan_id,
    nama_karyawan,
    jabatan
)

SELECT 
    karyawan.karyawan_id,
    karyawan.nama_karyawan,
    karyawan.jabatan
FROM 
    karyawan;

-- Tabel Dimensi Rekening
USE tubesdwh;
CREATE TABLE dimensi_rekening (
  rekening_id INT NOT NULL,
  nama_nasabah VARCHAR(100) NOT NULL,
  saldo DECIMAL(18, 2) NOT NULL,
  alamat VARCHAR(255) NOT NULL
);

-- ETL
INSERT INTO dimensi_rekening (
    rekening_id,
    nama_nasabah,
    saldo,
    alamat
)

SELECT 
    rekening.rekening_id,
    rekening.nama_nasabah,
    rekening.saldo,
    rekening.alamat
FROM 
    rekening;

-- Tabel Dimensi Kantor Cabang
USE tubesdwh;
CREATE TABLE dimensi_kantor_cabang (
  cabang_id INT NOT NULL,
  nama_cabang VARCHAR(100) NOT NULL,
  kota VARCHAR(100) NOT NULL
);

-- ETL
INSERT INTO dimensi_kantor_cabang (
    cabang_id,
    nama_cabang,
    kota
)

SELECT 
    kantor_cabang.cabang_id,
    kantor_cabang.nama_cabang,
    kantor_cabang.kota
FROM 
    kantor_cabang;
    
-- Tabel Dimensi Waktu
USE tubesdwh;
CREATE TABLE dimensi_waktu (
	waktu_id INT AUTO_INCREMENT PRIMARY KEY,
    waktu DATE,
    tanggal INT,
    nama_bulan VARCHAR(20),
    tahun INT
);

-- Memasukkan data dari tabel setor
USE tubesdwh;
INSERT INTO dimensi_waktu (waktu,tanggal,nama_bulan,tahun)
SELECT
    tanggal_setor AS waktu,
    DAY(tanggal_setor) AS tanggal,
    CASE
        WHEN EXTRACT(MONTH FROM tanggal_setor) = 1 THEN 'Januari'
        WHEN EXTRACT(MONTH FROM tanggal_setor) = 2 THEN 'Februari'
        WHEN EXTRACT(MONTH FROM tanggal_setor) = 3 THEN 'Maret'
        WHEN EXTRACT(MONTH FROM tanggal_setor) = 4 THEN 'April'
        WHEN EXTRACT(MONTH FROM tanggal_setor) = 5 THEN 'Mei'
        WHEN EXTRACT(MONTH FROM tanggal_setor) = 6 THEN 'Juni'
        WHEN EXTRACT(MONTH FROM tanggal_setor) = 7 THEN 'Juli'
        WHEN EXTRACT(MONTH FROM tanggal_setor) = 8 THEN 'Agustus'
        WHEN EXTRACT(MONTH FROM tanggal_setor) = 9 THEN 'September'
        WHEN EXTRACT(MONTH FROM tanggal_setor) = 10 THEN 'Oktober'
        WHEN EXTRACT(MONTH FROM tanggal_setor) = 11 THEN 'November'
        WHEN EXTRACT(MONTH FROM tanggal_setor) = 12 THEN 'Desember'
    END AS nama_bulan,
    YEAR(tanggal_setor) AS tahun
FROM
    setor;

    
-- Memasukkan data dari tabel transfer
INSERT INTO dimensi_waktu (waktu, tanggal, nama_bulan, tahun)
SELECT
    tanggal_transfer AS waktu,
    DAY(tanggal_transfer) AS tanggal,
    CASE
        WHEN EXTRACT(MONTH FROM tanggal_transfer) = 1 THEN 'Januari'
        WHEN EXTRACT(MONTH FROM tanggal_transfer) = 2 THEN 'Februari'
        WHEN EXTRACT(MONTH FROM tanggal_transfer) = 3 THEN 'Maret'
        WHEN EXTRACT(MONTH FROM tanggal_transfer) = 4 THEN 'April'
        WHEN EXTRACT(MONTH FROM tanggal_transfer) = 5 THEN 'Mei'
        WHEN EXTRACT(MONTH FROM tanggal_transfer) = 6 THEN 'Juni'
        WHEN EXTRACT(MONTH FROM tanggal_transfer) = 7 THEN 'Juli'
        WHEN EXTRACT(MONTH FROM tanggal_transfer) = 8 THEN 'Agustus'
        WHEN EXTRACT(MONTH FROM tanggal_transfer) = 9 THEN 'September'
        WHEN EXTRACT(MONTH FROM tanggal_transfer) = 10 THEN 'Oktober'
        WHEN EXTRACT(MONTH FROM tanggal_transfer) = 11 THEN 'November'
        WHEN EXTRACT(MONTH FROM tanggal_transfer) = 12 THEN 'Desember'
    END AS nama_bulan,
    YEAR(tanggal_transfer) AS tahun
FROM
    transfer
ON DUPLICATE KEY UPDATE waktu_id = waktu_id;

-- Memasukkan data dari tabel tarikTunai
INSERT INTO dimensi_waktu (waktu, tanggal, nama_bulan, tahun)
SELECT
    tanggal_tarikTunai AS waktu,
    DAY(tanggal_tarikTunai) AS tanggal,
    CASE
        WHEN EXTRACT(MONTH FROM tanggal_tarikTunai) = 1 THEN 'Januari'
        WHEN EXTRACT(MONTH FROM tanggal_tarikTunai) = 2 THEN 'Februari'
        WHEN EXTRACT(MONTH FROM tanggal_tarikTunai) = 3 THEN 'Maret'
        WHEN EXTRACT(MONTH FROM tanggal_tarikTunai) = 4 THEN 'April'
        WHEN EXTRACT(MONTH FROM tanggal_tarikTunai) = 5 THEN 'Mei'
        WHEN EXTRACT(MONTH FROM tanggal_tarikTunai) = 6 THEN 'Juni'
        WHEN EXTRACT(MONTH FROM tanggal_tarikTunai) = 7 THEN 'Juli'
        WHEN EXTRACT(MONTH FROM tanggal_tarikTunai) = 8 THEN 'Agustus'
        WHEN EXTRACT(MONTH FROM tanggal_tarikTunai) = 9 THEN 'September'
        WHEN EXTRACT(MONTH FROM tanggal_tarikTunai) = 10 THEN 'Oktober'
        WHEN EXTRACT(MONTH FROM tanggal_tarikTunai) = 11 THEN 'November'
        WHEN EXTRACT(MONTH FROM tanggal_tarikTunai) = 12 THEN 'Desember'
    END AS nama_bulan,
    YEAR(tanggal_tarikTunai) AS tahun
FROM
    tarik_tunai
ON DUPLICATE KEY UPDATE waktu_id = waktu_id;

-- Tabel Dimensi Jenis Transaksi
CREATE TABLE dimensi_jenis_transaksi (
    jenis_transaksi_id INT AUTO_INCREMENT PRIMARY KEY,
    rekening_id INT,
    karyawan_id INT,
    cabang_id INT,
    jenis_transaksi VARCHAR(50),
    tanggal_transaksi DATE,
    jumlah_transaksi DECIMAL(15,2)
);

-- ETL
-- Memasukkan data dari tabel transfer
INSERT INTO dimensi_jenis_transaksi (rekening_id, karyawan_id, cabang_id, jenis_transaksi, tanggal_transaksi, jumlah_transaksi)
SELECT
	rekening_pengirim AS rekening_id,
    karyawan_id AS karyawan_id,
    cabang_id AS cabang_id,
    'Transfer' AS jenis_transaksi,
    tanggal_transfer AS tanggal_transaksi,
    jumlah_transfer AS jumlah_transaksi
FROM
    transfer;

-- Memasukkan data dari tabel setor
INSERT INTO dimensi_jenis_transaksi (rekening_id, karyawan_id, cabang_id, jenis_transaksi, tanggal_transaksi, jumlah_transaksi)
SELECT
	rekening_pengirim AS rekening_id,
    karyawan_id AS karyawan_id,
    cabang_id AS cabang_id,
    'Setor' AS jenis_transaksi,
    tanggal_setor AS tanggal_transaksi,
    jumlah_setor AS jumlah_transaksi
FROM
    setor;

-- Memasukkan data dari tabel tarikTunai
INSERT INTO dimensi_jenis_transaksi (rekening_id, karyawan_id, cabang_id, jenis_transaksi, tanggal_transaksi, jumlah_transaksi)
SELECT
	rekening_pengirim AS rekening_id,
    karyawan_id AS karyawan_id,
    cabang_id AS cabang_id,
    'tarikTunai' AS jenis_transaksi,
    tanggal_tarikTunai AS tanggal_transaksi,
    jumlah_tunai AS jumlah_transaksi
FROM
    tarik_tunai;

-- Tabel Fakta Transaksi Nasabah
-- DDL
CREATE TABLE fakta_transaksi_nasabah (
 	transaksi_id INT AUTO_INCREMENT PRIMARY KEY,
    rekening_id INT,
    waktu_id INT,
    cabang_id INT,
    karyawan_id INT,
    jenis_transaksi_id INT,
    jenis_transaksi VARCHAR(50),
    tanggal_transaksi DATE,
    jumlah_transaksi DECIMAL,
    biaya_admin DECIMAL,
    
    FOREIGN KEY (rekening_id) REFERENCES dimensi_rekening(rekening_id),
    FOREIGN KEY (waktu_id) REFERENCES dimensi_waktu(waktu_id),
    FOREIGN KEY (cabang_id) REFERENCES dimensi_kantor_cabang(cabang_id),
    FOREIGN KEY (karyawan_id) REFERENCES dimensi_karyawan(karyawan_id)
);

-- ETL
INSERT INTO fakta_transaksi_nasabah (
    rekening_id, 
    waktu_id, 
    cabang_id, 
    karyawan_id, 
    jenis_transaksi_id, 
    jenis_transaksi, 
    tanggal_transaksi, 
    jumlah_transaksi, 
    biaya_admin
)
SELECT
    dr.rekening_id,
    dw.waktu_id,
    dc.cabang_id,
    dk.karyawan_id,
    dj.jenis_transaksi_id,
    dj.jenis_transaksi,
    dj.tanggal_transaksi,
    dj.jumlah_transaksi,
    SUM(dj.jumlah_transaksi * 0.01) AS biaya_admin
FROM dimensi_rekening dr 
JOIN dimensi_jenis_transaksi dj ON dr.rekening_id = dj.rekening_id
JOIN dimensi_karyawan dk ON dj.karyawan_id = dk.karyawan_id
JOIN dimensi_kantor_cabang dc ON dj.cabang_id = dc.cabang_id
JOIN dimensi_waktu dw ON dj.tanggal_transaksi = dw.waktu
GROUP BY 
    dr.rekening_id,
    dw.waktu_id,
    dc.cabang_id,
    dk.karyawan_id,
    dj.jenis_transaksi_id,
    dj.jenis_transaksi,
    dj.tanggal_transaksi,
    dj.jumlah_transaksi;
