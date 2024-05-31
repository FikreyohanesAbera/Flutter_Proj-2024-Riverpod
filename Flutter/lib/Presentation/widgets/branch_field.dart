import 'package:flutter/material.dart';
import 'package:flutter_application_1/application/Providers/branchProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BranchField extends ConsumerWidget {
  final void Function(bool, String) onBranchSelected;

  const BranchField({
    required this.onBranchSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String branchValue = ref.watch(branchProvider);
    return Wrap(
      children: <Widget>[
        ChoiceChip(
          key: const Key("branchChip"),
          label: const Padding(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Arat kilo',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          selected: branchValue == 'Arat kilo',
          onSelected: (selected) {
            if (selected) onBranchSelected(true, 'Arat kilo');
          },
          selectedColor: const Color.fromRGBO(0, 224, 231, 1),
          backgroundColor: const Color.fromRGBO(0, 147, 148, 1),
        ),
        const SizedBox(width: 7),
        ChoiceChip(
          label: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Tor Hailoch',
              style: TextStyle(fontSize: 16),
            ),
          ),
          selected: branchValue == 'Tor Hailoch',
          onSelected: (selected) {
            if (selected) onBranchSelected(true, "Tor Hailoch");
          },
          selectedColor: const Color.fromRGBO(0, 224, 231, 1),
          backgroundColor: const Color.fromRGBO(0, 147, 148, 1),
        ),
        const SizedBox(width: 7),
        ChoiceChip(
          label: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Mexico',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          selected: branchValue == 'Mexico',
          onSelected: (selected) {
            if (selected) onBranchSelected(true, "Mexico");
          },
          selectedColor: const Color.fromRGBO(0, 224, 231, 1),
          backgroundColor: const Color.fromRGBO(0, 147, 148, 1),
        ),
      ],
    );
  }
}
