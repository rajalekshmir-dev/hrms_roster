import 'package:flutter/material.dart';

class CommonDropdown extends StatefulWidget {
  final String title;
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;

  const CommonDropdown({
    super.key,
    required this.title,
    required this.items,
    required this.onChanged,
    this.value,
  });

  @override
  State<CommonDropdown> createState() => _CommonDropdownState();
}

class _CommonDropdownState extends State<CommonDropdown> {
  String? selectedValue;

  @override
  void initState() {
    selectedValue = widget.value;
    super.initState();
  }

  void openDropdown() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        final theme = Theme.of(context);

        return Container(
          height: MediaQuery.of(context).size.height * .55,

          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
          ),

          child: Column(
            children: [
              const SizedBox(height: 10),

              /// drag handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 10),

              /// header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: theme.colorScheme.onSurface,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              Divider(color: theme.dividerColor),

              /// list
              Expanded(
                child: ListView.builder(
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    final item = widget.items[index];
                    final isSelected = item == selectedValue;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedValue = item;
                        });

                        widget.onChanged(item);
                        Navigator.pop(context);
                      },

                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        padding: const EdgeInsets.all(14),

                        decoration: BoxDecoration(
                          color: isSelected
                              ? theme.colorScheme.primary.withOpacity(0.12)
                              : theme.colorScheme.surface,

                          borderRadius: BorderRadius.circular(12),

                          border: Border.all(
                            color: isSelected
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurface.withOpacity(0.15),
                          ),
                        ),

                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ),

                            if (isSelected)
                              Icon(
                                Icons.check_circle,
                                color: theme.colorScheme.primary,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSelected = selectedValue != null;

    return GestureDetector(
      onTap: openDropdown,

      child: Container(
        margin: const EdgeInsets.only(left: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        height: 42,

        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withOpacity(0.12)
              : theme.colorScheme.surface,

          borderRadius: BorderRadius.circular(24),

          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface.withOpacity(0.2),
          ),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedValue ?? widget.title,
              style: TextStyle(
                fontSize: 14,
                color: theme.colorScheme.onSurface,
              ),
            ),

            const SizedBox(width: 6),

            Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: theme.colorScheme.onSurface,
            ),
          ],
        ),
      ),
    );
  }
}
