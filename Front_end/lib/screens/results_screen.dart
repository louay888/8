import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late AnimationController _entryCtrl;
  late List<Animation<double>> _parallaxs;
  late List<Animation<Offset>> _slides;

  // ── Palette ──────────────────────────────────────────────
  static const _bg      = Color(0xFF060d12);
  static const _surface = Color(0xFF0d1a22);
  static const _teal    = Color(0xFF00e5d4);
  static const _tealDim = Color(0xFF00b3a4);
  static const _tealGlow= Color(0x2200e5d4);
  static const _red     = Color(0xFFff4d6d);
  static const _blue    = Color(0xFF3d9bff);
  static const _amber   = Color(0xFFf5a623);
  static const _purple  = Color(0xFFb57aff);
  static const _green   = Color(0xFF00e5a0);
  static const _textHi  = Color(0xFFe8f8f7);
  static const _textMid = Color(0xFF7ab8b3);
  static const _textLow = Color(0xFF3d6e6a);
  static const _border  = Color(0xFF162a32);

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..repeat(reverse: true);
    _entryCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1100));

    _parallaxs = List.generate(5, (i) {
      final s = (i * 0.15).clamp(0.0, 1.0);
      final e = (s + 0.45).clamp(0.0, 1.0);
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _entryCtrl, curve: Interval(s, e, curve: Curves.easeOut)),
      );
    });
    _slides = List.generate(5, (i) {
      final s = (i * 0.15).clamp(0.0, 1.0);
      final e = (s + 0.5).clamp(0.0, 1.0);
      return Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
        CurvedAnimation(parent: _entryCtrl, curve: Interval(s, e, curve: Curves.easeOutCubic)),
      );
    });

    Future.delayed(const Duration(milliseconds: 80), () => _entryCtrl.forward());
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _entryCtrl.dispose();
    super.dispose();
  }

  Widget _parallaxTransition({required Animation<double> opacity, required Widget child}) =>
    FadeTransition(opacity: opacity, child: child);

  Widget _animated(int i, Widget child) => _parallaxTransition(
    opacity: _parallaxs[i],
    child: SlideTransition(position: _slides[i], child: child),
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
                _animated(0, _buildSectionLabel('MÉTRIQUES DE PERFORMANCE', Icons.speed_rounded)),
                const SizedBox(height: 14),
                _animated(0, _buildMetricsGrid()),
                const SizedBox(height: 22),
                _animated(1, _buildSectionLabel('LIVRABLES', Icons.output_rounded)),
                const SizedBox(height: 14),
                _animated(1, _buildDeliverables()),
                const SizedBox(height: 22),
                _animated(2, _buildSectionLabel("DONNÉES D'ENTRAÎNEMENT", Icons.dataset_rounded)),
                const SizedBox(height: 14),
                _animated(2, _buildDatasetPanel()),
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
            top: -60, right: -40,
            child: AnimatedBuilder(
              animation: _pulseCtrl,
              builder: (_, __) => Container(
                width: 260, height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    _green.withOpacity(0.12 + 0.06 * _pulseCtrl.value),
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
                  _dot(_green),
                  const SizedBox(width: 8),
                  Text('SYS:RÉSULTATS  //  PERFORMANCES & LIVRABLES',
                    style: GoogleFonts.sourceCodePro(color: _tealDim, fontSize: 9.5, letterSpacing: 1.8, fontWeight: FontWeight.w600)),
                ]),
                const SizedBox(height: 10),
                Text('Résultats\nPrincipaux',
                  style: GoogleFonts.rajdhani(color: _textHi, fontSize: 34, fontWeight: FontWeight.w700, height: 1.05, letterSpacing: 0.5)),
              ],
            ),
          ),
          Positioned(bottom: 0, left: 0, right: 0,
            child: Container(height: 1, decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.transparent, _green.withOpacity(0.4), Colors.transparent]),
            ))),
        ]),
      ),
    );
  }

  Widget _buildSectionLabel(String label, IconData icon) {
    return Row(children: [
      Icon(icon, color: _teal, size: 15),
      const SizedBox(width: 8),
      Text(label, style: GoogleFonts.sourceCodePro(
        color: _tealDim, fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.w700)),
    ]);
  }

  Widget _buildMetricsGrid() {
    final metrics = [
      ('PSNR', '31.56', 'Peak Signal-to-Noise Ratio', _red),
      ('RMSE', '0.11', 'Root Mean Square Error', _blue),
      ('MRAE', '0.13', 'Mean Relative Absolute Error', _amber),
      ('LR.', '0.4', 'Learning Rate', _purple),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.15,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: metrics.length,
      itemBuilder: (_, i) {
        final m = metrics[i];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _border),
            boxShadow: [BoxShadow(color: m.$4.withOpacity(0.1), blurRadius: 14, spreadRadius: -4)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 24, height: 2, decoration: BoxDecoration(
                color: m.$4,
                boxShadow: [BoxShadow(color: m.$4.withOpacity(0.6), blurRadius: 5)],
              )),
              const SizedBox(height: 10),
              Text(m.$2, style: GoogleFonts.rajdhani(
                color: m.$4, fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
              const SizedBox(height: 2),
              Text(m.$1, style: GoogleFonts.sourceCodePro(
                color: _textHi, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
              const SizedBox(height: 2),
              Text(m.$3, style: GoogleFonts.inter(
                color: _textLow, fontSize: 10, fontWeight: FontWeight.w500)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDeliverables() {
    final outputs = [
      ('Multispectral',   '13 bands spectral image',    Icons.layers_rounded,   _blue),
      ('RGB', '3 bands visible light image', Icons.folder_rounded,   _green),
      ('Hyperspectral', '31 bands spectral image', Icons.map_rounded,      _amber),
      ('Model',   'MST++,Transformer',     Icons.web_rounded,      _red),
    ];

    return Column(
      children: outputs.map((item) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _border),
          boxShadow: [BoxShadow(color: item.$4.withOpacity(0.07), blurRadius: 10, spreadRadius: -4)],
        ),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: item.$4.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: item.$4.withOpacity(0.2)),
            ),
            child: Icon(item.$3, color: item.$4, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(item.$1, style: GoogleFonts.rajdhani(
              color: _textHi, fontSize: 15, fontWeight: FontWeight.w700)),
            const SizedBox(height: 3),
            Text(item.$2, style: GoogleFonts.inter(
              color: _textMid, fontSize: 12.5, fontWeight: FontWeight.w400)),
          ])),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: item.$4.withOpacity(0.08),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: item.$4.withOpacity(0.2)),
            ),
            child: Icon(Icons.check_rounded, color: item.$4, size: 14),
          ),
        ]),
      )).toList(),
    );
  }

  Widget _buildDatasetPanel() {
    final rows = [
      ('MS bands', '13'),
      ('Classes', '6  (background, contours, built, non_built, water, road_network)'),
      ('Source', 'Google Earth Engine (Sentinel-2)'),
      ('Échantillons', '1200'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border),
        boxShadow: [BoxShadow(color: _tealGlow, blurRadius: 18, spreadRadius: -4)],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _purple.withOpacity(0.25)),
            ),
            child: Icon(Icons.dataset_rounded, color: _purple, size: 18),
          ),
          const SizedBox(width: 12),
          Text('SEMAP Dataset', style: GoogleFonts.rajdhani(
            color: _textHi, fontSize: 17, fontWeight: FontWeight.w700, letterSpacing: 0.3)),
        ]),
        const SizedBox(height: 18),
        ...rows.asMap().entries.map((e) => Column(children: [
          if (e.key > 0) Container(height: 1, color: _border, margin: const EdgeInsets.symmetric(vertical: 12)),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              width: 88,
              child: Text(e.value.$1, style: GoogleFonts.sourceCodePro(
                color: _textLow, fontSize: 10, letterSpacing: 1.2, fontWeight: FontWeight.w600)),
            ),
            Expanded(child: Text(e.value.$2, style: GoogleFonts.inter(
              color: _textMid, fontSize: 13, fontWeight: FontWeight.w500))),
          ]),
        ])),
      ]),
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