import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutSection extends StatelessWidget {
  final GlobalKey aboutKey;
  const AboutSection({Key? key, required this.aboutKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Colors.grey],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          // Sidebar Section
          Expanded(
            flex: 1,
            child: Container(
              key: aboutKey,
              color: Colors.black87,
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Image with CircleAvatar
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: const CircleAvatar(
                        radius: 95,
                        backgroundImage: AssetImage('assets/omkar_image.jpg'),
                      ),
                    ),

                    const SizedBox(height: 15),
                    Text(
                      "Omkar Narwade",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Electronics & Telecommunication Engineer",
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Divider(
                        color: Colors.white30, thickness: 1, height: 30),

                    _buildSectionTitle("Personal Details"),
                    _buildEducationCard(
                      FontAwesomeIcons.graduationCap,
                      "Degree",
                      "Bachelor of Engineering",
                    ),
                    _buildEducationCard(
                      FontAwesomeIcons.language,
                      "Known Languages",
                      "Marathi, Hindi, English",
                    ),
                    _buildEducationCard(
                      FontAwesomeIcons.laptopCode,
                      "Technical Skills ",
                      "GitHub, SQLFlite, Firebase",
                    ),
                    _buildEducationCard(
                      FontAwesomeIcons.signsPost,
                      "Intrest",
                      "Traveling, Cricket",
                    ),
                    const Divider(
                        color: Colors.white30, thickness: 1, height: 30),
                  ],
                ),
              ),
            ),
          ),

          // Main Content SectiCertificateon
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("ABOUT ME", isHeader: true),
                  const SizedBox(height: 10),
                  _buildSectionTitle("BRIEF SUMMARY"),
                  Text(
                    "A detail-oriented Electronics and Telecommunication Engineering student with expertise in Java, Python, Dart, and Flutter for cross-platform development. Experienced in object-oriented programming, multithreading, data structures, and mobile application development.",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSectionTitle("Technical Skills"),
                  _buildSkillIndicator("Java", 0.9),
                  _buildSkillIndicator("Python", 0.8),
                  _buildSkillIndicator("Dart", 0.85),
                  _buildSkillIndicator("Flutter Framework", 0.9),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationCard(IconData icon, String title, String details) {
    return Card(
      color: Colors.black54,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            FaIcon(icon, color: Colors.white70, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    details,
                    style: GoogleFonts.poppins(
                        color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        title,
        style: isHeader
            ? GoogleFonts.montserrat(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  const Shadow(
                    blurRadius: 3,
                    color: Color.fromARGB(255, 119, 118, 118),
                    offset: Offset(5, 5),
                  ),
                ],
              )
            : GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
      ),
    );
  }

  Widget _buildSkillIndicator(String skill, double level) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            skill,
            style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 5),
          TweenAnimationBuilder<double>(
            duration: const Duration(seconds: 2),
            curve: Curves.easeOut,
            tween: Tween<double>(begin: 0, end: level),
            builder: (context, value, child) {
              return Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    height: 12,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.grey[800],
                    ),
                  ),
                  Container(
                    height: 12,
                    width: 850 * value,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
