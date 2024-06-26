import 'package:flutter/material.dart';
import 'package:flutter_application_1/Presentation/screens/main_reserve.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../others/bookingDetail.dart';
import '../../domain/bookingsClass.dart';
import '../widgets/My_bookingsState.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

final remainingTimeProvider = Provider<String>((ref) {
  final targetDateTime = ref.watch(targetDateTimeProvider);
  final remainingDuration = targetDateTime.difference(DateTime.now());

  // Format remaining time
  final hours = remainingDuration.inHours;
  final minutes = remainingDuration.inMinutes.remainder(60);
  final seconds = remainingDuration.inSeconds.remainder(60);

  return '$hours hours, $minutes minutes, $seconds seconds';
});

final targetDateTimeProvider = Provider<DateTime>((ref) {
  final format = DateFormat('E MMM dd yyyy hh:mma');
  return format.parse('Mon May 27 2024 09:09AM');
});

class ExpandedBooking extends StatefulWidget {
  final dynamic arguments;
  const ExpandedBooking({Key? key, required this.arguments}) : super(key: key);
  @override
  _ExpandedBookingState createState() => _ExpandedBookingState();
}

class _ExpandedBookingState extends State<ExpandedBooking> {
  late DateTime _remainingTime = DateTime.now();
  int numOfPeople = 0;
  String type = '';
  String branch = '';
  String food = '';

  @override
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _remainingTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTime);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime(Timer timer) {
    setState(() {
      _remainingTime = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dynamic arguments = widget.arguments;

    ReservedTable yourData;

    if (arguments != null && arguments is ReservedTable) {
      yourData = arguments;
      yourData.guests;
      yourData.date;
      yourData.time;
      yourData.type;
      yourData.food;
      yourData.date;
    } else {
      throw ErrorSummary("message");
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Details"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).replace("/home?index=2");
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              alignment: Alignment.centerLeft,
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      height: 170,
                      child: Image.asset("assets/woman.png"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.timer,
                          color: Color.fromRGBO(33, 34, 33, 1),
                          size: 28.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            '${_remainingTime.hour}:${_remainingTime.minute}:${_remainingTime.second}',
                            style: const TextStyle(
                              fontSize: 25,
                              color: Color.fromRGBO(33, 34, 33, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Time Remaining",
                      style: TextStyle(
                        color: Color.fromRGBO(24, 24, 23, 0.957),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0),
                  ),
                  child: Container(
                    color: const Color(0xff101520),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              yourData.food!,
                              style: GoogleFonts.amita(
                                fontSize: 45,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(153, 56, 231, 202),
                              ),
                            ),
                            Container(
                              height: 140,
                              child: Image.asset('${yourData.imageUrl}'),
                            ),
                          ],
                        ),
                        const SizedBox(width: 40),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff182032),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xffd1ede1),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(-1, 0),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Type",
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              140,
                                              211,
                                              182,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          '${yourData.type}',
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                153, 56, 231, 202),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.people,
                                      size: 35,
                                      color: Color.fromARGB(153, 56, 231, 202),
                                    ),
                                    const SizedBox(width: 7),
                                    Text(
                                      '${yourData.guests}',
                                      style: const TextStyle(
                                        fontSize: 30,
                                        color: const Color(0xffd1ede1),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Branch",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                            255,
                                            140,
                                            211,
                                            182,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        '${yourData.branch}',
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(153, 56, 231, 202),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.timelapse_outlined,
                              color: Color.fromARGB(255, 26, 32, 31),
                              size: 24,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 134, 180, 163),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  '${yourData.date} ${yourData.time}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(33, 34, 33, 1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 35),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amberAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                context.goNamed('mainReserve', extra: {
                                  "data": yourData.food!,
                                  "create": "false",
                                  "tableNumber": yourData.tablesNum.toString(),
                                  "checkTime": yourData.time!
                                });
                              },
                              child: const Text(
                                'Modify Booking',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
