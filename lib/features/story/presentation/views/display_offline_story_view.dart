import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/core/theming/app_colors.dart';
import 'package:instagram_app/core/utils/assets.dart';
import 'package:instagram_app/features/story/presentation/views/widgets/story_viewer_item.dart';
import 'package:video_player/video_player.dart';
import '../../data/models/story_model.dart';
import '../manager/story_cubit/story_cubit.dart';

class DisplayOfflineStoriesStoryView extends StatefulWidget {
  const DisplayOfflineStoriesStoryView(
      {super.key, required this.stories, required this.isMyStory});

  final List<StoryModel> stories;
  final bool isMyStory;

  @override
  State<DisplayOfflineStoriesStoryView> createState() =>
      _DisplayOfflineStoriesStoryViewState();
}

class _DisplayOfflineStoriesStoryViewState
    extends State<DisplayOfflineStoriesStoryView> {
  late StoryCubit storyCubit;
  VideoPlayerController? _videoController;
  int _currentIndex = 0;
  Duration defaultDuration = const Duration(seconds: 5);
  late Duration _storyDuration;
  late bool _isImage;
  late Duration _elapsedTime;
  late bool _isVideoInitialized;
  Timer? _timer;
  bool isLongPress = false;
  bool doScroll = false;

  @override
  void initState() {
    super.initState();
    storyCubit = context.read<StoryCubit>();
    _elapsedTime = Duration.zero;
    _isVideoInitialized = false;
    _loadStory(widget.stories[_currentIndex]);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _tapTimer?.cancel();
    _videoController?.dispose();

    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    if (!_isImage && _videoController != null) {
      _videoController?.addListener(() {
        if (_videoController!.value.isInitialized) {
          setState(() {
            _elapsedTime = _videoController!.value.position;
            if (_elapsedTime >= _storyDuration) {
              _onNextStory();
            }
          });
        }
      });
    } else {
      _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
        setState(() {
          _elapsedTime += const Duration(milliseconds: 100);
          if (_elapsedTime >= _storyDuration) {
            _onNextStory();
          }
        });
      });
    }
  }

  void _loadStory(StoryModel story) {
    _timer?.cancel();
    _tapTimer?.cancel();
    _videoController?.pause();
    _videoController?.dispose();

    setState(() {
      _isImage = story.mediaType == MediaType.image;
      _storyDuration = story.duration != 0
          ? Duration(seconds: story.duration)
          : defaultDuration;
      _elapsedTime = Duration.zero;

      if (!_isImage) {
        _isVideoInitialized = false;
        _videoController =
            VideoPlayerController.file(File(story.localFilePath!))
              ..initialize().then((_) {
                setState(() {
                  _isVideoInitialized = true;
                  _storyDuration =
                      _videoController?.value.duration ?? defaultDuration;
                  _videoController?.play();
                });
                _startTimer();
              });
      } else {
        _isVideoInitialized = false;
        _startTimer();
      }
    });
  }

  void _onNextStory() {
    if (isLongPress) return;
    if (_currentIndex < widget.stories.length - 1) {
      setState(() {
        _currentIndex++;
        _loadStory(widget.stories[_currentIndex]);
      });
    } else {
      _timer?.cancel();
      _videoController?.pause();
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }
  }

  Timer? _tapTimer;

  void _handleTapDown(TapDownDetails details) {
    _pauseStory();
    _tapTimer?.cancel();
    _tapTimer = Timer(const Duration(milliseconds: 400), () {
      if (!isLongPress) {
        if (details.localPosition.dx < MediaQuery.of(context).size.width / 2) {
          _onPreviousStory();
        } else {
          _onNextStory();
        }
      }
    });
  }

  void _cancelTapTimer() {
    _tapTimer?.cancel();
  }

  void _pauseStory() {
    _timer?.cancel();
    if (!_isImage && _videoController?.value.isPlaying == true) {
      _videoController?.pause();
    }
  }

  void _resumeStory() {
    if (_isImage) {
      _startTimer();
    } else if (_videoController?.value.isInitialized == true &&
        !_videoController!.value.isPlaying) {
      _videoController?.play();
      _startTimer();
    }
  }

  void _onPreviousStory() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _loadStory(widget.stories[_currentIndex]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<StoryModel> stories = widget.stories;
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (widget.isMyStory) {
          if (details.primaryVelocity! < -500) {
            _pauseStory();
            _buildBottomSheet(context, widget.stories[_currentIndex]);
          }
        }
        if (details.primaryVelocity! > -500) {
          Navigator.pop(context);
        }
      },
      onLongPress: () {
        isLongPress = true;
        _pauseStory();
      },
      onLongPressUp: () {
        isLongPress = false;
        _resumeStory();
      },
      onTapDown: _handleTapDown,
      onTapCancel: _cancelTapTimer,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            _buildStoryMedia(stories),
            _buildStoryProgressBar(stories),
            _buildStoryCaption(stories),
          ],
        ),
      ),
    );
  }

  Positioned _buildStoryCaption(List<StoryModel> stories) {
    return Positioned(
      bottom: 80,
      left: 16,
      right: 16,
      child: Text(
        stories[_currentIndex].caption,
        style: const TextStyle(color: Colors.white, fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }

  Positioned _buildStoryProgressBar(List<StoryModel> stories) {
    return Positioned(
      top: 50,
      left: 16,
      right: 16,
      child: Row(
        children: List.generate(stories.length, (index) {
          double targetProgress = 0.0;
          if (index < _currentIndex) {
            targetProgress = 1.0;
          } else if (index == _currentIndex) {
            targetProgress = (_elapsedTime.inSeconds / _storyDuration.inSeconds)
                .clamp(0.0, 1.0);
          }

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: targetProgress),
                duration: const Duration(milliseconds: 300),
                builder: (context, value, _) {
                  return LinearProgressIndicator(
                    value: value,
                    backgroundColor: Colors.white.withAlpha(100),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }

  Center _buildStoryMedia(List<StoryModel> stories) {
    return _isImage
        ? Center(
            child: Image.file(
              File(stories[_currentIndex].localFilePath!),
              width: double.infinity,
            ),
          )
        : _isVideoInitialized && _videoController!.value.isInitialized
            ? Center(
                child: AspectRatio(
                  aspectRatio: _videoController!.value.aspectRatio,
                  child: VideoPlayer(_videoController!),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 0.7,
                ),
              );
  }

  void _buildBottomSheet(BuildContext context, StoryModel story) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.pop(context),
          // إغلاق عند الضغط في أي مكان
          child: Container(
            color: Colors.black.withAlpha(150),
            child: GestureDetector(
              onTap: () {}, // منع إغلاق الـ BottomSheet عند الضغط داخله
              child: DraggableScrollableSheet(
                initialChildSize: 0.5,
                minChildSize: 0.3,
                maxChildSize: 0.8,
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.r),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue[100]!,
                            Colors.blue[50]!,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: const [
                            0.2,
                            0.7,
                          ],
                        )),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            top: 7.h,
                          ),
                          child: Row(
                            textBaseline: TextBaseline.alphabetic,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${story.viewersModels!.entries.length} ',
                                style: TextStyle(
                                    color: AppColorsManager.mainBlue,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                              Image.asset(
                                height: 40.h,
                                AssetsData.storyViewEyeIcon,
                              )
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey[400],
                          thickness: 0.5.h,
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              ...story.viewersModels!.entries.map((entry) {
                                // story.seenStoryDate![entry.key] = DateTime.now().toIso8601String();
                                return Padding(
                                  padding: EdgeInsets.only(top: 5.h),
                                  child: StoryViewersItem(friend: entry.value),
                                );
                              })
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    ).whenComplete(_resumeStory);
  }
}
