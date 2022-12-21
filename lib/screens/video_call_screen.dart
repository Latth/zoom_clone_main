import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoom_clone_main/resources/auth_methods.dart';
import 'package:zoom_clone_main/resources/jitsi_meet_methods.dart';
import 'package:zoom_clone_main/utils/colors.dart';
import 'package:zoom_clone_main/widgets/meeting_option.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthMethods _authMethods = AuthMethods();
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  bool isJoinScreenLoaded = false;

  late TextEditingController _tecMeetingIdController;
  late TextEditingController _tecName;

  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    super.initState();
    _tecMeetingIdController = TextEditingController();
    _tecName = TextEditingController(text: _authMethods.user.displayName!);

    setState(() {
      isJoinScreenLoaded = true;
    });
  }

  isAudioMutedFunc(bool val) {
    setState(() {
      isAudioMuted = val;
    });
  }

  isVideoMutedFunc(bool val) {
    setState(() {
      isVideoMuted = val;
    });
  }

  _joinMeeting() {
    if (_tecMeetingIdController.text == "") {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Invalid Room ID",
        title: "Unsuccesful!",
      );
    }
    _jitsiMeetMethods.createMeeting(
      roomName: _tecMeetingIdController.text,
      username: _tecName.text,
      isAudioMuted: isAudioMuted,
      isVideoMuted: isVideoMuted,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tecMeetingIdController.dispose();
    _tecName.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Join a meeting",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: isJoinScreenLoaded == false
          ? Container()
          : Column(
              children: [
                joinTextField(
                  hintText: "Room ID",
                  tecCont: _tecMeetingIdController,
                ),
                joinTextField(
                  hintText: "Name",
                  tecCont: _tecName,
                ),
                const SizedBox(height: 20),
                joinButton(),
                const SizedBox(height: 20),
                MeetingOption(
                  text: "Mute Audio",
                  isMute: isAudioMuted,
                  onChange: isAudioMutedFunc,
                ),
                MeetingOption(
                  text: "Mute Video",
                  isMute: isVideoMuted,
                  onChange: isVideoMutedFunc,
                ),
              ],
            ),
    );
  }

  SizedBox joinTextField({
    required String hintText,
    required TextEditingController tecCont,
  }) {
    return SizedBox(
      height: 60,
      child: TextField(
        controller: tecCont,
        maxLines: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          fillColor: backgroundColor,
          filled: true,
          border: InputBorder.none,
          hintText: hintText.toString(),
        ),
      ),
    );
  }

  SizedBox joinButton() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: ElevatedButton(
          onPressed: _joinMeeting,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
          ),
          child: const Text(
            "Join",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
