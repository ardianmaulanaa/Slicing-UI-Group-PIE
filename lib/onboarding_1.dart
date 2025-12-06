import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'registrasilogin.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF093731),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false, // ✅ Hapus back default
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5F2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "Lewati",
              style: TextStyle(
                color: Color(0xFF179778),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Bagian gambar dengan kelengkungan
          ClipPath(
            clipper: CurveClipper(curveDepth: 180),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              width: double.infinity,
              child: Image.asset(
                'assets/img/splashboarding/bgonboarding.png',
                fit: BoxFit.cover,
                alignment: const Alignment(-0.3, 0), // geser sedikit ke kanan
              ),
            ),
          ),
          const SizedBox(height: 50),
          // Judul
          const Text(
            "Tanam Sayur Segar dari Rumah Tanpa Ribet! 🥕🍅",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          // Deskripsi
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "Bersama HydroMe, menanam sayuran untuk hidup lebih sehat dan hemat, jadi lebih mudah!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          const Spacer(),
          // Indikator halaman
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 15,
                height: 15,
                decoration: const BoxDecoration(
                  color: Color(0xFF179778),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 15,
                height: 15,
                decoration: const BoxDecoration(
                  color: Color(0x33FFFFFF),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),

          // ✅ Tombol Panah (Back & Next)
          Padding(
            padding: const EdgeInsets.only(bottom: 50, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Tombol Back
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // ✅ Navigasi kembali
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3E5E57),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    minimumSize: const Size(60, 60),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                // Tombol Next
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Onboarding2(),
                      ),
                    ); // ✅ Navigasi ke halaman berikutnya
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3E5E57),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    minimumSize: const Size(60, 60),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom clipper dengan kelengkungan dinamis
class CurveClipper extends CustomClipper<Path> {
  final double curveDepth;
  CurveClipper({this.curveDepth = 150});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 70);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 48,
      size.width,
      size.height - 80,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

// ✅ Halaman berikutnya (contoh)
class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF093731),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5F2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "Lewati",
              style: TextStyle(
                color: Color(0xFF179778),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          ClipPath(
            clipper: CurveClipper(curveDepth: 180),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              width: double.infinity,
              child: Image.asset(
                'assets/img/splashboarding/bgonboarding2.png',
                fit: BoxFit.cover,
                alignment: const Alignment(-0.3, 0),
              ),
            ),
          ),
          const SizedBox(height: 50),
          const Text(
            "Belanja Starter Kit & Jual Hasil Panen!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "Belanja, jual panen, dan penuhi kebutuhanmu di marketplace kami. Praktis banget buat kamu yang suka berkebun dari rumah!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 15,
                height: 15,
                decoration: const BoxDecoration(
                  color: Color(0x33FFFFFF),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 15,
                height: 15,
                decoration: const BoxDecoration(
                  color: Color(0xFF179778),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(bottom: 50, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3E5E57),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    minimumSize: const Size(60, 60),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Registrasilogin(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3E5E57),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    minimumSize: const Size(60, 60),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
