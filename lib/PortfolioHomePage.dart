import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'about_section.dart';
import 'contact_me_section.dart';
import 'education_deatils.dart';
import 'project_detail_section.dart';
import 'project_section.dart';
import 'resume_section.dart';

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey educationKey = GlobalKey();
  final GlobalKey resumeKey = GlobalKey();
  final GlobalKey projectKey = GlobalKey();
  final GlobalKey projectDetailKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();

  // Function to scroll to a specific section using a key
  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(
            milliseconds: 600), // Reduced duration for smoother scrolling
        curve: Curves.easeInOut,
        alignment: 0.1,
      );
    }
  }

  // Function to scroll to a specific offset directly
  void _smoothScrollTo(double offset) {
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView(
              controller: _scrollController,
              padding: EdgeInsets.zero,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 700,
                      width: double.infinity,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/background_image.jpg',
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.9),
                                  Colors.transparent,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 100,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, I'm",
                            style: GoogleFonts.montserrat(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                "Omkar Narwade",
                                textStyle: GoogleFonts.dancingScript(
                                  color:
                                      const Color.fromARGB(255, 255, 74, 213),
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                ),
                                speed: const Duration(milliseconds: 100),
                              ),
                            ],
                            isRepeatingAnimation: false,
                          ),
                          const SizedBox(height: 20),
                          AnimatedTextKit(
                            animatedTexts: [
                              "Flutter Developer",
                              "Java Developer",
                              "Python Developer"
                            ]
                                .map((title) => TypewriterAnimatedText(
                                      title,
                                      textStyle: GoogleFonts.montserrat(
                                        fontSize: 24,
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      speed: const Duration(milliseconds: 100),
                                    ))
                                .toList(),
                            repeatForever: true,
                          ),
                          const SizedBox(height: 30),
                          AnimatedOpacity(
                            opacity: 1.0,
                            duration: Duration(seconds: 2),
                            child: Text(
                              "Enthusiastic developer addicted to building cool Projects.",
                              style: GoogleFonts.dancingScript(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: const Color.fromARGB(255, 255, 74, 213),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          const Row(
                            children: [
                              FlipButton(
                                frontText: "GITHUB PROFILE",
                                backText: "CHECK IT ON GITHUB",
                                icon: FontAwesomeIcons.github,
                                url: "https://github.com/OmkarNarwade",
                                iconBackgroundColor: Colors.white,
                                backColor: Colors.black,
                              ),
                              SizedBox(width: 16),
                              FlipButton(
                                frontText: "LINKEDIN PROFILE",
                                backText: "CONNECT ON LINKEDIN",
                                icon: FontAwesomeIcons.linkedinIn,
                                url:
                                    "https://www.linkedin.com/in/omkar-narwade/",
                                iconBackgroundColor: Colors.white,
                                backColor: Colors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                AboutSection(aboutKey: aboutKey),
                EducationSection(educationKey: educationKey),
                ResumeSection(resumeKey: resumeKey),
                ProjectSection(projectKey: projectKey),
                ProjectsSectionDetails(projectdetailKey: projectDetailKey),
                ContactMeSection(contactKey: contactKey),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SidebarIcon(
                  icon: Icons.home,
                  onPressed: () => _smoothScrollTo(0),
                  label: "Home",
                ),
                const SizedBox(height: 20),
                SidebarIcon(
                    icon: Icons.person,
                    onPressed: () => _scrollToSection(aboutKey),
                    label: "About Me"),
                const SizedBox(height: 20),
                SidebarIcon(
                    icon: FontAwesomeIcons.graduationCap,
                    onPressed: () => _scrollToSection(educationKey),
                    label: "Education"),
                const SizedBox(height: 20),
                SidebarIcon(
                    icon: FontAwesomeIcons.filePen,
                    onPressed: () => _scrollToSection(projectKey),
                    label: "Projects"),
                const SizedBox(height: 20),
                SidebarIcon(
                    icon: FontAwesomeIcons.laptopCode,
                    onPressed: () => _scrollToSection(projectKey),
                    label: "Development"),
                const SizedBox(height: 20),
                SidebarIcon(
                    icon: FontAwesomeIcons.whatsapp,
                    onPressed: () => _scrollToSection(contactKey),
                    label: "Contact Me"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SidebarIcon extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String label;

  const SidebarIcon({
    required this.icon,
    required this.onPressed,
    required this.label,
  });

  @override
  State<SidebarIcon> createState() => _SidebarIconState();
}

class _SidebarIconState extends State<SidebarIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: SizedBox(
          width: 80,
          height: 60,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _isHovered
                      ? Colors.black.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _isHovered ? Colors.white : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: AnimatedRotation(
                  turns: _isHovered ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(widget.icon, size: 30, color: Colors.white),
                ),
              ),
              Positioned(
                bottom: -30, // Push label below the icon
                child: AnimatedOpacity(
                  opacity: _isHovered ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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

class FlipButton extends StatefulWidget {
  final String frontText;
  final String backText;
  final IconData icon;
  final String url;
  final Color iconBackgroundColor;
  final Color backColor;

  const FlipButton({
    super.key,
    required this.frontText,
    required this.backText,
    required this.icon,
    required this.url,
    this.iconBackgroundColor = Colors.white,
    this.backColor = Colors.black,
  });

  @override
  State<FlipButton> createState() => _FlipButtonState();
}

class _FlipButtonState extends State<FlipButton>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    _animation = Tween<double>(begin: 0, end: pi / 2)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
          _controller.forward();
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
          _controller.reverse();
        });
      },
      child: GestureDetector(
        onTap: _launchURL,
        child: SizedBox(
          width: 190,
          height: 40,
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: widget.iconBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                  ),
                ),
                child: Center(
                  child: FaIcon(widget.icon, size: 20, color: Colors.black),
                ),
              ),
              Expanded(
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateX(_animation.value),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: widget.backColor,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(6),
                                  bottomRight: Radius.circular(6),
                                ),
                              ),
                              child: Text(
                                widget.frontText,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateX(_animation.value - pi / 2),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: widget.backColor,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(6),
                                  bottomRight: Radius.circular(6),
                                ),
                              ),
                              child: Text(
                                widget.backText,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
