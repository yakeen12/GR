import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/Models/episode_model.dart';
import 'package:music_app/Models/podcast_model.dart';

class PodcastProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;

  Episode? currentEpisode; // الأغنية الحالية
  bool isPlayingBool = false; // حالة التشغيل

  String? get currentEpisodeImg => currentEpisode!.podcast.img;
  String? get currentEpisodeId => currentEpisode!.id;
  String? get currentSongTitle => currentEpisode!.title;
  String? get currentEpisodeHostName => currentEpisode!.podcast.host;
  Podcast? get currentEpisodePodcast => currentEpisode!.podcast;
  String? get currentEpisodeUrl => currentEpisode!.audioUrl;

  bool get isPlaying => _audioPlayer.playing;

  void stop() {
    print("Stopping Podcast...");
    currentEpisode = null; // فقط إيقاف التشغيل دون مسح القائمة
    _audioPlayer.stop();
    notifyListeners();
  }

  // تحديث الأغنية والبلاي ليست إذا كانت مختلفة
  void setEpisode(Episode newEpisode) {
    // إذا كانت الأغنية هي نفسها الأغنية الحالية، لا تفعل شيئًا
    if (currentEpisode?.id == newEpisode.id) {
      resumeEpisode();
      return;
    }
    currentEpisode = newEpisode;
    isPlayingBool = true;

    startEpisode();
    notifyListeners(); // تحديث الواجهة
  }

  // تشغيل الأغنية الحالية
  Future<void> startEpisode() async {
    if (currentEpisode != null) {
      print("currentEpisodeId $currentEpisodeId");

      await _audioPlayer.setUrl(currentEpisode!.audioUrl);
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
        if (state.processingState == ProcessingState.completed) {}
      });
    }
  }

  // إيقاف الأغنية مؤقتًا
  void pauseEpisode() {
    _audioPlayer.pause();
    notifyListeners();
  }

  // استئناف الأغنية
  void resumeEpisode() {
    _audioPlayer.play();
    notifyListeners();
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
