import 'package:flutter/material.dart';
import 'package:yoursbuilder/ContactUsPage.dart';
import 'package:yoursbuilder/home.dart';
import 'AboutPage.dart';
import 'ServicePage.dart';
import 'OderPage.dart';
import 'ProjectPage.dart';
import 'AppDevelopmentPage.dart';
import 'PaymentPage.dart';

class WebsiteDevelopment extends StatefulWidget {
  @override
  State<WebsiteDevelopment> createState() => WebsitedevelopmentState();
}

class WebsitedevelopmentState extends State<WebsiteDevelopment> {
  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C2E),
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Colors.blueAccent, Colors.cyan]),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text('E', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            const SizedBox(width: 10),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'errol',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                  TextSpan(
                    text: 'tech',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.lightBlueAccent),
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (isDesktop)
              Row(
                children: [
                  navButton('ABOUT US', () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutPage()));
                  }),
                  navButton('SERVICE', () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ServicePage()));
                  }),
                ],
              )
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: isDesktop ? null : Drawer(
        backgroundColor: const Color(0xFF1C1C2E),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text('ErrolTech Menu', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            ...drawerItems(),
          ],
        ),
      ),
      body: Row(
        children: [
          if (isDesktop)
            Container(
              width: 220,
              color: const Color(0xFF1C1C2E),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  ...drawerItems(),
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                final bool isWide = constraints.maxWidth > 800;

                return Padding(
                  padding: const EdgeInsets.all(30),
                  child: isWide
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: pricingCards(),
                          ),
                        )
                      : ListView(
                          children: pricingCards().expand((card) => [card, const SizedBox(height: 30)]).toList(),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> pricingCards() => const [
        PricingCard(
          title: 'Silver ',
          oldPrice: '₹11999.00 Only',
          newPrice: '₹9999.00 Only',
          features: [
            '3-Page Static Website (HTML/CSS/JS)',
            'Mobile Responsive Design',
            '2 Stock Images',
            '1 jQuery Slider Banner',
            'Contact/Query Form',
            'Basic SEO Optimization',
            'Delivery in 3–4 Days',
            'Free Hosting for 1 Month',

          ],
        ),
        SizedBox(width: 45),
        PricingCard(
          title: 'Startup Package',
          oldPrice: '₹34999.00 Only',
          newPrice: '₹29999 Only',
          features: [
            '5–7 Page Website (Custom Design)',
            'WordPress or Static (Client Choice)',
            'Mobile + Tablet Responsive',
            'Contact Form with Google Map Integration',
            'Google Friendly Sitemap',
            'Basic On-Page SEO',
            'SSL Certificate Integration',
            'Free Domain (.com/.in) for 1 Year',
            'Free Hosting for 1 Year',
            '2 Months Support',
          ],
        ),
        SizedBox(width: 45),
        PricingCard(
          title: 'Professional Package',
          oldPrice: 'Above ₹89999.00 ',
          newPrice: 'Above ₹69999.00 ',
          features: [
            '10+ Pages Custom Dynamic Website',
            'CMS / Admin Panel Integration (WordPress/Custom PHP/Node)',
            '8 Stock Images + Premium UI Design',
            '5 Banner Designs',
            'Blog Setup + Contact Forms',
            'Performance Optimization',
            'Full SEO Setup + Analytics',
            'Domain + Hosting (1 Year)',
            '3 Months Support + Maintenance',
          ],
        ),
      ];

  Widget navButton(String label, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }

  List<Widget> drawerItems() {
    return [
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
        Navigator.push(context, MaterialPageRoute(builder: (_) => WebsiteDevelopment()));
      }),
    ];
  }

  Widget sidebarItem(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(label, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}

class PricingCard extends StatelessWidget {
  final String title;
  final String oldPrice;
  final String newPrice;
  final List<String> features;

  const PricingCard({
    super.key,
    required this.title,
    required this.oldPrice,
    required this.newPrice,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 8,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              oldPrice,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              newPrice,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Suitable for potential super-startups\nand brand revamps for companies.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
            const Divider(),
            SizedBox(
              height: 220,
              child: ListView.builder(
                itemCount: features.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.check, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          features[index],
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OderPage()));
                },
                child: const Text(
                  "ORDER NOW",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
