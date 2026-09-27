enum VerificationStatus {
  pending,
  approved,
  rejected,
}

extension VerificationStatusExtension on VerificationStatus {
  String get label {
    switch (this) {
      case VerificationStatus.approved:
        return 'Approved';
      case VerificationStatus.rejected:
        return 'Rejected';
      case VerificationStatus.pending:
        return 'Pending';
    }
  }
}

class VerificationDocument {
  final String id;
  final String name;
  final String subtitle;
  final String type; // 'pdf' or 'image'
  final String url;

  const VerificationDocument({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.type,
    required this.url,
  });

  factory VerificationDocument.fromJson(Map<String, dynamic> json) {
    return VerificationDocument(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      subtitle: json['subtitle'] ?? '',
      type: json['type'] ?? 'pdf',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subtitle': subtitle,
      'type': type,
      'url': url,
    };
  }
}

class ProductVerificationModel {
  final String id;
  final String productName;
  final String brand;
  final String model;
  final String serialNumber;
  final String productId;
  final String registeredBy;
  final String registeredEmail;
  final String registeredPhone;
  final String registeredDate;
  final String purchaseDate;
  final String warranty;
  final String category;
  final String imageUrl;
  VerificationStatus status;
  final List<VerificationDocument> documents;

  ProductVerificationModel({
    required this.id,
    required this.productName,
    required this.brand,
    required this.model,
    required this.serialNumber,
    required this.productId,
    required this.registeredBy,
    required this.registeredEmail,
    required this.registeredPhone,
    required this.registeredDate,
    required this.purchaseDate,
    required this.warranty,
    required this.category,
    required this.imageUrl,
    this.status = VerificationStatus.pending,
    required this.documents,
  });

  factory ProductVerificationModel.fromJson(Map<String, dynamic> json) {
    return ProductVerificationModel(
      id: json['id'] ?? '',
      productName: json['productName'] ?? '',
      brand: json['brand'] ?? '',
      model: json['model'] ?? '',
      serialNumber: json['serialNumber'] ?? '',
      productId: json['productId'] ?? '',
      registeredBy: json['registeredBy'] ?? '',
      registeredEmail: json['registeredEmail'] ?? '',
      registeredPhone: json['registeredPhone'] ?? '',
      registeredDate: json['registeredDate'] ?? '',
      purchaseDate: json['purchaseDate'] ?? '',
      warranty: json['warranty'] ?? '',
      category: json['category'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      status: json['status'] == 'approved'
          ? VerificationStatus.approved
          : json['status'] == 'rejected'
              ? VerificationStatus.rejected
              : VerificationStatus.pending,
      documents: (json['documents'] as List<dynamic>?)
              ?.map((e) => VerificationDocument.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'brand': brand,
      'model': model,
      'serialNumber': serialNumber,
      'productId': productId,
      'registeredBy': registeredBy,
      'registeredEmail': registeredEmail,
      'registeredPhone': registeredPhone,
      'registeredDate': registeredDate,
      'purchaseDate': purchaseDate,
      'warranty': warranty,
      'category': category,
      'imageUrl': imageUrl,
      'status': status.name,
      'documents': documents.map((e) => e.toJson()).toList(),
    };
  }
}
