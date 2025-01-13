import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/Models/artist_model.dart';
import 'package:music_app/Models/song_model.dart';

class MusicProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<Song> playlist = [];
  int currentIndex = 0;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;
  bool isRepeat = false;
  Song? currentSong; // الأغنية الحالية
  bool isPlayingBool = false; // حالة التشغيل

  String? get currentSongImg =>
      playlist.isNotEmpty ? playlist[currentIndex].img : null;
  String? get currentSongId =>
      playlist.isNotEmpty ? playlist[currentIndex].id : null;
  String? get currentSongTitle =>
      playlist.isNotEmpty ? playlist[currentIndex].title : null;
  String? get currentSongArtistName =>
      playlist.isNotEmpty ? playlist[currentIndex].artist.name : null;
  Artist? get currentSongArtist =>
      playlist.isNotEmpty ? playlist[currentIndex].artist : null;
  String? get currentSongUrl =>
      playlist.isNotEmpty ? playlist[currentIndex].url : null;

  bool get isPlaying => _audioPlayer.playing;

  // تحميل قائمة الأغاني
  void setPlaylist(List<Song> songs) {
    playlist = songs;

    notifyListeners();
  }

  void stop() {
    print("Stopping music...");
    currentSong = null; // فقط إيقاف التشغيل دون مسح القائمة
    _audioPlayer.stop();

    notifyListeners();
  }

  // تحديث الأغنية والبلاي ليست إذا كانت مختلفة
  void setPlaylistAndSong(List<Song> newplaylist, int index) {
    // إذا كانت الأغنية هي نفسها الأغنية الحالية، لا تفعل شيئًا
    if (playlist == newplaylist && currentSong?.id == newplaylist[index].id) {
      resumeSong();
      return;
    } else if (currentSong?.id == newplaylist[index].id) {
      playlist = newplaylist;
      currentIndex = index;
      resumeSong();
      return;
    }

    // تحديث الأغنية والبلاي ليست
    playlist = newplaylist;
    currentIndex = index;
    currentSong = playlist[index];
    isPlayingBool = true;

    playSong();
    notifyListeners(); // تحديث الواجهة
  }

// playlist song index
  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  // تشغيل الأغنية الحالية
  Future<void> playSong() async {
    if (currentSongUrl != null) {
      print("currentSongId $currentSongId");

      await _audioPlayer.setUrl(playlist[currentIndex].url);
      _audioPlayer.play();
      _audioPlayer.durationStream.listen((duration) {
        totalDuration = duration ?? Duration.zero;
        notifyListeners();
      });
      _audioPlayer.positionStream.listen((position) {
        currentPosition = position;
        notifyListeners();
      });
      _audioPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          _onSongFinished(); // انتقل إلى الأغنية التالية
        }
      });
    }
  }

  // إيقاف الأغنية مؤقتًا
  void pauseSong() {
    _audioPlayer.pause();
    notifyListeners();
  }

  // استئناف الأغنية
  void resumeSong() {
    _audioPlayer.play();
    notifyListeners();
  }

  // تخطي للأغنية التالية
  Future<void> skipNext() async {
    if (currentIndex < playlist.length - 1) {
      currentIndex++;
      isRepeat = false;

      await playSong();
    }
  }

  // الرجوع للأغنية السابقة
  Future<void> skipPrevious() async {
    if (currentIndex > 0) {
      currentIndex--;
      isRepeat = false;
      await playSong();
    }
  }

  // التحكم في تقدم الأغنية
  Future<void> seekTo(Duration position) async {
    await _audioPlayer.seek(position);
    notifyListeners();
  }

  void _onSongFinished() async {
    if (isRepeat) {
      // إذا كانت خاصية التكرار مفعلة، عد إلى بداية الأغنية
      playSong();
    }
    // عند انتهاء الأغنية الحالية، انتقل إلى الأغنية التالية
    else if (currentIndex < playlist.length - 1) {
      currentIndex++;
      await playSong();
    }
    // else {
    //
    //   isPlaying = false;
    // }
  }

  void toggleRepeat() {
    isRepeat = !isRepeat;
    notifyListeners();
  }

  // تنظيف مشغل الصوت عند عدم الحاجة
  void disposePlayer() {
    _audioPlayer.dispose();
  }
}
