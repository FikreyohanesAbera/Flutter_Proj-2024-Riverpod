import 'package:flutter/material.dart';
import 'package:flutter_application_1/application/Providers/changeusernameProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:user_profile/lib/pages/edit_profile_page.dart';

class EditProfilePage extends ConsumerWidget {
  EditProfilePage({super.key});
  final changeUsername = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          key: const Key("backToProfile"),
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).replace("/home?index=3");
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              key: const Key("changeName"),
              controller: changeUsername,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              key: const Key("namechangeButton"),
              onPressed: () async {
                final username = changeUsername.text;
                await ref
                    .read(ChangeUsernameProvider.notifier)
                    .changeUsername(ref, username);
                final res = ref.watch(ChangeUsernameProvider);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('$res'),
                  duration: const Duration(seconds: 1),
                ));
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
