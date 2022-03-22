import 'package:flutter/material.dart';

const itemSize = 150.0;

class ShrinkTopListPage extends StatefulWidget {
  const ShrinkTopListPage({Key? key}) : super(key: key);

  @override
  State<ShrinkTopListPage> createState() => _ShrinkTopListPageState();
}

class _ShrinkTopListPageState extends State<ShrinkTopListPage> {
  final scrollController = ScrollController();

  void onListen() {
    setState(() {});
  }

  @override
  void initState() {
    scrollController.addListener(onListen);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shrink top List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: CustomScrollView(
          controller: scrollController,
          slivers: <Widget>[
            const SliverToBoxAdapter(
              child: Placeholder(fallbackHeight: 100.0),
            ),
            const SliverAppBar(
              title: Text(
                "My Characters",
                style: TextStyle(color: Colors.black),
              ),
              pinned: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              final itemPositionOffSet = index * itemSize / 2;
              final difference = scrollController.offset - itemPositionOffSet;
              final percent = 1 - (difference / (itemSize / 2));
              double opacity = percent;
              double scale = percent;
              if (opacity > 1.0) opacity = 1.0;
              if (opacity < 0.0) opacity = 0.0;
              if (percent > 1.0) scale = 1.0;

              return Align(
                heightFactor: 0.5,
                child: Opacity(
                  opacity: opacity,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..scale(scale, 1.0),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      color: Colors.orange,
                      child: SizedBox(
                        height: itemSize,
                        child: Row(
                          children: [
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(15.0),
                              ),
                            ),
                            Image.network(
                              'https://w7.pngwing.com/pngs/387/638/png-transparent-son-goku-goku-trunks-gohan-vegeta-super-saiya-dragon-ball-z-photography-manga-vertebrate.png',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }, childCount: 30))
          ],
        ),
      ),
    );
  }
}

class MyCustomHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return const Text("My Custom");
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 100.0;

  @override
  // TODO: implement minExtent
  double get minExtent => 100.0;

  @override
  bool shouldRebuild(covariant MyCustomHeader oldDelegate) {
    return true;
  }
}
