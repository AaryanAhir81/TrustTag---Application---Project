import 'package:flutter/material.dart';
import 'package:trusttag_application/src/core/constants/app_colors.dart';

class RegisterProductScreen extends StatefulWidget {
  const RegisterProductScreen({super.key});

  @override
  State<RegisterProductScreen> createState() => _RegisterProductScreenState();
}

class _RegisterProductScreenState extends State<RegisterProductScreen> {
  int _currentStep = 1;
  final PageController _pageController = PageController();

  // Step 1 Controllers
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _categoryController = TextEditingController();
  final _serialController = TextEditingController();
  String _selectedCondition = 'Excellent';

  // Step 2 Controllers
  final _purchaseDateController = TextEditingController();
  final _priceController = TextEditingController();
  final _sellerController = TextEditingController();
  final _warrantyStartController = TextEditingController();
  final _warrantyEndController = TextEditingController();

  void _nextPage() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
      _pageController.animateToPage(
        _currentStep - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentStep > 1) {
      setState(() {
        _currentStep--;
      });
      _pageController.animateToPage(
        _currentStep - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.blue.withValues(alpha: 0.1),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black, size: 20),
              onPressed: _previousPage,
            ),
          ),
        ),
        title: Text(
          'Register Product',
          style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          _buildStepIndicator(),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildStep1(),
                _buildStep2(),
                _buildStep3(),
              ],
            ),
          ),
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    String stepTitle = '';
    if (_currentStep == 1) stepTitle = 'Basic Info';
    if (_currentStep == 2) stepTitle = 'Purchase Details';
    if (_currentStep == 3) stepTitle = 'Documents';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step $_currentStep of 3',
                style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
              ),
              Text(
                stepTitle,
                style: const TextStyle(color: AppColors.secondaryBlue, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildProgressBar(active: _currentStep >= 1),
              const SizedBox(width: 8),
              _buildProgressBar(active: _currentStep >= 2),
              const SizedBox(width: 8),
              _buildProgressBar(active: _currentStep >= 3),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar({required bool active}) {
    return Expanded(
      child: Container(
        height: 6,
        decoration: BoxDecoration(
          color: active ? Colors.blue : Colors.grey.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldLabel('Product Name'),
          _buildTextField(_nameController, 'e.g Iphone 15 pro'),
          const SizedBox(height: 16),
          _buildFieldLabel('Brand'),
          _buildTextField(_brandController, 'e.g Apple'),
          const SizedBox(height: 16),
          _buildFieldLabel('Model'),
          _buildTextField(_modelController, 'e.g A3290'),
          const SizedBox(height: 16),
          _buildFieldLabel('Category'),
          _buildTextField(_categoryController, 'Phone / Laptop / Tablet..'),
          const SizedBox(height: 16),
          _buildFieldLabel('Serial Number'),
          _buildTextField(_serialController, 'e.g D23X6GDSF8H'),
          const SizedBox(height: 16),
          _buildFieldLabel('Condition'),
          Row(
            children: [
              _buildConditionOption('Excellent'),
              const SizedBox(width: 10),
              _buildConditionOption('Good'),
              const SizedBox(width: 10),
              _buildConditionOption('Fair'),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldLabel('Purchase Date'),
          _buildTextField(_purchaseDateController, 'dd-mm-yyy'),
          const SizedBox(height: 16),
          _buildFieldLabel('Purchase Price'),
          _buildTextField(_priceController, 'e.g \$999'),
          const SizedBox(height: 16),
          _buildFieldLabel('Seller / Store'),
          _buildTextField(_sellerController, 'e.g Apple Store'),
          const SizedBox(height: 16),
          _buildFieldLabel('Warranty Start'),
          _buildTextField(_warrantyStartController, 'dd-mm-yyy'),
          const SizedBox(height: 16),
          _buildFieldLabel('Warranty End'),
          _buildTextField(_warrantyEndController, 'dd-mm-yyy'),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Upload supporting documents to strengthen your product\'s verification.',
            style: TextStyle(color: AppColors.textGrey, fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 24),
          _buildDocUploadTile(Icons.description_outlined, 'Purchase Invoice', 'Required - PDF , JPG , PNG'),
          const SizedBox(height: 16),
          _buildDocUploadTile(Icons.verified_user_outlined, 'Warranty Card', 'Required - PDF , JPG , PNG'),
          const SizedBox(height: 16),
          _buildDocUploadTile(Icons.camera_alt_outlined, 'Product Photos', 'Optimal - PDF , JPG , PNG'),
          const SizedBox(height: 16),
          _buildDocUploadTile(Icons.handyman_outlined, 'Service Documents', 'Optimal - PDF , JPG , PNG'),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: isDark ? Colors.white70 : Colors.black87),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: isDark ? Colors.white : Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        ),
      ),
    );
  }

  Widget _buildConditionOption(String title) {
    bool selected = _selectedCondition == title;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedCondition = title;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: selected ? Colors.blue : (isDark ? Colors.white10 : Colors.black12)),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: selected ? Colors.blue : Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDocUploadTile(IconData icon, String title, String subtitle) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? Colors.white10 : Colors.black12, style: BorderStyle.solid),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: isDark ? Colors.white : Colors.black)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        border: Border(top: BorderSide(color: isDark ? Colors.white10 : Colors.black12, width: 0.5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              if (_currentStep < 3) {
                _nextPage();
              } else {
                _showSuccess();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _currentStep == 3 ? Colors.green : const Color(0xFF525CFF),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_currentStep == 3) const Icon(Icons.check_circle_outline),
                if (_currentStep == 3) const SizedBox(width: 8),
                Text(
                  _currentStep == 3 ? 'Register Product' : 'Continue',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                if (_currentStep < 3) const SizedBox(width: 8),
                if (_currentStep < 3) const Icon(Icons.arrow_forward, size: 18),
              ],
            ),
          ),
          if (_currentStep > 1) ...[
            const SizedBox(height: 12),
            TextButton(
              onPressed: _previousPage,
              child: const Text('Back', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            ),
          ],
        ],
      ),
    );
  }

  void _showSuccess() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 80),
                const SizedBox(height: 24),
                Text(
                  'Success!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Your product has been registered successfully.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Pop dialog
                    Navigator.of(context).pop(); // Pop register screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF525CFF),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Go to Home', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
