import 'package:musette_app/screens/music.dart';
import 'package:musette_app/screens/login.dart';
import 'package:musette_app/screens/editMusic.dart';
import 'package:musette_app/screens/addMusic.dart';
import 'package:musette_app/screens/viewuser.dart';
import 'package:musette_app/screens/service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Music> _musicList = <Music>[];
  final _musicService = MusicService();
  final FirebaseAuth auth = FirebaseAuth.instance;


  Future signOut(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Login()),
            (route) => false);
  }

  getAllUserDetails() async {
    var users = await _musicService.readAllMusics();
    _musicList = <Music>[];
    users.forEach((user) {
      setState(() {
        var musicModel = Music();
        musicModel.id = user['id'];
        musicModel.songName = user['songName'];
        musicModel.artist = user['artist'];
        musicModel.lyricist = user['lyricist'];
        musicModel.composer = user['composer'];
        musicModel.producer = user['producer'];
        musicModel.label = user['label'];
        musicModel.isMonetize = user['isMonetize'];
        _musicList.add(musicModel);
      });
    });
  }

  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, userId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Delete this song?',
              style: TextStyle(color: Colors.teal, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.red),
                  onPressed: ()  async{
                    var result=await _musicService.deleteMusic(userId);
                    if (result != null) {
                      Navigator.pop(context);
                      getAllUserDetails();
                      _showSuccessSnackBar(
                          'Music Data Deletion Success');
                    }
                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.teal),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Music Library"),
        leading: BackButton(
          onPressed: () {
            signOut(context);
          },
        )
      ),

      body: ListView.builder(
          itemCount: _musicList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewMusic(
                            music: _musicList[index],
                          )));
                },
                leading: const Icon(Icons.person),
                title: Text(_musicList[index].songName ?? ''),
                subtitle: Text(_musicList[index].artist ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditMusic(
                                    music: _musicList[index],
                                  ))).then((data) {
                            if (data != null) {
                              getAllUserDetails();
                              _showSuccessSnackBar(
                                  'Music Data Updated Successfully');
                            }
                          });
                          ;
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.teal,
                        )),
                    IconButton(
                        onPressed: () {
                          _deleteFormDialog(context, _musicList[index].id);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            );
          }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddMusic()))
              .then((data) {
            if (data != null) {
              getAllUserDetails();
              _showSuccessSnackBar('Music Data added successfully');
            }
          });
        },
        child: const Icon(Icons.add),
      ),

    );
  }
}