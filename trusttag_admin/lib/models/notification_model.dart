enum NotificationStatus { sent, pending, failed }

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String recipient;
  final String date;
  final NotificationStatus status;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.recipient,
    required this.date,
    this.status = NotificationStatus.sent,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      recipient: json['recipient'] ?? '',
      date: json['date'] ?? '',
      status: json['status'] == 'pending'
          ? NotificationStatus.pending
          : json['status'] == 'failed'
              ? NotificationStatus.failed
              : NotificationStatus.sent,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'recipient': recipient,
      'date': date,
      'status': status.name,
    };
  }
}
