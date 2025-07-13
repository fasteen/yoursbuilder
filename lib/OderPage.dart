import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class OderPage extends StatefulWidget {
  @override
  State<OderPage> createState() => _OderPageState();
}

class _OderPageState extends State<OderPage> {
  final _formKey = GlobalKey<FormState>();

  String? name, projectName, projectType, description, email, phone, budget, deadline, notes;

  final List<String> projectTypes = ['App Development', 'Website Design', 'Logo & Branding', 'Digital Marketing', 'UI/UX Design', 'Other'];

  // Add a focus node for better keyboard dismissal
  final FocusNode _formFocusNode = FocusNode();

  @override
  void dispose() {
    _formFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Dismiss keyboard when tapping outside text fields
      onTap: () {
        _formFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white, // Changed to white for a cleaner, premium base
        appBar: AppBar(
          title: Text(
            "New Project Request", // More professional title
            style: GoogleFonts.poppins(
              fontSize: 22, // Slightly larger for prominence
              fontWeight: FontWeight.w700, // Bolder
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.indigo.shade800, // Darker, richer indigo
          elevation: 8, // Increased elevation for a more substantial look
          centerTitle: true,
          // Optional: Add a subtle leading icon or action for branding
          // leading: Icon(Icons.business_center, color: Colors.white),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0), // More generous padding
          child: Center(
            child: Container( // Using Container for more control over decoration
              constraints: const BoxConstraints(maxWidth: 700), // Max width for larger screens
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA), // Off-white for the card background
                borderRadius: BorderRadius.circular(20), // More rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08), // Softer, more diffuse shadow
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(35), // More internal padding
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch elements across the width
                    children: [
                      Text(
                        "Tell us about your project", // More inviting heading
                        style: GoogleFonts.poppins(
                          fontSize: 28, // Larger and more impactful
                          fontWeight: FontWeight.w700,
                          color: Colors.indigo.shade900, // Darker text for contrast
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Fill out the form below and we'll get back to you shortly.", // Subtitle for clarity
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      buildTextField("Full Name", onSaved: (val) => name = val, icon: Icons.person_outline),
                      buildTextField("Project Name", onSaved: (val) => projectName = val, icon: Icons.work_outline),
                      buildDropdownField(
                        labelText: "Project Type",
                        value: projectType,
                        items: projectTypes,
                        onChanged: (val) => setState(() => projectType = val),
                        validator: (val) => val == null ? "Please select a project type" : null,
                        icon: Icons.category_outlined,
                      ),
                      buildTextField("Project Description", maxLines: 4, onSaved: (val) => description = val, icon: Icons.description_outlined),
                      buildTextField("Email Address", keyboardType: TextInputType.emailAddress, onSaved: (val) => email = val, icon: Icons.email_outlined),
                      buildTextField("Phone Number", keyboardType: TextInputType.phone, onSaved: (val) => phone = val, icon: Icons.phone_outlined),
                      buildTextField("Budget Range (e.g., ₹50,000 - ₹1,00,000)", onSaved: (val) => budget = val, icon: Icons.account_balance_wallet_outlined),
                      buildTextField("Desired Deadline (e.g., 2-3 months)", onSaved: (val) => deadline = val, icon: Icons.calendar_today_outlined),
                      buildTextField("Additional Notes/Requirements", maxLines: 3, onSaved: (val) => notes = val, icon: Icons.notes_outlined),
                      const SizedBox(height: 40),
                      ElevatedButton.icon(
                        onPressed: _submitForm,
                        icon: const Icon(Icons.send_rounded, size: 22), // Modern icon
                        label: Text(
                          "Submit Project Request", // Clearer call to action
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16), // Larger padding
                          backgroundColor: Colors.indigo.shade700, // Consistent indigo shade
                          foregroundColor: Colors.white, // Text color
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Softer corners
                          elevation: 10, // More pronounced lift
                          shadowColor: Colors.indigo.shade200, // Subtle shadow color
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await FirebaseFirestore.instance.collection('orders').add({
          'name': name,
          'projectName': projectName,
          'projectType': projectType,
          'description': description,
          'email': email,
          'phone': phone,
          'budget': budget,
          'deadline': deadline,
          'notes': notes,
          'timestamp': Timestamp.now(),
        });

        if (!mounted) return; // Check if the widget is still mounted

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Text(
              "Request Submitted!",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.indigo.shade700),
            ),
            content: Text(
              "Thank you $name! Your project request for '$projectName' ($projectType) has been received by ErrolTech Team. We'll be in touch soon!",
              style: GoogleFonts.poppins(fontSize: 15),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _formKey.currentState?.reset(); // Reset form fields
                  setState(() {
                    projectType = null; // Reset dropdown value
                  });
                },
                child: Text(
                  "Awesome!",
                  style: GoogleFonts.poppins(color: Colors.indigo),
                ),
              )
            ],
          ),
        );
      } catch (e) {
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Submission Failed"),
            content: Text("There was an error submitting your request. Please try again. Error: $e"),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))
            ],
          ),
        );
      }
    }
  }

  Widget buildTextField(
    String label, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    required FormFieldSetter<String> onSaved,
    IconData? icon, // Optional icon parameter
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20), // Increased spacing between fields
      child: TextFormField(
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: GoogleFonts.poppins(fontSize: 16), // Consistent font for input
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(color: Colors.grey.shade700), // Lighter label
          hintStyle: GoogleFonts.poppins(color: Colors.grey.shade400),
          prefixIcon: icon != null ? Icon(icon, color: Colors.indigo.shade400) : null, // Premium icon
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), // Softer border radius
            borderSide: BorderSide(color: Colors.grey.shade300), // Lighter default border
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0), // Consistent enabled border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.indigo.shade600, width: 2.0), // Thicker, colored focus border
          ),
          filled: true, // Fill the background
          fillColor: Colors.white, // White fill for text fields
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16), // Adjusted padding
        ),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return "This field is required.";
          }
          // Basic email validation
          if (keyboardType == TextInputType.emailAddress && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(val)) {
            return "Please enter a valid email address.";
          }
          // Basic phone number validation (simple check for digits)
          if (keyboardType == TextInputType.phone && !RegExp(r'^[0-9]+$').hasMatch(val)) {
            return "Please enter a valid phone number.";
          }
          return null;
        },
        onSaved: onSaved,
      ),
    );
  }

  Widget buildDropdownField({
    required String labelText,
    String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    FormFieldValidator<String>? validator,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.poppins(color: Colors.grey.shade700),
          prefixIcon: icon != null ? Icon(icon, color: Colors.indigo.shade400) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.indigo.shade600, width: 2.0),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
        style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
        dropdownColor: Colors.white, // Dropdown menu background
        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.indigo),
        items: items.map((type) => DropdownMenuItem(value: type, child: Text(type, style: GoogleFonts.poppins()))).toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}