enum ServiceStatus { completed, inProgress, pending }

extension ServiceStatusExtension on ServiceStatus {
  String get label {
    switch (this) {
      case ServiceStatus.completed:
        return 'Completed';
      case ServiceStatus.inProgress:
        return 'In Progress';
      case ServiceStatus.pending:
        return 'Pending';
    }
  }
}

class ServiceHistoryModel {
  final String id;
  String productName;
  String serialNumber;
  String serviceCenter;
  String serviceType;
  String date;
  String cost;
  ServiceStatus status;
  String notes;

  ServiceHistoryModel({
    required this.id,
    required this.productName,
    required this.serialNumber,
    required this.serviceCenter,
    required this.serviceType,
    required this.date,
    required this.cost,
    required this.status,
    this.notes = '',
  });

  ServiceHistoryModel copyWith({
    String? id,
    String? productName,
    String? serialNumber,
    String? serviceCenter,
    String? serviceType,
    String? date,
    String? cost,
    ServiceStatus? status,
    String? notes,
  }) {
    return ServiceHistoryModel(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      serialNumber: serialNumber ?? this.serialNumber,
      serviceCenter: serviceCenter ?? this.serviceCenter,
      serviceType: serviceType ?? this.serviceType,
      date: date ?? this.date,
      cost: cost ?? this.cost,
      status: status ?? this.status,
      notes: notes ?? this.notes,
    );
  }

  factory ServiceHistoryModel.fromJson(Map<String, dynamic> json) {
    return ServiceHistoryModel(
      id: json['id'] ?? '',
      productName: json['productName'] ?? '',
      serialNumber: json['serialNumber'] ?? '',
      serviceCenter: json['serviceCenter'] ?? '',
      serviceType: json['serviceType'] ?? '',
      date: json['date'] ?? '',
      cost: json['cost'] ?? 'N/A',
      status: json['status'] == 'completed'
          ? ServiceStatus.completed
          : json['status'] == 'inProgress'
              ? ServiceStatus.inProgress
              : ServiceStatus.pending,
      notes: json['notes'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'serialNumber': serialNumber,
      'serviceCenter': serviceCenter,
      'serviceType': serviceType,
      'date': date,
      'cost': cost,
      'status': status.name,
      'notes': notes,
    };
  }
}
