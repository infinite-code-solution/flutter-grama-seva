import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Explore Services',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildCategoryCard(
                  'Food',
                  const Text('🍔', style: TextStyle(fontSize: 28)),
                ),
                _buildCategoryCard(
                  'Groceries',
                  const Text('🛒', style: TextStyle(fontSize: 28)),
                ),
                _buildCategoryCard(
                  'Clothing',
                  const Text('👕', style: TextStyle(fontSize: 28)),
                ),
                _buildCategoryCard(
                  'Housing',
                  const Text('🏠', style: TextStyle(fontSize: 28)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildCategoryCard(
                  'Pharmacy',
                  const Icon(
                    Icons.local_pharmacy,
                    color: Colors.teal,
                    size: 32,
                  ),
                ),
                _buildCategoryCard(
                  'Hospitals',
                  const Text('🏥', style: TextStyle(fontSize: 28)),
                ),
                _buildCategoryCard(
                  'RMP Doctors',
                  const Text('👨‍⚕️', style: TextStyle(fontSize: 28)),
                ),
                _buildCategoryCard(
                  'Transport',
                  const Text('🚌', style: TextStyle(fontSize: 28)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(String title, Widget iconWidget) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 4.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.indigo.withOpacity(0.03),
                      shape: BoxShape.circle,
                    ),
                    child: iconWidget,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      height: 1.2,
                      letterSpacing: 0.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
