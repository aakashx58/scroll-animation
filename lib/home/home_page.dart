import 'package:flutter/material.dart';

import '../animations/fade_animation.dart';
import '../animations/slide_animation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true, // Make the header pinned (persistent)
            delegate: MySliverPersistentHeaderDelegate(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // Build and return the item at the given index
                return FadeAnimation(
                  intervalStart: 0.4,
                  duration: const Duration(milliseconds: 1250),
                  child: SlideAnimation(
                    begin: const Offset(0, 100),
                    intervalStart: 0.4,
                    duration: const Duration(milliseconds: 1250),
                    child: Container(
                      height: 80,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xffeeeeee),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                );
              },
              childCount: 34, // Specify the number of items in the list
            ),
          ),
          // Other sliver widgets here...
        ],
      ),
    );
  }
}

const _maxHeaderHeight = 300.0;
const _minHeaderHeight = 120.0;
const _maxProfileHeight = 60.0;
const _minProfileHeight = 20.0;
const _leftMargin = 150.0;

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / _maxHeaderHeight;
    final profileImageSize = (_maxProfileHeight * (1 - percent)).clamp(
      _minProfileHeight,
      _maxProfileHeight,
    );
    return Container(
      color: Colors.pink,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: _minHeaderHeight / 2 - 10,
            child: Text(
              "Aakash",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            left: (_leftMargin * (1 - percent)).clamp(20, _leftMargin),
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: CircleAvatar(
                backgroundColor: const Color(0xffeeeeee),
                radius: profileImageSize,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => _maxHeaderHeight; // Minimum height of the header

  @override
  double get minExtent => _minHeaderHeight; // Maximum height of the header

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
