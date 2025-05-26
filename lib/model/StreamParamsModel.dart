import 'dart:core';
import 'dart:ui';

import 'package:apivideo_live_stream/apivideo_live_stream.dart';

class StreamParamsModel {
  /// The video configuration

  /// The video bitrate in bps
  int videoBitrate = 1000000;

  /// The live streaming video resolution
  Resolution videoResolution = Resolution.RESOLUTION_720;

  /// The video frame rate in fps
  int videoFps = 30;

  /// The video configuration
  VideoConfig get videoConfig => VideoConfig(
    bitrate: videoBitrate,
    resolution: videoResolution,
    fps: videoFps,
  );

  /// The audio configuration

  /// The audio bitrate in bps
  int audioBitrate = 128000;

  /// The number of audio channels
  Channel audioChannel = Channel.stereo;

  /// The sample rate of the audio capture
  SampleRate audioSampleRate = SampleRate.kHz_22;

  /// Enable the echo cancellation
  bool audioEnableEchoCanceler = true;

  /// Enable the noise suppressor
  bool audioEnableNoiseSuppressor = true;

  /// The audio configuration
  AudioConfig get audioConfig => AudioConfig(
    bitrate: audioBitrate,
    channel: audioChannel,
    sampleRate: audioSampleRate,
    enableEchoCanceler: audioEnableEchoCanceler,
    enableNoiseSuppressor: audioEnableNoiseSuppressor,
  );

  /// The network configuration

  /// The server URL
  String rtmpUrl = "rtmp://192.168.0.29/live/";

  /// The stream key
  String streamKey = "test";
}
