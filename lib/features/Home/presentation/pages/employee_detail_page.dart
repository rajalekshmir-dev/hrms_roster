import 'package:flutter/material.dart';
import 'package:hrms_roster/core/constant/colors.dart';
import 'package:hrms_roster/core/constant/text_style.dart';
import 'package:hrms_roster/features/Home/domain/entities/directory_contact.dart';
import 'package:hrms_roster/features/search_info/presentation/widgets/employee_card_expended.dart';

class EmployeeDetailPage extends StatefulWidget {
  final DirectoryContact employee;

  const EmployeeDetailPage({super.key, required this.employee});

  @override
  State<EmployeeDetailPage> createState() => _EmployeeDetailPageState();
}

class _EmployeeDetailPageState extends State<EmployeeDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kDashboardBgColor,
      appBar: AppBar(
        title: Text(
          widget.employee.name,
          style: AppTextStyles.headline.copyWith(fontSize: 18),
        ),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.kHeadingColor,
        elevation: 0,
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: AppColors.kSoftColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          widget.employee.name.isNotEmpty
                              ? widget.employee.name[0].toUpperCase()
                              : '?',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.employee.name,
                            style: AppTextStyles.headline,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.employee.employeeId ?? '',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.kPrimaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.employee.title,
                            style: AppTextStyles.subtitle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.kSoftColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.access_time,
                    size: 20,
                    color: AppColors.kPrimaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Created', style: AppTextStyles.caption),
                      const SizedBox(height: 2),
                      Text(
                        widget.employee.createdDate ?? '11/30/2024 5:00AM',
                        style: AppTextStyles.body.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.kPrimaryColor,
              unselectedLabelColor: AppColors.kLightTextColor,
              indicatorColor: AppColors.kPrimaryColor,
              indicatorWeight: 3,
              dividerColor: Colors.transparent,
              labelStyle: AppTextStyles.subtitle.copyWith(
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: AppTextStyles.subtitle,
              tabs: const [
                Tab(text: 'Details'),
                Tab(text: 'Relationships'),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildSectionCard(
                        title: 'Basic Information',
                        child: Column(
                          children: [
                            _buildInfoRow(
                              'Employee ID',
                              widget.employee.employeeId ?? '',
                            ),
                            _buildDivider(),
                            _buildInfoRow('Full Name', widget.employee.name),
                            _buildDivider(),
                            _buildInfoRow(
                              'Department',
                              widget.employee.department ?? '',
                            ),
                            _buildDivider(),
                            _buildInfoRow('Designation', widget.employee.title),
                            _buildDivider(),
                            _buildInfoRow('Location', widget.employee.location),
                            _buildDivider(),
                            _buildInfoRow(
                              'Experience',
                              widget.employee.experience ?? '3Y 4M',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // if (widget.employee.skills != null &&
                      //     widget.employee.skills!.isNotEmpty)
                      //   _buildSectionCard(
                      //     title: 'Skills',
                      //     child: Wrap(
                      //       spacing: 8,
                      //       runSpacing: 8,
                      //       children: widget.employee.skills!.map((skill) {
                      //         return _buildSkillChip(skill);
                      //       }).toList(),
                      //     ),
                      // ),
                      if (widget.employee.skills != null &&
                          widget.employee.skills!.isNotEmpty)
                        _buildSectionCard(
                          title: 'Skills',
                          child: ExpandableSkills(
                            skills: widget.employee.skills!,
                            initialCount: 6,
                          ),
                        ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),

                SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildSectionCard(
                        title: 'Reporting Structure',
                        child: Column(
                          children: [
                            _buildRelationshipRow(
                              'Reporting Manager',
                              widget.employee.reportingManager ??
                                  'Panchal Ileshkumar',
                            ),
                            _buildDivider(),
                            _buildRelationshipRow(
                              'Project Manager',
                              widget.employee.projectManager ?? 'N/A',
                            ),
                            _buildDivider(),
                            _buildRelationshipRow(
                              'Tech Group',
                              widget.employee.techGroup ?? 'IoS',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      if (widget.employee.currentProjects != null &&
                          widget.employee.currentProjects!.isNotEmpty)
                        _buildSectionCard(
                          title: 'Current Projects',
                          child: Column(
                            children: widget.employee.currentProjects!
                                .map((project) => _buildProjectCard(project))
                                .toList(),
                          ),
                        ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(title, style: AppTextStyles.sectionTitle),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.kDashboardBgColor,
          ),
          Padding(padding: const EdgeInsets.all(16), child: child),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.kLightTextColor,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(value, style: AppTextStyles.body)),
        ],
      ),
    );
  }

  Widget _buildRelationshipRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.kLightTextColor,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(ProjectDetail project) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.kGreyColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  project.name,
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.kPrimaryColor,
                  ),
                ),
              ),
              if (project.status != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: project.status == 'BUDGETED'
                        ? Colors.green.shade50
                        : AppColors.kSoftColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    project.status!,
                    style: AppTextStyles.caption.copyWith(
                      color: project.status == 'BUDGETED'
                          ? Colors.green.shade700
                          : AppColors.kPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (project.projectManager != null && project.projectManager != 'N/A')
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      'PM: ${project.projectManager}',
                      style: AppTextStyles.caption,
                    ),
                  ),
                ],
              ),
            ),
          if (project.customer != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      'Customer: ${project.customer}',
                      style: AppTextStyles.caption,
                    ),
                  ),
                ],
              ),
            ),
          if (project.role != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      'Role: ${project.role}',
                      style: AppTextStyles.caption,
                    ),
                  ),
                ],
              ),
            ),
          if (project.occupancy != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Text(
                    'Occupancy: ${project.occupancy}%',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.kPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: LinearProgressIndicator(
                        value: (project.occupancy ?? 0) / 100,
                        backgroundColor: AppColors.kSoftColor,
                        valueColor: AlwaysStoppedAnimation(
                          AppColors.kPrimaryColor,
                        ),
                        minHeight: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.kSoftColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        skill,
        style: AppTextStyles.caption.copyWith(
          color: AppColors.kPrimaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 0.5,
      color: AppColors.kDashboardBgColor,
    );
  }
}
