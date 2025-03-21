import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:zybotest/loginscrn2.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      // Initialize the video controller with network
      _videoController = VideoPlayerController.network(
          'https://videos.pexels.com/video-files/13929574/13929574-uhd_1440_2560_24fps.mp4');
      await _videoController.initialize();
      await _videoController.setLooping(true);
      await _videoController.play();

      // Update state only if widget is still mounted
      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isVideoInitialized = false;
        });
      }
      debugPrint('Error initializing video: $e');
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background video or fallback
          _isVideoInitialized
              ? FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _videoController.value.size.width,
                    height: _videoController.value.size.height,
                    child: VideoPlayer(_videoController),
                  ),
                )
              : Container(
                  color: Colors.black,
                  child: Center(
                    child: _errorMessage.isNotEmpty
                        ? Text(
                            'Video Error: $_errorMessage',
                            style: TextStyle(color: Colors.red),
                          )
                        : CircularProgressIndicator(color: Colors.white),
                  ),
                ),

          // Overlay for better text readability
          Container(color: Colors.black.withOpacity(0.4)),

          // Main content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),

                // Logo
                Image.asset(
                  '/Users/kirxnroy/zybotest/assets/Logo.png',
                  height: 60,
                ),

                const Spacer(), // Push remaining content to bottom

                // Welcome text
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Let's Meet New People Around You 😍",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Get Started button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const PhoneOnboardingScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(double.infinity, 56),
                    ),
                    child: const Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
