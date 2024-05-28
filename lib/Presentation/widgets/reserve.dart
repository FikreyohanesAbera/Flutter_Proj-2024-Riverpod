import 'package:flutter/material.dart';
import 'package:flutter_application_1/application/Providers/branchProvider.dart';
import 'package:flutter_application_1/application/Providers/reserveProvider.dart';
import 'package:flutter_application_1/application/Providers/typeProvider.dart';
import 'package:flutter_application_1/application/Providers/userDataProvider.dart';
import 'package:flutter_application_1/application/Providers/userProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'number_of_people.dart';
import 'date_field.dart';
import 'type_field.dart';
import 'time_field.dart';
import 'branch_field.dart';

final isConfirmingProvider = StateProvider<bool>((ref) {
  return false;
});

class ReservationForm extends ConsumerWidget {
  String foodName;
  TextEditingController numberOfPeopleController;
  TextEditingController dateController;
  TextEditingController timeController;
  bool isDateFocused;
  bool isTimeFocused;
  final void Function(bool, String) onTypeSelected;
  final void Function(bool, String) onBranchSelected;

  ReservationForm({
    required this.foodName,
    required this.numberOfPeopleController,
    required this.dateController,
    required this.timeController,
    required this.isDateFocused,
    required this.isTimeFocused,
    required this.onTypeSelected,
    required this.onBranchSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String datas = '';
    ref.watch(userProvider).when(data: (data) {
      datas = data;
    }, error: (err, stackTr) {
      print(err);
    }, loading: () {
      print("loading");
    });
    final String id = ref.watch(userDataProvider);
    final bool _isConfirming = ref.watch(isConfirmingProvider);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 15),
        child: Form(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            NumberOfPeopleField(
              numberOfPeopleController: numberOfPeopleController,
            ),
            const SizedBox(height: 25),
            DateField(
              dateController: dateController,
              isDateFocused: isDateFocused,
              isTimeFocused: isTimeFocused,
            ),
            const SizedBox(height: 25),
            TimeField(
              timeController: timeController,
              isDateFocused: isDateFocused,
              isTimeFocused: isTimeFocused,
            ),
            const SizedBox(height: 20),
            const Text(
              'Type',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            const SizedBox(height: 3),
            TypeField(
              onTypeSelected: onTypeSelected,
            ),
            const SizedBox(height: 10),
            const Text(
              'Branch',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            const SizedBox(height: 3),
            BranchField(
              onBranchSelected: onBranchSelected,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                ref.read(userDataProvider.notifier).state = datas;

                ref.read(isConfirmingProvider.notifier).state = false;
                await ref.read(reserveStateProvider.notifier).reserve(
                      ref,
                      numberOfPeopleController.text,
                      dateController.text,
                      timeController.text,
                      ref.read(typeProvider.notifier).state,
                      ref.read(branchProvider.notifier).state,
                      foodName,
                    );

                ref.read(isConfirmingProvider.notifier).state = false;
                final reservestate = ref.watch(reserveStateProvider);

                if (reservestate.containsKey("error")) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${reservestate['error']}'),
                    duration: const Duration(seconds: 5),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle, color: Colors.green),
                          SizedBox(width: 8),
                          Text(
                            'Successfully Booked',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.white,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amberAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: _isConfirming
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    )
                  : const Text(
                      'Confirm Booking',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
            ),
          ]),
        ),
      ),
    );
  }
}
