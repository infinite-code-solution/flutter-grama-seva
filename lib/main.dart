import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(const GramaSevaApp());
}

class GramaSevaApp extends StatelessWidget {
  const GramaSevaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grama Seva UI',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto', // Make sure to configure fonts in pubspec.yaml if customized
      ),
      home: const SplashScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Custom Header Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Brand Logo/Name
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey[200],
                          child: const Icon(Icons.apps, color: Colors.indigo, size: 20),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Grama',
                              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, height: 1.1),
                            ),
                            Text(
                              'Seva',
                              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, height: 1.1),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Address / Location Component
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, color: Colors.grey, size: 20),
                        const SizedBox(width: 4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '123 Main St. Bengaluru,',
                              style: TextStyle(fontSize: 12, color: Colors.black87),
                            ),
                            Text(
                              'Karnataka 560001',
                              style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 2. Promotional Discount Card
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: const Color(0xFF162A4A), // Dark blue shade matching image
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      // Content Side
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Save your\n70% off',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white24,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                              ),
                              child: const Text('Shop now', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      ),
                      // Image Placeholder graphics
                      Positioned(
                        right: 16,
                        bottom: 0,
                        top: 0,
                        child: Center(
                          child: Container(
                            width: 110,
                            height: 130,
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.image, color: Colors.white30, size: 40),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Carousel Page Indicator dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle)),
                ],
              ),
              const SizedBox(height: 24),

              // 3. Featured Hotels Section Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Featured Hotels',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        children: const [
                          Text('View All', style: TextStyle(color: Colors.grey, fontSize: 13)),
                          Icon(Icons.chevron_right, color: Colors.grey, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Horizontal Hotel Cards List
              SizedBox(
                height: 140,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(16),
                  children: const [
                    HotelCard(name: 'Grand Stay Inn', price: '₹2500/night'),
                    HotelCard(name: 'City Center Suites', price: '₹2500/night'),
                    HotelCard(name: 'Parkview Luxury', price: '₹2500/night'),
                  ],
                ),
              ),

              // 4. Best Sellers Navigation Header Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F2547), // Dark variant container
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Best Sellers',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Icon(Icons.chevron_right, color: Colors.white, size: 18),
                    ],
                  ),
                ),
              ),

              // Bottom Grid/Showcase placeholder area
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
color: Colors.grey[100],borderRadius: BorderRadius.circular(8),),
child: const Icon(Icons.fastfood_outlined, color: Colors.grey),),),const SizedBox(width: 16),Expanded(child: Container(height: 80,decoration: BoxDecoration(color: Colors.grey[100],borderRadius: BorderRadius.circular(8),),child: const Icon(Icons.shopping_bag_outlined, color: Colors.grey),),),],),)],),),
),
  bottomNavigationBar: BottomNavigationBar(
    currentIndex: _selectedIndex,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.black87,
    unselectedItemColor: Colors.grey,
    selectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
    unselectedLabelStyle: const TextStyle(fontSize: 11),
    onTap: (index) {
      setState(() {
        _selectedIndex = index;
      });
    },
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'Orders'),
      BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Account'),
    ],
  ),
);
}
}


class HotelCard extends StatelessWidget {
  final String name;final String price;
const HotelCard({Key? key,required this.name,required this.price,}) : super(key: key);
@override Widget build(BuildContext context) {return Container(width: 110,margin: const EdgeInsets.only(right: 16),child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
  Container(height: 50,width: double.infinity,decoration: BoxDecoration(color: Colors.grey[100],borderRadius: BorderRadius.circular(8),border: Border.all(color: Colors.grey[200]!),),child: const Icon(Icons.apartment, color: Colors.grey, size: 28),),const SizedBox(height: 6),Text(name,maxLines: 1,overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87),),Row(children: const [Text('4.2', style: TextStyle(fontSize: 10, color: Colors.grey)),Icon(Icons.star, color: Colors.amber, size: 10),],),Text(price,style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54),),
],
),

);
}
}