import 'package:musette_app/screens/music.dart';
import 'package:musette_app/screens/service.dart';
import 'package:flutter/material.dart';

class AddMusic extends StatefulWidget {
  const AddMusic({Key? key}) : super(key: key);

  @override
  State<AddMusic> createState() => _AddMusicState();
}

class _AddMusicState extends State<AddMusic> {
  var _musicSongNameController = TextEditingController();
  var _musicArtistController = TextEditingController();
  var _musicLyricistController = TextEditingController();
  var _musicComposerController = TextEditingController();
  var _musicProducerController = TextEditingController();
  var _musicLabelController = TextEditingController();
  var _musicMonetizationController = TextEditingController();
  bool _validateSongName = false;
  bool _validateArtist = false;
  bool _validateLyricist = false;
  bool _validateComposer = false;
  bool _validateProducer = false;
  bool _validateLabel = false;
  bool _validateMonetization = false;
  var _musicService=MusicService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Song Information"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Song',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _musicSongNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Song Name',
                    labelText: 'Song Name',
                    errorText:
                    _validateSongName ? 'Song Name Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _musicArtistController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Artist Name or Pen Name',
                    labelText: 'Artist',
                    errorText: _validateArtist
                        ? 'Artist Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _musicLyricistController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Lyricist Name',
                    labelText: 'Lyricist',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _musicComposerController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Composer Name',
                    labelText: 'Composer',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _musicProducerController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Producer Name',
                    labelText: 'Producer',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _musicLabelController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Label Name',
                    labelText: 'Label',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _musicMonetizationController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Monetization Availability Status',
                    labelText: 'Availability ',
                    errorText:
                    _validateMonetization ? 'This Field Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.teal,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          _musicSongNameController.text.isEmpty
                              ? _validateSongName = true
                              : _validateSongName = false;
                          _musicArtistController.text.isEmpty
                              ? _validateArtist = true
                              : _validateArtist = false;
                          _musicMonetizationController.text.isEmpty
                              ? _validateMonetization = true
                              : _validateMonetization = false;

                        });
                        if (_validateSongName == false &&
                            _validateArtist == false &&
                            _validateMonetization == false) {
                          var _music = Music();
                          _music.songName = _musicSongNameController.text;
                          _music.artist = _musicArtistController.text;
                          _music.lyricist = _musicLyricistController.text;
                          _music.composer = _musicComposerController.text;
                          _music.producer = _musicProducerController.text;
                          _music.label = _musicLabelController.text;
                          _music.isMonetize = _musicMonetizationController.text;
                          var result=await _musicService.SaveMusic(_music);
                          Navigator.pop(context,result);
                        }
                      },
                      child: const Text('Save Details')),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        _musicSongNameController.text = '';
                        _musicArtistController.text = '';
                        _musicLyricistController.text = '';
                        _musicComposerController.text = '';
                        _musicProducerController.text = '';
                        _musicLabelController.text = '';
                        _musicMonetizationController.text = '';
                      },
                      child: const Text('Clear Details'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}