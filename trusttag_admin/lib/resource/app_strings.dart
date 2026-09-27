class AppStrings {
  AppStrings._();

  // Branding
  static const String appName = 'TrustTag Admin';
  static const String trustTag = 'TrustTag';
  static const String admin = 'Admin';

  // Navigation Items
  static const String navDashboard = 'Dashboard';
  static const String navVerification = 'Verification';
  static const String navProducts = 'Products';
  static const String navUsers = 'Users';
  static const String navServiceHistory = 'Service History';
  static const String navServiceCenters = 'Service Centers';
  static const String navLogout = 'Logout';

  // Dashboard Header & Stats
  static const String dashboardTitle = 'Dashboard';
  static const String welcomeBackAdmin = 'Welcome back, Admin';
  static const String statTotalUsers = 'Total Users';
  static const String statTotalProducts = 'Total Products';
  static const String statPendingReview = 'Pending Review';
  static const String statVerified = 'Verified';

  // Recent Verification Table
  static const String recentRequestsTitle = 'Recent Verification Requests';
  static const String colProduct = 'Product';
  static const String colOwner = 'Owner';
  static const String colStatus = 'Status';

  // Product Verification Screen
  static const String productVerificationTitle = 'Product Verification';
  static const String productVerificationSubtitle =
      'Review and approve pending products';
  static const String productDetailsTitle = 'Product Details';
  static const String productInformation = 'Product Information';
  static const String documents = 'Documents';
  static const String ownerDetails = 'Owner Details';

  // Card Labels
  static const String labelSerial = 'Serial :';
  static const String labelRegisteredBy = 'Registered by';
  static const String labelProductID = 'Product ID';
  static const String labelRegisteredOn = 'Registered On';
  static const String labelWarranty = 'Warranty';
  static const String labelCategory = 'Category';

  // Detail Labels
  static const String labelProductName = 'Product Name';
  static const String labelBrand = 'Brand';
  static const String labelModel = 'Model';
  static const String labelSerialNumber = 'Serial Number';
  static const String labelPurchaseDate = 'Purchase Date';
  static const String labelName = 'Name';
  static const String labelEmail = 'Email';
  static const String labelPhone = 'Phone';

  // Buttons
  static const String btnReject = 'Reject';
  static const String btnViewDetails = 'View Details';
  static const String btnApprove = 'Approve';
  static const String btnView = 'View';

  // Login Screen
  static const String welcomeBack = 'Welcome Back!';
  static const String loginSubtitle = 'Please login to your account';
  static const String email = 'Email';
  static const String emailHint = 'Enter Your Email...';
  static const String password = 'Password';
  static const String passwordHint = '••••••••';
  static const String forgotPassword = 'Forgot Password?';
  static const String loginBtn = 'LOGIN';
  static const String or = 'OR';
  static const String dontHaveAccount = "Don't have an account? ";
  static const String signUpLink = 'Sign Up';

  // Sign Up Screen
  static const String createAccountTitle = 'Create Your Admin\nAccount';
  static const String signUpSubtitle = 'Join the TrustTag security portal';
  static const String fullName = 'Full Name';
  static const String fullNameHint = 'John Doe';
  static const String workEmail = 'Work Email';
  static const String workEmailHint = 'name@company.com';
  static const String confirmPassword = 'Confirm Password';
  static const String agreeToTerms = 'I agree to the ';
  static const String termsOfService = 'Terms of Service';
  static const String and = ' and ';
  static const String privacyPolicy = 'Privacy Policy';
  static const String createAccountBtn = 'Create Account';
  static const String alreadyHaveAccount = 'Already have an account? ';
  static const String loginLink = 'Login';

  // Forgot Password Screen
  static const String forgotPasswordTitle = 'Reset Your Password';
  static const String forgotPasswordSubtitle =
      'Enter your work email address and we will send you instructions to reset your password.';
  static const String sendResetLinkBtn = 'Send Reset Link';
  static const String backToLogin = 'Back to Login';
  static const String resetLinkSentTitle = 'Check Your Email';
  static const String resetLinkSentSubtitle =
      'If an account exists for that email, password reset instructions have been sent.';

  // Validation Messages
  static const String valEmailRequired = 'Email address is required.';
  static const String valEmailInvalid = 'Please enter a valid email address.';
  static const String valPasswordRequired = 'Password is required.';
  static const String valPasswordTooShort =
      'Password must be at least 6 characters.';
  static const String valFullNameRequired = 'Full name is required.';
  static const String valConfirmPasswordRequired =
      'Please confirm your password.';
  static const String valPasswordsDoNotMatch = 'Passwords do not match.';
  static const String valTermsRequired =
      'You must accept the Terms and Privacy Policy to register.';

  // Footer
  static const String copyright =
      '© 2026 TrustTag Security. All rights reserved.';
  static const String contactSupport = 'Contact Support';
}
