import 'package:equatable/equatable.dart';

class ProjectEntity extends Equatable {
  final String? projectName;
  final String? customer;
  final String? role;
  final String? deployment;

  const ProjectEntity({
    this.projectName,
    this.customer,
    this.role,
    this.deployment,
  });

  @override
  List<Object?> get props => [projectName, customer, role, deployment];
}
