import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'dart:html' as html;

class ResumeSection extends StatefulWidget {
  final GlobalKey resumeKey;
  const ResumeSection({Key? key, required this.resumeKey})
      : super(key: resumeKey);
  @override
  _ResumeSectionState createState() => _ResumeSectionState();
}

class _ResumeSectionState extends State<ResumeSection> {
  bool isHovered = false;
  bool isPressed = false;
  final String cvPath = "assets/Resume.pdf"; // Ensure CV.pdf is in assets

  Future<void> _downloadCV(BuildContext context) async {
    try {
      if (kIsWeb) {
        // Flutter Web: Trigger download in browser
        final String pdfUrl = cvPath;
        html.AnchorElement(href: pdfUrl)
          ..setAttribute("download", "CV.pdf")
          ..click();
      } else {
        // Flutter Mobile/Desktop: Save & Open File
        final ByteData data = await rootBundle.load(cvPath);
        final List<int> bytes = data.buffer.asUint8List();
        final Directory dir = await getApplicationDocumentsDirectory();
        final String filePath = '${dir.path}/CV.pdf';
        final File file = File(filePath);
        await file.writeAsBytes(bytes);
        await OpenFile.open(filePath);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("CV downloaded successfully!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to download CV"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          Text(
            "RESUME",
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

          // Brief Info Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  "Detail-oriented Electronics & Telecommunication Engineering student with hands-on experience in Flutter, Java, Python, SQL, and Firebase. Proficient in building scalable and user-centric mobile applications, including a Habit Tracker, To-Do App, and Quiz App. Successfully completed an internship at Biencaps Systems Pvt. Ltd. as a Mobile App Developer, contributing to UI/UX enhancements and seamless backend integration. Driven by a passion for crafting innovative solutions with a strong focus on performance, usability, and real-world impact.",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Animated Download CV Button (Perfect Alignment & Spacing)
          MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: GestureDetector(
              onTapDown: (_) => setState(() => isPressed = true),
              onTapUp: (_) {
                setState(() => isPressed = false);
                _downloadCV(context);
              },
              onTapCancel: () => setState(() => isPressed = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                width: 160,
                height: 40,
                transform: isPressed
                    ? Matrix4.translationValues(3, 3, 0) // Moves on click
                    : Matrix4.identity(),
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: isPressed
                      ? []
                      : [
                          const BoxShadow(
                              color: Colors.white, offset: Offset(4, 4))
                        ],
                ),
                child: Stack(
                  children: [
                    // Expanding Icon on Hover
                    Align(
                      alignment: Alignment.centerRight,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: isHovered ? 160 : 42, // Adjusted for spacing
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Center(
                            child: Icon(Icons.download,
                                color: Colors.white, size: 22),
                          ),
                        ),
                      ),
                    ),

                    // Download CV Text (Fades Out on Hover)
                    Positioned(
                      left: 12,
                      top: 10,
                      child: AnimatedOpacity(
                        opacity: isHovered ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          "Download CV",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
