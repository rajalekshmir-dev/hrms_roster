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
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  /// drag handle
                  const SizedBox(height: 10),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
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
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const Spacer(),

                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
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
                            color: Colors.blue.shade700,
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
                          title: Text(item),
                          value: selected,
                          activeColor: Colors.blue,
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
                    child: Row(
                      children: [
                        OutlinedButton(
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
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
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
