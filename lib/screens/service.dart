import 'dart:async';

import 'package:musette_app/screens/repo.dart';
import 'package:musette_app/screens/music.dart';

class MusicService
{
  late Repository _repository;
  MusicService(){
    _repository = Repository();
  }
  //Save User
  SaveMusic(Music music) async{
    return await _repository.insertData('musics', music.musicMap());
  }
  //Read All Users
  readAllMusics() async{
    return await _repository.readData('musics');
  }
  //Edit User
  UpdateMusic(Music music) async{
    return await _repository.updateData('musics', music.musicMap());
  }

  deleteMusic(musicId) async {
    return await _repository.deleteDataById('musics', musicId);
  }

}