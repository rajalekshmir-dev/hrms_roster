import 'package:equatable/equatable.dart';

import 'json_parser.dart';

class EmployeeModel extends Equatable {
  EmployeeModel({
    required this.action,
    required this.ranking,
    required this.response,
    required this.data,
    required this.totalResults,
    required this.parsedQuery,
    required this.processingTime,
    required this.employeeSearch,
  });

  final String? action;
  final bool? ranking;
  final String? response;
  final List<Datum> data;
  final int? totalResults;
  final ParsedQuery? parsedQuery;
  final double? processingTime;
  final bool? employeeSearch;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      action: json["action"],
      ranking: json["ranking"] == true,
      response: json["response"],
      data: (json["data"] as List<dynamic>? ?? [])
          .map((e) => Datum.fromJson(e))
          .toList(),
      totalResults: JsonParser.toInt(json["total_results"]),
      parsedQuery: json["parsed_query"] == null
          ? null
          : ParsedQuery.fromJson(json["parsed_query"]),
      processingTime: JsonParser.toDouble(json["processing_time"]),
      employeeSearch: json["employee_search"] == true,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "action": action,
      "ranking": ranking,
      "response": response,
      "data": data.map((e) => e.toJson()).toList(),
      "total_results": totalResults,
      "parsed_query": parsedQuery,
      "processing_time": processingTime,
      "employee_search": employeeSearch,
    };
  }

  @override
  List<Object?> get props => [
    action,
    ranking,
    response,
    data,
    totalResults,
    parsedQuery,
    processingTime,
    employeeSearch,
  ];
}

class Datum extends Equatable {
  Datum({
    required this.employeeId,
    required this.displayName,
    required this.employeeDepartment,
    required this.totalExp,
    required this.skillSet,
    required this.empLocation,
    required this.designation,
    required this.techGroup,
    required this.vvdnExp,
    required this.projects,
    required this.rankedBy,
    required this.aiScore,
    required this.aiReason,
    required this.aiTier,
    required this.aiCriteria,
  });

  final String? employeeId;
  final String? displayName;
  final String? employeeDepartment;
  final String? totalExp;
  final String? skillSet;
  final String? empLocation;
  final String? designation;
  final String? techGroup;
  final String? vvdnExp;
  final List<Project> projects;
  final String? rankedBy;
  final double? aiScore;
  final String? aiReason;
  final int? aiTier;
  final AiCriteria? aiCriteria;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      employeeId: json['employee_id'] ?? '',
      displayName: json['display_name'] ?? '',
      designation: json['designation'] ?? '',
      employeeDepartment: json["employee_department"],
      totalExp: json["total_exp"],
      skillSet: json["skill_set"],
      empLocation: json["emp_location"],
      techGroup: json["tech_group"],
      vvdnExp: json["vvdn_exp"],
      projects: json["projects"] == null
          ? []
          : List<Project>.from(
              json["projects"]!.map((x) => Project.fromJson(x)),
            ),
      rankedBy: json["ranked_by"],
      aiScore: JsonParser.toDouble(json["ai_score"]),
      aiReason: json["ai_reason"],
      aiTier: json["ai_tier"],
      aiCriteria: json["ai_criteria"] == null
          ? null
          : AiCriteria.fromJson(json["ai_criteria"]),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "employee_id": employeeId,
      "display_name": displayName,
      "employee_department": employeeDepartment,
      "total_exp": totalExp,
      "skill_set": skillSet,
      "emp_location": empLocation,
      "designation": designation,
      "tech_group": techGroup,
      "vvdn_exp": vvdnExp,
      "projects": projects.map((e) => e.toJson()).toList(),
      "ranked_by": rankedBy,
      "ai_score": aiScore,
      "ai_reason": aiReason,
      "ai_tier": aiTier,
      "ai_criteria": aiCriteria?.toJson(),
    };
  }

  @override
  List<Object?> get props => [
    employeeId,
    displayName,
    employeeDepartment,
    totalExp,
    skillSet,
    empLocation,
    designation,
    techGroup,
    vvdnExp,
    projects,
    rankedBy,
    aiScore,
    aiReason,
    aiTier,
    aiCriteria,
  ];
}

class AiCriteria extends Equatable {
  AiCriteria({
    required this.skill,
    required this.availability,
    required this.experience,
  });

  final double? skill;
  final double? availability;
  final double? experience;

  factory AiCriteria.fromJson(Map<String, dynamic> json) {
    return AiCriteria(
      skill: JsonParser.toDouble(json["Skill"]),
      availability: JsonParser.toDouble(json["Availability"]),
      experience: JsonParser.toDouble(json["Experience"]),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "Skill": skill,
      "Availability": availability,
      "Experience": experience,
    };
  }

  @override
  List<Object?> get props => [skill, availability, experience];
}

class Project extends Equatable {
  Project({
    required this.projectName,
    required this.customer,
    required this.role,
    required this.deployment,
    required this.occupancy,
    required this.projectIndustry,
    required this.projectStatus,
    required this.projectJoinedDate,
  });

  final String? projectName;
  final String? customer;
  final String? role;
  final String? deployment;
  final int? occupancy;
  final String? projectIndustry;
  final String? projectStatus;
  final DateTime? projectJoinedDate;

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      projectName: json["project_name"],
      customer: json["customer"],
      role: json["role"],
      deployment: json["deployment"],
      occupancy: JsonParser.toInt(json["occupancy"]),
      projectIndustry: json["project_industry"],
      projectStatus: json["project_status"],
      projectJoinedDate: DateTime.tryParse(json["project_joined_date"] ?? ""),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "project_name": projectName,
      "customer": customer,
      "role": role,
      "deployment": deployment,
      "occupancy": occupancy,
      "project_industry": projectIndustry,
      "project_status": projectStatus,
      "project_joined_date": projectJoinedDate?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
    projectName,
    customer,
    role,
    deployment,
    occupancy,
    projectIndustry,
    projectStatus,
    projectJoinedDate,
  ];
}

class ParsedQuery extends Equatable {
  ParsedQuery({
    required this.skills,
    required this.context,
    required this.skillContextMode,
    required this.location,
    required this.ranking,
    required this.semanticSkills,
  });

  final List<String> skills;
  final List<String> context;
  final String? skillContextMode;
  final String? location;
  final bool? ranking;
  final List<String> semanticSkills;

  factory ParsedQuery.fromJson(Map<String, dynamic> json) {
    return ParsedQuery(
      skills: json["skills"] == null
          ? []
          : List<String>.from(json["skills"]!.map((x) => x)),
      context: json["context"] == null
          ? []
          : List<String>.from(json["context"]!.map((x) => x)),
      skillContextMode: json["skill_context_mode"],
      location: json["location"],
      ranking: json["ranking"],
      semanticSkills: json["semantic_skills"] == null
          ? []
          : List<String>.from(json["semantic_skills"]!.map((x) => x)),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "skills": skills,
      "context": context,
      "skill_context_mode": skillContextMode,
      "location": location,
      "ranking": ranking,
      "semantic_skills": semanticSkills,
    };
  }

  @override
  List<Object?> get props => [
    skills,
    context,
    skillContextMode,
    location,
    ranking,
    semanticSkills,
  ];
}
