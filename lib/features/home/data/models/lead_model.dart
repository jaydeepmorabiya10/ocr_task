import '../../domain/entities/lead.dart';

class LeadModel extends Lead {
  LeadModel({
    super.id,
    super.assigned,
    super.name,
    super.company,
    super.email,
    super.phone,
    super.leadSourceName,
    super.leadStatusName,
    super.leadStatusColor,
    super.createdAt,
    super.lastcontact,
  });

  factory LeadModel.fromJson(Map<String, dynamic> json) {
    return LeadModel(
      id: json['id'],
      assigned: json['assigned'],
      name: json['name'],
      company: json['company'],
      email: json['email'],
      phone: json['phone'],
      leadSourceName: json['lead_source_name'],
      leadStatusName: json['lead_status_name'],
      leadStatusColor: json['lead_status_color'],
      createdAt: json['created_at'],
      lastcontact: json['lastcontact'],
    );
  }
}
