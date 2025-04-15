import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class ProjectsSectionDetails extends StatelessWidget {
  final GlobalKey projectdetailKey;
  const ProjectsSectionDetails({Key? key, required this.projectdetailKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: projectdetailKey,
      width: double.infinity,
      child: Stack(
        children: [
          // Background Image (Grayscale look)
          Container(
            width: double.infinity,
            height: 400,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/project_detail_background.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              ),
            ),
          ),

          // Black Overlay for contrast
          Container(
            width: double.infinity,
            height: 400,
            color: Colors.black.withOpacity(0.6),
          ),

          // Content
          const SizedBox(
            width: double.infinity,
            height: 400,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 35),

                    // Title
                    Text(
                      "PROJECT SHOWCASE",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                        shadows: [
                          Shadow(offset: Offset(-4, 4), color: Colors.white24),
                        ],
                      ),
                    ),

                    SizedBox(height: 25),

                    // Stats Section
                    Wrap(
                      spacing: 20,
                      runSpacing: 15,
                      alignment: WrapAlignment.center,
                      children: [
                        StatCard(title: "Achievements", value: "4"),
                        StatCard(title: "Projects", value: "7"),
                        StatCard(title: "Complete Course", value: "2"),
                        StatCard(title: "Certificate", value: "2"),
                      ],
                    ),

                    SizedBox(height: 35),

                    // Subtitle
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Explore more on ",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: "GitHub",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                              shadows: [
                                Shadow(
                                  offset: Offset(4, 4),
                                  color: Colors.deepOrange,
                                ),
                                Shadow(
                                  offset: Offset(8, 8),
                                  color: Colors.deepPurple,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Solving real-world problems with data-driven thinking",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white60,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: 30),

                    // GitHub Button
                    GitHubButton(),
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

class StatCard extends StatefulWidget {
  final String title;
  final String value;
  const StatCard({super.key, required this.title, required this.value});

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: isHovered ? 130 : 120,
        height: isHovered ? 100 : 90,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.grey[900]!,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white70,
            width: 1.2,
          ),
          boxShadow: isHovered
              ? [
                  const BoxShadow(
                    color: Colors.white24,
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: Offset(3, 3),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.title.toUpperCase(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class GitHubButton extends StatefulWidget {
  const GitHubButton({super.key});

  @override
  State<GitHubButton> createState() => _GitHubButtonState();
}

class _GitHubButtonState extends State<GitHubButton>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: pi / 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchGitHub() async {
    const url = "https://github.com/OmkarNarwade";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
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
        onTap: _launchGitHub,
        child: Container(
          width: 190,
          height: 40,
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                  ),
                ),
                child: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.github,
                    size: 20,
                    color: Colors.black,
                  ),
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
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                "GITHUB PROFILE",
                                style: TextStyle(
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
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                "CHECK IT ON GITHUB",
                                style: TextStyle(
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
