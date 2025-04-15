import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math'; // Required for 3D flip effect

class ProjectSection extends StatefulWidget {
  final GlobalKey projectKey;
  const ProjectSection({Key? key, required this.projectKey}) : super(key: key);

  @override
  _ProjectSectionState createState() => _ProjectSectionState();
}

class _ProjectSectionState extends State<ProjectSection> {
  int hoveredIndex = -1; // Track hovered card

  final List<Map<String, String>> projects = [
    {
      "title": "Routiner - Habit Tracker",
      "duration": "Jun 2024 - Jul 2024",
      "tools": "JavaFX, OOP, Exception Handling, GitLab",
      "description":
          "A habit tracking app with an interactive UI and exception handling.",
      "url": "https://gitlab.com/codevengers3/habbit-tracker.git",
      "image": "assets/Project_assets/Habbit_Tracker_image.jpg",
    },
    {
      "title": "To-Do App",
      "duration": "Dec 2023",
      "tools": "Flutter, State Management, SQL Database",
      "description":
          "A cross-platform mobile app with SQLite integration and custom UI.",
      "url": "https://github.com/OmkarNarwade/ToDo-App",
      "image": "assets/Project_assets/todo_app.jpg",
    },
    {
      "title": "Quiz App",
      "duration": "Nov 2023",
      "tools": "Flutter, State Management",
      "description":
          "A dynamic quiz app with real-time answer validation and score summary.",
      "url": "https://github.com/OmkarNarwade/Quiz-App",
      "image": "assets/Project_assets/quiz_app.jpg",
    },
    {
      "title": "Network Exploit Detection Using ML",
      "duration": "Jan-Feb 2024",
      "tools": "Flutter, Machine Learning, Python, Network Security",
      "description":
          "An AI-powered system that detects cyber threats in real-time by analyzing network traffic patterns. Using ML algorithms, it identifies anomalies, ensuring proactive security. Integrated with a Flutter-based dashboard, it provides an interactive and insightful view for network monitoring.",
      "url": "https://github.com/OmkarNarwade",
      "image": "assets/Project_assets/netwok_exploit_detection.jpg",
    }
  ];

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.projectKey,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          Text(
            "PROJECTS",
            style: GoogleFonts.montserrat(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
              shadows: [
                const Shadow(offset: Offset(-4, 4), color: Colors.white24),
              ],
            ),
          ),

          const SizedBox(height: 20),
          // Project Cards with Flip Animation
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: List.generate(projects.length, (index) {
              return Column(
                children: [
                  _buildProjectCard(projects[index], index),
                  const SizedBox(height: 8), // Space between card and title
                  Text(
                    projects[index]["title"]!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(Map<String, String> project, int index) {
    return MouseRegion(
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = -1),
      child: TweenAnimationBuilder(
        tween: Tween<double>(
            begin: hoveredIndex == index ? pi : 0.0,
            end: hoveredIndex == index ? 0.0 : pi),
        duration: const Duration(milliseconds: 500),
        builder: (context, double value, child) {
          final isFront = value < pi / 2;
          final flipDirection = index.isEven ? 1.0 : -1.0; // Left or Right

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // Perspective effect
              ..rotateY(flipDirection * value),
            child: Stack(
              children: [
                // Back Side (Project Info)
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(pi),
                  child: _buildFrontCard(project),
                ),
                // Front Side (Image)
                if (isFront) _buildBackCard(project),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFrontCard(Map<String, String> project) {
    return Container(
      width: 350,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white70, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          project["image"]!,
          fit: BoxFit.cover, // Full-size image
        ),
      ),
    );
  }

  Widget _buildBackCard(Map<String, String> project) {
    return GestureDetector(
      onTap: () => _launchURL(project["url"]!),
      child: Container(
        width: 350,
        height: 300,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white70, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              project["duration"]!,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              project["tools"]!,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              project["description"]!,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white54,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "Click to View More",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
