import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:switchly/core/constants/colors.dart';
import 'package:switchly/core/widgets/my_text_form_field.dart';
import 'package:switchly/features/auth/presentation/screens/register_screen.dart';
import 'package:switchly/features/product/presentation/screens/home_screen.dart';
import 'package:animations/animations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  void _toggleShowPassword() => setState(() => _showPassword = !_showPassword);

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

  void _submitLogin() {
    if (_formKey.currentState!.validate()) {
      _navigateTo(const HomeScreen());
    }
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
      resizeToAvoidBottomInset: true,
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
                  _buildTitle('Login', screenWidth),
                  SizedBox(height: screenHeight * 0.04),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildEmailField(),
                          SizedBox(height: screenHeight * 0.02),
                          _buildPasswordField(),
                          SizedBox(height: screenHeight * 0.04),
                          _buildLoginButton(screenHeight),
                        ],
                      ),
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return MyTextFormField(
      controller: passwordController,
      hintText: 'Password',
      obscureText: !_showPassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) =>
          value == null || value.isEmpty ? 'Please enter your password' : null,
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

  Widget _buildLoginButton(double screenHeight) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(screenHeight * 0.07),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      onPressed: _submitLogin,
      child: Text(
        'Log in',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildFooterText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black,
                fontSize: 14,
              ),
        ),
        TextButton(
          onPressed: () => _navigateTo(const RegisterScreen()),
          child: Text(
            'Sign up',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
          ),
        ),
      ],
    );
  }
}
