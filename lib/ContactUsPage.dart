import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ContactFormScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ContactFormScreen extends StatefulWidget {
  const ContactFormScreen({super.key}); 

  @override
  _ContactFormScreenState createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  String _cleanPhoneNumber(String phoneNumber) {
    return phoneNumber.replaceAll(RegExp(r'[\u2000-\u200F\u2028-\u202F\u205F\u3000]'), '').trim();
  }

  Future<void> _submitData() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final message = messageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('customers').add({
        'name': name,
        'email': email,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(), 
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message sent successfully!')),
      );

      nameController.clear();
      emailController.clear();
      messageController.clear();
    } catch (e) {
      print('Error submitting data to Firestore: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send message: $e')),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 800;

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C2E),
      appBar: AppBar(
        title: const Text('Contact Us', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF2A2A3D),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: isDesktop
                ? Row(
                    children: [
                      Expanded(flex: 2, child: _buildFormSection()),
                      const SizedBox(width: 32),
                      Expanded(flex: 1, child: _buildContactInfoSection()),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFormSection(),
                      const SizedBox(height: 32),
                      _buildContactInfoSection(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Let’s talk",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3E3C62),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "To request a quote or want to meet up for coffee,\ncontact us directly or fill out the form and we will get back to you promptly.",
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
        const SizedBox(height: 30),
        _buildTextField("Your Name", nameController),
        const SizedBox(height: 16),
        _buildTextField("Your Email", emailController),
        const SizedBox(height: 16),
        _buildTextField("Your Message", messageController, maxLines: 4),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _submitData,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3E3C62),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text("Send Message", style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ],
    );
  }

  Widget _buildContactInfoSection() {
    final String cleanedPhoneNumber = _cleanPhoneNumber("+91 7598235188");
    final String telUri = "tel:$cleanedPhoneNumber";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _contactInfo(
          Icons.location_on,
          "10/41A , South Street Karungulam Vaiyampatti Trichy",
          () => launchUrl(Uri.parse("https://www.google.com/maps/search/?api=1&query=151+New+Park+Ave,+Hartford,+CT+06106")),
        ),
        const SizedBox(height: 16),
        _contactInfo(
          Icons.phone,
          cleanedPhoneNumber,
          () => launchUrl(Uri.parse(telUri)),
        ),
        const SizedBox(height: 16),
        _contactInfo(
          Icons.email,
          "erroltechnology@gmail.com",
          () => launchUrl(Uri.parse("mailto:erroltechnology@gmail.com")),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _socialIcon(FontAwesomeIcons.google, () => launchUrl(Uri.parse("mailto:erroltechnology@gmail.com"))),
            const SizedBox(width: 16),
            _socialIcon(FontAwesomeIcons.instagram, () => launchUrl(Uri.parse("https://www.instagram.com/erroltech"))),
            const SizedBox(width: 16),
            _socialIcon(FontAwesomeIcons.whatsapp, () => launchUrl(Uri.parse("https://wa.me/7598235188"))),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: label,
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _contactInfo(IconData icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color.fromARGB(255, 65, 139, 199)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: CircleAvatar(
        backgroundColor: const Color(0xFF3E3C62),
        radius: 20,
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
