import 'package:fire_chat/core/models/models.dart';
import 'package:meta/meta.dart';


class CreateRoomArgs {
  final List<UserModel> members;

  const CreateRoomArgs({
    @required this.members,
  });
}
