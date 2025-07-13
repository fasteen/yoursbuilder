import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import 'AboutPage.dart';
import 'AppDevelopmentPage.dart';
import 'ContactUsPage.dart';
import 'LogoPage.dart';
import 'ProjectPage.dart';
import 'ServicePage.dart';
import 'WebsiteDevelopment.dart';
import 'PaymentPage.dart';

class CustomerForm extends StatefulWidget {
  const CustomerForm({super.key});

  @override
  State<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/myvideo.mp4');
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      _controller.setLooping(true);
      _controller.setVolume(0.0);
      _controller.play();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> submitData() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        messageController.text.isEmpty) return;

    await FirebaseFirestore.instance.collection('customers').add({
      'name': nameController.text,
      'email': emailController.text,
      'message': messageController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Submitted Successfully')),
    );

    nameController.clear();
    emailController.clear();
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth >= 800;
        bool isMobile = constraints.maxWidth < 600;

        return Scaffold(
          backgroundColor: const Color(0xFF1C1C2E),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color(0xFF1C1C2E),
            leading: isDesktop
                ? null
                : Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      tooltip:
                          MaterialLocalizations.of(context).openAppDrawerTooltip,
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
            title: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Colors.blueAccent, Colors.cyan]),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text('E',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                const SizedBox(width: 10),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                          text: 'errol',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                      TextSpan(
                          text: 'tech',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.lightBlueAccent)),
                    ],
                  ),
                ),
              ],
            ),
            actions: isDesktop ? [] : null,
          ),
          drawer: isDesktop ? null : Drawer(child: buildSidebar()),
          body: Column(
            children: [
              const Divider(height: 1, color: Colors.grey),
              Expanded(
                child: Row(
                  children: [
                    if (isDesktop)
                      SizedBox(width: 250, child: buildSidebar()),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: FutureBuilder(
                                  future: _initializeVideoPlayerFuture,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return SizedBox(
                                        height: 370,
                                        width: double.infinity,
                                        child: FittedBox(
                                          fit: BoxFit.cover,
                                          child: SizedBox(
                                            width: _controller.value.size.width,
                                            height:
                                                _controller.value.size.height,
                                            child: VideoPlayer(_controller),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox(
                                        height: 250,
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      );
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 40),
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                        text: 'OUR',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                    TextSpan(
                                        text: 'SERVICE',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.lightBlueAccent)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              Center(
                                child: Wrap(
                                  spacing: isDesktop ? 60 : 20,
                                  runSpacing: 20,
                                  alignment: WrapAlignment.center,
                                  children: [
                                    serviceCard(
                                      icon: Icons.phone_android,
                                      title: 'App Development',
                                      description:
                                          'High-performance Flutter mobile apps.',
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  AppDevelopmentPage())),
                                    ),
                                    serviceCard(
                                      icon: Icons.web,
                                      title: 'Website Development',
                                      description:
                                          'Responsive, SEO-optimized modern websites.',
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  Websitedevelopment())),
                                    ),
                                    serviceCard(
                                      icon: Icons.brush,
                                      title: 'Logo Design',
                                      description:
                                          'Clean and modern branding logos.',
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => LogoPage())),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 60),
                              _buildFooter(isDesktop, isMobile),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildSidebar() {
    return Container(
      color: const Color(0xFF1C1C2E),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              children: [
                buildDrawerItem(Icons.home, 'Dashboard', () {}),
                buildDrawerItem(Icons.work, 'Projects', () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ProjectPage()))),
                buildDrawerItem(Icons.message, 'Messages', () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ContactUsPage()))),
                buildDrawerItem(Icons.apple_outlined, 'App', () =>
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => AppDevelopmentPage()))),
                buildDrawerItem(Icons.web, 'Web', () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Websitedevelopment()))),
                buildDrawerItem(Icons.account_balance_wallet, 'Payments',
                    () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => PaymentPage()))),
                
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 40, bottom: 10),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'erroltech@gmail.com',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title,
          style: const TextStyle(color: Colors.white, fontSize: 16)),
      onTap: onTap,
    );
  }

  Widget serviceCard(
      {required IconData icon,
      required String title,
      required String description,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 240,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C3E),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Column(
          children: [
            Icon(icon, size: 50, color: Colors.lightBlueAccent),
            const SizedBox(height: 16),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
            const SizedBox(height: 10),
            Text(description,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 14, color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(bool isDesktop, bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color.fromARGB(31, 255, 255, 255))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4D9FFF), Color(0xFF38C8EF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Text('E', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 10),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(text: 'errol', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600)),
                      TextSpan(text: 'tech', style: TextStyle(color: Color(0xFF38C8EF), fontSize: 24, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text('MJFasteen | Praveen | Eugin', style: TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              FooterNavItem(title: 'Home', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerForm()))),
              FooterNavItem(title: 'About', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutPage()))),
              FooterNavItem(title: 'Experience', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) =>  AboutPage()))),
              FooterNavItem(title: 'Projects', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProjectPage()))),
              FooterNavItem(title: 'Contact', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactUsPage()))),
            ],
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 20,
            alignment: WrapAlignment.center,
            children: const [
              FooterIcon(icon: FontAwesomeIcons.instagram, url: 'https://https://www.instagram.com/erroltech?igsh=MWxyaGNtN25rZDN3dA=='),
              FooterIcon(icon: FontAwesomeIcons.github, url: 'https://github.com/fasteen/JAVA-Project'),
              FooterIcon(icon: FontAwesomeIcons.twitter, url: 'https://twitter.com/yourusername'),
              FooterIcon(icon: FontAwesomeIcons.solidEnvelope, url: 'mailto:erroltechnology@gmail.com'),
            ],
          ),
          const SizedBox(height: 30),
          const Text('© 2024 E errolTech. All Rights Reserved.', style: TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      ),
    );
  }
}

class FooterNavItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const FooterNavItem({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 14)),
    );
  }
}

class FooterIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const FooterIcon({super.key, required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not launch URL')),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
