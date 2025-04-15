import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactMeSection extends StatefulWidget {
  final GlobalKey contactKey;

  const ContactMeSection({Key? key, required this.contactKey})
      : super(key: key);

  @override
  _ContactMeSectionState createState() => _ContactMeSectionState();
}

class _ContactMeSectionState extends State<ContactMeSection> {
  String? _hoveredIcon;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _messageController = TextEditingController();

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'narwadeomakr03@gmail.com',
      query: 'subject=Portfolio Inquiry',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not send email';
    }
  }

  void _submitContactForm() async {
    if (_formKey.currentState!.validate()) {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'narwadeomakr03@gmail.com',
        query: Uri.encodeFull(
          'subject=New Portfolio Inquiry&body='
          'Name: ${_nameController.text}\n'
          'Email: ${_emailController.text}\n'
          'Phone: ${_phoneController.text}\n\n'
          '${_messageController.text}',
        ),
      );

      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _messageController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch mail app')),
        );
      }
    }
  }

  Widget _buildRoundedField(TextEditingController controller, String label,
      {bool isEmail = false, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.poppins(color: Colors.white),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter $label';
        }
        if (isEmail && !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return 'Enter a valid email';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: label,
        hintStyle: GoogleFonts.poppins(color: Colors.white70),
        filled: true,
        fillColor: Colors.black,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.contactKey,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🔶 Contact Form Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Form TO',
                            style: GoogleFonts.poppins(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              shadows: [
                                const Shadow(
                                    offset: Offset(-3, 6),
                                    color: Color.fromARGB(255, 80, 80, 80))
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Get In Touch !!',
                            style: GoogleFonts.poppins(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                const Shadow(
                                    offset: Offset(-3, 6),
                                    color: Color.fromARGB(
                                        255, 80, 80, 80)) // Added shadow here
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Feel free to reach out for collaborations or just a friendly hello 👋',
                            style: GoogleFonts.dancingScript(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 40),
                    // Right Form
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildRoundedField(_emailController, 'Email',
                                isEmail: true),
                            const SizedBox(height: 15),
                            _buildRoundedField(_phoneController, 'Phone'),
                            const SizedBox(height: 15),
                            _buildRoundedField(_nameController, 'Name'),
                            const SizedBox(height: 15),
                            _buildRoundedField(_messageController, 'Message',
                                maxLines: 4),
                            const SizedBox(height: 20),
                            MouseRegion(
                              onEnter: (_) =>
                                  setState(() => _hoveredIcon = 'submit'),
                              onExit: (_) =>
                                  setState(() => _hoveredIcon = null),
                              child: GestureDetector(
                                onTap: _submitContactForm,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    width: 200,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.transparent,
                                    ),
                                    child: Stack(
                                      children: [
                                        // Left-to-right expanding circle mimic
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 600),
                                            curve: Curves.easeOutExpo,
                                            width: _hoveredIcon == 'submit'
                                                ? 200
                                                : 0,
                                            height: 50,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                left: Radius.circular(30),
                                              ),
                                            ),
                                          ),
                                        ),

                                        // Centered text with animated color
                                        Center(
                                          child: AnimatedDefaultTextStyle(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: _hoveredIcon == 'submit'
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                            child: const Text('Submit'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // 🔷 Social Icons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialIcon(
                  FontAwesomeIcons.linkedin,
                  'https://www.linkedin.com/in/omkar-narwade/',
                  'LinkedIn',
                  Colors.blue,
                  'linkedin'),
              _socialIcon(
                  FontAwesomeIcons.github,
                  'https://github.com/OmkarNarwade',
                  'GitHub',
                  Colors.white,
                  'github'),
              _socialIcon(
                  FontAwesomeIcons.instagram,
                  'https://instagram.com/omkar_narwade_10',
                  'Instagram',
                  Colors.pinkAccent,
                  'instagram'),
              _socialIcon(
                  FontAwesomeIcons.envelope,
                  'mailto:narwadeomakr03@gmail.com',
                  'Email',
                  Colors.red,
                  'gmail',
                  isEmail: true),
            ],
          ),
          const SizedBox(height: 10),

          // 🔻 Footer Text
          Text(
            '© ${DateTime.now().year} Omkar Narwade | All Rights Reserved\n'
            'Designed & Developed with ❤️ in Flutter\n'
            'Open to exciting projects & collaborations.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(
    IconData icon,
    String url,
    String label,
    Color color,
    String identifier, {
    bool isEmail = false,
  }) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIcon = identifier),
      onExit: (_) => setState(() => _hoveredIcon = null),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: _hoveredIcon == identifier
                    ? _getHoverColor(identifier)
                    : Colors.white,
                shape: BoxShape.circle,
                boxShadow: _hoveredIcon == identifier
                    ? [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 4))
                      ]
                    : [],
              ),
              child: IconButton(
                icon: FaIcon(
                  icon,
                  color:
                      _hoveredIcon == identifier ? Colors.white : Colors.black,
                  size: 28,
                ),
                onPressed: isEmail ? _sendEmail : () => _launchURL(url),
              ),
            ),
            const SizedBox(height: 8),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _hoveredIcon == identifier ? 1 : 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                decoration: BoxDecoration(
                  color: _getHoverColor(identifier),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  label,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getHoverColor(String identifier) {
    switch (identifier) {
      case 'linkedin':
        return Colors.blue;
      case 'github':
        return Colors.black;
      case 'instagram':
        return Colors.pinkAccent;
      case 'gmail':
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }
}
