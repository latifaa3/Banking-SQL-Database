-- Total Transaksi per Rekening
USE tubesdwh;
SELECT
	rekening_id,
    SUM(jumlah_transaksi) AS total_transaksi
FROM
	fakta_transaksi_nasabah
GROUP BY
	rekening_id;
    
    
-- Menghitung berapa kali transaksi yang dilakukan per cabang
USE tubesdwh;
SELECT
	dc.cabang_id,
    dc.nama_cabang,
    dc.kota,
    COUNT(*) AS jumlah_transaksi
FROM
	fakta_transaksi_nasabah ftn
JOIN
	dimensi_kantor_cabang dc ON ftn.cabang_id = dc.cabang_id
GROUP BY
	dc.cabang_id,
    dc.nama_cabang,
    dc.kota
ORDER BY
	jumlah_transaksi DESC;
    
-- Karyawan yang melayani nasabah terbanyak
USE tubesdwh;
SELECT
	dk.karyawan_id,
    dk.nama_karyawan,
    COUNT(ftn.transaksi_id) AS jumlah_transaksi
FROM
	fakta_transaksi_nasabah ftn
JOIN
	dimensi_karyawan dk ON ftn.karyawan_id = dk.karyawan_id
GROUP BY
	dk.karyawan_id, dk.nama_karyawan
ORDER BY
	jumlah_transaksi DESC;
    
    
-- Karyawan yang melayani nasabah terbanyak pada tahun 2021
USE tubesdwh;
SELECT 
	dk.karyawan_id,
    dk.nama_karyawan,
    COUNT(*) AS jumlah_transaksi
FROM
	fakta_transaksi_nasabah ftn
JOIN
	dimensi_karyawan dk ON ftn.karyawan_id = dk.karyawan_id
WHERE
	YEAR(tanggal_transaksi) = 2021
GROUP BY
	dk.karyawan_id,
    dk.nama_karyawan
ORDER BY
	jumlah_transaksi DESC;
