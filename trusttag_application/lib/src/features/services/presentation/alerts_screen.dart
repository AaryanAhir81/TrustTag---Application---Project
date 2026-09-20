import 'package:trusttag_application/src/core/resources/resources.dart';

class AlertsScreen extends StatelessWidget {
  final bool isTab;

  const AlertsScreen({super.key, this.isTab = false});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: isTab 
          ? null 
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.blue.withValues(alpha: 0.1),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
        title: Text(
          'Notifications',
          style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Center(
                child: Text(
                  '2 New',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNotificationCard(
            context: context,
            icon: Icons.arrow_forward,
            iconColor: Colors.blue,
            title: 'Ownership Request',
            description: 'Alex Turner wants to claim your MacBook Pro',
            time: '2m ago',
            isUnread: true,
          ),
          const SizedBox(height: 12),
          _buildNotificationCard(
            context: context,
            icon: Icons.check_circle,
            iconColor: Colors.green,
            title: 'Transfer Approved',
            description: 'Your iPhone 13 transfer to Jamie was approved',
            time: '1h ago',
            isUnread: true,
          ),
          const SizedBox(height: 12),
          _buildNotificationCard(
            context: context,
            icon: Icons.error_outline,
            iconColor: Colors.amber,
            title: 'Warranty Expiring',
            description: 'MacBook Pro warranty expires in 30 days',
            time: '3h ago',
          ),
          const SizedBox(height: 12),
          _buildNotificationCard(
            context: context,
            icon: Icons.notifications_none,
            iconColor: Colors.blue,
            title: 'Service Reminder',
            description: 'Samsung Galaxy S24 service due next month',
            time: '1d ago',
          ),
          const SizedBox(height: 12),
          _buildNotificationCard(
            context: context,
            icon: Icons.cancel_outlined,
            iconColor: Colors.red,
            title: 'Transfer Rejected',
            description: 'The ownership request for iPad Air was declined',
            time: '2d ago',
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required String time,
    bool isUnread = false,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(AppLayout.cardRadius),
        border: Border.all(color: isUnread ? Colors.blue.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.05)),
        boxShadow: isUnread ? [
          BoxShadow(color: Colors.blue.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))
        ] : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withValues(alpha: 0.1),
            radius: 24,
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black87,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
