class LeadResponseModel {
  int? httpStatus;
  List<LeadsData>? data;
  Pagination? pagination;
  String? status;
  String? message;

  LeadResponseModel(
      {this.httpStatus, this.data, this.pagination, this.status, this.message});

  LeadResponseModel.fromJson(Map<String, dynamic> json) {
    httpStatus = json['http_status'];
    if (json['data'] != null) {
      data = <LeadsData>[];
      json['data'].forEach((v) {
        data!.add(LeadsData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['http_status'] = this.httpStatus;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class LeadsData {
  int? id;
  String? assigned;
  String? name;
  String? company;
  String? email;
  String? phone;
  String? leadSourceName;
  String? leadStatusName;
  String? leadStatusColor;
  String? createdAt;
  String? lastcontact;

  LeadsData(
      {this.id,
      this.assigned,
      this.name,
      this.company,
      this.email,
      this.phone,
      this.leadSourceName,
      this.leadStatusName,
      this.leadStatusColor,
      this.createdAt,
      this.lastcontact});

  LeadsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assigned = json['assigned'];
    name = json['name'];
    company = json['company'];
    email = json['email'];
    phone = json['phone'];
    leadSourceName = json['lead_source_name'];
    leadStatusName = json['lead_status_name'];
    leadStatusColor = json['lead_status_color'];
    createdAt = json['created_at'];
    lastcontact = json['lastcontact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['assigned'] = this.assigned;
    data['name'] = this.name;
    data['company'] = this.company;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['lead_source_name'] = this.leadSourceName;
    data['lead_status_name'] = this.leadStatusName;
    data['lead_status_color'] = this.leadStatusColor;
    data['created_at'] = this.createdAt;
    data['lastcontact'] = this.lastcontact;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;

  Pagination({this.currentPage, this.lastPage, this.perPage, this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    return data;
  }
}
