
const lampu = prompt("Masukkan Warna Lampu (merah, kuning, hijau):").toLowerCase();
let pesan;

if (lampu === "merah") {
    pesan = "Kendaraan Berhenti";
} else if (lampu === "kuning") {
    pesan = "Kendaraan Hati-hati";
} else{
    pesan = "Kendaraan Berjalan";
} 