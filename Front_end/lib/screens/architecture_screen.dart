import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/project_data.dart';

class ArchitectureScreen extends StatefulWidget {
  const ArchitectureScreen({super.key});

  @override
  State<ArchitectureScreen> createState() => _ArchitectureScreenState();
}

class _ArchitectureScreenState extends State<ArchitectureScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late AnimationController _entryCtrl;
  late List<Animation<double>> _fades;
  late List<Animation<Offset>> _slides;

  // ── Palette ──────────────────────────────────────────────
  static const _bg      = Color(0xFF060d12);
  static const _surface = Color(0xFF0d1a22);
  static const _teal    = Color(0xFF00e5d4);
  static const _tealDim = Color(0xFF00b3a4);
  static const _tealGlow= Color(0x2200e5d4);
  static const _purple  = Color(0xFFb57aff);
  static const _red     = Color(0xFFff4d6d);
  static const _green   = Color(0xFF00e5a0);
  static const _blue    = Color(0xFF3d9bff);
  static const _amber   = Color(0xFFf5a623);
  static const _textHi  = Color(0xFFe8f8f7);
  static const _textMid = Color(0xFF7ab8b3);
  static const _textLow = Color(0xFF3d6e6a);
  static const _border  = Color(0xFF162a32);

  // Cycle colors for step cards
  static const _stepColors = [_blue, _red, _green, _amber, _purple, _teal];

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..repeat(reverse: true);
    _entryCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));

    _fades = List.generate(6, (i) {
      final s = (i * 0.12).clamp(0.0, 1.0);
      final e = (s + 0.45).clamp(0.0, 1.0);
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _entryCtrl, curve: Interval(s, e, curve: Curves.easeOut)));
    });
    _slides = List.generate(6, (i) {
      final s = (i * 0.12).clamp(0.0, 1.0);
      final e = (s + 0.5).clamp(0.0, 1.0);
      return Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
        CurvedAnimation(parent: _entryCtrl, curve: Interval(s, e, curve: Curves.easeOutCubic)));
    });

    Future.delayed(const Duration(milliseconds: 80), () => _entryCtrl.forward());
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _entryCtrl.dispose();
    super.dispose();
  }

  Widget _animated(int i, Widget child) => FadeTransition(
    opacity: _fades[i.clamp(0, _fades.length - 1)],
    child: SlideTransition(position: _slides[i.clamp(0, _slides.length - 1)], child: child),
  );

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
                _animated(0, _sectionLabel('PIPELINE DE TRAITEMENT', Icons.account_tree_rounded)),
                const SizedBox(height: 14),
                _animated(0, _buildPipelineFlow()),
                const SizedBox(height: 22),
                _animated(1, _sectionLabel('ÉTAPES DÉTAILLÉES', Icons.list_alt_rounded)),
                const SizedBox(height: 14),
                ...architectureSteps.asMap().entries.map((e) =>
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _animated(
                      (e.key + 1).clamp(0, _fades.length - 1),
                      _buildStepCard(e.key, e.value),
                    ),
                  )),
                const SizedBox(height: 12),
                _animated(3, _sectionLabel('STACK TECHNIQUE', Icons.memory_rounded)),
                const SizedBox(height: 14),
                _animated(3, _buildTechStack()),
                const SizedBox(height: 22),
                _animated(4, _sectionLabel('FLUX DE DONNÉES', Icons.swap_vert_rounded)),
                const SizedBox(height: 14),
                _animated(4, _buildDataFlow()),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 175,
      backgroundColor: _bg,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Stack(fit: StackFit.expand, children: [
          CustomPaint(painter: _GridPainter()),
          Positioned(
            top: -50, left: -50,
            child: AnimatedBuilder(
              animation: _pulseCtrl,
              builder: (_, __) => Container(
                width: 280, height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    _purple.withOpacity(0.10 + 0.06 * _pulseCtrl.value),
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
                  _dot(_purple),
                  const SizedBox(width: 8),
                  Text('SYS:ARCHITECTURE  //  PIPELINE · STACK · FLUX',
                    style: GoogleFonts.sourceCodePro(color: _tealDim, fontSize: 9.5, letterSpacing: 1.8, fontWeight: FontWeight.w600)),
                ]),
                const SizedBox(height: 10),
                Text('Méthodologie', style: GoogleFonts.rajdhani(
                  color: _textHi, fontSize: 34, fontWeight: FontWeight.w700, height: 1.05, letterSpacing: 0.5)),
              ],
            ),
          ),
          Positioned(bottom: 0, left: 0, right: 0,
            child: Container(height: 1, decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.transparent, _purple.withOpacity(0.4), Colors.transparent]),
            ))),
        ]),
      ),
    );
  }

  Widget _sectionLabel(String label, IconData icon) => Row(children: [
    Icon(icon, color: _teal, size: 15),
    const SizedBox(width: 8),
    Text(label, style: GoogleFonts.sourceCodePro(
      color: _tealDim, fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.w700)),
  ]);

  Widget _buildPipelineFlow() {
    final steps = [
      ('Multispectral',   Icons.image_rounded,              Color(0xFF7ab8b3)),
      ('Préparation', Icons.tune_rounded,              _blue),
      ('Data calibration', Icons.auto_awesome_mosaic_rounded,_teal),
      ('Model',  Icons.polyline_rounded,            _red),
      ('Export',   Icons.code_rounded,               _amber),
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border),
        boxShadow: [BoxShadow(color: _tealGlow, blurRadius: 16, spreadRadius: -4)],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: steps.asMap().entries.map((e) {
            final isLast = e.key == steps.length - 1;
            return Row(children: [
              Column(children: [
                Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: e.value.$3.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: e.value.$3.withOpacity(0.3)),
                    boxShadow: [BoxShadow(color: e.value.$3.withOpacity(0.15), blurRadius: 8)],
                  ),
                  child: Icon(e.value.$2, color: e.value.$3, size: 22),
                ),
                const SizedBox(height: 8),
                Text(e.value.$1, style: GoogleFonts.sourceCodePro(
                  color: e.value.$3, fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
              ]),
              if (!isLast) Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.arrow_forward_rounded, color: _textLow, size: 18),
              ),
            ]);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildStepCard(int index, ArchitectureStep step) {
    final color = _stepColors[index % _stepColors.length];
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Container(
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _border),
          boxShadow: [BoxShadow(color: color.withOpacity(0.08), blurRadius: 12, spreadRadius: -4)],
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          iconColor: color,
          collapsedIconColor: _textLow,
          leading: Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withOpacity(0.25)),
            ),
            child: Center(child: Text(step.icon, style: const TextStyle(fontSize: 22))),
          ),
          title: Text(step.title, style: GoogleFonts.rajdhani(
            color: _textHi, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.2)),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(step.description, style: GoogleFonts.inter(
              color: _textMid, fontSize: 12.5, height: 1.4)),
          ),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.1)),
              ),
              child: Column(
                children: step.details.map((d) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 5, height: 5,
                      decoration: BoxDecoration(
                        color: color, shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: color.withOpacity(0.6), blurRadius: 4)],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Text(d, style: GoogleFonts.inter(
                      color: _textMid, fontSize: 13, height: 1.55))),
                  ]),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechStack() {
    final categories = [
      ('Vision & IA', [
        ('OpenCV', '4.9+', const Color(0xFF5c3ee8)),
        ('PyTorch', '2.2+', const Color(0xFFee4c2c)),
        ('Google Earth Engine', '0.3.3+', _blue),
        ('Kaggle', '0.1+', _teal),
      ]),
    ];

    return Column(
      children: categories.map((cat) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _border),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(cat.$1, style: GoogleFonts.sourceCodePro(
            color: _tealDim, fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: cat.$2.map((tech) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: tech.$3.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: tech.$3.withOpacity(0.25)),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  width: 7, height: 7,
                  decoration: BoxDecoration(
                    color: tech.$3, borderRadius: BorderRadius.circular(2),
                    boxShadow: [BoxShadow(color: tech.$3.withOpacity(0.5), blurRadius: 4)],
                  ),
                ),
                const SizedBox(width: 8),
                Text(tech.$1, style: GoogleFonts.sourceCodePro(
                  color: _textHi, fontSize: 11.5, fontWeight: FontWeight.w600)),
                const SizedBox(width: 6),
                Text(tech.$2, style: GoogleFonts.sourceCodePro(
                  color: _textLow, fontSize: 10)),
              ]),
            )).toList(),
          ),
        ]),
      )).toList(),
    );
  }

  Widget _buildDataFlow() {
    final rows = [
      ('Multispectral', '13 bands',  'Layer stacking',          Icons.web_rounded,    const Color(0xFF61dafb)),
      
      ('Pipeline', 'Python Agent',     'Traitement IA ', Icons.memory_rounded,  _red),
      ('Model',      'MST++',       'Endpoints ',          Icons.api_rounded,    _green),
      ('Output',   'Hyperspectral',      '31 bands',          Icons.layers_rounded, _amber),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border),
        boxShadow: [BoxShadow(color: _tealGlow, blurRadius: 16, spreadRadius: -4)],
      ),
      child: Column(
        children: rows.asMap().entries.map((e) {
          final isLast = e.key == rows.length - 1;
          final r = e.value;
          return Column(children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: r.$5.withOpacity(0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: r.$5.withOpacity(0.18)),
              ),
              child: Row(children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: r.$5.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: r.$5.withOpacity(0.3)),
                  ),
                  child: Icon(r.$4, color: r.$5, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Text(r.$1, style: GoogleFonts.rajdhani(
                      color: _textHi, fontSize: 15, fontWeight: FontWeight.w700)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: r.$5.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: r.$5.withOpacity(0.25)),
                      ),
                      child: Text(r.$2, style: GoogleFonts.sourceCodePro(
                        color: r.$5, fontSize: 9.5, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
                    ),
                  ]),
                  const SizedBox(height: 3),
                  Text(r.$3, style: GoogleFonts.inter(color: _textMid, fontSize: 12.5)),
                ])),
              ]),
            ),
            if (!isLast) Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Icon(Icons.arrow_downward_rounded, color: _textLow, size: 20),
            ),
          ]);
        }).toList(),
      ),
    );
  }

  Widget _dot(Color c) => AnimatedBuilder(
    animation: _pulseCtrl,
    builder: (_, __) => Container(
      width: 7, height: 7,
      decoration: BoxDecoration(
        shape: BoxShape.circle, color: c,
        boxShadow: [BoxShadow(color: c.withOpacity(0.5 + 0.3 * _pulseCtrl.value), blurRadius: 6)],
      ),
    ),
  );
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = const Color(0xFF0d1a22)..strokeWidth = 0.4;
    const step = 28.0;
    for (double x = 0; x < size.width; x += step) canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    for (double y = 0; y < size.height; y += step) canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
  }
  @override bool shouldRepaint(_) => false;
}