import 'package:flutter/material.dart';
import 'package:flutter_application_1/application/Providers/typeProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TypeField extends ConsumerWidget {
  final void Function(bool, String) onTypeSelected;

  const TypeField({
    required this.onTypeSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String typeValue = ref.watch(typeProvider);
    return Wrap(
      children: <Widget>[
        ChoiceChip(
          label: const Padding(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 1),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Business',
                style: TextStyle(fontSize: 16), // Reduced font size
              ),
            ),
          ),
          selected: typeValue == 'Business',
          onSelected: (selected) {
            if (selected) onTypeSelected(true, 'Business');
          },
          selectedColor: const Color.fromRGBO(0, 224, 231, 1),
          backgroundColor: const Color.fromRGBO(0, 147, 148, 1),
        ),
        const SizedBox(width: 10),
        ChoiceChip(
          label: const Padding(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 1),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Non-Business',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          selected: typeValue == 'Non-Business',
          onSelected: (selected) {
            if (selected) onTypeSelected(true, 'Non-Business');
          },
          selectedColor: const Color.fromRGBO(0, 224, 231, 1),
          backgroundColor: const Color.fromRGBO(0, 147, 148, 1),
        ),
      ],
    );
  }
}
