import 'package:cirilla/models/models.dart';
import 'package:flutter/material.dart';
import '../blocks/blocks.dart';

class PostContent extends StatelessWidget {
  final Post post;

  PostContent({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index == post.blocks.length - 1) {
            return Column(
              children: [
                PostBlock(block: post.blocks[index]),
                SizedBox(height: 50),
                Divider(
                  height: 1,
                  thickness: 1,
                ),
              ],
            );
          }
          return PostBlock(block: post.blocks[index]);
        },
        childCount: post.blocks.length,
      ),
    );
  }
}
