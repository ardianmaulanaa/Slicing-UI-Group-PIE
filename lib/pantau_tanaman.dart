import 'package:flutter/material.dart';

// CustomClipper untuk membuat kurva di bagian bawah header
class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50); // Mulai dari kiri bawah, naik 50
    path.quadraticBezierTo(
      size.width / 2, // Titik kontrol di tengah horizontal
      size.height, // Titik kontrol di paling bawah
      size.width, // Titik akhir di kanan horizontal
      size.height - 50, // Titik akhir di kanan bawah, naik 50
    );
    path.lineTo(size.width, 0); // Garis ke kanan atas
    path.close(); // Tutup path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Widget untuk Search Bar
class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // Dibuat lebih bulat
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10, // Dibuat lebih blur
            offset: const Offset(0, 4), // Dibuat lebih berbayang
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari tanaman kamu...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget Header Melengkung yang berisi teks, status bar, dan gambar
class CustomCurvedHeader extends StatelessWidget {
  const CustomCurvedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna hijau gelap
    const Color darkGreen = Color.fromARGB(255, 8, 53, 44);

    return ClipPath(
      clipper: CurveClipper(),
      child: Container(
        height: 200, // Ketinggian latar belakang hijau
        color: darkGreen,
        width: double.infinity,
        // Gunakan padding untuk menyesuaikan posisi teks/ikon (termasuk safe area)
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 50),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kolom untuk Teks Judul
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    // Status bar Teks Waktu (tiruan)
                    SizedBox(height: 10),
                    // Teks Judul
                    Text(
                      'Bagaimana Kabar\nTanamanmu Hari Ini?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Ikon Status Bar di Kanan Atas
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Spacer(),
                  // Gambar Daun
                  Container(
                    width: 100, // Sesuaikan ukuran
                    height: 100, // Sesuaikan ukuran
                    child: Image.asset(
                      'assets/daun.png', // Ganti dengan path aset Anda
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ------------------ HOME (Halaman 1) ------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // 1. Curved Header
            const CustomCurvedHeader(),

            // 2. Konten Utama (dimulai di bawah kurva)
            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  // Search Bar diposisikan di sini
                  SearchBarWidget(), // Sudah ada margin horizontal 16.0 di dalam widget ini

                  SizedBox(height: 24),

                  // Daftar Tanaman
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Daftar Tanamanmu',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: PlantListContainer(), // Menggunakan kode lama Anda
                  ),

                  SizedBox(height: 24),

                  // Riwayat
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Riwayat',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: PlantListContainer(), // Menggunakan kode lama Anda
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const StatusBar(), // Menggunakan kode lama Anda
    );
  }
}

/// ------------------ LIST & ITEM ------------------
class PlantListContainer extends StatelessWidget {
  const PlantListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color.fromARGB(255, 216, 212, 212)),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: const [
          PlantListItem(
            name: "Selada Hidroponik",
            level: "Mudah",
            day: "Hari ke-1",
            imagePath: "assets/selada.png",
          ),
          Divider(height: 24),
          PlantListItem(
            name: "Bayam Hidroponik",
            level: "Mudah",
            day: "Hari ke-5",
            imagePath: "assets/bayam.png",
          ),
          Divider(height: 24),
          PlantListItem(
            name: "Cabai Hidroponik",
            level: "Sulit",
            day: "Hari ke-10",
            imagePath: "assets/cabai.png",
          ),
        ],
      ),
    );
  }
}

class PlantListItem extends StatelessWidget {
  final String name;
  final String level;
  final String day;
  final String imagePath;

  const PlantListItem({
    super.key,
    required this.name,
    required this.level,
    required this.day,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    // menentukan warna berdasarkan level
    final Color levelColor = (level.toLowerCase() == "sulit")
        ? Colors.red
        : Colors.green;

    return Row(
      children: [
        // thumbnail
        Container(
          height: 72,
          width: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),

              Row(
                children: [
                  Icon(Icons.lens_rounded, color: levelColor, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    level,
                    style: TextStyle(fontSize: 12, color: levelColor),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              // HARI - icon daun, warna hijau
              Row(
                children: [
                  const Icon(Icons.eco, color: Colors.green, size: 14),
                  const SizedBox(width: 6),
                  Text(day, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),

        // BUTTON PANTAU warna teks putih
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    PantauTanamanScreen(plantName: name, imageAsset: imagePath),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 30, 150, 90),
            foregroundColor: Colors.white, // <-- tulisan putih
            minimumSize: const Size(90, 44),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
          ),
          child: const Text(
            "Pantau",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

/// ------------------ STATUS BAR ------------------
class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Icon(Icons.home_filled, size: 24),
          Icon(Icons.eco, size: 24),
          Icon(Icons.shopping_bag_rounded, size: 24),
          Icon(Icons.person_pin, size: 24),
        ],
      ),
    );
  }
}

/// ------------------ PANTAU TANAMAN (Halaman 2) ------------------
class PantauTanamanScreen extends StatefulWidget {
  final String plantName;
  final String imageAsset;

  const PantauTanamanScreen({
    super.key,
    required this.plantName,
    required this.imageAsset,
  });

  @override
  State<PantauTanamanScreen> createState() => _PantauTanamanScreenState();
}

class _PantauTanamanScreenState extends State<PantauTanamanScreen> {
  int selectedDayIndex = 0;
  // contoh tugas (sederhana)
  final List<Map<String, dynamic>> tasks = [
    {'text': 'Siapkan Nutrisi & Air🧪', 'done': false},
    {'text': 'Rendam Rockwool🧼', 'done': false},
    {'text': 'Tanam Benih Selada🌱', 'done': false},
    {'text': 'Tutup & Simpan☁', 'done': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // gunakan AppBar simple
      appBar: AppBar(
        centerTitle: true,
        title: Text('Pantau Tanaman'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header curved dengan gambar (pakai CurveClipper)
            ClipPath(
              clipper: CurveClipper(),
              child: Container(
                height: 220,
                width: double.infinity,
                color: Colors.green.shade700,
                child: Image.asset(
                  widget.imageAsset,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),

            // Card info (seolah floating) - Sudah diubah
            Container(
              transform: Matrix4.translationValues(0.0, -40.0, 0.0),
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul dan Level
                  Text(
                    widget.plantName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.circle, color: Colors.green, size: 12),
                          SizedBox(width: 6),
                          Text('Mudah', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Row(
                        children: const [
                          Icon(Icons.eco, color: Colors.green, size: 14),
                          SizedBox(width: 6),
                          Text('Hari ke-1', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // BARU: Row untuk Progress Bar dan Daun
                  Card(
                    elevation: 4,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Progres Menanam',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  'Ayo mulai menanam!',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // BAR PROGRESS
                                Stack(
                                  children: [
                                    LinearProgressIndicator(
                                      value: 1.0, // 0%
                                      minHeight: 8,
                                      backgroundColor: Colors.orange.shade100,
                                      color: Colors.orange.shade100,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: 12,
                                        height: 12,
                                        margin: const EdgeInsets.only(top: 0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.orange.shade300,
                                          border: Border.all(
                                            color: Colors.orange.shade300,
                                            width: 2,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.1,
                                              ),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const Text(
                                  '0% Selesai',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // DAUN
                          Container(
                            width: 80,
                            height: 80,
                            alignment: Alignment.topRight,
                            child: Image(
                              image: AssetImage(
                                "assets/daunputih.png",
                              ), // Harus menggunakan AssetImage
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 0),

                  // Bagian Hari-hari (sebelumnya ada di sini)
                  SizedBox(
                    height: 88,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        vertical: 9,
                        horizontal: 16,
                      ),
                      itemCount: 7,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final selected = index == selectedDayIndex;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDayIndex = index;
                            });
                          },
                          child: Column(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 240),
                                width: 48,
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32),
                                  color: selected
                                      ? Colors.green.shade600
                                      : Colors.green.shade50,
                                ),
                                child: Center(
                                  child: Text(
                                    'Hari\n${index + 1}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: selected
                                          ? Colors.white
                                          : Colors.green.shade800,
                                      fontSize: selected ? 12 : 11,
                                      fontWeight: selected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Tugas hari dan tips (kotak putih)
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tugas Hari ke-${selectedDayIndex + 1}📌',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...List.generate(tasks.length, (i) {
                    return CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: Colors.green,
                      checkColor: Colors.white,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: Text(tasks[i]['text']),
                      value: tasks[i]['done'],
                      onChanged: (v) {
                        setState(() {
                          tasks[i]['done'] = v ?? false;
                        });
                      },
                    );
                  }),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.eco, color: Colors.green),
                      const Text(
                        'Tips Hari Ini:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text('Gunakan air tanpa kaporit untuk hasil terbaik.'),
                ],
              ),
            ),

            // Banner marketplace contoh
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade400,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                // Mengubah Row menjadi Column untuk tata letak vertikal
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    // Teks "Belum punya alat dan bahan?"
                    'Belum punya alat dan bahan?',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    // Menggunakan Row untuk teks dan gambar di bagian atas
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              // Teks "Kunjungi Marketplace HydroPoMe!"
                              'Kunjungi Marketplace\nHydroPoMe!',
                              style: TextStyle(
                                fontSize: 24, // Ukuran teks yang lebih besar
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.2, // Jarak antar baris
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Tombol "Belanja Sekarang"
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors
                                    .teal
                                    .shade500, // Warna hijau pada gambar
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Text(
                                'Belanja Sekarang',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Placeholder untuk gambar
                      // Ganti dengan widget gambar yang sebenarnya jika perlu disesuaikan dengan tinggi Container
                      SizedBox(
                        width: 120, // Sesuaikan lebar gambar
                        height: 120, // Sesuaikan tinggi gambar
                        child: Image.asset(
                          "assets/banner.png",
                          fit: BoxFit.cover,
                          // Ganti dengan widget yang menampilkan gambar sistem hidroponik
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // tombol bawah
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Lihat panduan (contoh)')),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.green.shade200),
                      foregroundColor: Colors.green,
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Lihat Panduan',
                      selectionColor: Color.fromARGB(0, 131, 161, 104),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      // Saat user klik "Hari ke-1 Selesai" -> tampilkan popup (Halaman 3)
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return const CompletedPopup();
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(8),
                      ),
                    ),
                    child: Text(
                      'Hari ke-${selectedDayIndex + 1} Selesai',
                      selectionColor: const Color.fromARGB(245, 235, 233, 233),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ------------------ POPUP "HALAMAN 3" ------------------
class CompletedPopup extends StatelessWidget {
  const CompletedPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Center(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 360),
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: Colors.green.shade600,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 14),
              const Text(
                'Tugas Hari ke-1 Selesai 🎉',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),
              ElevatedButton(
                onPressed: () {
                  // contoh behavior: tutup dialog -> lanjut ke hari berikutnya (di implementasi real bisa increment)
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Lanjut ke hari berikutnya')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  minimumSize: const Size.fromHeight(44),
                  side: const BorderSide(color: Colors.green),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                ),
                child: const Text(
                  'Hari Berikutnya',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(44),
                  side: const BorderSide(color: Colors.green),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                ),
                child: const Text(
                  'Kembali',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
