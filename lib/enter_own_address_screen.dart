import 'package:flutter/material.dart';

class EnterOwnAddressScreen extends StatefulWidget {
  const EnterOwnAddressScreen({Key? key}) : super(key: key);

  @override
  State<EnterOwnAddressScreen> createState() => _EnterOwnAddressScreenState();
}

class _EnterOwnAddressScreenState extends State<EnterOwnAddressScreen> {
  String selectedType = 'Home';

  Widget buildTypeButton(String type, IconData icon) {
    bool isSelected = selectedType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedType = type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFFFBE6) : Colors.white,
            border: Border.all(color: isSelected ? const Color(0xFFFFE066) : Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isSelected ? Colors.black87 : Colors.grey, size: 24),
              const SizedBox(height: 4),
              Text(
                type,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.black87 : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hint, {bool isMandatory = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black54),
          suffixIcon: isMandatory
              ? const Padding(
                  padding: EdgeInsets.only(right: 12, top: 14),
                  child: Text('*', style: TextStyle(color: Colors.red, fontSize: 16)),
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Enter Address Details',
          style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Save address as',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                buildTypeButton('Home', Icons.home_outlined),
                const SizedBox(width: 12),
                buildTypeButton('Work', Icons.work_outline),
                const SizedBox(width: 12),
                buildTypeButton('Other', Icons.location_on_outlined),
              ],
            ),
            const SizedBox(height: 24),
            
            const Text(
              'Address Details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            buildTextField('Complete Address / Street name', isMandatory: true),
            buildTextField('Flat / House no / Floor / Building', isMandatory: true),
            buildTextField('Landmark (Optional)'),
            buildTextField('Pincode', isMandatory: true),
            buildTextField('City', isMandatory: true),
            
            const SizedBox(height: 24),
            
            const Text(
              'Delivery Instructions (Optional)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'E.g. Leave at the door, beware of dog...',
                hintStyle: const TextStyle(color: Colors.black45, fontSize: 13),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade200)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
              ),
            ),
            
            const SizedBox(height: 100), // padding for bottom button
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFD700), // Yellow
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Save address',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
