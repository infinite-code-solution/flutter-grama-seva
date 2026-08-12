import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Food',
    'Groceries',
    'Clothing',
    'Housing',
    'Pharmacy',
    'Hospitals',
    'RMP Doctors',
    'Transport',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header (Home page design)
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Brand Logo/Name
              Image.asset(
                'assets/app_icon.png',
                width: 80.0,
                errorBuilder: (context, error, stackTrace) {
                  return Container(color: Colors.orange[100]);
                },
              ),
              // Address / Location Component
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '123 Main St. Bengaluru,',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Karnataka 560001',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
        // Filter Chips (Categories)
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: _categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: _buildFilterChip(
                    category,
                    _selectedCategory == category,
                    () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Order List
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: _buildCategoryContent(),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildCategoryContent() {
    List<Widget> content = [];

    if (_selectedCategory == 'All' || _selectedCategory == 'Pharmacy') {
      content.addAll([
        _buildOrderCard(
          status: 'Delivered',
          dateTime: 'Jul 16 • 9:26pm',
          logoPath: 'assets/app_icon.png',
          isPro: true,
          storeName: 'Al Aziziya Pharmacy',
          orderId: '3763535152',
          price: 'QAR 50.00',
          statusColor: Colors.green.shade50,
          statusTextColor: Colors.green.shade700,
        ),
        const SizedBox(height: 16),
        _buildOrderCard(
          status: 'Delivered',
          dateTime: 'Jul 16 • 8:34pm',
          logoPath: 'assets/app_icon.png',
          isPro: true,
          storeName: 'Sunlife Pharmacy',
          orderId: '3763394531',
          price: 'QAR 151.00',
          statusColor: Colors.green.shade50,
          statusTextColor: Colors.green.shade700,
        ),
        const SizedBox(height: 16),
      ]);
    }

    if (_selectedCategory == 'All' || _selectedCategory == 'Food') {
      content.addAll([
        _buildOrderCard(
          status: 'On the way',
          dateTime: 'Aug 12 • 6:30pm',
          logoPath: 'assets/app_icon.png',
          isPro: false,
          storeName: 'McDonald\'s',
          orderId: '3781122334',
          price: 'QAR 45.00',
          statusColor: Colors.blue.shade50,
          statusTextColor: Colors.blue.shade700,
        ),
        const SizedBox(height: 16),
        _buildOrderCard(
          status: 'Cancelled',
          dateTime: 'Aug 10 • 7:00pm',
          logoPath: 'assets/app_icon.png',
          isPro: true,
          storeName: 'KFC',
          orderId: '3779988776',
          price: 'QAR 85.00',
          statusColor: Colors.red.shade50,
          statusTextColor: Colors.red.shade700,
        ),
        const SizedBox(height: 16),
      ]);
    }

    if (content.isEmpty) {
      content.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Center(
            child: Column(
              children: [
                Icon(Icons.inbox_outlined, size: 64, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                Text(
                  'No orders found for $_selectedCategory',
                  style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Explore items and place your first order!',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      content.add(
        const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Text(
              'All caught up! You\'ve seen all your orders from the past 3 months',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
        ),
      );
      content.add(const SizedBox(height: 24));
    }

    return content;
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black87 : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.black87 : Colors.grey.shade300),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard({
    required String status,
    required String dateTime,
    required String logoPath,
    required bool isPro,
    required String storeName,
    required String orderId,
    required String price,
    Color? statusColor,
    Color? statusTextColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top section
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor ?? Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(fontSize: 12, color: statusTextColor ?? Colors.black54, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  dateTime,
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEEEEEE)), // faint divider
          // Middle section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                    image: DecorationImage(
                      image: AssetImage(logoPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (isPro) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'pro',
                                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 6),
                          ],
                          Expanded(
                            child: Text(
                              storeName,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Order ID: $orderId',
                        style: const TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Price and Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'View details',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text('Order again'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Rating section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Rate',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                Row(
                  children: List.generate(5, (index) => const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.star_border, color: Colors.grey, size: 24),
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
