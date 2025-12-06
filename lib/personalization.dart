import 'package:flutter/material.dart';

// Warna Hijau Tua Khusus untuk Header
const Color kHeaderGreen = Color.fromARGB(255, 23, 65, 25);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Step1Page(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          // Seed Color tetap menggunakan warna hijau tua yang diminta
          seedColor: kHeaderGreen,
        ),
        // Opsi: Menggunakan Material3 agar warna default elemen UI sesuai seed
        useMaterial3: true,
      ),
    );
  }
}

// ============================================================
// ========================= CLIPPER ==========================
// ============================================================

// CustomClipper untuk Header yang melengkung
class CurvedHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// ============================================================
// ========================= WIDGETS ==========================
// ============================================================

// Header visual (menggantikan CurvedAppBar)
class CurvedHeader extends StatelessWidget {
  final String title;
  final String step;
  final Color backgroundColor;
  final Function()? onBack;

  const CurvedHeader({
    super.key,
    required this.title,
    required this.step,
    required this.backgroundColor,
    this.onBack,
  });

  final double headerHeight = 150.0;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedHeaderClipper(),
      child: Container(
        height: headerHeight,
        // WARNA INI YANG DIUBAH
        color: backgroundColor,
        child: SafeArea(
          // Mengganti AppBar dengan Column dan Row kustom
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bagian 1: Row Kustom (Panah, Step, Lewati)
              Padding(
                // Padding vertikal agar sedikit turun dari atas
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tombol Kembali (Panah Kiri) - Hanya tampil di Step 2 dan 3
                    if (step != '1/3')
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: onBack ?? () => Navigator.pop(context),
                        ),
                      )
                    else
                      // Placeholder agar elemen kanan tetap di kanan penuh
                      const SizedBox(width: 40, height: 40),

                    // Sisi Kanan: Penomoran Step dan Tombol Lewati
                    Row(
                      children: [
                        // Teks Step (Misalnya "3/3") - Tidak terbungkus
                        Text(
                          step,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8), // Jarak pemisah
                        // Tombol Lewati (Dibungkus Pil)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Lewati",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Bagian 2: Judul Utama
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget untuk Judul setiap bagian pertanyaan (Ikon daun di dalam lingkaran)
Widget sectionTitle(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Row(
      children: [
        // KOTAK MELINGKAR DI BELAKANG IKON DAUN
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color.fromARGB(255, 42, 120, 40),
              width: 1,
            ),
          ),
          child: const Icon(
            Icons.eco,
            color: const Color.fromARGB(255, 42, 120, 40),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

// Pembungkus untuk setiap set pertanyaan
Widget QuestionBox({required List<Widget> children}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ),
  );
}

// Widget untuk kartu pilihan (radio button)
Widget optionCard({
  required bool selected,
  required Function() onTap,
  required String text,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected
              ? const Color.fromARGB(255, 42, 120, 40)
              : Colors.grey.shade300,
          width: selected ? 2 : 1,
        ),
        color: selected
            ? const Color.fromARGB(255, 42, 120, 40).withOpacity(0.08)
            : Colors.white,
      ),
      child: Row(
        children: [
          Icon(
            selected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: selected
                ? const Color.fromARGB(255, 42, 120, 40)
                : Colors.grey,
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    ),
  );
}

// ============================================================
// ========================= STEP 1 ===========================
// ============================================================

class Step1Page extends StatefulWidget {
  @override
  State<Step1Page> createState() => _Step1PageState();
}

class _Step1PageState extends State<Step1Page> {
  String? pengalaman;
  String? tujuan;

  final double headerHeight = 150.0;
  final double contentRadius = 25.0;
  final double bottomNavHeight = 90.0;

  @override
  Widget build(BuildContext context) {
    final double contentOffsetTop = headerHeight - contentRadius;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: Stack(
        children: [
          // 1. Header Melengkung (Bagian Hijau)
          CurvedHeader(
            // MENGGANTI HANYA BAGIAN INI: menggunakan kHeaderGreen
            backgroundColor: kHeaderGreen,
            step: "1/3",
            title: "Yuk Jawab Biar HydropoMe Tahu Kebutuhanmu 💚",
          ),

          // 2. Konten Utama (SingleChildScrollView)
          Padding(
            padding: EdgeInsets.only(top: contentOffsetTop),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ).copyWith(top: 0, bottom: bottomNavHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: contentRadius / 2),

                  // PERTANYAAN 1
                  QuestionBox(
                    children: [
                      sectionTitle(
                        "Apakah kamu pernah mencoba menanam hidroponik sebelumnya?",
                      ),
                      optionCard(
                        selected: pengalaman == "belum",
                        onTap: () => setState(() => pengalaman = "belum"),
                        text: "Belum pernah",
                      ),
                      optionCard(
                        selected: pengalaman == "pemula",
                        onTap: () => setState(() => pengalaman = "pemula"),
                        text: "Pernah, tapi masih pemula",
                      ),
                      optionCard(
                        selected: pengalaman == "berpengalaman",
                        onTap: () =>
                            setState(() => pengalaman = "berpengalaman"),
                        text: "Sudah cukup berpengalaman",
                      ),
                    ],
                  ),

                  // PERTANYAAN 2
                  QuestionBox(
                    children: [
                      sectionTitle(
                        "Apa tujuan utama kamu menggunakan aplikasi HydropoMe?",
                      ),
                      optionCard(
                        selected: tujuan == "belajar",
                        onTap: () => setState(() => tujuan = "belajar"),
                        text: "Belajar hidroponik dari awal",
                      ),
                      optionCard(
                        selected: tujuan == "merawat",
                        onTap: () => setState(() => tujuan = "merawat"),
                        text: "Merawat tanaman hidroponik yang sudah ada",
                      ),
                      optionCard(
                        selected: tujuan == "membeli",
                        onTap: () => setState(() => tujuan = "membeli"),
                        text: "Membeli peralatan dan perlengkapan hidroponik",
                      ),
                      optionCard(
                        selected: tujuan == "menjual",
                        onTap: () => setState(() => tujuan = "menjual"),
                        text: "Menjual hasil panen",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Tombol Selanjutnya (fixed di bawah)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color.fromARGB(
                255,
                42,
                120,
                40,
              ), // Kembali ke Colors.green
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Step2Page()),
              );
            },
            child: const Text("Selanjutnya", style: TextStyle(fontSize: 16)),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// ========================= STEP 2 ===========================
// ============================================================

class Step2Page extends StatefulWidget {
  @override
  State<Step2Page> createState() => _Step2PageState();
}

class _Step2PageState extends State<Step2Page> {
  List<String> jenis = [];
  String? waktu;
  String? lokasi;

  // Menggunakan checkbox yang bisa dipilih lebih dari satu
  Widget checkboxCard({
    required bool selected,
    required Function() onTap,
    required String text,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? const Color.fromARGB(255, 42, 120, 40)
                : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
          color: selected
              ? const Color.fromARGB(255, 42, 120, 40).withOpacity(0.08)
              : Colors.white,
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.check_box : Icons.check_box_outline_blank,
              color: selected
                  ? const Color.fromARGB(255, 42, 120, 40)
                  : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(text)),
          ],
        ),
      ),
    );
  }

  // Menggunakan radio button yang hanya bisa dipilih satu
  Widget radioCard({
    required bool selected,
    required Function() onTap,
    required String text,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? const Color.fromARGB(255, 42, 120, 40)
                : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
          color: selected
              ? const Color.fromARGB(255, 42, 120, 40).withOpacity(0.08)
              : Colors.white,
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected
                  ? const Color.fromARGB(255, 42, 120, 40)
                  : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(text)),
          ],
        ),
      ),
    );
  }

  final double headerHeight = 150.0;
  final double contentRadius = 25.0;
  final double bottomNavHeight = 90.0;

  @override
  Widget build(BuildContext context) {
    final double contentOffsetTop = headerHeight - contentRadius;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: Stack(
        children: [
          // 1. Header Melengkung (Bagian Hijau)
          CurvedHeader(
            // MENGGANTI HANYA BAGIAN INI: menggunakan kHeaderGreen
            backgroundColor: kHeaderGreen,
            step: "2/3",
            title: "Yuk Jawab Biar HydropoMe Tahu Kebutuhanmu 💚",
          ),

          // 2. Konten Utama (SingleChildScrollView)
          Padding(
            padding: EdgeInsets.only(top: contentOffsetTop),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ).copyWith(top: 0, bottom: bottomNavHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: contentRadius / 2),

                  // PERTANYAAN 1 (Jenis Tanaman)
                  QuestionBox(
                    children: [
                      sectionTitle(
                        "Jenis tanaman apa saja yang ingin kamu tanam?",
                      ),
                      checkboxCard(
                        selected: jenis.contains("sayuran"),
                        onTap: () {
                          setState(() {
                            jenis.contains("sayuran")
                                ? jenis.remove("sayuran")
                                : jenis.add("sayuran");
                          });
                        },
                        text: "Sayuran daun (misalnya selada, bayam)",
                      ),
                      checkboxCard(
                        selected: jenis.contains("buah"),
                        onTap: () {
                          setState(() {
                            jenis.contains("buah")
                                ? jenis.remove("buah")
                                : jenis.add("buah");
                          });
                        },
                        text: "Buah (misalnya tomat, stroberi)",
                      ),
                      checkboxCard(
                        selected: jenis.contains("herbal"),
                        onTap: () {
                          setState(() {
                            jenis.contains("herbal")
                                ? jenis.remove("herbal")
                                : jenis.add("herbal");
                          });
                        },
                        text: "Tanaman herbal",
                      ),
                      checkboxCard(
                        selected: jenis.contains("rekomendasi"),
                        onTap: () {
                          setState(() {
                            jenis.contains("rekomendasi")
                                ? jenis.remove("rekomendasi")
                                : jenis.add("rekomendasi");
                          });
                        },
                        text: "Belum tahu / ingin rekomendasi",
                      ),
                    ],
                  ),

                  // PERTANYAAN 2 (Waktu Luang)
                  QuestionBox(
                    children: [
                      sectionTitle(
                        "Berapa waktu yang bisa kamu luangkan per hari?",
                      ),
                      radioCard(
                        selected: waktu == "<10",
                        onTap: () => setState(() => waktu = "<10"),
                        text: "< 10 menit",
                      ),
                      radioCard(
                        selected: waktu == "10-30",
                        onTap: () => setState(() => waktu = "10-30"),
                        text: "10–30 menit",
                      ),
                      radioCard(
                        selected: waktu == ">30",
                        onTap: () => setState(() => waktu = ">30"),
                        text: "> 30 menit",
                      ),
                    ],
                  ),

                  // PERTANYAAN 3 (Lokasi)
                  QuestionBox(
                    children: [
                      sectionTitle(
                        "Di mana kamu akan menanam tanaman hidroponik?",
                      ),
                      radioCard(
                        selected: lokasi == "indoor",
                        onTap: () => setState(() => lokasi = "indoor"),
                        text: "Dalam ruangan",
                      ),
                      radioCard(
                        selected: lokasi == "outdoor",
                        onTap: () => setState(() => lokasi = "outdoor"),
                        text: "Luar ruangan",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Tombol Selanjutnya (fixed di bawah)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color.fromARGB(
                255,
                42,
                120,
                40,
              ), // Kembali ke Colors.green
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Step3Page()),
              );
            },
            child: const Text("Selanjutnya", style: TextStyle(fontSize: 16)),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// ========================= STEP 3 ===========================
// ============================================================

class Step3Page extends StatefulWidget {
  @override
  State<Step3Page> createState() => _Step3PageState();
}

class _Step3PageState extends State<Step3Page> {
  String? area;

  // Modifikasi: optionArea menerima widget kustom
  Widget optionArea({
    required String value,
    required String label,
    required Widget iconOrImage,
  }) {
    bool selected = area == value;

    return GestureDetector(
      onTap: () => setState(() => area = value),
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? const Color.fromARGB(255, 42, 120, 40)
                : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
          color: selected
              ? const Color.fromARGB(255, 42, 120, 40).withOpacity(0.08)
              : Colors.white,
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected
                  ? const Color.fromARGB(255, 42, 120, 40)
                  : Colors.grey,
            ),
            const SizedBox(width: 12),

            // Ilustrasi/Ikon untuk Area Tanam
            iconOrImage,

            const SizedBox(width: 12),
            Expanded(child: Text(label)),
          ],
        ),
      ),
    );
  }

  final double headerHeight = 150.0;
  final double contentRadius = 25.0;
  final double bottomNavHeight = 90.0;

  @override
  Widget build(BuildContext context) {
    final double contentOffsetTop = headerHeight - contentRadius;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: Stack(
        children: [
          // 1. Header Melengkung (Bagian Hijau)
          CurvedHeader(
            // MENGGANTI HANYA BAGIAN INI: menggunakan kHeaderGreen
            backgroundColor: kHeaderGreen,
            step: "3/3",
            title: "Yuk Jawab Biar HydropoMe Tahu Kebutuhanmu 💚",
          ),

          // 2. Konten Utama (SingleChildScrollView)
          Padding(
            padding: EdgeInsets.only(top: contentOffsetTop),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ).copyWith(top: 0, bottom: bottomNavHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: contentRadius / 2),

                  // PERTANYAAN 1 (Area Tanam)
                  QuestionBox(
                    children: [
                      sectionTitle("Berapa luas area tanam yang kamu miliki?"),

                      // Opsi 1: < 1 m² (Ukuran Gambar Kecil)
                      optionArea(
                        value: "<1",
                        label: "< 1 m²",
                        iconOrImage: Image.asset(
                          'assets/ukuran.png', // FILE ASET TUNGGAL
                          width: 30,
                          height: 30,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.crop_square,
                            size: 30,
                            color: const Color.fromARGB(
                              255,
                              42,
                              120,
                              40,
                            ), // Kembali ke Colors.green
                          ),
                        ),
                      ),

                      // Opsi 2: 1–3 m² (Ukuran Gambar Sedang)
                      optionArea(
                        value: "1-3",
                        label: "1–3 m²",
                        iconOrImage: Image.asset(
                          'assets/ukuran.png', // FILE ASET TUNGGAL
                          width: 45,
                          height: 45,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.crop_landscape,
                            size: 45,
                            color: const Color.fromARGB(
                              255,
                              42,
                              120,
                              40,
                            ), // Kembali ke Colors.green
                          ),
                        ),
                      ),

                      // Opsi 3: > 3 m² (Ukuran Gambar Besar)
                      optionArea(
                        value: ">3",
                        label: "> 3 m²",
                        iconOrImage: Image.asset(
                          'assets/ukuran.png', // FILE ASET TUNGGAL
                          width: 60,
                          height: 60,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.crop_original,
                            size: 60,
                            color: const Color.fromARGB(
                              255,
                              42,
                              120,
                              40,
                            ), // Kembali ke Colors.green
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Tombol Simpan (fixed di bawah)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color.fromARGB(
                255,
                42,
                120,
                40,
              ), // Kembali ke Colors.green
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {},
            child: const Text("Simpan", style: TextStyle(fontSize: 16)),
          ),
        ),
      ),
    );
  }
}
