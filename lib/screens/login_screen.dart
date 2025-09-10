import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';
import 'posts_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Important: Allow resizing when keyboard appears
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => PostsScreen()),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red.withOpacity(0.8),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          } else if (state is AuthPasswordResetSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green.withOpacity(0.8),
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height, // Set explicit height
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade50.withOpacity(0.9),
                Colors.white.withOpacity(0.95),
                Colors.blue.shade100.withOpacity(0.8),
                Colors.white.withOpacity(0.9),
              ],
              stops: [0.0, 0.3, 0.7, 1.0],
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder( // Use LayoutBuilder to get available space
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight( // Allows flexible height
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible( // Allow flexible space
                              child: FadeTransition(
                                opacity: _fadeAnimation,
                                child: SlideTransition(
                                  position: _slideAnimation,
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: 400, // Max width for larger screens
                                    ),
                                    padding: EdgeInsets.all(24.0), // Reduced padding
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.85),
                                      borderRadius: BorderRadius.circular(24),
                                      border: Border.all(
                                        color: Colors.blue.shade100.withOpacity(0.5),
                                        width: 1.5,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.blue.shade200.withOpacity(0.2),
                                          blurRadius: 25,
                                          offset: Offset(0, 10),
                                          spreadRadius: 2,
                                        ),
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.8),
                                          blurRadius: 15,
                                          offset: Offset(-5, -5),
                                        ),
                                      ],
                                    ),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Company Logo
                                          Container(
                                            height: 80, // Reduced from 100
                                            width: 80,  // Reduced from 100
                                            padding: EdgeInsets.all(6), // Reduced padding
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.9),
                                              borderRadius: BorderRadius.circular(16), // Reduced radius
                                              border: Border.all(
                                                color: Colors.blue.shade100,
                                                width: 2,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.blue.shade100.withOpacity(0.3),
                                                  blurRadius: 15,
                                                  offset: Offset(0, 5),
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.asset(
                                                'assets/pmg_logo.png',
                                                fit: BoxFit.contain,
                                                errorBuilder: (context, error, stackTrace) {
                                                  return Icon(
                                                    Icons.business,
                                                    color: Colors.blue.shade600,
                                                    size: 40, // Reduced size
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 24), // Reduced from 32

                                          // Title
                                          Text(
                                            'Welcome Back!',
                                            style: TextStyle(
                                              fontSize: 24, // Reduced from 28
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue.shade800,
                                            ),
                                          ),
                                          SizedBox(height: 6), // Reduced
                                          Text(
                                            'Sign in to continue',
                                            style: TextStyle(
                                              fontSize: 14, // Reduced
                                              color: Colors.blue.shade600,
                                            ),
                                          ),
                                          SizedBox(height: 24), // Reduced from 32

                                          // Email Field
                                          _buildTextField(
                                            controller: _emailController,
                                            label: 'Email',
                                            icon: Icons.email_outlined,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter your email';
                                              }
                                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                                return 'Please enter a valid email';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 16), // Reduced from 20

                                          // Password Field
                                          _buildTextField(
                                            controller: _passwordController,
                                            label: 'Password',
                                            icon: Icons.lock_outline,
                                            isPassword: true,
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
                                          SizedBox(height: 12), // Reduced from 16

                                          // Forgot Password Link
                                          // Align(
                                          //   alignment: Alignment.centerRight,
                                          //   child: TextButton(
                                          //     onPressed: () {
                                          //       _showForgotPasswordDialog(context);
                                          //     },
                                          //     style: TextButton.styleFrom(
                                          //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          //       minimumSize: Size(0, 0),
                                          //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          //     ),
                                          //     child: Text(
                                          //       'Forgot Password?',
                                          //       style: TextStyle(
                                          //         color: Colors.blue.shade600,
                                          //         fontWeight: FontWeight.w600,
                                          //         fontSize: 13, // Reduced
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                           SizedBox(height: 20), // Reduced from 16

                                          // Login Button
                                          BlocBuilder<AuthBloc, AuthState>(
                                            builder: (context, state) {
                                              return Container(
                                                width: double.infinity,
                                                height: 50, // Reduced from 56
                                                child: ElevatedButton(
                                                  onPressed: state is AuthLoading ? null : () {
                                                    if (_formKey.currentState!.validate()) {
                                                      context.read<AuthBloc>().add(
                                                        AuthSignInRequested(
                                                          email: _emailController.text.trim(),
                                                          password: _passwordController.text,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.transparent,
                                                    shadowColor: Colors.transparent,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(14), // Reduced
                                                    ),
                                                  ).copyWith(
                                                    backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                                  ),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Colors.blue.shade600,
                                                          Colors.blue.shade400,
                                                        ],
                                                        begin: Alignment.topLeft,
                                                        end: Alignment.bottomRight,
                                                      ),
                                                      borderRadius: BorderRadius.circular(14),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.blue.shade300.withOpacity(0.4),
                                                          blurRadius: 15,
                                                          offset: Offset(0, 5),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Center(
                                                      child: state is AuthLoading
                                                          ? SizedBox(
                                                        height: 20, // Reduced
                                                        width: 20,  // Reduced
                                                        child: CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                        ),
                                                      )
                                                          : Text(
                                                        'Sign In',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16, // Reduced
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showForgotPasswordDialog(BuildContext context) {
    final TextEditingController _resetEmailController = TextEditingController();
    final GlobalKey<FormState> _resetFormKey = GlobalKey<FormState>();

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
            constraints: BoxConstraints(
              maxWidth: 350,
              maxHeight: MediaQuery.of(context).size.height * 0.7, // Max height constraint
            ),
            padding: EdgeInsets.all(20), // Reduced padding
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
            child: SingleChildScrollView( // Make dialog scrollable
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon
                  Container(
                    padding: EdgeInsets.all(12), // Reduced
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.blue.shade200,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.lock_reset,
                      color: Colors.blue.shade600,
                      size: 28, // Reduced
                    ),
                  ),
                  SizedBox(height: 16), // Reduced

                  // Title
                  Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: 20, // Reduced
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  SizedBox(height: 6), // Reduced

                  // Subtitle
                  Text(
                    'Enter your email address and we\'ll send you a link to reset your password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13, // Reduced
                      color: Colors.blue.shade600,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 20), // Reduced

                  // Email Input
                  Form(
                    key: _resetFormKey,
                    child: TextFormField(
                      controller: _resetEmailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: Icon(Icons.email_outlined, color: Colors.blue.shade500),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.blue.shade50.withOpacity(0.6),
                        labelStyle: TextStyle(color: Colors.blue.shade700),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blue.shade500, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blue.shade200.withOpacity(0.5), width: 1),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Reduced
                      ),
                      style: TextStyle(color: Colors.blue.shade800),
                    ),
                  ),
                  SizedBox(height: 20), // Reduced

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12), // Reduced
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
                      SizedBox(width: 12), // Reduced
                      Expanded(
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: state is AuthLoading ? null : () {
                                if (_resetFormKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                    AuthForgotPasswordRequested(
                                      email: _resetEmailController.text.trim(),
                                    ),
                                  );
                                  Navigator.of(dialogContext).pop();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade600,
                                padding: EdgeInsets.symmetric(vertical: 12), // Reduced
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                              child: state is AuthLoading
                                  ? SizedBox(
                                height: 16, // Reduced
                                width: 16,  // Reduced
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                                  : Text(
                                'Send Reset Link',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14, // Reduced
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? _obscurePassword : false,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue.shade500),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.blue.shade400,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14), // Reduced
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.blue.shade50.withOpacity(0.6),
        labelStyle: TextStyle(color: Colors.blue.shade700),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.blue.shade500, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.blue.shade200.withOpacity(0.5), width: 1),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Reduced padding
      ),
      style: TextStyle(color: Colors.blue.shade800),
    );
  }
}
