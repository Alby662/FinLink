import 'package:intl/intl.dart';

class Invoice {
  final String id;
  final String clientId;
  final String month;
  final int year;
  final String serialNumber;
  final DateTime invoiceDate;
  final String invoiceNumber;
  final String gstin;
  final String partyName;
  final double taxableAmount;
  final double gstPercentage;
  final double cgst;
  final double igst;
  final double sgst;
  final double tdsTcs;
  final double discountPostageFreight;
  final double totalAmount;
  final String? invoiceFileUrl;
  final String status; // 'draft', 'submitted', 'processed'
  final DateTime createdAt;
  final DateTime updatedAt;

  Invoice({
    required this.id,
    required this.clientId,
    required this.month,
    required this.year,
    required this.serialNumber,
    required this.invoiceDate,
    required this.invoiceNumber,
    required this.gstin,
    required this.partyName,
    required this.taxableAmount,
    required this.gstPercentage,
    required this.cgst,
    required this.igst,
    required this.sgst,
    required this.tdsTcs,
    required this.discountPostageFreight,
    required this.totalAmount,
    this.invoiceFileUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create an Invoice from JSON data
  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      clientId: json['client_id'],
      month: json['month'],
      year: json['year'],
      serialNumber: json['serial_number'],
      invoiceDate: DateTime.parse(json['invoice_date']),
      invoiceNumber: json['invoice_number'],
      gstin: json['gstin'],
      partyName: json['party_name'],
      taxableAmount: json['taxable_amount'].toDouble(),
      gstPercentage: json['gst_percentage'].toDouble(),
      cgst: json['cgst'].toDouble(),
      igst: json['igst'].toDouble(),
      sgst: json['sgst'].toDouble(),
      tdsTcs: json['tds_tcs'].toDouble(),
      discountPostageFreight: json['discount_postage_freight'].toDouble(),
      totalAmount: json['total_amount'].toDouble(),
      invoiceFileUrl: json['invoice_file_url'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Convert Invoice to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_id': clientId,
      'month': month,
      'year': year,
      'serial_number': serialNumber,
      'invoice_date': invoiceDate.toIso8601String(),
      'invoice_number': invoiceNumber,
      'gstin': gstin,
      'party_name': partyName,
      'taxable_amount': taxableAmount,
      'gst_percentage': gstPercentage,
      'cgst': cgst,
      'igst': igst,
      'sgst': sgst,
      'tds_tcs': tdsTcs,
      'discount_postage_freight': discountPostageFreight,
      'total_amount': totalAmount,
      'invoice_file_url': invoiceFileUrl,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Create a copy of Invoice with some fields updated
  Invoice copyWith({
    String? id,
    String? clientId,
    String? month,
    int? year,
    String? serialNumber,
    DateTime? invoiceDate,
    String? invoiceNumber,
    String? gstin,
    String? partyName,
    double? taxableAmount,
    double? gstPercentage,
    double? cgst,
    double? igst,
    double? sgst,
    double? tdsTcs,
    double? discountPostageFreight,
    double? totalAmount,
    String? invoiceFileUrl,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Invoice(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      month: month ?? this.month,
      year: year ?? this.year,
      serialNumber: serialNumber ?? this.serialNumber,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      gstin: gstin ?? this.gstin,
      partyName: partyName ?? this.partyName,
      taxableAmount: taxableAmount ?? this.taxableAmount,
      gstPercentage: gstPercentage ?? this.gstPercentage,
      cgst: cgst ?? this.cgst,
      igst: igst ?? this.igst,
      sgst: sgst ?? this.sgst,
      tdsTcs: tdsTcs ?? this.tdsTcs,
      discountPostageFreight: discountPostageFreight ?? this.discountPostageFreight,
      totalAmount: totalAmount ?? this.totalAmount,
      invoiceFileUrl: invoiceFileUrl ?? this.invoiceFileUrl,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class InvoiceFormData {
  final String month;
  final int year;
  final String serialNumber;
  final DateTime invoiceDate;
  final String invoiceNumber;
  final String gstin;
  final String partyName;
  final double taxableAmount;
  final double gstPercentage;
  final double cgst;
  final double igst;
  final double sgst;
  final double tdsTcs;
  final double discountPostageFreight;
  final double totalAmount;

  InvoiceFormData({
    required this.month,
    required this.year,
    required this.serialNumber,
    required this.invoiceDate,
    required this.invoiceNumber,
    required this.gstin,
    required this.partyName,
    required this.taxableAmount,
    required this.gstPercentage,
    required this.cgst,
    required this.igst,
    required this.sgst,
    required this.tdsTcs,
    required this.discountPostageFreight,
    required this.totalAmount,
  });

  // Convert to Invoice
  Invoice toInvoice({
    required String id,
    required String clientId,
    String status = 'draft',
    String? invoiceFileUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) {
    return Invoice(
      id: id,
      clientId: clientId,
      month: month,
      year: year,
      serialNumber: serialNumber,
      invoiceDate: invoiceDate,
      invoiceNumber: invoiceNumber,
      gstin: gstin,
      partyName: partyName,
      taxableAmount: taxableAmount,
      gstPercentage: gstPercentage,
      cgst: cgst,
      igst: igst,
      sgst: sgst,
      tdsTcs: tdsTcs,
      discountPostageFreight: discountPostageFreight,
      totalAmount: totalAmount,
      invoiceFileUrl: invoiceFileUrl,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

// GST calculation utility
Map<String, double> calculateGST(double taxableAmount, double gstPercentage, bool isInterState) {
  final totalGstAmount = (taxableAmount * gstPercentage) / 100;

  if (isInterState) {
    return {
      'cgst': 0,
      'sgst': 0,
      'igst': totalGstAmount,
    };
  } else {
    final halfGst = totalGstAmount / 2;
    return {
      'cgst': halfGst,
      'sgst': halfGst,
      'igst': 0,
    };
  }
}

// Total amount calculation utility
double calculateTotalAmount(
  double taxableAmount,
  double cgst,
  double sgst,
  double igst,
  double tdsTcs,
  double discountPostageFreight,
) {
  return taxableAmount + cgst + sgst + igst - tdsTcs + discountPostageFreight;
}

// Get list of months
List<String> getMonths() {
  return [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
}

// Get current month
String getCurrentMonth() {
  final monthIndex = DateTime.now().month - 1;
  return getMonths()[monthIndex];
}

// Get current year
int getCurrentYear() {
  return DateTime.now().year;
}

// Format currency
String formatCurrency(double amount) {
  return NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  ).format(amount);
}
