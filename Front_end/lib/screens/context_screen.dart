import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/project_data.dart';

class ContextScreen extends StatefulWidget {
  const ContextScreen({super.key});

  @override
  State<ContextScreen> createState() => _ContextScreenState();
}

class _ContextScreenState extends State<ContextScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _gridController;
  late List<Animation<double>> _gridFades;
  late List<Animation<Offset>> _gridSlides;

  // ── Palette ──────────────────────────────────────────────
  static const _bg        = Color(0xFF060d12);
  static const _surface   = Color(0xFF0d1a22);
  static const _teal      = Color(0xFF00e5d4);
  static const _tealDim   = Color(0xFF00b3a4);
  static const _tealGlow  = Color(0x2200e5d4);
  static const _red       = Color(0xFFff4d6d);
  static const _green     = Color(0xFF00e5a0);
  static const _blue      = Color(0xFF3d9bff);
  static const _textHi    = Color(0xFFe8f8f7);
  static const _textMid   = Color(0xFF7ab8b3);
  static const _textLow   = Color(0xFF3d6e6a);
  static const _border    = Color(0xFF162a32);

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _gridController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _gridFades = List.generate(6, (i) {
      final s = (i * 0.12).clamp(0.0, 1.0);
      final e = (s + 0.45).clamp(0.0, 1.0);
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _gridController,
          curve: Interval(s, e, curve: Curves.easeOut),
        ),
      );
    });

    _gridSlides = List.generate(6, (i) {
      final s = (i * 0.12).clamp(0.0, 1.0);
      final e = (s + 0.5).clamp(0.0, 1.0);
      return Tween<Offset>(
        begin: const Offset(0, 0.18),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _gridController,
        curve: Interval(s, e, curve: Curves.easeOutCubic),
      ));
    });

    Future.delayed(
      const Duration(milliseconds: 100),
      () => _gridController.forward(),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _gridController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildStatusRow(),
                const SizedBox(height: 18),
                _buildDashboardGrid(),
                const SizedBox(height: 18),
                _buildInfoPanel(),
                const SizedBox(height: 18),
                _buildTechSection(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // ── App Bar ───────────────────────────────────────────────
  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 175,
      backgroundColor: _bg,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(painter: _GridPainter()),
            // Glow blob
            Positioned(
              top: -60,
              left: -40,
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (_, __) => Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(colors: [
                      _tealGlow.withOpacity(
                          0.18 + 0.08 * _pulseController.value),
                      Colors.transparent,
                    ]),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 64, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(children: [
                    _dotBadge(_teal),
                    const SizedBox(width: 8),
                    Text(
                      'SYS:CONTEXTE  //  PFA · GÉOMATIQUE · EABA',
                      style: GoogleFonts.sourceCodePro(
                        color: _tealDim,
                        fontSize: 9.5,
                        letterSpacing: 1.8,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ]),
                  const SizedBox(height: 10),
                  Text(
                    'Contexte\ndu Projet',
                    style: GoogleFonts.rajdhani(
                      color: _textHi,
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      height: 1.05,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.transparent,
                    _teal.withOpacity(0.4),
                    Colors.transparent,
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Status Row ────────────────────────────────────────────
  Widget _buildStatusRow() {
    return Row(children: [
      _StatusPill(label: 'EN COURS', color: _green, pulse: _pulseController),
      const SizedBox(width: 10),
      _StatusPill(label: 'IA · SIG', color: _blue, pulse: _pulseController),
      const Spacer(),
      Text(
        projectInfo.year,
        style: GoogleFonts.sourceCodePro(
          color: _textLow,
          fontSize: 11,
          letterSpacing: 1.2,
        ),
      ),
    ]);
  }

  // ── 2-col Dashboard Grid ──────────────────────────────────
  Widget _buildDashboardGrid() {
    final cells = [
      _CellData(
        tag: '01',
        title: 'Problématique',
        body:
            '''Comment reconstruire de manière fiable une information spectrale continue à haute résolution (imagerie hyperspectrale) à partir d'une information spatiale dense mais spectralement pauvre (imagerie RVB), afin de pallier le compromis physique des capteurs actuels ?''',
        icon: Icons.layers_rounded,
        accent: _red,
        index: 0,
        wide: false,
      ),
      _CellData(
        tag: '02',
        title: 'Objectifs',
        body:
            '''L'objectif principal de ce travail est de développer [ou d'évaluer] une méthodologie de reconstruction super-spectrale capable de générer des images hyperspectrales à haute résolution spatiale à partir d'images RVB standards, en garantissant la fidélité de la signature spectrale du sol.''',
        icon: Icons.track_changes_rounded,
        accent: _green,
        index: 1,
        wide: false,
      ),
      _CellData(
        tag: '03',
        title: 'Contexte Académique',
        body:
            '''Ce projet vise à lever le compromis physique des capteurs en reconstruisant une image hyperspectrale (riche en bandes physico-chimiques) à partir d'une image RVB standard (haute résolution spatiale). Face à ce problème mathématiquement mal posé, une architecture d'apprentissage profond est entraînée pour modéliser la correspondance complexe entre les textures trichromatiques et les signatures spectrales du sol. Les cubes de données générés sont ensuite validés par des métriques rigoureuses (SAM, RMSE) pour garantir leur exactitude thématique et leur exploitabilité. Cette innovation permet de démocratiser l'accès à la haute précision spectrale à moindre coût pour la cartographie et la géologie.''',
        icon: Icons.school_rounded,
        accent: _blue,
        index: 2,
        wide: true,
      ),
    ];

    return Column(children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: _animatedCell(cells[0])),
        const SizedBox(width: 12),
        Expanded(child: _animatedCell(cells[1])),
      ]),
      const SizedBox(height: 12),
      _animatedCell(cells[2]),
    ]);
  }

  Widget _animatedCell(_CellData c) {
    return FadeTransition(
      opacity: _gridFades[c.index],
      child: SlideTransition(
        position: _gridSlides[c.index],
        child: _DashCell(data: c),
      ),
    );
  }

  // ── Info Panel ────────────────────────────────────────────
  Widget _buildInfoPanel() {
    final rows = [
      ('👤', 'Étudiant',   projectInfo.student),
      ('👨‍🏫', 'Superviseur', projectInfo.supervisor),
      ('🏫', 'École',      projectInfo.school),
      ('📅', 'Année',      projectInfo.year),
    ];

    return FadeTransition(
      opacity: _gridFades[3],
      child: SlideTransition(
        position: _gridSlides[3],
        child: Container(
          decoration: BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _border),
            boxShadow: [
              BoxShadow(color: _tealGlow, blurRadius: 18, spreadRadius: -4),
            ],
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Icon(Icons.person_pin_rounded, color: _teal, size: 16),
                const SizedBox(width: 8),
                Text('INFORMATIONS', style: _tagStyle()),
                const Spacer(),
                Text('[ ]',
                    style: GoogleFonts.sourceCodePro(
                        color: _textLow, fontSize: 12)),
              ]),
              const SizedBox(height: 16),
              ...rows.map((r) => _infoRow(r.$1, r.$2, r.$3)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String emoji, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(emoji, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            label,
            style: GoogleFonts.sourceCodePro(
              color: _textLow,
              fontSize: 9,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.rajdhani(
              color: _textHi,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ]),
      ]),
    );
  }

  // ── Tech Section ──────────────────────────────────────────
  Widget _buildTechSection() {
    return FadeTransition(
      opacity: _gridFades[4],
      child: SlideTransition(
        position: _gridSlides[4],
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(Icons.memory_rounded, color: _teal, size: 16),
            const SizedBox(width: 8),
            Text('TECHNOLOGIES CLÉS', style: _tagStyle()),
          ]),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: projectInfo.technologies
                .map((t) =>
                    _TechBadge(label: t, pulseCtrl: _pulseController))
                .toList(),
          ),
        ]),
      ),
    );
  }

  // ── Shared helpers ────────────────────────────────────────
  Widget _dotBadge(Color c) => AnimatedBuilder(
        animation: _pulseController,
        builder: (_, __) => Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: c,
            boxShadow: [
              BoxShadow(
                color: c.withOpacity(0.5 + 0.3 * _pulseController.value),
                blurRadius: 6,
              ),
            ],
          ),
        ),
      );

  TextStyle _tagStyle() => GoogleFonts.sourceCodePro(
        color: _tealDim,
        fontSize: 10,
        letterSpacing: 2,
        fontWeight: FontWeight.w700,
      );
}

// ─────────────────────────────────────────────────────────────
// Dash Cell
// ─────────────────────────────────────────────────────────────
class _CellData {
  final String tag, title, body;
  final IconData icon;
  final Color accent;
  final int index;
  final bool wide;

  const _CellData({
    required this.tag,
    required this.title,
    required this.body,
    required this.icon,
    required this.accent,
    required this.index,
    required this.wide,
  });
}

class _DashCell extends StatefulWidget {
  final _CellData data;
  const _DashCell({required this.data});

  @override
  State<_DashCell> createState() => _DashCellState();
}

class _DashCellState extends State<_DashCell> {
  bool _pressed = false;

  static const _surface = Color(0xFF0d1a22);
  static const _border  = Color(0xFF162a32);
  static const _textHi  = Color(0xFFe8f8f7);
  static const _textMid = Color(0xFF7ab8b3);

  @override
  Widget build(BuildContext context) {
    final c = widget.data;
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 130),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: _pressed ? const Color(0xFF112230) : _surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _pressed ? c.accent.withOpacity(0.5) : _border,
            ),
            boxShadow: [
              BoxShadow(
                color: c.accent.withOpacity(_pressed ? 0.18 : 0.06),
                blurRadius: _pressed ? 20 : 12,
                spreadRadius: -4,
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    c.tag,
                    style: GoogleFonts.sourceCodePro(
                      color: c.accent.withOpacity(0.6),
                      fontSize: 10,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: c.accent.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: c.accent.withOpacity(0.2)),
                    ),
                    child: Icon(c.icon, color: c.accent, size: 16),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                width: 28,
                height: 2,
                decoration: BoxDecoration(
                  color: c.accent,
                  borderRadius: BorderRadius.circular(1),
                  boxShadow: [
                    BoxShadow(
                      color: c.accent.withOpacity(0.6),
                      blurRadius: 6,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                c.title,
                style: GoogleFonts.rajdhani(
                  color: _textHi,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                c.body,
                style: GoogleFonts.inter(
                  color: _textMid,
                  fontSize: 12.5,
                  height: 1.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Tech Badge
// ─────────────────────────────────────────────────────────────
class _TechBadge extends StatefulWidget {
  final String label;
  final AnimationController pulseCtrl;
  const _TechBadge({required this.label, required this.pulseCtrl});

  @override
  State<_TechBadge> createState() => _TechBadgeState();
}

class _TechBadgeState extends State<_TechBadge> {
  bool _hovered = false;

  static const _teal    = Color(0xFF00e5d4);
  static const _surface = Color(0xFF0d1a22);
  static const _border  = Color(0xFF162a32);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _hovered ? _teal.withOpacity(0.12) : _surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _hovered ? _teal.withOpacity(0.6) : _border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: _teal.withOpacity(0.15),
                    blurRadius: 12,
                    spreadRadius: -2,
                  )
                ]
              : [],
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (_hovered) ...[
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _teal,
                boxShadow: [
                  BoxShadow(color: _teal.withOpacity(0.8), blurRadius: 5)
                ],
              ),
            ),
            const SizedBox(width: 7),
          ],
          Text(
            widget.label,
            style: GoogleFonts.sourceCodePro(
              color: _hovered ? _teal : const Color(0xFF5a9a95),
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ]),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Grid Background Painter
// ─────────────────────────────────────────────────────────────
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF0d1a22)
      ..strokeWidth = 0.4;

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

// ─────────────────────────────────────────────────────────────
// Status Pill
// ─────────────────────────────────────────────────────────────
class _StatusPill extends StatelessWidget {
  final String label;
  final Color color;
  final AnimationController pulse;
  const _StatusPill(
      {required this.label, required this.color, required this.pulse});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        AnimatedBuilder(
          animation: pulse,
          builder: (_, __) => Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4 + 0.4 * pulse.value),
                  blurRadius: 5,
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.sourceCodePro(
            color: color,
            fontSize: 9.5,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ]),
    );
  }
}