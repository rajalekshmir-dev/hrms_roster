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

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedValue != null;

    return Container(
      margin: const EdgeInsets.only(left: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 42,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.shade50 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey.shade300,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          hint: Text(widget.title, style: const TextStyle(fontSize: 14)),
          icon: const Icon(Icons.keyboard_arrow_down, size: 20),
          isDense: false,
          alignment: Alignment.centerLeft,
          items: widget.items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
            widget.onChanged(value);
          },
        ),
      ),
    );
  }
}
