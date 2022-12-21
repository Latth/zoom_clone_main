import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zoom_clone_main/resources/jitsi_meet_methods.dart';
import 'package:zoom_clone_main/widgets/home_meeting_button.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({super.key});

  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  createNewMeeting() async {
    var random = Random();

    _jitsiMeetMethods.createMeeting(
      roomName: random.nextInt((10000000) + 10000000).toString(),
      isAudioMuted: true,
      isVideoMuted: true,
    );
  }

  joinMeeting(context) {
    Navigator.pushNamed(context, '/video-call');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetingButton(
              onPressed: createNewMeeting,
              text: "New Meeting",
              icon: Icons.videocam,
            ),
            HomeMeetingButton(
              onPressed: () => joinMeeting(context),
              text: "Join Meeting",
              icon: Icons.add_box_rounded,
            ),
            HomeMeetingButton(
              onPressed: () {},
              text: "Schedule",
              icon: Icons.calendar_today,
            ),
            HomeMeetingButton(
              onPressed: () {},
              text: "Share Screen",
              icon: Icons.arrow_upward_rounded,
            ),
          ],
        ),
        const Expanded(
          child: Center(
            child: Text(
              "Create/Join meetings with just a click!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        )
      ],
    );
  }
}
