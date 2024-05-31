import 'package:flutter/material.dart';
import 'package:flutter_application_1/application/Providers/branchProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/Providers/typeProvider.dart';
import './reserve.dart';

class ReservationFormPage extends ConsumerStatefulWidget {
  final String data;
  final bool create;
  final String tableNumber;
  final String checkTime;

  ReservationFormPage(
      {Key? key,
      required this.checkTime,
      required this.data,
      required this.create,
      required this.tableNumber})
      : super(key: key);

  @override
  _ReservationFormPageState createState() => _ReservationFormPageState();
}

class _ReservationFormPageState extends ConsumerState<ReservationFormPage> {
  late TextEditingController _numberOfPeopleController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;

  @override
  void initState() {
    super.initState();
    _numberOfPeopleController = TextEditingController();
    _dateController = TextEditingController();
    _timeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final bool _isDateFocused = false;
    final bool _isTimeFocused = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation Form'),
        leading: IconButton(
          key: const Key("backToHomeFromReserve"),
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).replace("/home?index=1");
          },
        ),
      ),
      backgroundColor: const Color.fromRGBO(8, 68, 104, 1),
      body: ReservationForm(
        checkTime: widget.checkTime,
        tableNumber: widget.tableNumber,
        create: widget.create,
        foodName: widget.data,
        numberOfPeopleController: _numberOfPeopleController,
        dateController: _dateController,
        timeController: _timeController,
        isDateFocused: _isDateFocused,
        isTimeFocused: _isTimeFocused,
        onTypeSelected: (selected, selectedType) {
          if (selected) {
            ref.read(typeProvider.notifier).state = selectedType;
          } else {
            ref.read(typeProvider.notifier).state = '';
          }
        },
        onBranchSelected: (selected, selectedBranch) {
          if (selected) {
            ref.read(branchProvider.notifier).state = selectedBranch;
          } else {
            ref.read(branchProvider.notifier).state = '';
          }
        },
      ),
    );
  }
}
