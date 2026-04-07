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
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Select Tech Group",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  ...widget.items.map((item) {
                    final selected = tempSelected.contains(item);

                    return CheckboxListTile(
                      title: Text(item),
                      value: selected,
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
                  }),

                  const SizedBox(height: 10),

                  Row(
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
    return GestureDetector(
      onTap: openSelection,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 36,
        decoration: BoxDecoration(
          color: selectedItems.isEmpty
              ? Colors.grey.shade100
              : Colors.blue.shade50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selectedItems.isEmpty ? Colors.grey.shade300 : Colors.blue,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedItems.isEmpty
                  ? widget.title
                  : "${selectedItems.length} selected",
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(width: 4),

            const Icon(Icons.keyboard_arrow_down, size: 18),
          ],
        ),
      ),
    );
  }
}
