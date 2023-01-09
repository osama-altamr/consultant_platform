import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            child: Column(
          children: [
            SizedBox(
              height: 120,
            ),
            Center(
              child: AvatarGlow(
                glowColor: Colors.red,
                endRadius: 100.0,
                duration: Duration(milliseconds: 2000),
                repeat: true,
                showTwoGlows: true,
                repeatPauseDuration: Duration(milliseconds: 100),
                child: Material(
                  // Replace this child with your own
                  elevation: 15.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    backgroundImage: NetworkImage(
                      'https://cdn.pixabay.com/photo/2020/05/14/02/31/covid-19-5169689__340.jpg',
                    ),
                    radius: 70,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Doctor 3lla ',
              style: TextStyle(
                fontSize: 25,
                color: Colors.redAccent,
                fontFamily: 'Arvo',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
             Text(
              '+1 102 221 23123',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Arvo',
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: 120,
            ),
            Text(
              'Connecting...',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Arvo',
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height:40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 1.4,
                  child: CircleAvatar(
                      child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.video_call),
                  )),
                ),
                SizedBox(width: 60,),
                Transform.scale(
                  scale: 1.4,
                  child: CircleAvatar(
                      child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.call),
                  )),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
