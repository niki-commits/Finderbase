import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Implement login logic here
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo
                Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CustomPaint(
                      painter: MazeLogoPainter(),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Welcome text
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3949AB),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Sign in to continue to FinderBase',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),

                // Login form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Email field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email_outlined,
                              color: Color(0xFF3949AB)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color(0xFF3949AB), width: 2),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Password field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline,
                              color: Color(0xFF3949AB)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color(0xFF3949AB), width: 2),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Remember me and Forgot password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 24,
                                width: 24,
                                child: Checkbox(
                                  value: _rememberMe,
                                  activeColor: const Color(0xFF3949AB),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value!;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Remember me',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              // Forgot password logic
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color(0xFF3949AB),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Login button
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3949AB),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Sign up link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account? ',
                            style: TextStyle(color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Color(0xFF3949AB),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
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

    final outlineCirclePaint = Paint()
      ..color = const Color(0xFF3949AB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, radius, whitePaint);
    canvas.drawCircle(center, radius, outlineCirclePaint);

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
