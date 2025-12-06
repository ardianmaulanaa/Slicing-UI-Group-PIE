import 'package:flutter/material.dart';

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 50,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Widget statusItem(String asset, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(asset, width: 40, height: 40),
          const SizedBox(height: 5),
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget profileMenu({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = const Color(0xFF063F33),
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: color.withOpacity(0.5), width: 1),
                  color: color.withOpacity(0.05),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 15),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward,
                color: color.withOpacity(0.5),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco),
            label: "Pantau Tanaman",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Marketplace",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin),
            label: "Profil",
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipPath(
            clipper: CurveClipper(),
            child: Container(
              width: double.infinity,
              height: 200,
              color: const Color(0xFF063F33),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage("assets/profile.png"),
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Mellafesa",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "mellafesaa@gmail.com",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => const EditProfilePage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(5),
                        ),
                        backgroundColor: Colors.green.shade500,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 8,
                        ),
                      ),
                      child: const Text("Edit Profil"),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Status Pesanan Marketplace",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      statusItem("assets/diproses.png", "Diproses", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) =>
                                const OrderStatusPage(initialTab: 0),
                          ),
                        );
                      }),
                      statusItem("assets/dikirim.png", "Dikirim", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) =>
                                const OrderStatusPage(initialTab: 1),
                          ),
                        );
                      }),
                      statusItem("assets/selesai.png", "Selesai", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) =>
                                const OrderStatusPage(initialTab: 2),
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          profileMenu(icon: Icons.eco, title: "Personalisasi", onTap: () {}),
          profileMenu(
            icon: Icons.logout,
            title: "Logout",
            color: Colors.red,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  static const Color primaryGreen = Color.fromARGB(255, 25, 84, 51);
  static const Color fillColor = Color.fromARGB(255, 235, 250, 236);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Edit Profil", style: TextStyle(color: Colors.black)),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ProfileImageWithEditButton(onEditPressed: () {}),
              const SizedBox(height: 30),

              inputField("Nama Lengkap", "Mellafesa"),
              const SizedBox(height: 20),

              inputField("Email", "mellafesaa@gmail.com"),
              const SizedBox(height: 20),

              passwordField("Password"),
              const SizedBox(height: 20),

              passwordField("Ubah Password"),
              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  "Simpan",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: value),
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryGreen),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryGreen, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget passwordField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor,
            suffixIcon: const Icon(Icons.visibility_off, color: primaryGreen),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryGreen),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryGreen, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileImageWithEditButton extends StatelessWidget {
  final VoidCallback onEditPressed;

  const ProfileImageWithEditButton({super.key, required this.onEditPressed});

  static const Color primaryGreen = Color.fromARGB(255, 25, 84, 51);
  static const double avatarRadius = 40;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: avatarRadius * 2,
      height: avatarRadius * 2,
      child: Stack(
        children: [
          const CircleAvatar(
            radius: avatarRadius,
            backgroundImage: AssetImage("assets/profile.png"),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onEditPressed,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: primaryGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit_square,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderStatusPage extends StatefulWidget {
  final int initialTab;

  const OrderStatusPage({super.key, this.initialTab = 0});

  @override
  State<OrderStatusPage> createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  late int selected;

  @override
  void initState() {
    selected = widget.initialTab;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Status Pesanan",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                tabButton("Diproses", 0),
                const SizedBox(width: 10),
                tabButton("Dikirim", 1),
                const SizedBox(width: 10),
                tabButton("Selesai", 2),
              ],
            ),
            const SizedBox(height: 25),
            orderCard(),
          ],
        ),
      ),
    );
  }

  Widget tabButton(String text, int index) {
    bool active = selected == index;
    return GestureDetector(
      onTap: () => setState(() => selected = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
        decoration: BoxDecoration(
          color: active ? Colors.green.shade700 : Colors.green.shade100,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? Colors.white : Colors.green,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget orderCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/paket.png",
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Paket Lengkap",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Rp 25.000   ~Rp 50.000~",
                      style: TextStyle(
                        color: Color.fromARGB(255, 25, 84, 51),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Jumlah produk: 1pcs",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("1 produk", style: TextStyle(color: Colors.grey)),
              Text(
                "Total : Rp 35.000",
                style: TextStyle(
                  color: Color.fromARGB(255, 25, 84, 51),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
