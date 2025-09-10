import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/posts/posts_bloc.dart';
import '../blocs/posts/posts_event.dart';
import '../blocs/posts/posts_state.dart';
import '../repositories/posts_repository.dart';
import '../widgets/post_item.dart';  // Fixed import
import '../widgets/shimmer_loading.dart';
import 'login_screen.dart';

class PostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsBloc(PostsRepository())..add(PostsFetchRequested()),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade50.withOpacity(0.3),
                Colors.white,
                Colors.blue.shade50.withOpacity(0.2),
              ],
            ),
          ),
          child: CustomScrollView(
            slivers: [
              // Custom App Bar
              SliverAppBar(
                expandedHeight: 120,
                floating: false,
                pinned: true,
                backgroundColor: Colors.white.withOpacity(0.95),
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'Posts',
                    style: TextStyle(
                      color: Colors.blue.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue.shade100.withOpacity(0.3),
                          Colors.white.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                ),
                actions: [
                  // Refresh Button
                  // BlocBuilder<PostsBloc, PostsState>(
                  //   builder: (context, state) {
                  //     return IconButton(
                  //       icon: Icon(
                  //         Icons.refresh,
                  //         color: Colors.blue.shade600,
                  //       ),
                  //       onPressed: () {
                  //         context.read<PostsBloc>().add(PostsRefreshRequested());
                  //       },
                  //     );
                  //   },
                  // ),
                  // Logout Button
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.logout_outlined,
                  //     color: Colors.blue.shade600,
                  //   ),
                  //   onPressed: () {
                  //     _showLogoutDialog(context);
                  //   },
                  // ),
                  SizedBox(width: 8),
                ],
              ),

              // Posts Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: BlocBuilder<PostsBloc, PostsState>(
                    builder: (context, state) {
                      if (state is PostsLoading) {
                        return _buildShimmerLoading();
                      } else if (state is PostsRefreshing) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blue.shade400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'Refreshing posts...',
                                    style: TextStyle(
                                      color: Colors.blue.shade600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _buildPostsList(state.oldPosts),
                          ],
                        );
                      } else if (state is PostsLoaded) {
                        return _buildPostsList(state.posts);
                      } else if (state is PostsError) {
                        return _buildErrorWidget(context, state.message);
                      }
                      return Container();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Column(
      children: List.generate(6, (index) => ShimmerLoading()),
    );
  }

  Widget _buildPostsList(List<dynamic> posts) {
    return Column(
      children: [
        // Stats Card
        Container(
          margin: EdgeInsets.only(bottom: 20, top: 10),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade400, Colors.blue.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade200.withOpacity(0.5),
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.article_outlined,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${posts.length} Posts',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Latest updates from the community',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Posts List
        ...posts.map((post) => PostCard(post: post)).toList(),

        // Bottom Spacing
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildErrorWidget(BuildContext context, String message) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.red.shade100.withOpacity(0.5),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red.shade400,
            size: 64,
          ),
          SizedBox(height: 20),
          Text(
            'Oops! Something went wrong',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            message,
            style: TextStyle(
              fontSize: 14,
              color: Colors.red.shade500,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.read<PostsBloc>().add(PostsFetchRequested());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Try Again',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.blue.shade100,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade100.withOpacity(0.3),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.orange.shade200,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.logout,
                    color: Colors.orange.shade600,
                    size: 32,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Are you sure you want to sign out of your account?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue.shade600,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.blue.shade300),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.blue.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                          context.read<AuthBloc>().add(AuthSignOutRequested());
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade500,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          'Sign Out',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
