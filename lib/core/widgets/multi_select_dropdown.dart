import 'package:flutter/material.dart';

class MultiSelectDropdown extends StatefulWidget {
  final String title;
  final List<String> items;
  final Function(List<String>) onChanged;

  const MultiSelectDropdown({
    super.key,
    required this.title,
    required this.items,
    required this.onChanged,
  });

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  List<String> selectedItems = [];

  void openSelection() {
    List<String> tempSelected = List.from(selectedItems);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.65,

              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
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

                  /// selected count
                  if (tempSelected.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${tempSelected.length} selected",
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 10),

                  /// list
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.items.length,
                      itemBuilder: (context, index) {
                        final item = widget.items[index];
                        final selected = tempSelected.contains(item);

                        return CheckboxListTile(
                          title: Text(
                            item,
                            style: TextStyle(
                              color: theme.colorScheme.onSurface,
                            ),
                          ),

                          value: selected,

                          activeColor: theme.colorScheme.primary,

                          checkColor: Colors.white,

                          onChanged: (value) {
                            setModalState(() {
                              if (value == true) {
                                tempSelected.add(item);
                              } else {
                                tempSelected.remove(item);
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),

                  /// buttons
                  SafeArea(
                    top: false,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                selectedItems.clear();
                              });

                              widget.onChanged(selectedItems);
                              Navigator.pop(context);
                            },
                            child: const Text("Clear"),
                          ),

                          const Spacer(),

                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedItems = tempSelected;
                              });

                              widget.onChanged(selectedItems);
                              Navigator.pop(context);
                            },
                            child: const Text("Apply"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final hasSelection = selectedItems.isNotEmpty;

    return GestureDetector(
      onTap: openSelection,

      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 36,

        decoration: BoxDecoration(
          color: hasSelection
              ? theme.colorScheme.primary.withOpacity(0.1)
              : theme.colorScheme.surface,

          borderRadius: BorderRadius.circular(20),

          border: Border.all(
            color: hasSelection
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface.withOpacity(0.2),
          ),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              hasSelection ? "${selectedItems.length} selected" : widget.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: theme.colorScheme.onSurface),
            ),

            const SizedBox(width: 4),

            Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: theme.colorScheme.onSurface,
            ),
          ],
        ),
      ),
    );
  }
}