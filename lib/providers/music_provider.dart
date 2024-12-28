import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/Models/song_model.dart';

class MusicProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer(); // مشغل الصوت
  List<Song> playlist =
      []; // قائمة الأغاني (تحتوي على عنوان الأغنية والرابط والفنان)
  int currentIndex = 0; // مؤشر الأغنية الحالية
  Duration currentPosition = Duration.zero; // التقدم الحالي في الأغنية
  Duration totalDuration = Duration.zero; // مدة الأغنية الكلية

  String? get currentSongImg =>
      playlist.isNotEmpty ? playlist[currentIndex].img : null;
  String? get currentSongTitle =>
      playlist.isNotEmpty ? playlist[currentIndex].title: null;
  String? get currentSongArtist =>
      playlist.isNotEmpty ? playlist[currentIndex].artist.name : null;
      String? get currentSongUrl =>
      playlist.isNotEmpty ? playlist[currentIndex].url : null;

  bool get isPlaying => _audioPlayer.playing;

  // تحميل قائمة الأغاني
  void setPlaylist(List<Song> songs) {
    playlist = songs;
    notifyListeners();
  }

  // تشغيل الأغنية الحالية
  Future<void> playSong() async {
    if (currentSongUrl != null) {
      await _audioPlayer.setUrl(currentSongUrl!);
      _audioPlayer.play();
      _audioPlayer.durationStream.listen((duration) {
        totalDuration = duration ?? Duration.zero;
        notifyListeners();
      });
      _audioPlayer.positionStream.listen((position) {
        currentPosition = position;
        notifyListeners();
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
      await playSong();
    }
  }

  // الرجوع للأغنية السابقة
  Future<void> skipPrevious() async {
    if (currentIndex > 0) {
      currentIndex--;
      await playSong();
    }
  }

  // التحكم في تقدم الأغنية
  Future<void> seekTo(Duration position) async {
    await _audioPlayer.seek(position);
    notifyListeners();
  }

  // تنظيف مشغل الصوت عند عدم الحاجة
  void disposePlayer() {
    _audioPlayer.dispose();
  }
}
