// Route names for the app
class AppRoutes {
  // Auth routes
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  
  // Client routes
  static const String clientDashboard = '/client/dashboard';
  static const String clientInvoices = '/client/invoices';
  static const String clientAccountants = '/client/accountants';
  static const String clientProfile = '/client/profile';
  static const String createInvoice = '/client/invoices/create';
  static const String editInvoice = '/client/invoices/edit';
  static const String viewInvoice = '/invoices/view';
  static const String accountantDetails = '/client/accountants/details';
  static const String connectAccountant = '/client/accountants/connect';
  
  // Accountant routes
  static const String accountantDashboard = '/accountant/dashboard';
  static const String accountantClients = '/accountant/clients';
  static const String accountantReports = '/accountant/reports';
  static const String accountantProfile = '/accountant/profile';
  static const String clientDetails = '/accountant/clients/details';
  static const String exportData = '/accountant/export';
  
  // Common routes
  static const String notifications = '/notifications';
  static const String settings = '/settings';
  static const String connectionRequests = '/connection-requests';
}
