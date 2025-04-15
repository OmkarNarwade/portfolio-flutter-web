import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EducationSection extends StatefulWidget {
  final GlobalKey educationKey;
  const EducationSection({Key? key, required this.educationKey})
      : super(key: key);

  @override
  _EducationSectionState createState() => _EducationSectionState();
}

class _EducationSectionState extends State<EducationSection> {
  int hoveredIndex = -1; // Track hovered card

  final List<Map<String, dynamic>> educationList = [
    {
      "institution": "Savitribai Phule Pune University",
      "degree": "B.E - Electronics & Telecommunication Engineering",
      "year": "2021 - 2025",
      "grade": "Grade: A",
      "icon": FontAwesomeIcons.university, // University icon
    },
    {
      "institution": "Maharashtra State Board",
      "degree": "Higher Secondary (12th)",
      "year": "2020 - 2021",
      "grade": "Grade: A",
      "icon": FontAwesomeIcons.bookOpen, // Higher secondary icon
    },
    {
      "institution": "Maharashtra State Board",
      "degree": "Secondary School (10th)",
      "year": "2019 - 2020",
      "grade": "Grade: A+",
      "icon": FontAwesomeIcons.graduationCap, // Secondary school icon
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.educationKey,
      color: Colors.black, // Dark background for black & white theme
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          Text(
            "EDUCATION",
            style: GoogleFonts.montserrat(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white, // White text for contrast
              letterSpacing: 2,
              shadows: [
                const Shadow(
                  blurRadius: 3,
                  color: Color.fromARGB(255, 119, 118, 118),
                  offset: Offset(5, 5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Education Cards
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: List.generate(educationList.length, (index) {
              return _buildEducationCard(educationList[index], index);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationCard(Map<String, dynamic> edu, int index) {
    return MouseRegion(
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = -1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 350, // Fixed width for uniformity
        height: 200, // Fixed height for all cards
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black, // Black background for the card
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white70, width: 1), // White border
          boxShadow: [
            BoxShadow(
              color: hoveredIndex == index
                  ? Colors.white.withOpacity(0.3) // Glow effect on hover
                  : Colors.white.withOpacity(0.1),
              blurRadius: 12,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Animated FontAwesome Icon
            AnimatedScale(
              scale:
                  hoveredIndex == index ? 1.3 : 1.0, // Icon enlarges on hover
              duration: const Duration(milliseconds: 300),
              child: FaIcon(
                edu["icon"],
                color: hoveredIndex == index ? Colors.white70 : Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              edu["institution"]!,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white, // White text
              ),
            ),
            const SizedBox(height: 5),
            Text(
              edu["degree"]!,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color:
                    Colors.white70, // Slightly faded white for secondary text
              ),
            ),
            const SizedBox(height: 5),
            Text(
              edu["year"]!,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color:
                    Colors.white70, // Slightly faded white for secondary text
              ),
            ),
            const SizedBox(height: 5),
            Text(
              edu["grade"]!,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white54, // More subtle for readability
              ),
            ),
          ],
        ),
      ),
    );
  }
}
