import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/app_colors.dart';
import 'package:shopping_app/l10n/app_localizations.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _currentPage = 1;

  void _nextPage() {
    if (_currentPage < 3) {
      setState(() {
        _currentPage++;
      });
    }
  }

  Widget _buildOnboardingScreen({
    Key? key,
    required String image,
    required String title,
    required String description,
    required String buttonText,
  }) {
    return Padding(
      key: key,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Spacer(),

          Expanded(
            flex: 7,
            child: Image.asset(
              image,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 24),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF172033),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Colors.black54,
            ),
          ),

          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIndicator(_currentPage == 1),
              const SizedBox(width: 8),
              _buildIndicator(_currentPage == 2),
            ],
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 28 : 9,
      height: 9,
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primaryColor
            : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _buildWelcomeScreen(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Padding(
      key: const ValueKey('welcome'),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Spacer(),

          Image.asset(
            'assets/images/rafiki.png',
            height: 300,
            width: double.infinity,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 25),

          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: '${l.welcomeTo}\n',
                  style: const TextStyle(
                    color: Color(0xFF172033),
                  ),
                ),
                const TextSpan(
                  text: 'Shop',
                  style: TextStyle(
                    color: Color(0xFF172033),
                  ),
                ),
                const TextSpan(
                  text: 'In',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Text(
            l.welcomeDescription,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.black54,
            ),
          ),

          const Spacer(),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Text(
                l.signup,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
                side: const BorderSide(
                  color: AppColors.primaryColor,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                l.login,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          child: _currentPage == 1
              ? _buildOnboardingScreen(
                  key: const ValueKey(1),
                  image: 'assets/images/onboarding_2.png',
                  title: l.menOnboardingTitle,
                  description: l.menOnboardingDescription,
                  buttonText: l.next,
                )
              : _currentPage == 2
                  ? _buildOnboardingScreen(
                      key: const ValueKey(2),
                      image: 'assets/images/onboarding_1.png',
                      title: l.womenOnboardingTitle,
                      description: l.womenOnboardingDescription,
                      buttonText: l.next,
                    )
                  : _buildWelcomeScreen(context),
        ),
      ),
    );
  }
}