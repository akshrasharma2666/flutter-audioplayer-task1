import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LocalAudio(),
  ));
}

class LocalAudio extends StatefulWidget {
  _LocalAudioState createState() => _LocalAudioState();
}

class _LocalAudioState extends State<LocalAudio> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });

    advancedPlayer.positionHandler = (p) => setState(() {
          _position = p;
        });
  }

  String localFilePath;

  Widget _tab(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
              children: children
                  .map((w) => Container(child: w, padding: EdgeInsets.all(6.0)))
                  .toList()),
        ),
      ],
    );
  }

  Widget _btn(String txt, VoidCallback onPressed) {
    return ButtonTheme(
      minWidth: 48.0,
      child: Container(
        width: 150,
        height: 45,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Text(txt),
          color: Colors.blue[900],
          textColor: Colors.white,
          onPressed: onPressed,
        ),
      ),
    );
  }

  Widget slider() {
    return Slider(
      activeColor: Colors.blue.shade900,
      inactiveColor: Colors.blue,
      value: _position.inSeconds.toDouble(),
      min: 0.0,
      max: _duration.inSeconds.toDouble(),
      onChanged: (double value) {
        setState(() {
          SeektoSecond(value.toInt());
          value = value;
        });
      },
    );
  }

  Widget localAudio() {
    return _tab(
      [
        _btn("play",
            () => audioCache.play("audios/Soorma Anthem_320(MyMp3Song).mp3")),
        _btn("pause", () => advancedPlayer.pause()),
        _btn("stop", () => advancedPlayer.stop()),
        slider(),
      ],
    );
  }

  void SeektoSecond(int second) {
    Duration newDuration = new Duration(seconds: second);
    advancedPlayer.seek(newDuration);
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: Colors.blue.shade100,
        appBar: AppBar(
          elevation: 1.0,
          backgroundColor: Colors.blue,
          title: Text("Local Audio"),
        ),
        body: TabBarView(children: <Widget>[
          localAudio(),
        ]),
      ),
    );
  }
}
