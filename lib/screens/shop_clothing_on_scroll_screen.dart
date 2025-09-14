import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart'; // Import go_router

// Helper function to convert Figma color to Flutter Color
Color figmaColor(Map<String, dynamic> color) {
  return Color.fromRGBO(
    (color['r'] * 255).toInt(),
    (color['g'] * 255).toInt(),
    (color['b'] * 255).toInt(),
    color['a'] as double,
  );
}

// Function to generate asset path from Figma ID
String getImagePath(String figmaId) {
  // Figma IDs use ':' and ';', convert to '_' for file paths
  return 'assets/images/I${figmaId.replaceAll(':', '_').replaceAll(';', '_')}.png';
}

class ShopClothingOnScrollScreen extends StatefulWidget {
  static const String routeName = '/shop_clothing_on_scroll';

  const ShopClothingOnScrollScreen({super.key});

  @override
  State<ShopClothingOnScrollScreen> createState() => _ShopClothingOnScrollScreenState();
}

class _ShopClothingOnScrollScreenState extends State<ShopClothingOnScrollScreen> {
  int _selectedIndex = 0; // State for the selected item in the bottom navigation bar

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Implement navigation for each bottom navigation item
    switch (index) {
      case 0: // Shop (current screen or home)
        // If already on the shop screen, navigate to the root of this section.
        context.go(ShopClothingOnScrollScreen.routeName);
        break;
      case 1: // Wishlist
        context.go('/wishlist'); // Placeholder route
        break;
      case 2: // Categories
        context.go('/categories'); // Placeholder route
        break;
      case 3: // Cart
        context.go('/cart'); // Placeholder route
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Define colors from Figma JSON for consistency
    final primaryTextColor = figmaColor({"r": 0.125490203499794, "g": 0.125490203499794, "b": 0.125490203499794, "a": 1}); // Dark grey
    final blueColor = figmaColor({"r": 0, "g": 0.25882354378700256, "b": 0.8784313797950745, "a": 1}); // Figma blue
    final lightBlueBg = figmaColor({"r": 0.8980392217636108, "g": 0.9215686321258545, "b": 0.9882352948188782, "a": 1}); // Light blueish grey for search field
    final blackColor = figmaColor({"r": 0, "g": 0, "b": 0, "a": 1}); // Black

    // Estimate the height of the custom app bar from Figma group's render bounds: 169:86 has height 95.
    final appBarHeight = 95.0;

    // Dummy product data to populate the grid
    final List<Map<String, String>> products = [
      {"image_id": "169:78", "description": "Lorem ipsum dolor sit amet consectetur", "price": "\$17,00"},
      {"image_id": "169:70", "description": "Lorem ipsum dolor sit amet consectetur", "price": "\$17,00"},
      {"image_id": "169:48", "description": "Lorem ipsum dolor sit amet consectetur", "price": "\$17,00"},
      {"image_id": "169:54", "description": "Lorem ipsum dolor sit amet consectetur", "price": "\$17,00"},
      {"image_id": "169:42", "description": "Lorem ipsum dolor sit amet consectetur", "price": "\$17,00"},
      {"image_id": "169:62", "description": "Lorem ipsum dolor sit amet consectetur", "price": "\$17,00"},
    ];

    // Calculate dynamic childAspectRatio for GridView for responsiveness
    // Figma card image actual size: width 165, height 181
    // Description text line height: 16px. Max 2 lines = 32px
    // Price text line height: 21px. Max 1 line = 21px
    // Spacing estimations based on Figma layout (verticalSpacingImageText: 8.0, verticalSpacingTextPrice: 4.0)
    const double horizontalPadding = 20.0;
    const double crossAxisSpacing = 20.0;
    const double verticalSpacingImageText = 8.0;
    const double verticalSpacingTextPrice = 4.0;
    const double textHeightDescription = 36.0; // Figma's bounding box height for 2 lines
    const double textHeightPrice = 21.0; // Figma's bounding box height for 1 line

    // Calculate available width for the grid items
    // screenWidth - (leftPadding + rightPadding + crossAxisSpacing) / 2 items
    final itemWidth = (screenWidth - (2 * horizontalPadding) - crossAxisSpacing) / 2;
    
    // Calculate estimated item image height maintaining Figma's aspect ratio
    final imageHeightRatio = 181 / 165; // Based on Figma's card image dimensions
    final itemImageHeight = itemWidth * imageHeightRatio;

    // Total item height includes image, description, price, and their vertical spacings
    final itemTotalHeight = itemImageHeight + verticalSpacingImageText + textHeightDescription + verticalSpacingTextPrice + textHeightPrice;
    final childAspectRatio = itemWidth / itemTotalHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: blackColor.withOpacity(0.05),
                offset: const Offset(0, 1),
                blurRadius: 1,
              ),
            ],
          ),
          child: SafeArea(
            bottom: false, // Ensure SafeArea handles top only, bottom for bottom nav
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shop',
                        style: GoogleFonts.raleway(
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                          color: primaryTextColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.push('/filter'); // Example navigation using go_router
                        },
                        child: Icon(
                          Icons.filter_list, // Interpreted from Figma group 169:136 (Filter Icon)
                          color: primaryTextColor,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10), // Spacing between title and search field
                  Container(
                    height: 36,
                    decoration: BoxDecoration(
                      color: lightBlueBg,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          'Clothing',
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: blueColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            // Logic to remove filter or update state
                          },
                          child: Icon(
                            Icons.close, // Interpreted from Figma 169:90 (Close Icon)
                            size: 16,
                            color: blueColor.withOpacity(0.4),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            context.push('/search_options'); // Example navigation using go_router
                          },
                          child: Icon(
                            Icons.tune, // Interpreted from Figma group 169:92 (Image Icon)
                            color: blueColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20), // Vertical padding for grid content
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: 20, // Maintain Figma's vertical spacing between rows
          childAspectRatio: childAspectRatio,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];

          return GestureDetector(
            onTap: () {
              context.push('/product_detail', extra: item); // Example navigation using go_router with extra argument
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: itemImageHeight, // Use calculated responsive image height
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: [
                      BoxShadow(
                        color: blackColor.withOpacity(0.1),
                        offset: const Offset(0, 5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: Image.asset(
                      getImagePath(item["image_id"]!),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: verticalSpacingImageText),
                Text(
                  item["description"]!,
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: blackColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: verticalSpacingTextPrice),
                Text(
                  item["price"]!,
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: primaryTextColor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 84 + MediaQuery.of(context).padding.bottom, // Figma value + safe area inset
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: blackColor.withOpacity(0.1),
              offset: const Offset(0, -1),
              blurRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0), // Padding to visually separate from content
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildBottomNavItem(Icons.home_outlined, 0, _selectedIndex == 0 ? blackColor : blueColor, blueColor),
                  _buildBottomNavItem(Icons.favorite_border, 1, _selectedIndex == 1 ? blackColor : blueColor, blueColor),
                  _buildBottomNavItem(Icons.category_outlined, 2, _selectedIndex == 2 ? blackColor : blueColor, blueColor),
                  _buildBottomNavItem(Icons.shopping_bag_outlined, 3, _selectedIndex == 3 ? blackColor : blueColor, blueColor),
                ],
              ),
            ),
            // Bottom bar for iPhone X and newer devices (home indicator)
            // This bar should only be visible if padding.bottom > 0 and should sit at the very bottom
            // The 169:140 rectangle in Figma is for the home indicator
            if (MediaQuery.of(context).padding.bottom > 0)
              Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: MediaQuery.of(context).padding.bottom * 0.3), // Dynamic top padding and smaller bottom for indicator
                child: Container(
                  height: 5,
                  width: 134,
                  decoration: BoxDecoration(
                    color: blackColor,
                    borderRadius: BorderRadius.circular(34),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Helper widget for building bottom navigation items
  Widget _buildBottomNavItem(IconData icon, int index, Color iconActualColor, Color activeUnderlineColor) {
    bool isSelected = _selectedIndex == index;

    // Adjust icon to be filled or outlined based on selection to match Figma's active/inactive state visually
    IconData effectiveIcon;
    if (index == 0) { // Home icon behavior
      effectiveIcon = isSelected ? Icons.home : Icons.home_outlined;
    } else if (index == 1) { // Favorite icon behavior
      effectiveIcon = isSelected ? Icons.favorite : Icons.favorite_border;
    } else if (index == 2) { // Category icon behavior
      effectiveIcon = isSelected ? Icons.category : Icons.category_outlined;
    } else if (index == 3) { // Shopping bag icon behavior
      effectiveIcon = isSelected ? Icons.shopping_bag : Icons.shopping_bag_outlined;
    } else {
      effectiveIcon = icon; // Fallback
    }

    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        child: SizedBox(
          height: 50, // Fixed height for tap area
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                effectiveIcon, // Use effective icon based on selection
                color: iconActualColor, // Use the specific color based on active/inactive state
                size: 24,
              ),
              if (isSelected)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Container(
                    height: 3,
                    width: 25, // Underline bar width
                    decoration: BoxDecoration(
                      color: activeUnderlineColor, // Underline is always blue for active state in Figma
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}