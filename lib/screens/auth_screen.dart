import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';
import 'package:lottie_animations/config/constants/assets_path.dart';
import 'package:rive/rive.dart';

import '../config/constants/constants.dart';
import '../config/routes/routes.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  final _supportState = SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = '';
  bool _isAuthenticating = false;

  Future<void> authenticate() async {
    bool isAuthenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = authenticating;
      });
      isAuthenticated = await auth.authenticate(
        localizedReason: authMessage,
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = authenticating;
      });
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        // Add handling of no hardware here.
      } else if (e.code == auth_error.lockedOut ||
          e.code == auth_error.permanentlyLockedOut) {
        //handle case here
      } else {
        setState(() {
          _isAuthenticating = false;
          _authorized = 'Error - ${e.message}';
        });
        return;
      }
    }
    if (!mounted) {
      return;
    }

    setState(() => _authorized = isAuthenticated ? authorised : notAuthorised);

    if (isAuthenticated) {
      Future.delayed(
        const Duration(seconds: 2),
      ).then(
        (value) => Navigator.pushReplacementNamed(context, RoutePaths.homeScreen)
            .then((value) => _authorized = ''),
      );
    }
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          Column(
            children: [
              SizedBox(
                height: 450,
                child: _authorized == authenticating
                    ? const RiveAnimation.asset(
                        AssetPathRive.loadingAnimation,
                      )
                    : _authorized == authorised
                        ? const RiveAnimation.asset(
                            AssetPathRive.successAnimation,
                          )
                        : _authorized == notAuthorised
                            ? const RiveAnimation.asset(
                                AssetPathRive.failedAnimation,
                              )
                            : const RiveAnimation.asset(
                                AssetPathRive.loginAnimation,
                              ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                _authorized == '' ? welcomeMessage : _authorized,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
              const Divider(
                height: 150,
              ),
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: authenticate,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Login via biometric',
                      ),
                      Icon(Icons.fingerprint),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum SupportState {
  unknown,
  supported,
  unsupported,
}
