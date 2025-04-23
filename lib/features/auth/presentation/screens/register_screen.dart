import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:switchly/core/constants/colors.dart';
import 'package:switchly/core/widgets/my_text_form_field.dart';
import 'package:switchly/features/auth/presentation/screens/login_screen.dart';
import 'package:animations/animations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _showPassword = false;
  bool _showConfirmPassword = false;

  void _toggleShowPassword() => setState(() => _showPassword = !_showPassword);
  void _toggleShowConfirmPassword() =>
      setState(() => _showConfirmPassword = !_showConfirmPassword);

  void _navigateTo(Widget page) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  void _submitRegister() {
    final email = emailController.text;
    final password = passwordController.text;
    final confirm = confirmPasswordController.text;
    if (email.isEmpty || password.isEmpty || confirm.isEmpty) return;
    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }
    // Proceed with registration logic
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    final horizontalPadding = screenWidth > 600
        ? screenWidth * 0.2
        : screenWidth < 360
            ? 20.0
            : 35.0;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTitle('Register', screenWidth),
                  SizedBox(height: screenHeight * 0.04),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Column(
                      children: [
                        _buildEmailField(),
                        SizedBox(height: screenHeight * 0.02),
                        _buildPasswordField(),
                        SizedBox(height: screenHeight * 0.02),
                        _buildConfirmPasswordField(),
                        SizedBox(height: screenHeight * 0.04),
                        _buildRegisterButton(screenHeight),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  _buildFooterText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String text, double screenWidth) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: screenWidth > 600 ? 40 : 30,
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
          ),
    );
  }

  Widget _buildEmailField() {
    return MyTextFormField(
      controller: emailController,
      hintText: 'Email',
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) =>
          value == null || value.isEmpty ? 'Enter your email' : null,
    );
  }

  Widget _buildPasswordField() {
    return MyTextFormField(
      controller: passwordController,
      hintText: 'Password',
      obscureText: !_showPassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) =>
          value == null || value.isEmpty ? 'Enter your password' : null,
      suffixIcon: GestureDetector(
        onTap: _toggleShowPassword,
        child: Icon(
          _showPassword ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
          size: 18,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return MyTextFormField(
      controller: confirmPasswordController,
      hintText: 'Confirm Password',
      obscureText: !_showConfirmPassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) =>
          value == null || value.isEmpty ? 'Confirm your password' : null,
      suffixIcon: GestureDetector(
        onTap: _toggleShowConfirmPassword,
        child: Icon(
          _showConfirmPassword
              ? FontAwesomeIcons.eyeSlash
              : FontAwesomeIcons.eye,
          size: 18,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget _buildRegisterButton(double screenHeight) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(screenHeight * 0.07),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      onPressed: _submitRegister,
      child: Text(
        'Register',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
      ),
    );
  }

  Widget _buildFooterText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black,
              ),
        ),
        TextButton(
          onPressed: () => _navigateTo(const LoginScreen()),
          child: Text(
            'Sign In',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
