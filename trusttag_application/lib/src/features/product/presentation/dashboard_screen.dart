import 'package:trusttag_application/src/core/resources/resources.dart';
import 'package:trusttag_application/src/core/resources/mock_data.dart';
import 'package:trusttag_application/src/core/widgets/fade_in_slide.dart';
import 'package:trusttag_application/src/core/widgets/animated_pressable.dart';
import 'package:trusttag_application/src/features/product/presentation/register_product_screen.dart';
import 'package:trusttag_application/src/features/product/presentation/product_passport_screen.dart';

class DashboardScreen extends StatelessWidget {
  final VoidCallback? onViewAllTap;
  final VoidCallback? onAlertsTap;
  final VoidCallback? onProfileTap;

  const DashboardScreen({
    super.key, 
    this.onViewAllTap,
    this.onAlertsTap,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? AppColors.darkSurface : Colors.white;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppLayout.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Banner
          FadeInSlide(
            delay: 0.1,
            child: RepaintBoundary(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: AppColors.primaryGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppLayout.cardRadius + 4),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2962FF).withValues(alpha: 0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Hello, Aaryan 👋',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Manage and verify your digital\nproduct passports with ease.',
                      style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          FadeInSlide(
            delay: 0.2,
            child: Container(
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(AppLayout.cardRadius - 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                decoration: const InputDecoration(
                  hintText: 'Search your products...',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'Quick Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF1A237E)),
          ),
          const SizedBox(height: 16),
          FadeInSlide(
            delay: 0.3,
            child: Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    context: context,
                    icon: Icons.add_circle_outline,
                    title: 'Add Product',
                    subtitle: 'Register New',
                    color: const Color(0xFFE3F2FD),
                    iconColor: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterProductScreen()),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionCard(
                    context: context,
                    icon: Icons.inventory_2_outlined,
                    title: 'My Products',
                    subtitle: 'View All',
                    color: const Color(0xFFF3E5F5),
                    iconColor: Colors.purple,
                    onTap: onViewAllTap,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'System Overview',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF1A237E)),
          ),
          const SizedBox(height: 16),
          // Overview Section
          Row(
            children: [
              _buildOverviewCard(context, '12', 'Registered', const Color(0xFFE8EAF6), const Color(0xFF3F51B5)),
              const SizedBox(width: 12),
              _buildOverviewCard(context, '9', 'Verified', const Color(0xFFE8F5E9), const Color(0xFF4CAF50)),
              const SizedBox(width: 12),
              _buildOverviewCard(context, '3', 'Requests', const Color(0xFFFFFDE7), const Color(0xFFFBC02D)),
            ],
          ),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activities',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF1A237E)),
              ),
              TextButton(
                onPressed: onViewAllTap,
                child: const Text('See All', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Recent Activities List (from MockData)
          ...MockData.products.take(2).map((product) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _buildActivityItem(context, product),
          )),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnimatedPressable(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          borderRadius: BorderRadius.circular(AppLayout.cardRadius),
          border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDark ? color.withValues(alpha: 0.1) : color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.grey, fontSize: 11),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(BuildContext context, String count, String label, Color bgColor, Color textColor) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
        decoration: BoxDecoration(
          color: isDark ? bgColor.withValues(alpha: 0.1) : bgColor,
          borderRadius: BorderRadius.circular(AppLayout.cardRadius - 4),
          boxShadow: [
            BoxShadow(
              color: textColor.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? Colors.white : textColor),
              maxLines: 1,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: 10, color: isDark ? Colors.white70 : Colors.black54, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(BuildContext context, Product product) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnimatedPressable(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPassportScreen(
              productName: product.name,
              model: product.model,
              assetPath: product.assetPath,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          borderRadius: BorderRadius.circular(AppLayout.cardRadius - 2),
          border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
        ),
        child: Row(
          children: [
            Hero(
              tag: 'product-${product.name}',
              child: Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    product.assetPath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade100,
                      child: const Icon(Icons.image, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 4),
                  Text(product.model, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: product.statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                product.status,
                style: TextStyle(color: product.statusColor, fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
