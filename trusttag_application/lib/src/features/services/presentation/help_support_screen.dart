import 'package:trusttag_application/src/core/resources/resources.dart';
import 'package:trusttag_application/src/features/services/presentation/help_article_screen.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: surfaceColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Help Center', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How can we help?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 20),
            // Simple Search Bar
            Container(
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
              ),
              child: TextField(
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                decoration: const InputDecoration(
                  hintText: 'Search for articles...',
                  prefixIcon: Icon(Icons.search, color: Colors.blue),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Popular Topics',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            const SizedBox(height: 12),
            _buildSimpleLink(
              context, 
              'Getting Started with TrustTag',
              'Welcome to TrustTag! To get started, tap the "Add Product" button on your dashboard. You\'ll need your product name, model, and some basic purchase details. Once submitted, our team verifies the information to create your unique Digital Product Passport.'
            ),
            _buildSimpleLink(
              context, 
              'How to Transfer Ownership',
              'Transferring ownership is easy. Go to "My Products", select the item you wish to transfer, and tap the "Transfer" button. Enter the email address of the new owner. They will receive a notification to accept the transfer. Once they accept, the digital passport is updated instantly.'
            ),
            _buildSimpleLink(
              context, 
              'Security & Privacy FAQ',
              'TrustTag uses industry-leading encryption to protect your data. Your Digital Product Passport is stored securely, and only you (the current owner) have full access to its details until a transfer is initiated and confirmed.'
            ),
            _buildSimpleLink(
              context, 
              'Report a Problem',
              'If you encounter any issues with a product or a transfer, please use the "Email Us" button below. Provide as much detail as possible, including product serial numbers if applicable, so our support team can assist you quickly.'
            ),
            
            const SizedBox(height: 40),
            const Text(
              'Contact Support',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.email_outlined, color: Colors.blue),
                    title: Text('Email Us', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                    subtitle: const Text('Typical reply within 24 hours'),
                    trailing: const Icon(Icons.chevron_right, size: 20),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Support email: support@trusttag.com')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleLink(BuildContext context, String title, String content) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.white10 : Colors.transparent),
      ),
      child: ListTile(
        title: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: isDark ? Colors.white70 : Colors.black87)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HelpArticleScreen(title: title, content: content),
            ),
          );
        },
      ),
    );
  }
}
