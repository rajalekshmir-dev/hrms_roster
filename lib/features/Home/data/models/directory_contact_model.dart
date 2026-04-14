
// import '../../domain/entities/directory_contact.dart';

// class DirectoryContactModel extends DirectoryContact {
//   const DirectoryContactModel({
//     required super.name,
//     required super.title,
//     required super.location,
//     super.email,
//     super.phone,
//     super.avatar,
//     super.id, 
//     super.department,
//     super.occupancyPercent,
//   });

//   factory DirectoryContactModel.fromJson(Map<String, dynamic> json) {
  
//     final name = json['display_name'] ?? 
//                  json['name'] ?? 
//                  json['full_name'] ?? 
//                  json['employee_name'] ?? 
//                  '';

//     final title = json['designation'] ?? 
//                   json['title'] ?? 
//                   json['position'] ?? 
//                   json['role'] ?? 
//                   '';

//     final location = json['emp_location'] ?? 
//                      json['location'] ?? 
//                      json['office_location'] ?? 
//                      json['branch'] ?? 
//                      json['city'] ?? 
//                      '';

//     final department = json['employee_department'] ?? 
//                        json['department'] ?? 
//                        json['dept'] ?? 
//                        '';

    
//     dynamic idValue = json['employee_id'] ?? json['id'];
//     String? id;
//     if (idValue != null) {
//       id = idValue.toString(); 
//     }

//     return DirectoryContactModel(
//       name: name,
//       title: title,
//       location: location,
//       email: json['email'] ?? json['work_email'],
//       phone: json['phone'] ?? json['mobile'],
//       avatar: json['avatar'] ?? json['profile_pic'],
//       id: id,
//       department: department,
//       occupancyPercent: json['occupancy_percent'] ?? json['occupancyPercent'] ?? 0,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'title': title,
//       'location': location,
//       'email': email,
//       'phone': phone,
//       'avatar': avatar,
//       'id': id,
//       'department': department,
//       'occupancy_percent': occupancyPercent,
//     };
//   }
// }


// Update your DirectoryContactModel (data/models/directory_contact_model.dart)
import '../../domain/entities/directory_contact.dart';

class DirectoryContactModel extends DirectoryContact {
  const DirectoryContactModel({
    required super.name,
    required super.title,
    required super.location,
    super.email,
    super.phone,
    super.avatar,
    super.id, 
    super.department,
    super.occupancyPercent,
    super.techGroup,
    super.employeeId,
  });

  factory DirectoryContactModel.fromJson(Map<String, dynamic> json) {
    final name = json['display_name'] ?? 
                 json['name'] ?? 
                 json['full_name'] ?? 
                 json['employee_name'] ?? 
                 '';

    final title = json['designation'] ?? 
                  json['title'] ?? 
                  json['position'] ?? 
                  json['role'] ?? 
                  '';

    final location = json['emp_location'] ?? 
                     json['location'] ?? 
                     json['office_location'] ?? 
                     json['branch'] ?? 
                     json['city'] ?? 
                     '';

    final department = json['employee_department'] ?? 
                       json['department'] ?? 
                       json['dept'] ?? 
                       '';

    dynamic idValue = json['employee_id'] ?? json['id'];
    String? id;
    if (idValue != null) {
      id = idValue.toString();
    }

    return DirectoryContactModel(
      name: name,
      title: title,
      location: location,
      email: json['email'] ?? json['work_email'],
      phone: json['phone'] ?? json['mobile'],
      avatar: json['avatar'] ?? json['profile_pic'],
      id: id,
      department: department,
      occupancyPercent: json['occupancy_percent'] ?? json['occupancyPercent'] ?? 0,
      techGroup: json['tech_group'],
      employeeId: json['employee_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'location': location,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'id': id,
      'department': department,
      'occupancy_percent': occupancyPercent,
      'tech_group': techGroup,
      'employee_id': employeeId,
    };
  }
}