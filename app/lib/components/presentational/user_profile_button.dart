import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/utils/hooks/misc.dart';

class UserProfileButton extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final user = useCurrentUser();

    if (user == null) {
      return Container(width: 0, height: 0);
    }

    return IconButton(
      icon: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          user.providerData.first.photoUrl,
        ),
      ),
      onPressed: () async {},
    );
  }
}
