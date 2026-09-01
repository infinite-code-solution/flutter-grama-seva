import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'contacts_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top section with light background
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
              ),
              padding: const EdgeInsets.only(top: 24, bottom: 24),
              child: Column(
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
                  const SizedBox(height: 24),
                  // Top 3 cards (Vouchers, Wallet, Orders)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        _buildTopAction(
                          icon: Icons.local_activity,
                          iconColor: Colors.amber,
                          title: 'Vouchers',
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.grey.shade200,
                        ),
                        _buildTopAction(
                          icon: Icons.account_balance_wallet,
                          iconColor: Colors.amber,
                          title: 'Wallet',
                          subtitle: '₹ 0.00',
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.grey.shade200,
                        ),
                        _buildTopAction(
                          icon: Icons.receipt_long,
                          iconColor: Colors.amber,
                          title: 'Orders',
                        ),
                      ],
                    ),
                  ),
                  ),
                ],
              ),
            ),
            
            // Refer & Earn banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.card_giftcard, color: Colors.orange),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Refer & earn ₹ 250',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Rewards for friends too',
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      child: const Text('Refer Now', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
            
            // List Items
            _buildListItem(
              icon: Icons.person_outline,
              title: 'Rahul Kumar',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
            ),
            _buildListItem(
              icon: Icons.payment,
              title: 'Payment methods',
            ),
            _buildListItem(
              icon: Icons.location_on_outlined,
              title: 'Addresses',
            ),
            _buildListItem(
              icon: Icons.favorite_border,
              title: 'My favourites',
            ),
            _buildListItem(
              icon: Icons.health_and_safety_outlined,
              title: 'On-time Promise',
              iconColor: Colors.green,
            ),
            _buildListItem(
              icon: Icons.language,
              title: 'Language',
              trailingText: 'English',
            ),
            _buildListItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
            ),
            
            _buildListItem(
              icon: Icons.contacts_outlined,
              title: 'Contacts (Test)',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactsScreen()),
                );
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTopAction({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildListItem({
    required IconData icon,
    required String title,
    Color? iconColor,
    String? trailingText,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      leading: Icon(icon, color: iconColor ?? Colors.black87),
      title: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                trailingText,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
          const Icon(Icons.chevron_right, color: Colors.black87),
        ],
      ),
      onTap: onTap ?? () {},
    );
  }
}
