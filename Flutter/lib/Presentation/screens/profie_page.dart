import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/application/Providers/tokenProvider.dart';
import 'package:flutter_application_1/application/Providers/userDataProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../widgets/themes.dart';
import './edit_profile_page.dart';
import '../widgets/info_card.dart';
import '../widgets/drawer_item.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends ConsumerWidget {
  ProfilePage({Key? key}) : super(key: key);

  final isDarkModeProvider = StateProvider<bool>((ref) => false);
  final imageProvider = StateProvider<File?>((ref) => null);

  Future<void> _pickImage(BuildContext context, WidgetRef ref) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      ref.read(imageProvider.notifier).state = File(pickedFile.path);
    }
  }

  void clearToken(WidgetRef ref) {
    ref.read(tokenProvider.notifier).state = '';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listt = ref.watch(userDataProvider);
    final isDarkMode = ref.watch(isDarkModeProvider);
    // final returned_list = ref.read(userDataProvider.notifier).state;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? darkTheme : lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions: [
            IconButton(
              icon: isDarkMode
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.dark_mode),
              onPressed: () {
                ref.read(isDarkModeProvider.notifier).state =
                    !ref.read(isDarkModeProvider.notifier).state;
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: ref.read(imageProvider.notifier).state !=
                              null
                          ? FileImage(ref.read(imageProvider.notifier).state!)
                          : null,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt),
                        onPressed: () async {
                          await _pickImage(context, ref);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              InfoCard(label: 'First Name', value: listt[0]),
              const SizedBox(height: 5),
              InfoCard(label: 'Email', value: listt[1]),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).goNamed('editProfile');
                },
                child: const Text('Edit Profile'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                key: const Key("logout"),
                onPressed: () async {
                  try {
                    print('okay');
                    print(ref.read(userDataProvider.notifier).state);
                    const urll = 'http://10.5.223.79:5000/auth/';
                    const curr_url = "logout";
                    final response = await http.get(
                      Uri.parse('${urll}${curr_url}'),
                      headers: {
                        "token": ref.read(tokenProvider.notifier).state
                      },
                    );

                    if (response.statusCode >= 200 &&
                        response.statusCode < 300) {
                      final responseData = json.decode(response.body)["okay"];
                      clearToken(ref);
                      print(ref.read(tokenProvider.notifier).state);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('${responseData}'),
                        duration: const Duration(seconds: 1),
                      ));
                      GoRouter.of(context).go("/login");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Error'),
                        duration: const Duration(seconds: 1),
                      ));
                    }
                  } catch (error, sta) {
                    print('Error occurred: $sta');
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Errors'),
                      duration: const Duration(seconds: 1),
                    ));
                  }
                },
                child: const Text('Log Out'),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: const Text('Menu'),
              ),
              const SizedBox(height: 20),
              DrawerItem(
                  title: 'Home', onTap: () => print('Selected item: Home')),
              DrawerItem(
                  title: 'About', onTap: () => print('Selected item: About')),
              DrawerItem(
                  title: 'Booking History',
                  onTap: () => print('Selected item: Booking History')),
              DrawerItem(
                  title: 'Reservation',
                  onTap: () => print('Selected item: Reservation')),
              DrawerItem(
                  title: 'Sign Out',
                  onTap: () => print('Selected item: Sign Out')),
            ],
          ),
        ),
      ),
    );
  }
}
