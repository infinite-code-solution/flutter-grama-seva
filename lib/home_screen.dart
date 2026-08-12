import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'add_address_screen.dart';
import 'carousel_screen.dart';
import 'categories_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_scrollController.hasClients) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.position.pixels;
        double delta = 156.0; // width + margin of one card
        if (currentScroll + delta > maxScroll) {
          _scrollController.animateTo(
            0,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.animateTo(
            currentScroll + delta,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _showLocationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Map Placeholder
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.map, size: 64, color: Colors.grey[400]),
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.my_location, size: 16, color: Colors.black87),
                              SizedBox(width: 4),
                              Text('Locate me', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                
                // Delivery Address Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Delivery address',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        // Close the bottom sheet first
                        Navigator.pop(context);
                        // Then navigate to the add address screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AddAddressScreen()),
                        );
                      },
                      icon: const Icon(Icons.add, size: 18, color: Colors.black87),
                      label: const Text('New address', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Address Card 1 (Selected)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBE6), // Light yellow background
                    border: Border.all(color: const Color(0xFFFFE066)), // Yellow border
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.work_outline, size: 20, color: Colors.black87),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Work', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            SizedBox(height: 4),
                            Text(
                              'Tech Park, Whitefield, Bengaluru',
                              style: TextStyle(fontSize: 13, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.edit_outlined, size: 20, color: Colors.black54),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                
                // Address Card 2 (Unselected)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.home_outlined, size: 20, color: Colors.black87),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Home', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            SizedBox(height: 4),
                            Text(
                              '123 Main St. Bengaluru, Karnataka',
                              style: TextStyle(fontSize: 13, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.edit_outlined, size: 20, color: Colors.black54),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                // Confirm Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD700), // Yellow button
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Confirm address',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[80],
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top Custom Header Section
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
                  GestureDetector(
                    onTap: () => _showLocationBottomSheet(context),
                    child: Row(
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
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 2. Promotional Discount Card & Carousel
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: CarouselScreen(),
                    ),
                    const SizedBox(height: 12),

                    // Categories Section
                    const CategoriesScreen(),
                    const SizedBox(height: 16),

                    // 3. Featured Hotels Section Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Featured Hotels',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Row(
                              children: const [
                                Text(
                                  'View All',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: Colors.grey,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Horizontal Hotel Cards List
                    SizedBox(
                      height: 180,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          },
                        ),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: const [
                              HotelCard(
                                name: 'Grand Hyatt',
                                price: '₹5500/night',
                                imageUrl: 'assets/images/hotels/hotel1.jpg',
                              ),
                              HotelCard(
                                name: 'Taj Palace',
                                price: '₹8500/night',
                                imageUrl: 'assets/images/hotels/hotel2.jpg',
                              ),
                              HotelCard(
                                name: 'The Oberoi',
                                price: '₹9500/night',
                                imageUrl: 'assets/images/hotels/hotel3.jpg',
                              ),
                              HotelCard(
                                name: 'Leela Palace',
                                price: '₹12000/night',
                                imageUrl: 'assets/images/hotels/hotel4.jpg',
                              ),
                              HotelCard(
                                name: 'JW Marriott',
                                price: '₹9000/night',
                                imageUrl: 'assets/images/hotels/hotel5.jpg',
                              ),
                              HotelCard(
                                name: 'Radisson Blu',
                                price: '₹4500/night',
                                imageUrl: 'assets/images/hotels/hotel6.jpg',
                              ),
                              HotelCard(
                                name: 'Novotel',
                                price: '₹4000/night',
                                imageUrl: 'assets/images/hotels/hotel7.jpg',
                              ),
                              HotelCard(
                                name: 'Shangri-La',
                                price: '₹8000/night',
                                imageUrl: 'assets/images/hotels/hotel8.jpg',
                              ),
                              HotelCard(
                                name: 'Ritz-Carlton',
                                price: '₹15000/night',
                                imageUrl: 'assets/images/hotels/hotel9.jpg',
                              ),
                              HotelCard(
                                name: 'The Imperial',
                                price: '₹6000/night',
                                imageUrl: 'assets/images/hotels/hotel10.jpg',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Nearby Restaurants Section Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Nearby Restaurants',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Row(
                              children: const [
                                Text(
                                  'View all',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Restaurant Grid
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              mainAxisExtent: 85,
                            ),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          final famousRestaurants = [
                            {
                              'name': 'McDonald\'s',
                              'image':
                                  'assets/images/restaurants/mcdonalds.png',
                            },
                            {
                              'name': 'KFC',
                              'image': 'assets/images/restaurants/kfc.png',
                            },
                            {
                              'name': 'Subway',
                              'image': 'assets/images/restaurants/subway.png',
                            },
                            {
                              'name': 'Domino\'s Pizza',
                              'image': 'assets/images/restaurants/dominos.png',
                            },
                            {
                              'name': 'Burger King',
                              'image':
                                  'assets/images/restaurants/burgerking.png',
                            },
                            {
                              'name': 'Pizza Hut',
                              'image': 'assets/images/restaurants/pizzahut.png',
                            },
                            {
                              'name': 'Starbucks',
                              'image':
                                  'assets/images/restaurants/starbucks.png',
                            },
                            {
                              'name': 'Taco Bell',
                              'image': 'assets/images/restaurants/tacobell.png',
                            },
                            {
                              'name': 'Wendy\'s',
                              'image': 'assets/images/restaurants/wendys.png',
                            },
                            {
                              'name': 'Dunkin\'',
                              'image': 'assets/images/restaurants/dunkin.png',
                            },
                          ];

                          final restaurant =
                              famousRestaurants[index %
                                  famousRestaurants.length];
                          return RestaurantCard(
                            name: restaurant['name']!,
                            deliveryTime: '7 mins + 15 min',
                            imageUrl: restaurant['image']!,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Bottom Grid/Showcase placeholder area
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Most Ordered Food',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Row(
                              children: const [
                                Text(
                                  'View all',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Most Ordered Food Grid
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              mainAxisExtent: 220,
                            ),
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          final foods = [
                            {
                              'name': 'Chicken Biryani',
                              'newPrice': '₹150',
                              'oldPrice': '₹200',
                              'image': 'assets/images/food/biryani.jpg',
                              'topRated': true,
                            },
                            {
                              'name': 'Boneless Butter Chicken',
                              'newPrice': '₹220',
                              'oldPrice': '₹280',
                              'image': 'assets/images/food/butter_chicken.jpg',
                              'topRated': false,
                            },
                            {
                              'name': 'Chapathi',
                              'newPrice': '₹15',
                              'oldPrice': '₹20',
                              'image': 'assets/images/food/chapathi.jpg',
                              'topRated': false,
                            },
                            {
                              'name': 'Egg Roast',
                              'newPrice': '₹80',
                              'oldPrice': '₹110',
                              'image': 'assets/images/food/egg_roast.jpg',
                              'topRated': false,
                            },
                            {
                              'name': 'Masala Dosa',
                              'newPrice': '₹90',
                              'oldPrice': '₹120',
                              'image': 'assets/images/food/masala_dosa.jpg',
                              'topRated': true,
                            },
                            {
                              'name': 'Paneer Tikka',
                              'newPrice': '₹180',
                              'oldPrice': '₹240',
                              'image': 'assets/images/food/paneer_tikka.jpg',
                              'topRated': true,
                            },
                            {
                              'name': 'Mutton Rogan Josh',
                              'newPrice': '₹290',
                              'oldPrice': '₹350',
                              'image':
                                  'assets/images/food/mutton_rogan_josh.jpg',
                              'topRated': false,
                            },
                            {
                              'name': 'Gulab Jamun',
                              'newPrice': '₹60',
                              'oldPrice': '₹90',
                              'image': 'assets/images/food/gulab_jamun.jpg',
                              'topRated': false,
                            },
                          ];

                          final food = foods[index % foods.length];
                          return FoodCard(
                            name: food['name'] as String,
                            newPrice: food['newPrice'] as String,
                            oldPrice: food['oldPrice'] as String,
                            imageUrl: food['image'] as String,
                            isTopRated: food['topRated'] as bool,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final String name;
  final String deliveryTime;
  final String imageUrl;

  const RestaurantCard({
    Key? key,
    required this.name,
    required this.deliveryTime,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imageUrl,
              width: 45,
              height: 45,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 45,
                height: 45,
                color: Colors.grey[200],
                child: const Icon(
                  Icons.restaurant,
                  color: Colors.grey,
                  size: 24,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Row(
                  children: const [
                    Icon(Icons.star, color: Colors.amber, size: 12),
                    Icon(Icons.star, color: Colors.amber, size: 12),
                    Icon(Icons.star, color: Colors.amber, size: 12),
                    Icon(Icons.star, color: Colors.amber, size: 12),
                    Icon(Icons.star, color: Colors.amber, size: 12),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'Delivery - $deliveryTime',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HotelCard extends StatelessWidget {
  final String name;
  final String price;
  final String imageUrl;

  const HotelCard({
    Key? key,
    required this.name,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imageUrl,
              height: 90,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 90,
                color: Colors.grey[200],
                child: const Icon(Icons.broken_image, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: const [
              Text(
                '4.5',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.star, color: Colors.amber, size: 12),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
        ],
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final String name;
  final String newPrice;
  final String oldPrice;
  final String imageUrl;
  final bool isTopRated;

  const FoodCard({
    Key? key,
    required this.name,
    required this.newPrice,
    required this.oldPrice,
    required this.imageUrl,
    this.isTopRated = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imageUrl,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 140,
                  color: Colors.grey[200],
                  child: const Icon(Icons.fastfood, color: Colors.grey),
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(
                  Icons.add,
                  color: Colors.deepOrange,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (isTopRated) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: Colors.deepOrange, size: 12),
                const SizedBox(width: 4),
                const Text(
                  'Top rated',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
        ],
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Text(
              newPrice,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              oldPrice,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
