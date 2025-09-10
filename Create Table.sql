USE coba1;

-- Tabel Data Kantor_Cabang
CREATE TABLE Kantor_Cabang (
    cabang_id INT PRIMARY KEY,
    nama_cabang VARCHAR(100),
    kota VARCHAR(100)
);

-- Tabel Data Karyawan
CREATE TABLE Karyawan (
    karyawan_id INT PRIMARY KEY,
    nama_karyawan VARCHAR(100),
    jabatan VARCHAR(100)
);

-- Tabel Data Rekening
CREATE TABLE Rekening (
    rekening_id INT PRIMARY KEY,
    nama_nasabah VARCHAR(100),
    saldo DECIMAL(18, 2),
    alamat VARCHAR(255)
);

-- Tabel Data Setor
CREATE TABLE Setor (
    setor_id INT PRIMARY KEY,
    rekening_pengirim INT,
    rekening_penerima INT,
    karyawan_id INT,
    cabang_id INT,
    jumlah_setor DECIMAL(18, 2),
    tanggal_setor DATE,
    FOREIGN KEY (rekening_pengirim) REFERENCES Rekening(rekening_id),
    FOREIGN KEY (rekening_penerima) REFERENCES Rekening(rekening_id),
    FOREIGN KEY (karyawan_id) REFERENCES Karyawan(karyawan_id),
    FOREIGN KEY (cabang_id) REFERENCES Kantor_Cabang(cabang_id)
);

-- Tabel Data Transfer
CREATE TABLE Transfer (
    transfer_id INT PRIMARY KEY,
    rekening_pengirim INT,
    rekening_penerima INT,
    karyawan_id INT,
    cabang_id INT, 
    jumlah_transfer DECIMAL(18, 2),
    tanggal_transfer DATE,
    FOREIGN KEY (rekening_pengirim) REFERENCES Rekening(rekening_id),
    FOREIGN KEY (rekening_penerima) REFERENCES Rekening(rekening_id),
    FOREIGN KEY (karyawan_id) REFERENCES Karyawan(karyawan_id),
    FOREIGN KEY (cabang_id) REFERENCES Kantor_Cabang(cabang_id)
);

-- Tabel Data Tarik_tunai
CREATE TABLE Tarik_tunai (
    tarikTunai_id INT PRIMARY KEY,
    rekening_pengirim INT,
    rekening_penerima INT,
	karyawan_id INT,
    cabang_id INT, 
    jumlah_tunai DECIMAL(18, 2),
    tanggal_tarikTunai DATE,
    FOREIGN KEY (rekening_pengirim) REFERENCES Rekening(rekening_id),
    FOREIGN KEY (rekening_penerima) REFERENCES Rekening(rekening_id),
    FOREIGN KEY (karyawan_id) REFERENCES Karyawan(karyawan_id),
    FOREIGN KEY (cabang_id) REFERENCES Kantor_Cabang(cabang_id)
);