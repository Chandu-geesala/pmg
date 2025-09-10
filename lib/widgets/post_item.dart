import 'package:flutter/material.dart';
import '../models/post.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.blue.shade50,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.2),
            blurRadius: 15,
            offset: Offset(0, 5),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            _showPostDetails(context);
          },
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade400, Colors.blue.shade600],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          '${post.userId}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User ${post.userId}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.blue.shade800,
                            ),
                          ),
                          Text(
                            'Post #${post.id}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.more_vert,
                      color: Colors.blue.shade300,
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Title
                Text(
                  _capitalizeFirst(post.title),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 12),

                // Body Preview
                Text(
                  _capitalizeFirst(post.body),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue.shade600,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 16),

                // Footer
                // Row(
                //   children: [
                //     _buildActionButton(
                //       icon: Icons.favorite_border,
                //       label: 'Like',
                //       onTap: () {},
                //     ),
                //     SizedBox(width: 20),
                //     _buildActionButton(
                //       icon: Icons.chat_bubble_outline,
                //       label: 'Comment',
                //       onTap: () {},
                //     ),
                //     Spacer(),
                //     _buildActionButton(
                //       icon: Icons.share_outlined,
                //       label: 'Share',
                //       onTap: () {},
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: Colors.blue.shade400,
            ),
            SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue.shade400,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  void _showPostDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.blue.shade200,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.blue.shade400, Colors.blue.shade600],
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              '${post.userId}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'User ${post.userId}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.blue.shade800,
                                ),
                              ),
                              Text(
                                'Post #${post.id}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue.shade400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Text(
                      _capitalizeFirst(post.title),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          _capitalizeFirst(post.body),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue.shade700,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.favorite_border, color: Colors.white),
                            label: Text('Like', style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade500,
                              padding: EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.share, color: Colors.blue.shade500),
                            label: Text('Share', style: TextStyle(color: Colors.blue.shade500)),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.blue.shade300),
                              padding: EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
