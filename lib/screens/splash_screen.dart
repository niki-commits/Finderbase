import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    
    _controller.forward();
    
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3949AB),
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: CustomPaint(
                  painter: MazeLogoPainter(),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'FinderBase',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Find what matters',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFE0E0E0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MazeLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    
    // Outer circle
    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, whitePaint);
    
    // Maze paths
    final mazePaint = Paint()
      ..color = const Color(0xFF3949AB)
      ..style = PaintingStyle.fill;
    
    // Top path
    final topPath = Path();
    topPath.moveTo(center.dx, center.dy - 0.9 * radius);
    topPath.arcToPoint(
      Offset(center.dx + 0.9 * radius, center.dy),
      radius: Radius.circular(0.9 * radius),
      clockwise: true,
    );
    topPath.lineTo(center.dx + 0.6 * radius, center.dy);
    topPath.arcToPoint(
      Offset(center.dx, center.dy - 0.6 * radius),
      radius: Radius.circular(0.6 * radius),
      clockwise: false,
    );
    topPath.arcToPoint(
      Offset(center.dx - 0.6 * radius, center.dy),
      radius: Radius.circular(0.6 * radius),
      clockwise: false,
    );
    topPath.lineTo(center.dx - 0.9 * radius, center.dy);
    topPath.arcToPoint(
      Offset(center.dx, center.dy - 0.9 * radius),
      radius: Radius.circular(0.9 * radius),
      clockwise: true,
    );
    canvas.drawPath(topPath, mazePaint);
    
    // Bottom path
    final bottomPath = Path();
    bottomPath.moveTo(center.dx, center.dy + 0.9 * radius);
    bottomPath.arcToPoint(
      Offset(center.dx - 0.9 * radius, center.dy),
      radius: Radius.circular(0.9 * radius),
      clockwise: true,
    );
    bottomPath.lineTo(center.dx - 0.6 * radius, center.dy);
    bottomPath.arcToPoint(
      Offset(center.dx, center.dy + 0.6 * radius),
      radius: Radius.circular(0.6 * radius),
      clockwise: false,
    );
    bottomPath.arcToPoint(
      Offset(center.dx + 0.6 * radius, center.dy),
      radius: Radius.circular(0.6 * radius),
      clockwise: false,
    );
    bottomPath.lineTo(center.dx + 0.9 * radius, center.dy);
    bottomPath.arcToPoint(
      Offset(center.dx, center.dy + 0.9 * radius),
      radius: Radius.circular(0.9 * radius),
      clockwise: true,
    );
    canvas.drawPath(bottomPath, mazePaint);
    
    // Small top path
    final smallTopPath = Path();
    smallTopPath.moveTo(center.dx, center.dy - 0.3 * radius);
    smallTopPath.arcToPoint(
      Offset(center.dx + 0.3 * radius, center.dy),
      radius: Radius.circular(0.3 * radius),
      clockwise: true,
    );
    smallTopPath.lineTo(center.dx, center.dy);
    smallTopPath.close();
    canvas.drawPath(smallTopPath, mazePaint);
    
    // Small bottom path
    final smallBottomPath = Path();
    smallBottomPath.moveTo(center.dx, center.dy + 0.3 * radius);
    smallBottomPath.arcToPoint(
      Offset(center.dx - 0.3 * radius, center.dy),
      radius: Radius.circular(0.3 * radius),
      clockwise: true,
    );
    smallBottomPath.lineTo(center.dx, center.dy);
    smallBottomPath.close();
    canvas.drawPath(smallBottomPath, mazePaint);
    
    // Center dot
    final dotPaint = Paint()
      ..color = const Color(0xFFFF5722)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.1, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}