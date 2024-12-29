import 'package:flutter/material.dart';
import 'drawer_tile_item.dart';

class DrawerItemBuilder extends StatelessWidget {
  const DrawerItemBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.6,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return DrawerTileItem(
            index: index,
          );
        },
      ),
    );
  }
}
