import 'package:flutter/material.dart';

class PropertyDescription extends StatelessWidget {
  final String description;
  final bool isExpanded;
  final VoidCallback onToggleDescription;

  const PropertyDescription({
    super.key,
    required this.description,
    required this.isExpanded,
    required this.onToggleDescription,
  });

  @override
  Widget build(BuildContext context) {
    final descriptionToShow = isExpanded
        ? description
        : (description.length > 100
            ? '${description.substring(0, 100)}...'
            : description);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          descriptionToShow,
          style: const TextStyle(fontSize: 16),
        ),
        TextButton(
          onPressed: onToggleDescription,
          child: Text(
            isExpanded ? 'Read Less' : 'Read More',
            style: const TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
