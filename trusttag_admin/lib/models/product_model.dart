enum ProductStatus { verified, pending, rejected }

class ProductModel {
  final String id;
  final String name;
  final String brand;
  final String category;
  final String serialNumber;
  ProductStatus status;
  final int ownersCount;
  final String imageUrl;

  ProductModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.serialNumber,
    required this.status,
    required this.ownersCount,
    required this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      brand: json['brand'] ?? '',
      category: json['category'] ?? '',
      serialNumber: json['serialNumber'] ?? '',
      status: json['status'] == 'verified'
          ? ProductStatus.verified
          : json['status'] == 'rejected'
              ? ProductStatus.rejected
              : ProductStatus.pending,
      ownersCount: json['ownersCount'] ?? 1,
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'category': category,
      'serialNumber': serialNumber,
      'status': status.name,
      'ownersCount': ownersCount,
      'imageUrl': imageUrl,
    };
  }
}
