import 'package:flutter/material.dart';

class DeliveryAddressFormScreen extends StatefulWidget {
  const DeliveryAddressFormScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryAddressFormScreen> createState() => _DeliveryAddressFormScreenState();
}

class _DeliveryAddressFormScreenState extends State<DeliveryAddressFormScreen> {
  String selectedType = 'Apartment';
  String deliveryInstruction = 'Hand it to me';
  String dropOff = '';
  String label = '';

  Widget buildTypeButton(String type) {
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
          child: Center(
            child: Text(
              type,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: Colors.black87,
              ),
            ),
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
          suffixIcon: isMandatory ? const Padding(
            padding: EdgeInsets.only(right: 12, top: 14),
            child: Text('*', style: TextStyle(color: Colors.red, fontSize: 16)),
          ) : null,
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

  Widget buildPhotoButton(IconData icon, String text) {
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.grey, size: 28),
            const SizedBox(height: 8),
            Text(text, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
  
  Widget buildInstructionButton(String title, IconData icon, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: isSelected ? Colors.black87 : Colors.grey.shade300, width: isSelected ? 1.5 : 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: Colors.black87),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                ),
              ),
              if (isSelected)
                const Icon(Icons.radio_button_checked, size: 18, color: Colors.black87)
              else
                const Icon(Icons.radio_button_unchecked, size: 18, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropOffButton(String title) {
    bool isSelected = dropOff == title;
    return GestureDetector(
      onTap: () => setState(() => dropOff = title),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.black87 : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(title, style: TextStyle(color: isSelected ? Colors.black87 : Colors.black54)),
      ),
    );
  }

  Widget buildLabelButton(String title, IconData icon) {
    bool isSelected = label == title;
    return GestureDetector(
      onTap: () => setState(() => label = title),
      child: Container(
        margin: const EdgeInsets.only(right: 12, bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.black87 : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: isSelected ? Colors.black87 : Colors.black54),
            const SizedBox(width: 6),
            Text(title, style: TextStyle(color: isSelected ? Colors.black87 : Colors.black54)),
          ],
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
          'Delivery address',
          style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map Placeholder
            Container(
              height: 150,
              width: double.infinity,
              color: const Color(0xFFC8E6C9),
              child: Stack(
                children: [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Icon(Icons.location_on, size: 40, color: Colors.black),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 70),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text('Edit pin', style: TextStyle(color: Colors.white, fontSize: 12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
              ),
              child: const Text(
                'Bengaluru, Karnataka',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Address Types
                  Row(
                    children: [
                      buildTypeButton('Apartment'),
                      const SizedBox(width: 8),
                      buildTypeButton('House'),
                      const SizedBox(width: 8),
                      buildTypeButton('Office'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Text Fields
                  buildTextField('Building name', isMandatory: true),
                  Row(
                    children: [
                      Expanded(child: buildTextField('Apartment no.', isMandatory: true)),
                      const SizedBox(width: 16),
                      Expanded(child: buildTextField('Unit/Floor', isMandatory: true)),
                    ],
                  ),
                  buildTextField('Street', isMandatory: true),
                  buildTextField('Additional directions'),
                  
                  const SizedBox(height: 12),
                  
                  // Photo Guide
                  const Text('Photo guide', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text('Add photos to help the courier find you faster', style: TextStyle(color: Colors.black54, fontSize: 13)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      buildPhotoButton(Icons.domain_add, 'Building'),
                      const SizedBox(width: 12),
                      buildPhotoButton(Icons.door_front_door_outlined, 'Door'),
                      const SizedBox(width: 12),
                      buildPhotoButton(Icons.camera_alt_outlined, 'Other'),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Contact
                  const Text('Contact', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  const Text('Name*', style: TextStyle(fontSize: 12, color: Colors.black54)),
                  const SizedBox(height: 4),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade200)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Phone number*', style: TextStyle(fontSize: 12, color: Colors.black54)),
                  const SizedBox(height: 4),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('+ 91', style: TextStyle(fontSize: 15)),
                            const Icon(Icons.arrow_drop_down, color: Colors.black87),
                            const SizedBox(width: 8),
                            Container(width: 1, height: 24, color: Colors.grey), // Divider
                          ],
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade200)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  // Delivery instructions
                  const Text('Delivery instructions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      buildInstructionButton('Hand it to me', Icons.person_outline, deliveryInstruction == 'Hand it to me', () {
                        setState(() => deliveryInstruction = 'Hand it to me');
                      }),
                      const SizedBox(width: 12),
                      buildInstructionButton('Leave at a spot', Icons.location_on_outlined, deliveryInstruction == 'Leave at a spot', () {
                        setState(() => deliveryInstruction = 'Leave at a spot');
                      }),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Drop off here
                  const Text('Drop off here if I can\'t be reached', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Wrap(
                    children: [
                      buildDropOffButton('Front door'),
                      buildDropOffButton('Lobby'),
                      buildDropOffButton('Front desk'),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Additional note
                  const Text('Additional note', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Do you have any specific instructions for your courier?\n(Do not add order notes for restaurants here)',
                      hintStyle: const TextStyle(color: Colors.black45, fontSize: 13),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade200)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Label
                  const Text('Label', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Wrap(
                    children: [
                      buildLabelButton('Home', Icons.home_outlined),
                      buildLabelButton('Work', Icons.work_outline),
                      buildLabelButton('Hangout', Icons.people_outline),
                      buildLabelButton('Other', Icons.grid_view),
                    ],
                  ),
                  
                  const SizedBox(height: 100), // padding for bottom button
                ],
              ),
            ),
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
              // Close form and go back to home
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
