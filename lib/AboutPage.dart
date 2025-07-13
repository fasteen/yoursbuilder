import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  // Refined Royal Blue-Gold Palette
  static const Color deepMidnightBlue = Color(0xFF0A1128);
  static const Color sapphire = Color(0xFF1D3557);
  static const Color celestialBlue = Color(0xFF457B9D);
  static const Color goldenGlow = Color(0xFFFFD700);
  static const Color ivoryWhite = Color(0xFFF8F9FA);
  static const Color shimmerOverlay = Color(0x14FFFFFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'ErrolTech ',
          style: GoogleFonts.cinzelDecorative(
            color: goldenGlow,
            fontSize: 42,
            fontWeight: FontWeight.w800,
            shadows: [
              Shadow(
                color: goldenGlow.withOpacity(0.8),
                blurRadius: 20,
                offset: const Offset(0, 5),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background gradient
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [deepMidnightBlue, sapphire, celestialBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: CustomPaint(
                painter: StarryBackgroundPainter(),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: shimmerOverlay,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 120),
              child: _buildContentCard(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(
        color: deepMidnightBlue.withOpacity(0.6),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: celestialBlue.withOpacity(0.5),
            blurRadius: 60,
            offset: const Offset(0, 20),
          ),
        ],
        border: Border.all(
          color: sapphire.withOpacity(0.4),
          width: 3,
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 90,
            backgroundImage: const AssetImage('assets/logo.png'),
            backgroundColor: Colors.transparent,
          ),
          const SizedBox(height: 40),
          Text(
            'ErrolTech Solutions',
            textAlign: TextAlign.center,
            style: GoogleFonts.cinzelDecorative(
              fontSize: 40,
              color: goldenGlow,
              fontWeight: FontWeight.w700,
              letterSpacing: 3.5,
              shadows: [
                Shadow(
                  color: goldenGlow.withOpacity(0.5),
                  blurRadius: 25,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Excellence Through Code',
            style: GoogleFonts.lora(
              fontSize: 24,
              color: ivoryWhite,
              fontStyle: FontStyle.italic,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 50),
          Text(
            'We are pioneers of digital innovation, delivering high-impact web & mobile solutions, captivating UI/UX, cloud architectures, and enterprise platforms. Every product reflects our commitment to brilliance and excellence, powered by Flutter and Firebase.',
            style: GoogleFonts.openSans(
              color: ivoryWhite.withOpacity(0.95),
              fontSize: 18,
              height: 1.9,
              letterSpacing: 0.7,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          _buildContactInfo('10/41A , South Street Karungulam Vaiyampatti Trichy', FontAwesomeIcons.locationDot),
          const SizedBox(height: 20),
          _buildContactInfo('erroltechnology@gmail.com', FontAwesomeIcons.envelope),
          const SizedBox(height: 20),
          _buildContactInfo('+91 7592235188', FontAwesomeIcons.phone),
          const SizedBox(height: 50),
          Wrap(
            spacing: 25,
            alignment: WrapAlignment.center,
            children: const [
              FooterIcon(icon: FontAwesomeIcons.instagram, url: 'https://https://www.instagram.com/erroltech?igsh=MWxyaGNtN25rZDN3dA=='),
              FooterIcon(icon: FontAwesomeIcons.github, url: 'https://github.com/fasteen/JAVA-Project'),
              FooterIcon(icon: FontAwesomeIcons.linkedin, url: 'https://linkedin.com/company/erroltech-official'),
              FooterIcon(icon: FontAwesomeIcons.twitter, url: 'https://x.com/ErrolTech?t=U09J8HP9iFr7cc3Arr3O0w&s=08'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(String text, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: goldenGlow, size: 24),
        const SizedBox(width: 12),
        Text(
          text,
          style: GoogleFonts.openSans(
            color: ivoryWhite,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class StarryBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final random = Random();
    for (int i = 0; i < 200; i++) {
      paint.color = AboutPage.ivoryWhite.withOpacity(random.nextDouble() * 0.4 + 0.2);
      canvas.drawCircle(
        Offset(random.nextDouble() * size.width, random.nextDouble() * size.height),
        random.nextDouble() * 2.5 + 1,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class FooterIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const FooterIcon({super.key, required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Unable to open link.")),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AboutPage.celestialBlue,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Icon(icon, color: AboutPage.goldenGlow, size: 28),
      ),
    );
  }
}
