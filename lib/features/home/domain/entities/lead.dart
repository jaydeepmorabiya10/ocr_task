class Lead {
  final int? id;
  final String? assigned;
  final String? name;
  final String? company;
  final String? email;
  final String? phone;
  final String? leadSourceName;
  final String? leadStatusName;
  final String? leadStatusColor;
  final String? createdAt;
  final String? lastcontact;

  Lead({
    this.id,
    this.assigned,
    this.name,
    this.company,
    this.email,
    this.phone,
    this.leadSourceName,
    this.leadStatusName,
    this.leadStatusColor,
    this.createdAt,
    this.lastcontact,
  });

  factory Lead.fromJson(Map<String, dynamic> json) {
    return Lead(
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
