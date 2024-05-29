import 'package:flutter/material.dart';
import 'package:flutter_application_1/application/Providers/tableProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/toggle_button.dart';
import '../widgets/date_picker.dart';

class AdminPage extends ConsumerWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  final TextEditingController num_of_people1 = TextEditingController();
  final TextEditingController tableNum1 = TextEditingController();
  final TextEditingController tableNum2 = TextEditingController();

  final TextEditingController floorNum1 = TextEditingController();

  final TextEditingController type1 = TextEditingController();

  final TextEditingController num_of_people3 = TextEditingController();
  final TextEditingController tableNum3 = TextEditingController();
  final TextEditingController tableNum4 = TextEditingController();

  final TextEditingController floorNum3 = TextEditingController();

  final TextEditingController type3 = TextEditingController();

  AdminPage({super.key, required this.isDarkMode, required this.toggleTheme});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
            child: Text(
          'Admin Page',
          style: TextStyle(color: Colors.white),
        )),
        actions: [
          ToggleButton(isDarkMode: isDarkMode, toggleTheme: toggleTheme),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Center(
                child: DatePickerWidget(
                  onDateSelected: (DateTime? pickedDate) {
                    if (pickedDate != null) {
                      // Do something with the selected date
                      print('Selected date: $pickedDate');
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Table',
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                    TextFormField(
                      controller: tableNum1,
                      decoration:
                          const InputDecoration(labelText: 'Table Number'),
                    ),
                    TextFormField(
                      controller: num_of_people1,
                      decoration:
                          const InputDecoration(labelText: 'Number of Seats'),
                    ),
                    TextFormField(
                      controller: floorNum1,
                      decoration:
                          const InputDecoration(labelText: 'Floor Number'),
                    ),
                    TextFormField(
                      controller: type1,
                      decoration: const InputDecoration(labelText: 'Type'),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          final String seats = num_of_people1.text;
                          final String floor = floorNum1.text;

                          final String typem = type1.text;

                          final String tableNumber = tableNum1.text;

                          final dynamic goal = ref.watch(tableStateProvider);
                          await ref.read(tableStateProvider.notifier).table(
                              ref, seats, typem, floor, tableNumber, "create");
                          if (goal.containsKey("error")) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('${goal['error']}'),
                              duration: const Duration(seconds: 5),
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Successfully Added'),
                              duration: const Duration(seconds: 5),
                            ));
                          }
                        },
                        child: const Text('Add'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blueGrey[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get Single Table',
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                    TextFormField(
                      controller: tableNum2,
                      decoration:
                          const InputDecoration(labelText: 'Table Number'),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          final String tableNumber = tableNum2.text;

                          final dynamic goal = ref.watch(tableStateProvider);
                          await ref
                              .read(tableStateProvider.notifier)
                              .table(ref, "", "", "", tableNumber, "read");
                          if (goal.containsKey("error")) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('${goal['error']}'),
                              duration: const Duration(seconds: 5),
                            ));
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Table ${goal['tableNumber']}'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('Number of Seats: ${goal['seats']}'),
                                      Text('Floor Number ${goal['floor']}'),
                                      Text('Type of ${goal['Type']}'),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: const Text('Get Table'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blueGrey[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Update Tables',
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                    TextFormField(
                      controller: tableNum3,
                      decoration:
                          const InputDecoration(labelText: 'Table Number'),
                    ),
                    TextFormField(
                      controller: num_of_people3,
                      decoration:
                          const InputDecoration(labelText: 'Number of Seats'),
                    ),
                    TextFormField(
                      controller: floorNum3,
                      decoration:
                          const InputDecoration(labelText: 'Floor Number'),
                    ),
                    TextFormField(
                      controller: type3,
                      decoration: const InputDecoration(labelText: 'Type'),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          final String seats = num_of_people3.text;
                          final String floor = floorNum3.text;

                          final String typem = type3.text;

                          final String tableNumber = tableNum3.text;

                          final dynamic goal = ref.watch(tableStateProvider);
                          await ref.read(tableStateProvider.notifier).table(
                              ref, seats, typem, floor, tableNumber, "update");
                          if (goal.containsKey("error")) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('${goal['error']}'),
                              duration: const Duration(seconds: 5),
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Successfully Updated'),
                              duration: const Duration(seconds: 5),
                            ));
                          }
                        },
                        child: const Text('Update Table'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blueGrey[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delete Table',
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                    TextFormField(
                      controller: tableNum4,
                      decoration: const InputDecoration(
                          labelText: 'Table Number to Delete'),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          final String tableNumber = tableNum4.text;

                          final dynamic goal = ref.watch(tableStateProvider);
                          await ref
                              .read(tableStateProvider.notifier)
                              .table(ref, "", "", "", tableNumber, "delete");
                          if (goal.containsKey("error")) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('${goal['error']}'),
                              duration: const Duration(seconds: 5),
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Sucessfully Deleted'),
                              duration: const Duration(seconds: 5),
                            ));
                          }
                          // Implement delete table functionality
                        },
                        child: const Text('Delete Table'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blueGrey[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
