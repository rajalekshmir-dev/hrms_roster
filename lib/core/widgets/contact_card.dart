import 'package:flutter/material.dart';
import 'package:hrms_roster/core/constant/text_style.dart';
import 'package:hrms_roster/features/Home/domain/entities/directory_contact.dart';
import '../constant/colors.dart';

class ContactCard extends StatelessWidget {
  final DirectoryContact contact;

  const ContactCard({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.kGreyColor),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.kSoftColor,
            child: Text(
              contact.name.isNotEmpty ? contact.name[0].toUpperCase() : '?',
              style: AppTextStyles.headline.copyWith(
                fontSize: 18,
                color: AppColors.kPrimaryColor,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(contact.name, style: AppTextStyles.title),
                const SizedBox(height: 4),
                Text(
                  contact.title,
                  style: AppTextStyles.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: AppColors.kLightTextColor,
                    ),
                    const SizedBox(width: 4),
                    Text(contact.location, style: AppTextStyles.caption),
                  ],
                ),
              ],
            ),
          ),

          // Menu Button
          // IconButton(
          //   icon: Icon(Icons.more_vert, color: AppColors.kLightTextColor),
          //   onPressed: () {},
          // ),
        ],
      ),
    );
  }
}
