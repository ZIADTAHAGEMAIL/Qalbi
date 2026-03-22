import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


///  This Page From AI
///  This Page From AI
///  This Page From AI
///  This Page From AI
///  This Page From AI
///  This Page From AI
///  This Page From AI
///  This Page From AI
///  This Page From AI
///  This Page From AI
///  This Page From AI
///  This Page From AI
///  This Page From AI
///  This Page From AI
///  This Page From AI
///  This Page From AI

class Profileview extends StatefulWidget {
  const Profileview({super.key});

  @override
  State<Profileview> createState() => _ProfileviewState();
}

class _ProfileviewState extends State<Profileview> {
  double _fontSize = 1.2;
  String _selectedTheme = 'Light';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),

      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle("APPEARANCE"),
          _buildGroup([
            _buildThemeSelector(),
            const Divider(height: 1),
            _buildFontSizeSlider(),
          ]),

          _buildSectionTitle("GENERAL"),
          _buildGroup([
            _buildListTile(Icons.language, "Language", trailing: "English"),
            const Divider(height: 1),
            _buildListTile(
              Icons.gps_fixed,
              "Prayer Calculation",
              trailing: "UIS (Karachi)",
            ),
            const Divider(height: 1),
            _buildListTile(
              Icons.notifications_active_outlined,
              "Notifications",
              trailing: "Adhan Only",
            ),
          ]),

          _buildSectionTitle("QURAN SETTINGS"), // إضافة من عندي لتكملة التطبيق
          _buildGroup([
            _buildListTile(
              Icons.person_outline,
              "Reciter",
              trailing: "Mishary Alafasy",
            ),
            const Divider(height: 1),
            _buildListTile(
              Icons.download_for_offline_outlined,
              "Download Manager",
              trailing: "",
            ),
          ]),

          _buildSectionTitle("ABOUT & HELP"),
          _buildGroup([
            _buildListTile(Icons.description_outlined, "Terms of Service"),
            const Divider(height: 1),
            _buildListTile(Icons.privacy_tip_outlined, "Privacy Policy"),
            const Divider(height: 1),
            _buildListTile(Icons.send_outlined, "Send Feedback"),
            const Divider(height: 1),
            _buildListTile(Icons.info_outline, "Version 2.1.4"),
          ]),

          const SizedBox(height: 20),
          _buildGroup([
            _buildListTile(
              Icons.exit_to_app,
              "Sign Out",
              color: Colors.red,
              showArrow: false,
            ),
          ]),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // ويدجت لعنوان القسم
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8, top: 20),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // ويدجت لتجميع العناصر في بلوك واحد بحواف دائرية
  Widget _buildGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: children),
    );
  }

  // عنصر القائمة العادي
  Widget _buildListTile(
    IconData icon,
    String title, {
    String? trailing,
    Color color = Colors.black,
    bool showArrow = true,
  }) {
    return ListTile(
      leading: Icon(icon, color: color, size: 22),
      title: Text(title, style: TextStyle(color: color, fontSize: 16)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing != null)
            Text(
              trailing,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
          if (showArrow)
            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
      onTap: () {},
    );
  }

  // اختيار الثيم (Light, Dark, AMOLED)
  Widget _buildThemeSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Theme", style: TextStyle(fontSize: 16)),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: ['Light', 'Dark', 'AMOLED'].map((t) {
                bool isSelected = _selectedTheme == t;
                return GestureDetector(
                  onTap: () => setState(() => _selectedTheme = t),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xff00af87)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      t,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // سلايدر حجم الخط
  Widget _buildFontSizeSlider() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Quran Font Size", style: TextStyle(fontSize: 16)),
          Row(
            children: [
              const Text("A", style: TextStyle(fontSize: 14)),
              Expanded(
                child: Slider(
                  value: _fontSize,
                  min: 0.8,
                  max: 2.0,
                  activeColor: const Color(0xff00af87),
                  onChanged: (v) => setState(() => _fontSize = v),
                ),
              ),
              const Text("A", style: TextStyle(fontSize: 24)),
            ],
          ),
          Center(
            child: Text(
              "${(_fontSize * 100).toInt()}%",
              style: const TextStyle(
                color: Color(0xff00af87),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
