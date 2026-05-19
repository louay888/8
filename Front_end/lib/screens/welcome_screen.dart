import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/project_data.dart';

class WelcomeScreen extends StatefulWidget {
  final VoidCallback onGetStarted;
  const WelcomeScreen({super.key, required this.onGetStarted});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late AnimationController _entryCtrl;
  late Animation<double> _titleFade;
  late Animation<Offset> _titleSlide;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;
  late Animation<double> _btnFade;

  // ── Palette (shared with all screens) ────────────────────
  static const _bg       = Color(0xFF060d12);
  static const _surface  = Color(0xFF0d1a22);
  static const _teal     = Color(0xFF00e5d4);
  static const _tealDim  = Color(0xFF00b3a4);
  static const _tealGlow = Color(0x2200e5d4);
  static const _green    = Color(0xFF00e5a0);
  static const _textHi   = Color(0xFFe8f8f7);
  static const _textMid  = Color(0xFF7ab8b3);
  static const _textLow  = Color(0xFF3d6e6a);
  static const _border   = Color(0xFF162a32);

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this, duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _entryCtrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1200),
    );

    _titleFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _entryCtrl, curve: const Interval(0.0, 0.5, curve: Curves.easeOut)),
    );
    _titleSlide = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _entryCtrl, curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic)),
    );
    _cardFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _entryCtrl, curve: const Interval(0.3, 0.75, curve: Curves.easeOut)),
    );
    _cardSlide = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(parent: _entryCtrl, curve: const Interval(0.3, 0.8, curve: Curves.easeOutCubic)),
    );
    _btnFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _entryCtrl, curve: const Interval(0.6, 1.0, curve: Curves.easeOut)),
    );

    _entryCtrl.forward();
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _entryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Grid background
          CustomPaint(painter: _GridPainter()),
          // Animated glow
          AnimatedBuilder(
            animation: _pulseCtrl,
            builder: (_, __) => Positioned(
              top: -80,
              right: -80,
              child: Container(
                width: 340,
                height: 340,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    _tealGlow.withOpacity(0.20 + 0.10 * _pulseCtrl.value),
                    Colors.transparent,
                  ]),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  // Badge
                  SlideTransition(
                    position: _titleSlide,
                    child: FadeTransition(
                      opacity: _titleFade,
                      child: _buildBadge(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Main title
                  SlideTransition(
                    position: _titleSlide,
                    child: FadeTransition(
                      opacity: _titleFade,
                      child: _buildTitle(),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Description card
                  SlideTransition(
                    position: _cardSlide,
                    child: FadeTransition(
                      opacity: _cardFade,
                      child: _buildDescCard(),
                    ),
                  ),
                  const Spacer(),
                  // CTA
                  FadeTransition(
                    opacity: _btnFade,
                    child: _buildCTA(),
                  ),
                  const SizedBox(height: 16),
                  FadeTransition(
                    opacity: _btnFade,
                    child: Center(
                      child: Text(
                        'CartoVec © 2026 — Géomatique EABA',
                        style: GoogleFonts.sourceCodePro(
                          color: _textLow,
                          fontSize: 10,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge() {
    return Row(children: [
      AnimatedBuilder(
        animation: _pulseCtrl,
        builder: (_, __) => Container(
          width: 7, height: 7,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _green,
            boxShadow: [BoxShadow(
              color: _green.withOpacity(0.4 + 0.4 * _pulseCtrl.value),
              blurRadius: 6,
            )],
          ),
        ),
      ),
      const SizedBox(width: 10),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _border),
        ),
        child: Text(
          'PFA 2025–2026  //  SYSTÈME ACTIF',
          style: GoogleFonts.sourceCodePro(
            color: _tealDim,
            fontSize: 9.5,
            letterSpacing: 1.8,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ]);
  }

  Widget _buildTitle() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        projectInfo.title,
        style: GoogleFonts.rajdhani(
          color: _textHi,
          fontSize: 52,
          fontWeight: FontWeight.w800,
          height: 0.95,
          letterSpacing: -0.5,
        ),
      ),
      const SizedBox(height: 14),
      // Accent bar
      Container(
        width: 48, height: 3,
        decoration: BoxDecoration(
          color: _teal,
          borderRadius: BorderRadius.circular(2),
          boxShadow: [BoxShadow(color: _teal.withOpacity(0.6), blurRadius: 8)],
        ),
      ),
      const SizedBox(height: 14),
      Text(
        projectInfo.subtitle,
        style: GoogleFonts.inter(
          color: _textMid,
          fontSize: 17,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
      ),
    ]);
  }

  Widget _buildDescCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border),
        boxShadow: [BoxShadow(color: _tealGlow, blurRadius: 20, spreadRadius: -4)],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(Icons.terminal_rounded, color: _teal, size: 15),
          const SizedBox(width: 8),
          Text('DESCRIPTION', style: GoogleFonts.sourceCodePro(
            color: _tealDim, fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.w700,
          )),
          const Spacer(),
          Text('[ ] ', style: GoogleFonts.sourceCodePro(color: _textLow, fontSize: 11)),
        ]),
        const SizedBox(height: 14),
        // Scan line divider
        Container(height: 1, decoration: BoxDecoration(
          gradient: LinearGradient(colors: [_teal.withOpacity(0.4), Colors.transparent]),
        )),
        const SizedBox(height: 14),
        Text(
          projectInfo.description,
          style: GoogleFonts.inter(
            color: _textMid, fontSize: 13.5, height: 1.7, fontWeight: FontWeight.w400,
          ),
        ),
      ]),
    );
  }

  Widget _buildCTA() {
    return _PressableButton(
      onTap: widget.onGetStarted,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: _teal,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: _teal.withOpacity(0.35), blurRadius: 20, offset: const Offset(0, 6))],
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'INITIALISER',
            style: GoogleFonts.rajdhani(
              color: const Color(0xFF060d12),
              fontSize: 17,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.arrow_forward_rounded, color: Color(0xFF060d12), size: 20),
        ]),
      ),
    );
  }
}

// ── Pressable wrapper ────────────────────────────────────────
class _PressableButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  const _PressableButton({required this.child, required this.onTap});

  @override
  State<_PressableButton> createState() => _PressableButtonState();
}

class _PressableButtonState extends State<_PressableButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) { setState(() => _pressed = false); widget.onTap(); },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: widget.child,
      ),
    );
  }
}

// ── Grid Background Painter ──────────────────────────────────
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF0d1a22)..strokeWidth = 0.4;
    const step = 28.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}