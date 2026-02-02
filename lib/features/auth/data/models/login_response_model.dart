class LoginResponseModel {
  int? httpStatus;
  LoginData? data;
  String? status;
  String? message;

  LoginResponseModel({this.httpStatus, this.data, this.status, this.message});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    httpStatus = json['http_status'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['http_status'] = this.httpStatus;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class LoginData {
  Contact? contact;
  Permissions? permissions;
  String? accessToken;
  String? tokenType;

  LoginData({this.contact, this.permissions, this.accessToken, this.tokenType});

  LoginData.fromJson(Map<String, dynamic> json) {
    contact =
        json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    permissions = json['permissions'] != null
        ? new Permissions.fromJson(json['permissions'])
        : null;
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
    if (this.permissions != null) {
      data['permissions'] = this.permissions!.toJson();
    }
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    return data;
  }
}

class Contact {
  int? id;
  int? userid;
  int? clientId;
  int? roleId;
  String? firstname;
  String? lastname;
  String? phonenumber;
  String? title;
  String? email;
  String? profileImage;
  String? direction;
  String? emailVerifiedAt;
  int? isPrimary;
  int? createdBy;
  String? updatedBy;
  int? invoiceEmails;
  int? estimateEmails;
  int? creditNoteEmails;
  int? contractEmails;
  int? taskEmails;
  int? projectEmails;
  int? ticketEmails;
  String? createdAt;
  String? updatedAt;

  Contact(
      {this.id,
      this.userid,
      this.clientId,
      this.roleId,
      this.firstname,
      this.lastname,
      this.phonenumber,
      this.title,
      this.email,
      this.profileImage,
      this.direction,
      this.emailVerifiedAt,
      this.isPrimary,
      this.createdBy,
      this.updatedBy,
      this.invoiceEmails,
      this.estimateEmails,
      this.creditNoteEmails,
      this.contractEmails,
      this.taskEmails,
      this.projectEmails,
      this.ticketEmails,
      this.createdAt,
      this.updatedAt});

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    clientId = json['client_id'];
    roleId = json['role_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phonenumber = json['phonenumber'];
    title = json['title'];
    email = json['email'];
    profileImage = json['profile_image'];
    direction = json['direction'].toString();
    emailVerifiedAt = json['email_verified_at'].toString();
    isPrimary = json['is_primary'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'].toString();
    invoiceEmails = json['invoice_emails'];
    estimateEmails = json['estimate_emails'];
    creditNoteEmails = json['credit_note_emails'];
    contractEmails = json['contract_emails'];
    taskEmails = json['task_emails'];
    projectEmails = json['project_emails'];
    ticketEmails = json['ticket_emails'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['client_id'] = this.clientId;
    data['role_id'] = this.roleId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['phonenumber'] = this.phonenumber;
    data['title'] = this.title;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['direction'] = this.direction;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['is_primary'] = this.isPrimary;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['invoice_emails'] = this.invoiceEmails;
    data['estimate_emails'] = this.estimateEmails;
    data['credit_note_emails'] = this.creditNoteEmails;
    data['contract_emails'] = this.contractEmails;
    data['task_emails'] = this.taskEmails;
    data['project_emails'] = this.projectEmails;
    data['ticket_emails'] = this.ticketEmails;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Permissions {
  bool? dashboardDashboardCreate;
  bool? dashboardDashboardUpdate;
  bool? dashboardDashboardDelete;
  bool? dashboardDashboardView;
  bool? companyCompanyCreate;
  bool? companyCompanyUpdate;
  bool? companyCompanyDelete;
  bool? companyCompanyView;
  bool? companyEstimatesCreate;
  bool? companyEstimatesUpdate;
  bool? companyEstimatesDelete;
  bool? companyEstimatesView;
  bool? companyInvoicesCreate;
  bool? companyInvoicesUpdate;
  bool? companyInvoicesDelete;
  bool? companyInvoicesView;
  bool? companyPaymentsCreate;
  bool? companyPaymentsUpdate;
  bool? companyPaymentsDelete;
  bool? companyPaymentsView;
  bool? companyPdfCreate;
  bool? companyPdfUpdate;
  bool? companyPdfDelete;
  bool? companyPdfView;
  bool? manageusersUsersCreate;
  bool? manageusersUsersUpdate;
  bool? manageusersUsersDelete;
  bool? manageusersUsersView;
  bool? manageusersRolesandpermissionsCreate;
  bool? manageusersRolesandpermissionsUpdate;
  bool? manageusersRolesandpermissionsDelete;
  bool? manageusersRolesandpermissionsView;
  bool? leadsContactsCreate;
  bool? leadsContactsUpdate;
  bool? leadsContactsDelete;
  bool? leadsContactsView;
  bool? leadsSourcesCreate;
  bool? leadsSourcesUpdate;
  bool? leadsSourcesDelete;
  bool? leadsSourcesView;
  bool? leadsStatusesCreate;
  bool? leadsStatusesUpdate;
  bool? leadsStatusesDelete;
  bool? leadsStatusesView;

  Permissions(
      {this.dashboardDashboardCreate,
      this.dashboardDashboardUpdate,
      this.dashboardDashboardDelete,
      this.dashboardDashboardView,
      this.companyCompanyCreate,
      this.companyCompanyUpdate,
      this.companyCompanyDelete,
      this.companyCompanyView,
      this.companyEstimatesCreate,
      this.companyEstimatesUpdate,
      this.companyEstimatesDelete,
      this.companyEstimatesView,
      this.companyInvoicesCreate,
      this.companyInvoicesUpdate,
      this.companyInvoicesDelete,
      this.companyInvoicesView,
      this.companyPaymentsCreate,
      this.companyPaymentsUpdate,
      this.companyPaymentsDelete,
      this.companyPaymentsView,
      this.companyPdfCreate,
      this.companyPdfUpdate,
      this.companyPdfDelete,
      this.companyPdfView,
      this.manageusersUsersCreate,
      this.manageusersUsersUpdate,
      this.manageusersUsersDelete,
      this.manageusersUsersView,
      this.manageusersRolesandpermissionsCreate,
      this.manageusersRolesandpermissionsUpdate,
      this.manageusersRolesandpermissionsDelete,
      this.manageusersRolesandpermissionsView,
      this.leadsContactsCreate,
      this.leadsContactsUpdate,
      this.leadsContactsDelete,
      this.leadsContactsView,
      this.leadsSourcesCreate,
      this.leadsSourcesUpdate,
      this.leadsSourcesDelete,
      this.leadsSourcesView,
      this.leadsStatusesCreate,
      this.leadsStatusesUpdate,
      this.leadsStatusesDelete,
      this.leadsStatusesView});

  Permissions.fromJson(Map<String, dynamic> json) {
    dashboardDashboardCreate = json['dashboard.dashboard.create'];
    dashboardDashboardUpdate = json['dashboard.dashboard.update'];
    dashboardDashboardDelete = json['dashboard.dashboard.delete'];
    dashboardDashboardView = json['dashboard.dashboard.view'];
    companyCompanyCreate = json['company.company.create'];
    companyCompanyUpdate = json['company.company.update'];
    companyCompanyDelete = json['company.company.delete'];
    companyCompanyView = json['company.company.view'];
    companyEstimatesCreate = json['company.estimates.create'];
    companyEstimatesUpdate = json['company.estimates.update'];
    companyEstimatesDelete = json['company.estimates.delete'];
    companyEstimatesView = json['company.estimates.view'];
    companyInvoicesCreate = json['company.invoices.create'];
    companyInvoicesUpdate = json['company.invoices.update'];
    companyInvoicesDelete = json['company.invoices.delete'];
    companyInvoicesView = json['company.invoices.view'];
    companyPaymentsCreate = json['company.payments.create'];
    companyPaymentsUpdate = json['company.payments.update'];
    companyPaymentsDelete = json['company.payments.delete'];
    companyPaymentsView = json['company.payments.view'];
    companyPdfCreate = json['company.pdf.create'];
    companyPdfUpdate = json['company.pdf.update'];
    companyPdfDelete = json['company.pdf.delete'];
    companyPdfView = json['company.pdf.view'];
    manageusersUsersCreate = json['manageusers.users.create'];
    manageusersUsersUpdate = json['manageusers.users.update'];
    manageusersUsersDelete = json['manageusers.users.delete'];
    manageusersUsersView = json['manageusers.users.view'];
    manageusersRolesandpermissionsCreate =
        json['manageusers.rolesandpermissions.create'];
    manageusersRolesandpermissionsUpdate =
        json['manageusers.rolesandpermissions.update'];
    manageusersRolesandpermissionsDelete =
        json['manageusers.rolesandpermissions.delete'];
    manageusersRolesandpermissionsView =
        json['manageusers.rolesandpermissions.view'];
    leadsContactsCreate = json['leads.contacts.create'];
    leadsContactsUpdate = json['leads.contacts.update'];
    leadsContactsDelete = json['leads.contacts.delete'];
    leadsContactsView = json['leads.contacts.view'];
    leadsSourcesCreate = json['leads.sources.create'];
    leadsSourcesUpdate = json['leads.sources.update'];
    leadsSourcesDelete = json['leads.sources.delete'];
    leadsSourcesView = json['leads.sources.view'];
    leadsStatusesCreate = json['leads.statuses.create'];
    leadsStatusesUpdate = json['leads.statuses.update'];
    leadsStatusesDelete = json['leads.statuses.delete'];
    leadsStatusesView = json['leads.statuses.view'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dashboard.dashboard.create'] = this.dashboardDashboardCreate;
    data['dashboard.dashboard.update'] = this.dashboardDashboardUpdate;
    data['dashboard.dashboard.delete'] = this.dashboardDashboardDelete;
    data['dashboard.dashboard.view'] = this.dashboardDashboardView;
    data['company.company.create'] = this.companyCompanyCreate;
    data['company.company.update'] = this.companyCompanyUpdate;
    data['company.company.delete'] = this.companyCompanyDelete;
    data['company.company.view'] = this.companyCompanyView;
    data['company.estimates.create'] = this.companyEstimatesCreate;
    data['company.estimates.update'] = this.companyEstimatesUpdate;
    data['company.estimates.delete'] = this.companyEstimatesDelete;
    data['company.estimates.view'] = this.companyEstimatesView;
    data['company.invoices.create'] = this.companyInvoicesCreate;
    data['company.invoices.update'] = this.companyInvoicesUpdate;
    data['company.invoices.delete'] = this.companyInvoicesDelete;
    data['company.invoices.view'] = this.companyInvoicesView;
    data['company.payments.create'] = this.companyPaymentsCreate;
    data['company.payments.update'] = this.companyPaymentsUpdate;
    data['company.payments.delete'] = this.companyPaymentsDelete;
    data['company.payments.view'] = this.companyPaymentsView;
    data['company.pdf.create'] = this.companyPdfCreate;
    data['company.pdf.update'] = this.companyPdfUpdate;
    data['company.pdf.delete'] = this.companyPdfDelete;
    data['company.pdf.view'] = this.companyPdfView;
    data['manageusers.users.create'] = this.manageusersUsersCreate;
    data['manageusers.users.update'] = this.manageusersUsersUpdate;
    data['manageusers.users.delete'] = this.manageusersUsersDelete;
    data['manageusers.users.view'] = this.manageusersUsersView;
    data['manageusers.rolesandpermissions.create'] =
        this.manageusersRolesandpermissionsCreate;
    data['manageusers.rolesandpermissions.update'] =
        this.manageusersRolesandpermissionsUpdate;
    data['manageusers.rolesandpermissions.delete'] =
        this.manageusersRolesandpermissionsDelete;
    data['manageusers.rolesandpermissions.view'] =
        this.manageusersRolesandpermissionsView;
    data['leads.contacts.create'] = this.leadsContactsCreate;
    data['leads.contacts.update'] = this.leadsContactsUpdate;
    data['leads.contacts.delete'] = this.leadsContactsDelete;
    data['leads.contacts.view'] = this.leadsContactsView;
    data['leads.sources.create'] = this.leadsSourcesCreate;
    data['leads.sources.update'] = this.leadsSourcesUpdate;
    data['leads.sources.delete'] = this.leadsSourcesDelete;
    data['leads.sources.view'] = this.leadsSourcesView;
    data['leads.statuses.create'] = this.leadsStatusesCreate;
    data['leads.statuses.update'] = this.leadsStatusesUpdate;
    data['leads.statuses.delete'] = this.leadsStatusesDelete;
    data['leads.statuses.view'] = this.leadsStatusesView;
    return data;
  }
}
