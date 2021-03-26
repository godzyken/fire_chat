import 'package:fire_chat/ui/components/avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const ProfileImageWidget({
    Key key,
    @required this.imageUrl,
    this.radius = 20,
  }) : super(key: key);

/*
  evictImage(String imageUrl) {
    final NetworkImage provider = NetworkImage(imageUrl);
    provider.evict().then<void>((bool success) {
      if (success) debugPrint('removed image!');
    });
  }
*/

  @override
  Widget build(BuildContext context) => CircleAvatar(
    radius: radius,
    backgroundImage: NetworkImage(imageUrl),
    foregroundImage: NetworkImage(imageUrl),
  );
}
