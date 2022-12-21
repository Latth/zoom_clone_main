import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoom_clone_main/resources/auth_methods.dart';
import 'package:zoom_clone_main/resources/firestore_methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String? username,
  }) async {
    try {
      var options = JitsiMeetingOptions(
        room: roomName,
      )
        ..userDisplayName = username ?? _authMethods.user.displayName
        ..userEmail = _authMethods.user.email
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;
      _firestoreMethods.addToMeetingHistory(roomName);
      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      // ignore: avoid_print
      print(error);
    }
  }
}
