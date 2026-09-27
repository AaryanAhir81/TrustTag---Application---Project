import 'package:flutter/material.dart';
import 'package:trusttag_admin/models/notification_model.dart';
import 'package:trusttag_admin/resource/resource.dart';
import 'package:trusttag_admin/widgets/common_widgets.dart';
import 'package:trusttag_admin/widgets/header_widget.dart';
import 'package:trusttag_admin/widgets/sidebar_widget.dart';

class NotificationsScreen extends StatefulWidget {
  final ValueChanged<NavItem> onItemSelected;
  final VoidCallback? onNotificationTap;

  const NotificationsScreen({
    super.key,
    required this.onItemSelected,
    this.onNotificationTap,
  });

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String _selectedRecipient = 'All Users';

  final List<String> _recipientOptions = [
    'All Users',
    'Aaryan Bharvadiya',
    'Mr John',
    'User 102',
    'User 105',
  ];

  // Mock Recent Notifications List (Backend Ready Model Structure)
  final List<NotificationModel> _recentNotifications = [
    NotificationModel(
      id: 'NOTIF-101',
      title: 'Product Verified',
      message: 'Your product Iphone 15 Pro has been successfully verified.',
      recipient: 'Aaryan',
      date: 'Today',
      status: NotificationStatus.sent,
    ),
    NotificationModel(
      id: 'NOTIF-102',
      title: 'Service Completed',
      message: 'Keyboard repair for Dell Latitude 7490 is complete.',
      recipient: 'User 102',
      date: 'Yesterday',
      status: NotificationStatus.sent,
    ),
    NotificationModel(
      id: 'NOTIF-103',
      title: 'Ownership Request',
      message: 'Product transfer request initiated for MacBook Air M2.',
      recipient: 'User 105',
      date: '2 days ago',
      status: NotificationStatus.sent,
    ),
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendNotification() {
    if (_formKey.currentState?.validate() ?? false) {
      final newNotif = NotificationModel(
        id: 'NOTIF-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        title: _titleController.text.trim(),
        message: _messageController.text.trim(),
        recipient: _selectedRecipient,
        date: 'Just now',
        status: NotificationStatus.sent,
      );

      setState(() {
        _recentNotifications.insert(0, newNotif);
        _titleController.clear();
        _messageController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Notification sent to $_selectedRecipient!'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  void _deleteNotification(NotificationModel notif) {
    setState(() {
      _recentNotifications.removeWhere((item) => item.id == notif.id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notification deleted.'),
        backgroundColor: AppColors.error,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          // Left Sidebar Navigation
          SidebarWidget(
            activeItem: NavItem.dashboard, // Active nav item
            onItemSelected: widget.onItemSelected,
          ),

          // Main Area
          Expanded(
            child: Column(
              children: [
                // Top Header Bar
                HeaderWidget(
                  title: 'Notifications',
                  subtitle: 'Send broadcast & targeted notifications to users',
                  onNotificationTap: widget.onNotificationTap,
                ),

                // Main Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSizes.xl),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Card 1: Send Notification Form
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(AppSizes.xl),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.send_outlined,
                                        color: AppColors.primary,
                                        size: 22,
                                      ),
                                      SizedBox(width: AppSizes.sm),
                                      Text(
                                        'Send Notification',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: AppSizes.xl),

                                  // Recipient Dropdown (To:)
                                  const Text(
                                    'To:',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: AppSizes.xs + 2),
                                  DropdownButtonFormField<String>(
                                    initialValue: _selectedRecipient,
                                    decoration: AppStyles.inputDecoration(
                                      hintText: 'Select User',
                                      prefixIcon: const Icon(
                                        Icons.person_outline,
                                        size: 20,
                                        color: AppColors.textMuted,
                                      ),
                                    ),
                                    items: _recipientOptions
                                        .map(
                                          (user) => DropdownMenuItem(
                                            value: user,
                                            child: Text(user,
                                                style: AppStyles.body),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (val) {
                                      if (val != null) {
                                        setState(() {
                                          _selectedRecipient = val;
                                        });
                                      }
                                    },
                                  ),
                                  const SizedBox(height: AppSizes.md),

                                  // Title Input Field
                                  CustomInputField(
                                    label: 'Title:',
                                    hintText: 'Enter notification title...',
                                    controller: _titleController,
                                    prefixIcon: Icons.title_outlined,
                                    validator: (val) {
                                      if (val == null || val.trim().isEmpty) {
                                        return 'Notification title is required.';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: AppSizes.md),

                                  // Message Input Field
                                  const Text(
                                    'Message:',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: AppSizes.xs + 2),
                                  TextFormField(
                                    controller: _messageController,
                                    maxLines: 3,
                                    style: AppStyles.body,
                                    validator: (val) {
                                      if (val == null || val.trim().isEmpty) {
                                        return 'Notification message is required.';
                                      }
                                      return null;
                                    },
                                    decoration: AppStyles.inputDecoration(
                                      hintText: 'Enter notification message...',
                                    ),
                                  ),
                                  const SizedBox(height: AppSizes.xl),

                                  // Send Notification Action Button
                                  PrimaryButton(
                                    text: 'Send Notification',
                                    onPressed: _sendNotification,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSizes.xl),

                        // Card 2: Recent Notifications Table Container
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(AppSizes.xl),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.history_outlined,
                                      color: AppColors.primary,
                                      size: 22,
                                    ),
                                    SizedBox(width: AppSizes.sm),
                                    Text(
                                      'Recent Notifications',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppSizes.lg),

                                // Data Table
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.border),
                                    borderRadius: BorderRadius.circular(
                                        AppSizes.radiusMd),
                                  ),
                                  child: Column(
                                    children: [
                                      // Table Header
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: AppSizes.lg,
                                          vertical: AppSizes.md,
                                        ),
                                        decoration: const BoxDecoration(
                                          color: AppColors.background,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                AppSizes.radiusMd),
                                            topRight: Radius.circular(
                                                AppSizes.radiusMd),
                                          ),
                                        ),
                                        child: const Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                'TITLE',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.textSecondary,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'RECIPIENT',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.textSecondary,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'SENT DATE',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.textSecondary,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'STATUS',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.textSecondary,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'ACTION',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.textSecondary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                          height: 1, color: AppColors.border),

                                      // Table Rows List
                                      if (_recentNotifications.isEmpty)
                                        const Padding(
                                          padding: EdgeInsets.all(AppSizes.xxl),
                                          child: Text(
                                            'No notifications sent yet.',
                                            style: TextStyle(
                                                color: AppColors.textMuted),
                                          ),
                                        )
                                      else
                                        ..._recentNotifications.map((notif) {
                                          return Column(
                                            children: [
                                              _buildNotificationRow(notif),
                                              const Divider(
                                                  height: 1,
                                                  color: AppColors.border),
                                            ],
                                          );
                                        }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationRow(NotificationModel notif) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.lg,
        vertical: AppSizes.md,
      ),
      child: Row(
        children: [
          // Title Column
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.notifications_active_outlined,
                        size: 18, color: AppColors.primary),
                  ),
                ),
                const SizedBox(width: AppSizes.md),
                Expanded(
                  child: Text(
                    notif.title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Recipient Column
          Expanded(
            flex: 2,
            child: Text(
              notif.recipient,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Date Column
          Expanded(
            flex: 2,
            child: Text(
              notif.date,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ),

          // Status Badge Pill
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.md,
                  vertical: AppSizes.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.approvedBg,
                  borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                ),
                child: const Text(
                  'Sent',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.approvedText,
                  ),
                ),
              ),
            ),
          ),

          // Actions Column (View Message | Delete)
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // View Details Button
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.visibility_outlined,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    onPressed: () => _showNotificationDetailModal(notif),
                  ),
                ),
                const SizedBox(width: AppSizes.xs),

                // Delete Button
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFEE2E2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.delete_outline,
                      size: 16,
                      color: AppColors.error,
                    ),
                    onPressed: () => _deleteNotification(notif),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showNotificationDetailModal(NotificationModel notif) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(notif.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('To: ${notif.recipient}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: AppSizes.xs),
              Text('Sent: ${notif.date}'),
              const SizedBox(height: AppSizes.md),
              const Text('Message Body:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(AppSizes.md),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(notif.message),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
