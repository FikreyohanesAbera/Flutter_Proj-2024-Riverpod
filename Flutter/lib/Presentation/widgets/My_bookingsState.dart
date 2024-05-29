import 'package:flutter/material.dart';
import 'package:flutter_application_1/application/Providers/cancelProvider.dart';
import 'package:flutter_application_1/application/Providers/choiceProvider.dart';
import 'package:flutter_application_1/application/Providers/isChanged.dart';
import 'package:flutter_application_1/application/Providers/myres.dart';
import 'package:flutter_application_1/application/Providers/reserveProvider.dart';
import 'package:flutter_application_1/application/Providers/stateRes.dart';
import 'package:flutter_application_1/application/Providers/userDataProvider.dart';
import 'package:flutter_application_1/application/Providers/userProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/bookingsClass.dart';
import '../screens/ExpandedBooking.dart';
import '../screens/bookings.dart';

class MyBookings extends StatelessWidget {
  const MyBookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        print("rebuilttttttttttttttttttttttttttttttttt");
        ref.watch(isChangedProvider);

        double screenWidth = (MediaQuery.of(context).size.width);
        List<ReservedTable> tables = ref.watch(currentTablesProvider);
        String selectedChoice = ref.watch(selectedChoiceProvider);

        return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                "My Bookings",
              ),
            ),
          ),
          backgroundColor: const Color(0xff101520),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              children: [
                Wrap(
                  spacing: 15,
                  children: <Widget>[
                    ChoiceChip(
                      label: const Text(
                        'Current',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      selected: selectedChoice == 'current',
                      onSelected: (selected) {
                        if (selected) {
                          ref.read(selectedChoiceProvider.notifier).state =
                              'current';
                        }
                      },
                      selectedColor: Colors.blue,
                      backgroundColor: const Color(0xff101520),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.blue,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    ChoiceChip(
                      label: const Text(
                        'Past',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      selected: selectedChoice == 'past',
                      onSelected: (selected) {
                        if (selected) {
                          ref.read(selectedChoiceProvider.notifier).state =
                              'past';
                        }
                      },
                      selectedColor: Colors.blue,
                      backgroundColor: const Color(0xff101520),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.blue,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    ChoiceChip(
                      label: const Text(
                        'Canceled',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      selected: selectedChoice == 'canceled',
                      onSelected: (selected) {
                        if (selected) {
                          ref.read(selectedChoiceProvider.notifier).state =
                              'canceled';
                        }
                      },
                      selectedColor: Colors.blue,
                      backgroundColor: const Color(0xff101520),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.blue,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ref.watch(userProvider).when(data: (data) {
                  return ref.watch(userResProvider(data)).when(data: (data) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 10);
                          },
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                color: const Color(0xff182032),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 130,
                                        child: Row(children: [
                                          SizedBox(
                                            width: 170,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              child: Image.asset(
                                                "${data[index].imageUrl}",
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Column(
                                            children: [
                                              const SizedBox(height: 20),
                                              Text(
                                                "${data[index].food}",
                                                style: const TextStyle(
                                                    color: Colors.amberAccent,
                                                    fontSize: 24),
                                              ),
                                              const SizedBox(height: 20),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 5.0),
                                                  Text(
                                                    'Type: ${data[index].type}',
                                                    style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            202,
                                                            193,
                                                            193)),
                                                  ),
                                                  const SizedBox(height: 5.0),
                                                  Text(
                                                    'Number of Guests: ${data[index].guests}',
                                                    style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            202,
                                                            193,
                                                            193)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ]),
                                      ),
                                      const Divider(
                                        thickness: 1.4,
                                        color: Colors.lightGreen,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                color: Color.fromARGB(
                                                    153, 56, 231, 202),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, '/detail',
                                                  arguments: data[index]);
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "View Reservation",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        153, 56, 231, 202)),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          if (ref
                                                  .read(selectedChoiceProvider
                                                      .notifier)
                                                  .state ==
                                              'current')
                                            OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                side: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255,
                                                      221,
                                                      77,
                                                      89), // Change color here
                                                ),
                                              ),
                                              onPressed: () {
                                                ref
                                                    .read(CancelStateProvider
                                                        .notifier)
                                                    .cancel(
                                                        ref,
                                                        data[index].time!,
                                                        data[index].tablesNum);
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Cancel Reservation",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 221, 77, 89)),
                                                ),
                                              ),
                                            ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }, error: (error, stackTrace) {
                    print('Error: $error');
                    print('Stack trace:\n$stackTrace');

                    return Center(child: Text(error.toString()));
                  }, loading: () {
                    print("loadddidng");
                    return const Center(child: CircularProgressIndicator());
                  });
                }, error: ((error, stackTrace) {
                  return Center(child: Text("error"));
                }), loading: () {
                  print("loading");
                  return const Center(child: CircularProgressIndicator());
                })
              ],
            ),
          ),
        );
      },
    );
  }
}
