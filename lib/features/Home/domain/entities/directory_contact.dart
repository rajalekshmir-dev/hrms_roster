
class DirectoryContact {
  final String name;
  final String title;
  final String location;
  final String? email;
  final String? phone;
  final String? avatar;
  final String? id; 
  final String? department;
  final int occupancyPercent;

  const DirectoryContact({
    required this.name,
    required this.title,
    required this.location,
    this.email,
    this.phone,
    this.avatar,
    this.id,
    this.department,
    this.occupancyPercent = 0,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DirectoryContact &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          id == other.id;

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}