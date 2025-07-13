import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart'; // ✅ for opening links
import 'package:yoursbuilder/AppDevelopmentPage.dart';
import 'package:yoursbuilder/ContactUsPage.dart';
import 'package:yoursbuilder/PaymentPage.dart';
import 'package:yoursbuilder/WebsiteDevelopment.dart';
import 'package:yoursbuilder/home.dart';
import 'AboutPage.dart';
import 'ServicePage.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C2E),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1C1C2E),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Colors.blueAccent, Colors.cyan]),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text('E',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            const SizedBox(width: 10),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                      text: 'errol',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white)),
                  TextSpan(
                      text: 'tech',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.lightBlueAccent)),
                ],
              ),
            ),
          ],
        ),
        actions: isDesktop
            ? [
                _navButton('ABOUT US',
                    () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutPage()))),
                _navButton('SERVICE',
                    () => Navigator.push(context, MaterialPageRoute(builder: (_) => ServicePage()))),
                const SizedBox(width: 10),
              ]
            : null,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 600;
          return Row(
            children: [
              if (!isMobile)
                Container(
                  width: 220,
                  color: const Color(0xFF1C1C2E),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      sidebarItem(Icons.dashboard, 'DashBoard', () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerForm()));
                      }),
                      sidebarItem(Icons.work, 'Projects', () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const ProjectPage()));
                      }),
                      sidebarItem(Icons.calendar_today, 'Messages ', () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactUsPage()));
                      }),
                      sidebarItem(Icons.analytics, 'APP', () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => AppDevelopmentPage()));
                      }),
                      sidebarItem(Icons.payment, 'Payments', () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => PaymentPage()));
                      }),
                      sidebarItem(Icons.settings, 'WEBSITE', () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => Websitedevelopment()));
                      }),
                      const Spacer(),
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'erroltech@gmail.com',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    child: const ProjectsGridList(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  static TextButton _navButton(String title, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
    );
  }

  Widget sidebarItem(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(label, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}

// ======================== GRID & PROJECT CARD ========================

class ProjectsGridList extends StatelessWidget {
  const ProjectsGridList({super.key});

  final List<Project> projects = const [
    Project(
      image: 'assets/image1.png',
      title: 'EcommerceWebsite',
      description: 'A web-based restaurant system using JSP, Servlets, and MySQL.',
      tags: ['Java', 'JSP', 'Servlet', 'MySQL'],
      liveDemoUrl: 'https://68721683022e41f79dfb565b--shimmering-dodol-25c1e2.netlify.app/',
    ),
    Project(
      image: 'assets/image2.png',
      title: 'Furniture',
      description: 'Full-stack e-commerce site with cart, auth, and admin panel.',
      tags: ['Java', 'Hibernate', 'JEE', 'Bootstrap'],
      liveDemoUrl: 'https://thunderous-melomakarona-bff007.netlify.app/',
    ),
    Project(
      image: 'assets/image3.png',
      title: 'Vegetable',
      description: 'Mechanic booking and real-time vehicle service tracking.',
      tags: ['Booking', 'Tracking', 'API'],
      liveDemoUrl: 'https://zippy-fenglisu-42bc9e.netlify.app/',
    ),
    Project(
      image: 'assets/image4.png',
      title: 'Anime',
      description: 'Professors mark attendance, view percentage by semester end.',
      tags: ['Flutter', 'Firebase', 'Education'],
      liveDemoUrl: 'https://aesthetic-duckanoo-6eceae.netlify.app/',
    ),
    Project(
      image: 'assets/image5.png',
      title: 'Billing Software',
      description: 'Custom Flutter billing app with PDF invoices and Firestore DB.',
      tags: ['Billing', 'Flutter', 'PDF'],
      liveDemoUrl: 'https://euphonious-semolina-537cc9.netlify.app/',
    ),
    Project(
      image: 'assets/image6.png',
      title: 'Foodies',
      description: 'Responsive Flutter web portfolio with animations and projects.',
      tags: ['Portfolio', 'Flutter Web', 'UI'],
      liveDemoUrl: 'https://magenta-yeot-084292.netlify.app/',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;
    int crossAxisCount = isMobile ? 1 : (screenWidth < 900 ? 2 : 3);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: projects.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: isMobile ? 1.0 : 0.75,
      ),
      itemBuilder: (context, index) {
        return ProjectCard(project: projects[index]);
      },
    );
  }
}

class Project {
  final String image;
  final String title;
  final String description;
  final List<String> tags;
  final String? liveDemoUrl;

  const Project({
    required this.image,
    required this.title,
    required this.description,
    required this.tags,
    this.liveDemoUrl,
  });
}

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(project.title),
            content: Text(project.description),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close"))
            ],
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(66, 10, 10, 10),
              blurRadius: 12,
              offset: const Offset(2, 4),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Column(
            children: [
              Image.asset(
                project.image,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(project.title,
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            project.description,
                            style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        children: project.tags
                            .map((tag) => Chip(
                                  label: Text(tag, style: GoogleFonts.poppins(fontSize: 12)),
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(color: Colors.grey),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!isMobile)
                      _PremiumButton(label: "", icon: Icons.code, onTap: () {}),
                    _PremiumButton(
                      label: "View live",
                      icon: Icons.link,
                      onTap: () async {
                        if (project.liveDemoUrl != null &&
                            await canLaunchUrl(Uri.parse(project.liveDemoUrl!))) {
                          await launchUrl(Uri.parse(project.liveDemoUrl!), mode: LaunchMode.externalApplication);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Could not launch demo link')),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PremiumButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _PremiumButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        foregroundColor: Colors.deepPurple,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      onPressed: onTap,
      icon: Icon(icon, size: 16),
      label: Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
    );
  }
}
