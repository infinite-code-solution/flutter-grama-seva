import 'package:flutter/material.dart';

class EnterOwnAddressScreen extends StatefulWidget {
  const EnterOwnAddressScreen({Key? key}) : super(key: key);

  @override
  State<EnterOwnAddressScreen> createState() => _EnterOwnAddressScreenState();
}

class _EnterOwnAddressScreenState extends State<EnterOwnAddressScreen> {
  String selectedType = 'Home';
  String? selectedState;
  String? selectedDistrict;
  String? selectedMandal;
  String? selectedVillage;

  final List<String> states = ['Andhra Pradesh', 'Karnataka', 'Kerala', 'Tamil Nadu', 'Telangana'];
  final List<String> districts = ['Bengaluru Urban', 'Mysuru', 'Mangaluru', 'Hubballi', 'Belagavi'];
  final List<String> mandals = ['Yelahanka', 'Whitefield', 'Koramangala', 'Indiranagar', 'Jayanagar'];
  final List<String> villages = ['Marathahalli', 'Bellandur', 'HSR Layout', 'BTM Layout', 'Electronic City'];

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

  Widget buildRealDropdownField(String hint, IconData icon, List<String> items, String? selectedValue, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.grey.shade600, size: 20),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.blue.shade900.withOpacity(0.4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.blue.shade900),
          ),
        ),
        icon: Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: const TextStyle(color: Colors.black87, fontSize: 14)),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget buildInputField(String hint, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.grey.shade600, size: 20),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.blue.shade900.withOpacity(0.4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.blue.shade900),
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
            
            buildRealDropdownField('Select State', Icons.location_on, states, selectedState, (val) => setState(() => selectedState = val)),
            buildRealDropdownField('Select District/City', Icons.domain, districts, selectedDistrict, (val) => setState(() => selectedDistrict = val)),
            buildRealDropdownField('Select Mandal/Town', Icons.account_balance, mandals, selectedMandal, (val) => setState(() => selectedMandal = val)),
            buildRealDropdownField('Select Village', Icons.home, villages, selectedVillage, (val) => setState(() => selectedVillage = val)),
            
            buildInputField('Enter Street Name', Icons.edit_road),
            buildInputField('Enter Door Number', Icons.format_list_numbered),
            buildInputField('Enter Building Name', Icons.business),
            buildInputField('Enter Pincode', Icons.pin_drop_outlined),
            
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
