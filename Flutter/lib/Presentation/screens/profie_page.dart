import 'package:flutter/material.dart';
import 'package:flutter_application_1/application/Providers/userDataProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../widgets/themes.dart';
import './edit_profile_page.dart';
import '../widgets/info_card.dart';
import '../widgets/drawer_item.dart';

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
              const SizedBox(height: 40),
              InfoCard(label: 'Email', value: listt[1]),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                },
                child: const Text('Edit Profile'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Implement sign out functionality
                },
                child: const Text('Sign Out'),
              ),
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
