import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/features/home/presentation/views/widgets/image_shimmer_loading.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostImageContainer extends StatefulWidget {
  const PostImageContainer({
    super.key,
    required this.postImages,
  });

  final List<String> postImages;

  @override
  State<PostImageContainer> createState() => _PostImageContainerState();
}

class _PostImageContainerState extends State<PostImageContainer> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return widget.postImages.isNotEmpty
        ? Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: 300.h,
                width: double.infinity,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  controller: _pageController,
                  itemCount: widget.postImages.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: CachedNetworkImage(
                        imageUrl: widget.postImages[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (context, url) =>
                            const Center(child: ImageShimmerLoading()),
                        errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            size: 50,
                            color: Colors.red),
                      ),
                    );
                  },
                ),
              ),
              if (widget.postImages.length > 1)
                Positioned(
                  bottom: 10.h,
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: _dotsCount(),
                    effect: ExpandingDotsEffect(
                      dotHeight: 8.h,
                      dotWidth: 8.w,
                      activeDotColor: Colors.white,
                      dotColor: Colors.grey.shade400,
                    ),
                  ),
                ),
              Positioned(
                bottom: 10.h,
                right: 10.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(100),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "${currentIndex + 1}/${widget.postImages.length}",
                    // (2/10)
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }

  int _dotsCount() {
    if (widget.postImages.length > 5 &&
        currentIndex == widget.postImages.length - 1) {
      return 1;
    }
    if (widget.postImages.length > 5) {
      return 5;
    }
    return widget.postImages.length;
  }
}

