import 'package:flutter/material.dart';
import 'package:trusttag_admin/models/user_model.dart';
import 'package:trusttag_admin/resource/resource.dart';
import 'package:trusttag_admin/widgets/header_widget.dart';
import 'package:trusttag_admin/widgets/sidebar_widget.dart';

class UsersScreen extends StatefulWidget {
  final ValueChanged<NavItem> onItemSelected;
  final VoidCallback? onNotificationTap;

  const UsersScreen({
    super.key,
    required this.onItemSelected,
    this.onNotificationTap,
  });

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  UserAccountStatus? _selectedStatusFilter;

  // Mock Users List (Backend Ready Model Structure)
  final List<UserModel> _allUsers = [
    UserModel(
      id: '1',
      name: 'Aaryan Bharvadiya',
      email: 'aaryanahir1010@gmail.com',
      productsCount: 2,
      transferCount: 2,
      status: UserAccountStatus.active,
      avatarUrl: '',
    ),
    UserModel(
      id: '2',
      name: 'Mr John',
      email: 'john@gmail.com',
      productsCount: 1,
      transferCount: 1,
      status: UserAccountStatus.blocked,
      avatarUrl: '',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<UserModel> get _filteredUsers {
    return _allUsers.where((user) {
      final matchesSearch = _searchQuery.isEmpty ||
          user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          user.email.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesFilter = _selectedStatusFilter == null ||
          user.status == _selectedStatusFilter;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  int get _totalUsers => _allUsers.length;
  int get _activeUsers =>
      _allUsers.where((u) => u.status == UserAccountStatus.active).length;
  int get _blockedUsers =>
      _allUsers.where((u) => u.status == UserAccountStatus.blocked).length;

  void _toggleBlockStatus(UserModel user) {
    setState(() {
      if (user.status == UserAccountStatus.active) {
        user.status = UserAccountStatus.blocked;
      } else {
        user.status = UserAccountStatus.active;
      }
    });

    final String message = user.status == UserAccountStatus.blocked
        ? '${user.name} has been Blocked!'
        : '${user.name} has been Activated!';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: user.status == UserAccountStatus.active
            ? AppColors.success
            : AppColors.error,
        duration: const Duration(seconds: 2),
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
            activeItem: NavItem.users,
            onItemSelected: widget.onItemSelected,
          ),

          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // Top Header Bar
                HeaderWidget(
                  title: 'Manage Users',
                  subtitle: 'View, block, and manage user accounts',
                  onNotificationTap: widget.onNotificationTap,
                ),

                // Main Scrollable Area
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSizes.xl),
                    child: Column(
                      children: [
                        // Search & Filter Bar Row
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 44,
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: (val) {
                                    setState(() {
                                      _searchQuery = val;
                                    });
                                  },
                                  style: AppStyles.body,
                                  decoration: InputDecoration(
                                    hintText: 'Search products...',
                                    hintStyle: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textMuted,
                                    ),
                                    suffixIcon: const Icon(
                                      Icons.search,
                                      size: 20,
                                      color: AppColors.textMuted,
                                    ),
                                    filled: true,
                                    fillColor: AppColors.surface,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: AppSizes.md,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppSizes.radiusXl),
                                      borderSide: const BorderSide(
                                          color: AppColors.border),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppSizes.radiusXl),
                                      borderSide: const BorderSide(
                                          color: AppColors.primary, width: 1.5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSizes.md),
                            SizedBox(
                              height: 44,
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: AppColors.surface,
                                  foregroundColor: AppColors.textPrimary,
                                  side: const BorderSide(color: AppColors.border),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(AppSizes.radiusXl),
                                  ),
                                ),
                                icon: const Icon(Icons.filter_list_outlined,
                                    size: 18),
                                label: const Text('Filter'),
                                onPressed: _showFilterMenu,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.lg),

                        // Users Data Table Container
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius:
                                BorderRadius.circular(AppSizes.radiusLg),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            children: [
                              // Table Header Row
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.lg,
                                  vertical: AppSizes.md,
                                ),
                                decoration: const BoxDecoration(
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(AppSizes.radiusLg),
                                    topRight:
                                        Radius.circular(AppSizes.radiusLg),
                                  ),
                                ),
                                child: const Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        'User',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'products',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Transfer',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Status',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Action',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(height: 1, color: AppColors.border),

                              // Table Rows List
                              if (_filteredUsers.isEmpty)
                                const Padding(
                                  padding: EdgeInsets.all(AppSizes.xxl),
                                  child: Text(
                                    'No users match your filter.',
                                    style: TextStyle(color: AppColors.textMuted),
                                  ),
                                )
                              else
                                ..._filteredUsers.map((user) {
                                  return Column(
                                    children: [
                                      _buildUserRow(user),
                                      const Divider(
                                          height: 1, color: AppColors.border),
                                    ],
                                  );
                                }),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSizes.xl),

                        // Bottom Summary Metrics Cards Row (Clickable to Filter)
                        Row(
                          children: [
                            Expanded(
                              child: _buildMetricCard(
                                value: '$_totalUsers',
                                label: 'Total Users',
                                color: AppColors.primary,
                                isSelected: _selectedStatusFilter == null,
                                onTap: () {
                                  setState(() => _selectedStatusFilter = null);
                                },
                              ),
                            ),
                            const SizedBox(width: AppSizes.md),
                            Expanded(
                              child: _buildMetricCard(
                                value: '$_activeUsers',
                                label: 'Total Active',
                                color: AppColors.success,
                                isSelected: _selectedStatusFilter ==
                                    UserAccountStatus.active,
                                onTap: () {
                                  setState(() => _selectedStatusFilter =
                                      UserAccountStatus.active);
                                },
                              ),
                            ),
                            const SizedBox(width: AppSizes.md),
                            Expanded(
                              child: _buildMetricCard(
                                value: '$_blockedUsers',
                                label: 'Total Blocked',
                                color: AppColors.error,
                                isSelected: _selectedStatusFilter ==
                                    UserAccountStatus.blocked,
                                onTap: () {
                                  setState(() => _selectedStatusFilter =
                                      UserAccountStatus.blocked);
                                },
                              ),
                            ),
                          ],
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

  Widget _buildUserRow(UserModel user) {
    final bool isActive = user.status == UserAccountStatus.active;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.lg,
        vertical: AppSizes.md,
      ),
      child: Row(
        children: [
          // User Info Column (Avatar + Name + Email)
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryLight,
                  ),
                  child: const Center(
                    child: Icon(Icons.person, size: 20, color: AppColors.primary),
                  ),
                ),
                const SizedBox(width: AppSizes.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        user.email,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // products
          Expanded(
            flex: 2,
            child: Text(
              '${user.productsCount}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Transfer
          Expanded(
            flex: 2,
            child: Text(
              '${user.transferCount}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
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
                  color: isActive ? AppColors.approvedBg : AppColors.rejectedBg,
                  borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                ),
                child: Text(
                  isActive ? 'Active' : 'Blocked',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isActive
                        ? AppColors.approvedText
                        : AppColors.rejectedText,
                  ),
                ),
              ),
            ),
          ),

          // Action Buttons (View & Block / Unblock)
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // View Action Circle Button
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
                    onPressed: () => _showUserDetailsDialog(user),
                  ),
                ),
                const SizedBox(width: AppSizes.sm),

                // Block/Unblock Action Circle Button
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFFFEE2E2) : const Color(0xFFDCFCE7),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      isActive
                          ? Icons.do_not_disturb_on_outlined
                          : Icons.check,
                      size: 16,
                      color: isActive ? AppColors.error : AppColors.success,
                    ),
                    onPressed: () => _toggleBlockStatus(user),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required String value,
    required String label,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.lg,
          vertical: AppSizes.md + 2,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          border: Border.all(
            color: isSelected ? color : AppColors.border,
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? color : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterMenu() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter Users by Status',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSizes.md),
              ListTile(
                title: const Text('All Users'),
                trailing: _selectedStatusFilter == null
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(() => _selectedStatusFilter = null);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Active Users'),
                trailing: _selectedStatusFilter == UserAccountStatus.active
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(() =>
                      _selectedStatusFilter = UserAccountStatus.active);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Blocked Users'),
                trailing: _selectedStatusFilter == UserAccountStatus.blocked
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(() =>
                      _selectedStatusFilter = UserAccountStatus.blocked);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUserDetailsDialog(UserModel user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(user.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email: ${user.email}'),
              const SizedBox(height: AppSizes.xs),
              Text('Products Owned: ${user.productsCount}'),
              const SizedBox(height: AppSizes.xs),
              Text('Transfers: ${user.transferCount}'),
              const SizedBox(height: AppSizes.xs),
              Text('Status: ${user.status.name.toUpperCase()}'),
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
