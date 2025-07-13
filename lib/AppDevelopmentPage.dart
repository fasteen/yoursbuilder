import 'package:flutter/material.dart';
import 'package:yoursbuilder/AboutPage.dart';
import 'package:yoursbuilder/ContactUsPage.dart';
import 'package:yoursbuilder/ServicePage.dart';
import 'OderPage.dart';
import 'ProjectPage.dart';
import 'PaymentPage.dart';
import 'home.dart';
import 'WebsiteDevelopment.dart';

// Import your other sidebar page screens:


class AppDevelopmentPage extends StatefulWidget {
  @override
  State<AppDevelopmentPage> createState() => AppDevelopmentPageState();
}

class AppDevelopmentPageState extends State<AppDevelopmentPage> {
  bool get isDesktop => MediaQuery.of(context).size.width >= 800;

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
          oldPrice: '₹30000 Only',
          newPrice: '₹25000 Only',
          features: [
            '1 Android App (Basic UI)',
            '3–5 App Screens',
            'Static Content Integration',
            'Google Play Store Submission',
            'Splash Screen & App Icon',
            '1 Month Free Support',
            'Delivery in 5–7 Days',
            '100% Satisfaction Guarantee',
          ],
        ),
        SizedBox(width: 45),
        PricingCard(
          title: 'Startup Package',
          oldPrice: '₹50000 Only',
          newPrice: '₹45000 Only',
          features: [
            'Android + iOS Hybrid App (Flutter)',
            'Up to 8 Screens',
            'Firebase Backend Integration (Auth + DB)',
            'Contact Form / Feedback Module',
            'App Icon & Splash Screen',
            'Push Notification Setup (Firebase)',
            'Play Store & App Store Submission',
            '2 Months Free Support',
            'Custom Design Included',
          ],
        ),
        SizedBox(width: 45),
        PricingCard(
          title: 'Professional Package',
          oldPrice: '₹Above 80000 Only',
          newPrice: '₹Above 70000 ',
          features: [
            'Android + iOS App with Admin Panel',
            '12+ Custom Screens',
            'Advanced Firebase / NodeJS Backend',
            'Admin Dashboard (Web App)',
            'Payment Gateway Integration',
            'Google Maps & Geolocation',
            'Notification System',
            'App Analytics Integration',
            '3 Months Free Support',
            '100% Unique Design & Performance Optimization',

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
        Navigator.push(context, MaterialPageRoute(builder: (_) => Websitedevelopment()));
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
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              alignment: Alignment.centerLeft,
              child: Text(title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
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
                  Navigator.push(context, MaterialPageRoute(builder: (_) => OderPage()));
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
