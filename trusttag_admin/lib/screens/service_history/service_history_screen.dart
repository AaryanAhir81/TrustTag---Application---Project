import 'package:flutter/material.dart';
import 'package:trusttag_admin/models/service_history_model.dart';
import 'package:trusttag_admin/resource/resource.dart';
import 'package:trusttag_admin/widgets/header_widget.dart';
import 'package:trusttag_admin/widgets/sidebar_widget.dart';

class ServiceHistoryScreen extends StatefulWidget {
  final ValueChanged<NavItem> onItemSelected;
  final VoidCallback? onNotificationTap;

  const ServiceHistoryScreen({
    super.key,
    required this.onItemSelected,
    this.onNotificationTap,
  });

  @override
  State<ServiceHistoryScreen> createState() => _ServiceHistoryScreenState();
}

class _ServiceHistoryScreenState extends State<ServiceHistoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  ServiceStatus? _selectedStatusFilter;

  // Mock Service History Records (Backend Ready Model Structure)
  final List<ServiceHistoryModel> _allServices = [
    ServiceHistoryModel(
      id: 'SH-1001',
      productName: 'Iphone 15 Pro',
      serialNumber: 'X7Q2K9L3P4',
      serviceCenter: 'Apple Authorized Care',
      serviceType: 'Battery Replacement',
      date: '20 Jul 2026',
      cost: 'Under Warranty',
      status: ServiceStatus.completed,
      notes: 'Battery health diagnostic passed and component replaced.',
    ),
    ServiceHistoryModel(
      id: 'SH-1002',
      productName: 'Dell Latitude 7490',
      serialNumber: '9JLMT4C1..',
      serviceCenter: 'Dell Support Hub',
      serviceType: 'Keyboard Repair',
      date: '21 Jul 2026',
      cost: '\$85.00',
      status: ServiceStatus.inProgress,
      notes: 'Replacement keyboard module ordered and in installation.',
    ),
    ServiceHistoryModel(
      id: 'SH-1003',
      productName: 'MacBook Air M2',
      serialNumber: 'MC-882310',
      serviceCenter: 'Apple Service Point',
      serviceType: 'Display Diagnostic',
      date: '22 Jul 2026',
      cost: 'Pending Quote',
      status: ServiceStatus.pending,
      notes: 'Initial inspection logged for screen flickering issue.',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ServiceHistoryModel> get _filteredServices {
    return _allServices.where((service) {
      final matchesSearch = _searchQuery.isEmpty ||
          service.productName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          service.serialNumber.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          service.serviceCenter.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          service.serviceType.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesFilter = _selectedStatusFilter == null ||
          service.status == _selectedStatusFilter;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  int get _totalCount => _allServices.length;
  int get _completedCount =>
      _allServices.where((s) => s.status == ServiceStatus.completed).length;
  int get _inProgressCount =>
      _allServices.where((s) => s.status == ServiceStatus.inProgress).length;

  void _deleteServiceRecord(ServiceHistoryModel service) {
    setState(() {
      _allServices.removeWhere((item) => item.id == service.id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Service record ${service.id} deleted successfully.'),
        backgroundColor: AppColors.error,
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
            activeItem: NavItem.serviceHistory,
            onItemSelected: widget.onItemSelected,
          ),

          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // Top Header Bar
                HeaderWidget(
                  title: 'Service History',
                  subtitle: 'View maintenance records and service logs across centers',
                  onNotificationTap: widget.onNotificationTap,
                ),

                // Main Scrollable Body
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSizes.xl),
                    child: Column(
                      children: [
                        // Search Bar & Filter Button Row
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
                                    hintText: 'Search service records...',
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

                        // Service Records Table Container
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
                                        'PRODUCT & SERIAL',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        'SERVICE CENTER',
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
                                        'SERVICE TYPE',
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
                                        'DATE',
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
                                        'STATUS',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        'ACTION',
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
                              if (_filteredServices.isEmpty)
                                const Padding(
                                  padding: EdgeInsets.all(AppSizes.xxl),
                                  child: Text(
                                    'No service records found.',
                                    style: TextStyle(color: AppColors.textMuted),
                                  ),
                                )
                              else
                                ..._filteredServices.map((service) {
                                  return Column(
                                    children: [
                                      _buildServiceRow(service),
                                      const Divider(
                                          height: 1, color: AppColors.border),
                                    ],
                                  );
                                }),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSizes.xl),

                        // Bottom Metric Cards Row
                        Row(
                          children: [
                            Expanded(
                              child: _buildMetricCard(
                                value: '$_totalCount',
                                label: 'Total Services',
                                color: AppColors.primary,
                                isSelected: _selectedStatusFilter == null,
                                onTap: () =>
                                    setState(() => _selectedStatusFilter = null),
                              ),
                            ),
                            const SizedBox(width: AppSizes.md),
                            Expanded(
                              child: _buildMetricCard(
                                value: '$_completedCount',
                                label: 'Completed',
                                color: AppColors.success,
                                isSelected: _selectedStatusFilter ==
                                    ServiceStatus.completed,
                                onTap: () => setState(() =>
                                    _selectedStatusFilter =
                                        ServiceStatus.completed),
                              ),
                            ),
                            const SizedBox(width: AppSizes.md),
                            Expanded(
                              child: _buildMetricCard(
                                value: '$_inProgressCount',
                                label: 'In Progress',
                                color: AppColors.warning,
                                isSelected: _selectedStatusFilter ==
                                    ServiceStatus.inProgress,
                                onTap: () => setState(() =>
                                    _selectedStatusFilter =
                                        ServiceStatus.inProgress),
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

  Widget _buildServiceRow(ServiceHistoryModel service) {
    Color badgeBg;
    Color badgeText;

    switch (service.status) {
      case ServiceStatus.completed:
        badgeBg = AppColors.approvedBg;
        badgeText = AppColors.approvedText;
        break;
      case ServiceStatus.inProgress:
        badgeBg = AppColors.primaryLight;
        badgeText = AppColors.primary;
        break;
      case ServiceStatus.pending:
        badgeBg = AppColors.pendingBg;
        badgeText = AppColors.pendingText;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.lg,
        vertical: AppSizes.md,
      ),
      child: Row(
        children: [
          // Product Name & Serial Number
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.build_outlined,
                        size: 18, color: AppColors.primary),
                  ),
                ),
                const SizedBox(width: AppSizes.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.productName,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'Serial: ${service.serialNumber}',
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

          // Service Center
          Expanded(
            flex: 3,
            child: Text(
              service.serviceCenter,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Service Type
          Expanded(
            flex: 2,
            child: Text(
              service.serviceType,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ),

          // Date
          Expanded(
            flex: 2,
            child: Text(
              service.date,
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
                  color: badgeBg,
                  borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                ),
                child: Text(
                  service.status.label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: badgeText,
                  ),
                ),
              ),
            ),
          ),

          // Action Buttons Row (View | Edit | Delete)
          Expanded(
            flex: 4,
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
                    onPressed: () => _showServiceDetailsDialog(service),
                  ),
                ),
                const SizedBox(width: AppSizes.xs),

                // Edit Button
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    border: Border.all(color: AppColors.border),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.edit_outlined,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () => _showEditServiceDialog(service),
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
                    onPressed: () => _confirmDeleteServiceDialog(service),
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
                'Filter Service History',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSizes.md),
              ListTile(
                title: const Text('All Services'),
                trailing: _selectedStatusFilter == null
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(() => _selectedStatusFilter = null);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Completed'),
                trailing: _selectedStatusFilter == ServiceStatus.completed
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(
                      () => _selectedStatusFilter = ServiceStatus.completed);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('In Progress'),
                trailing: _selectedStatusFilter == ServiceStatus.inProgress
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(
                      () => _selectedStatusFilter = ServiceStatus.inProgress);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Pending'),
                trailing: _selectedStatusFilter == ServiceStatus.pending
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(
                      () => _selectedStatusFilter = ServiceStatus.pending);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showServiceDetailsDialog(ServiceHistoryModel service) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${service.productName} - Service Record'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Record ID: ${service.id}'),
              const SizedBox(height: AppSizes.xs),
              Text('Serial Number: ${service.serialNumber}'),
              const SizedBox(height: AppSizes.xs),
              Text('Service Center: ${service.serviceCenter}'),
              const SizedBox(height: AppSizes.xs),
              Text('Type: ${service.serviceType}'),
              const SizedBox(height: AppSizes.xs),
              Text('Date: ${service.date}'),
              const SizedBox(height: AppSizes.xs),
              Text('Cost / Status: ${service.cost}'),
              const SizedBox(height: AppSizes.md),
              const Text('Notes:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(service.notes),
            ],
          ),
          actions: [
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: const BorderSide(color: AppColors.border),
              ),
              icon: const Icon(Icons.delete_outline, size: 16),
              label: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                _confirmDeleteServiceDialog(service);
              },
            ),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.border),
              ),
              icon: const Icon(Icons.edit_outlined, size: 16),
              label: const Text('Edit'),
              onPressed: () {
                Navigator.of(context).pop();
                _showEditServiceDialog(service);
              },
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showEditServiceDialog(ServiceHistoryModel service) {
    final productNameController =
        TextEditingController(text: service.productName);
    final serialController = TextEditingController(text: service.serialNumber);
    final serviceCenterController =
        TextEditingController(text: service.serviceCenter);
    final serviceTypeController =
        TextEditingController(text: service.serviceType);
    final dateController = TextEditingController(text: service.date);
    final costController = TextEditingController(text: service.cost);
    final notesController = TextEditingController(text: service.notes);
    ServiceStatus editedStatus = service.status;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('Edit Service Record (${service.id})'),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: 420,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: productNameController,
                        decoration:
                            const InputDecoration(labelText: 'Product Name'),
                      ),
                      const SizedBox(height: AppSizes.sm),
                      TextField(
                        controller: serialController,
                        decoration:
                            const InputDecoration(labelText: 'Serial Number'),
                      ),
                      const SizedBox(height: AppSizes.sm),
                      TextField(
                        controller: serviceCenterController,
                        decoration:
                            const InputDecoration(labelText: 'Service Center'),
                      ),
                      const SizedBox(height: AppSizes.sm),
                      TextField(
                        controller: serviceTypeController,
                        decoration:
                            const InputDecoration(labelText: 'Service Type'),
                      ),
                      const SizedBox(height: AppSizes.sm),
                      TextField(
                        controller: dateController,
                        decoration: const InputDecoration(labelText: 'Date'),
                      ),
                      const SizedBox(height: AppSizes.sm),
                      TextField(
                        controller: costController,
                        decoration:
                            const InputDecoration(labelText: 'Cost / Warranty'),
                      ),
                      const SizedBox(height: AppSizes.md),
                      DropdownButtonFormField<ServiceStatus>(
                        initialValue: editedStatus,
                        decoration:
                            const InputDecoration(labelText: 'Service Status'),
                        items: const [
                          DropdownMenuItem(
                            value: ServiceStatus.completed,
                            child: Text('Completed'),
                          ),
                          DropdownMenuItem(
                            value: ServiceStatus.inProgress,
                            child: Text('In Progress'),
                          ),
                          DropdownMenuItem(
                            value: ServiceStatus.pending,
                            child: Text('Pending'),
                          ),
                        ],
                        onChanged: (val) {
                          if (val != null) {
                            setDialogState(() {
                              editedStatus = val;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: AppSizes.sm),
                      TextField(
                        controller: notesController,
                        maxLines: 2,
                        decoration: const InputDecoration(labelText: 'Notes'),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      service.productName = productNameController.text;
                      service.serialNumber = serialController.text;
                      service.serviceCenter = serviceCenterController.text;
                      service.serviceType = serviceTypeController.text;
                      service.date = dateController.text;
                      service.cost = costController.text;
                      service.status = editedStatus;
                      service.notes = notesController.text;
                    });
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Record ${service.id} updated successfully.'),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  },
                  child: const Text('Save Changes'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _confirmDeleteServiceDialog(ServiceHistoryModel service) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Service Record?'),
          content: Text(
            'Are you sure you want to delete service record ${service.id} for "${service.productName}"? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteServiceRecord(service);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
