import 'package:flutter/material.dart';

class ShimmerLoading extends StatefulWidget {
  @override
  _ShimmerLoadingState createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade50),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildShimmerContainer(40, 40, isCircle: true),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildShimmerContainer(80, 16),
                      SizedBox(height: 4),
                      _buildShimmerContainer(60, 12),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildShimmerContainer(double.infinity, 18),
            SizedBox(height: 8),
            _buildShimmerContainer(double.infinity, 18),
            SizedBox(height: 12),
            _buildShimmerContainer(double.infinity, 14),
            _buildShimmerContainer(double.infinity, 14),
            _buildShimmerContainer(200, 14),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerContainer(double width, double height, {bool isCircle = false}) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: isCircle
                ? BorderRadius.circular(height / 2)
                : BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade50,
                Colors.blue.shade100.withOpacity(0.7),
                Colors.blue.shade50,
              ],
              stops: [0.0, 0.5, 1.0],
              begin: Alignment(-1.0 + _animation.value * 2, 0.0),
              end: Alignment(1.0 + _animation.value * 2, 0.0),
            ),
          ),
        );
      },
    );
  }
}
