import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/typography.dart';
import '../../models/collector_model.dart';

/// Simulated In-App Call Screen
/// Strictly fulfills requirement 14:
/// - Realistic simulated calling interface ("Calling Collector...")
/// - Explicitly transparent (ready for real telephony/VoIP integration)
/// - Duration timer, mute, speaker, end call controls
class CallScreen extends StatefulWidget {
  final CollectorModel? collector;

  const CallScreen({super.key, this.collector});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  Timer? _callTimer;
  int _seconds = 0;
  bool _isConnected = false;
  bool _isMuted = false;
  bool _isSpeaker = false;

  @override
  void initState() {
    super.initState();
    // Simulate connection after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isConnected = true;
        });
        _startTimer();
      }
    });
  }

  void _startTimer() {
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _seconds++;
        });
      }
    });
  }

  @override
  void dispose() {
    _callTimer?.cancel();
    super.dispose();
  }

  String _formatDuration(int sec) {
    final m = (sec ~/ 60).toString().padLeft(2, '0');
    final s = (sec % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.collector?.name ?? 'Rajesh Kumar';
    final agency = widget.collector?.agency ?? 'GreenCycle Logistics Hub';
    final avatar = widget.collector?.avatar ?? 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&auto=format&fit=crop&q=80';

    return Scaffold(
      backgroundColor: ReCycloColors.brandNavy,
      body: SafeArea(
        child: Column(
          children: [
            // Top simulated notice banner
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Simulated In-App Call (Demo Mode)',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(),

            // Collector Avatar
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ReCycloColors.primary, width: 3),
                boxShadow: const [
                  BoxShadow(
                    color: ReCycloColors.primaryGlow,
                    blurRadius: 24,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.network(
                  avatar,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: ReCycloColors.primaryLight,
                    child: const Icon(Icons.person, size: 50, color: ReCycloColors.primary),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Collector Name & Call Status
            Text(
              name,
              style: ReCycloTypography.displayMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              agency,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _isConnected ? _formatDuration(_seconds) : 'Calling Collector...',
              style: TextStyle(
                color: _isConnected ? ReCycloColors.accentLeaf : Colors.white.withValues(alpha: 0.6),
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
            ),
            const Spacer(),

            // Call Controls Grid (Mute, Speaker, Keypad)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCallOption(
                    icon: _isMuted ? Icons.mic_off_rounded : Icons.mic_none_rounded,
                    label: _isMuted ? 'Muted' : 'Mute',
                    isActive: _isMuted,
                    onTap: () => setState(() => _isMuted = !_isMuted),
                  ),
                  _buildCallOption(
                    icon: Icons.dialpad_rounded,
                    label: 'Keypad',
                    isActive: false,
                    onTap: () {},
                  ),
                  _buildCallOption(
                    icon: _isSpeaker ? Icons.volume_up_rounded : Icons.volume_down_rounded,
                    label: _isSpeaker ? 'Speaker On' : 'Speaker',
                    isActive: _isSpeaker,
                    onTap: () => setState(() => _isSpeaker = !_isSpeaker),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),

            // End Call Button
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 68,
                height: 68,
                decoration: const BoxDecoration(
                  color: ReCycloColors.danger,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x40EF4444),
                      blurRadius: 16,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.call_end_rounded, color: Colors.white, size: 30),
                ),
              ),
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }

  Widget _buildCallOption({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? ReCycloColors.brandNavy : Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
