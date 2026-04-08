import 'package:equatable/equatable.dart';

class AiCriteriaEntity extends Equatable {
  final int? skill;
  final int? availability;
  final int? experience;

  const AiCriteriaEntity({this.skill, this.availability, this.experience});

  @override
  List<Object?> get props => [skill, availability, experience];
}
