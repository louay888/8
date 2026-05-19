import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project_data.dart';
import '../services/api_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  final ApiService _apiService = ApiService();

  late Future<List<dynamic>> _tasksFuture;
  late Future<List<dynamic>> _timelineFuture;
  late Future<List<dynamic>> _bibliographyFuture;
  late Future<List<dynamic>> _profilesFuture;

  late AnimationController _pulseCtrl;

  // ── Palette ──────────────────────────────────────────────
  static const _bg       = Color(0xFF060d12);
  static const _surface  = Color(0xFF0d1a22);
  static const _surfaceHi= Color(0xFF112230);
  static const _teal     = Color(0xFF00e5d4);
  static const _tealDim  = Color(0xFF00b3a4);
  static const _tealGlow = Color(0x2200e5d4);
  static const _green    = Color(0xFF00e5a0);
  static const _amber    = Color(0xFFf5a623);
  static const _red      = Color(0xFFff4d6d);
  static const _blue     = Color(0xFF3d9bff);
  static const _textHi   = Color(0xFFe8f8f7);
  static const _textMid  = Color(0xFF7ab8b3);
  static const _textLow  = Color(0xFF3d6e6a);
  static const _border   = Color(0xFF162a32);

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..repeat(reverse: true);
    _refreshAllData();
  }

  void _refreshAllData() {
    setState(() {
      _tasksFuture       = _apiService.fetchTasks();
      _timelineFuture    = _apiService.fetchTimeline();
      _bibliographyFuture= _apiService.fetchBibliography();
      _profilesFuture    = _apiService.fetchProfiles();
    });
  }

  Future<void> _launchURL(String urlString) async {
    if (urlString.isEmpty) return;
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Impossible d\'ouvrir : $urlString',
              style: GoogleFonts.sourceCodePro(color: _textHi, fontSize: 12)),
            backgroundColor: _surface,
          ),
        );
      }
    }
  }

  Color _getRefTypeColor(String? type) {
    switch (type) {
      case 'dataset':   return _blue;
      case 'article':   return const Color(0xFFb57aff);
      case 'framework': return _teal;
      default:          return _textLow;
    }
  }

  // ── Dialogs (styled) ─────────────────────────────────────
  void _showAddDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: _surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 36, height: 3, margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(color: _border, borderRadius: BorderRadius.circular(2))),
              _sheetTile(Icons.person_outline_rounded,   'Gérer le profil',     () async {
                Navigator.pop(context);
                final profiles = await _profilesFuture;
                if (profiles.isNotEmpty) _showEditProfileDialog(profiles.first);
                else _showCreateProfileDialog();
              }),
              _sheetTile(Icons.task_alt_rounded,         'Ajouter une tâche',   () { Navigator.pop(context); _showAddTaskDialog(); }),
              _sheetTile(Icons.timeline_rounded,         'Ajouter un jalon',    () { Navigator.pop(context); _showAddTimelineDialog(); }),
              _sheetTile(Icons.menu_book_rounded,        'Ajouter une référence',() { Navigator.pop(context); _showAddBibliographyDialog(); }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sheetTile(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _teal.withOpacity(0.08), borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _border),
        ),
        child: Icon(icon, color: _teal, size: 18),
      ),
      title: Text(label, style: GoogleFonts.rajdhani(
        color: _textHi, fontSize: 15, fontWeight: FontWeight.w600)),
      onTap: onTap,
    );
  }

  ThemeData get _dialogTheme => ThemeData.dark().copyWith(
    scaffoldBackgroundColor: _surface,
    dialogBackgroundColor: _surface,
    colorScheme: const ColorScheme.dark(
      primary: _teal, surface: _surface, onSurface: _textHi,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _bg,
      labelStyle: GoogleFonts.sourceCodePro(color: _textLow, fontSize: 11, letterSpacing: 1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: _border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: _border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: _teal),
      ),
    ),
  );

  void _showAddTaskDialog() {
    final titleCtrl = TextEditingController();
    final descCtrl  = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => Theme(data: _dialogTheme, child: AlertDialog(
        backgroundColor: _surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: _border)),
        title: Text('NOUVELLE TÂCHE', style: GoogleFonts.sourceCodePro(color: _tealDim, fontSize: 12, letterSpacing: 2)),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: titleCtrl, style: GoogleFonts.inter(color: _textHi),
            decoration: const InputDecoration(labelText: 'Titre')),
          const SizedBox(height: 12),
          TextField(controller: descCtrl, style: GoogleFonts.inter(color: _textHi),
            decoration: const InputDecoration(labelText: 'Description')),
        ]),
        actions: [
          _dialogBtn('ANNULER', () => Navigator.pop(context), outlined: true),
          _dialogBtn('AJOUTER', () async {
            if (titleCtrl.text.isNotEmpty) {
              final ok = await _apiService.createNewTask(titleCtrl.text, descCtrl.text);
              if (ok) { _refreshAllData(); if (mounted) Navigator.pop(context); }
            }
          }),
        ],
      )),
    );
  }

  void _showAddTimelineDialog() {
    final titleCtrl    = TextEditingController();
    final dateCtrl     = TextEditingController();
    final detailsCtrl  = TextEditingController();
    double progress    = 0;
    showDialog(
      context: context,
      builder: (_) => Theme(data: _dialogTheme, child: StatefulBuilder(
        builder: (ctx, setS) => AlertDialog(
          backgroundColor: _surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: _border)),
          title: Text('NOUVEAU JALON', style: GoogleFonts.sourceCodePro(color: _tealDim, fontSize: 12, letterSpacing: 2)),
          content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(controller: titleCtrl, style: GoogleFonts.inter(color: _textHi),
              decoration: const InputDecoration(labelText: 'Titre')),
            const SizedBox(height: 12),
            TextField(controller: dateCtrl, style: GoogleFonts.inter(color: _textHi),
              decoration: const InputDecoration(labelText: 'Période (ex: Oct 2025)')),
            const SizedBox(height: 12),
            TextField(controller: detailsCtrl, style: GoogleFonts.inter(color: _textHi),
              decoration: const InputDecoration(labelText: 'Détails')),
            const SizedBox(height: 16),
            Row(children: [
              Text('${progress.toInt()}%', style: GoogleFonts.sourceCodePro(color: _teal, fontSize: 13, fontWeight: FontWeight.w700)),
              Expanded(child: Slider(
                value: progress, min: 0, max: 100, divisions: 10,
                activeColor: _teal, inactiveColor: _border,
                onChanged: (v) => setS(() => progress = v),
              )),
            ]),
          ])),
          actions: [
            _dialogBtn('ANNULER', () => Navigator.pop(context), outlined: true),
            _dialogBtn('AJOUTER', () async {
              if (titleCtrl.text.isNotEmpty) {
                final ok = await _apiService.createTimelineEvent({
                  'title': titleCtrl.text, 'date_range': dateCtrl.text,
                  'achievement_details': detailsCtrl.text, 'progress_percentage': progress.toInt(),
                });
                if (ok) { _refreshAllData(); if (mounted) Navigator.pop(context); }
              }
            }),
          ],
        ),
      )),
    );
  }

  void _showAddBibliographyDialog() {
    final titleCtrl   = TextEditingController();
    final authorsCtrl = TextEditingController();
    final sourceCtrl  = TextEditingController();
    final urlCtrl     = TextEditingController();
    String refType    = 'article';
    showDialog(
      context: context,
      builder: (_) => Theme(data: _dialogTheme, child: StatefulBuilder(
        builder: (ctx, setS) => AlertDialog(
          backgroundColor: _surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: _border)),
          title: Text('NOUVELLE RÉFÉRENCE', style: GoogleFonts.sourceCodePro(color: _tealDim, fontSize: 12, letterSpacing: 2)),
          content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
            DropdownButtonFormField<String>(
              value: refType,
              dropdownColor: _surface,
              style: GoogleFonts.inter(color: _textHi),
              items: ['article', 'dataset', 'framework']
                .map((t) => DropdownMenuItem(value: t, child: Text(t.toUpperCase())))
                .toList(),
              onChanged: (v) => setS(() => refType = v!),
              decoration: const InputDecoration(labelText: 'Type'),
            ),
            const SizedBox(height: 12),
            TextField(controller: titleCtrl,   style: GoogleFonts.inter(color: _textHi), decoration: const InputDecoration(labelText: 'Titre')),
            const SizedBox(height: 12),
            TextField(controller: authorsCtrl, style: GoogleFonts.inter(color: _textHi), decoration: const InputDecoration(labelText: 'Auteurs')),
            const SizedBox(height: 12),
            TextField(controller: sourceCtrl,  style: GoogleFonts.inter(color: _textHi), decoration: const InputDecoration(labelText: 'Source')),
            const SizedBox(height: 12),
            TextField(controller: urlCtrl,     style: GoogleFonts.inter(color: _textHi), decoration: const InputDecoration(labelText: 'URL')),
          ])),
          actions: [
            _dialogBtn('ANNULER', () => Navigator.pop(context), outlined: true),
            _dialogBtn('AJOUTER', () async {
              if (titleCtrl.text.isNotEmpty) {
                final ok = await _apiService.createBibliographyEntry({
                  'title': titleCtrl.text, 'authors': authorsCtrl.text,
                  'source_info': sourceCtrl.text, 'url': urlCtrl.text, 'ref_type': refType,
                });
                if (ok) { _refreshAllData(); if (mounted) Navigator.pop(context); }
              }
            }),
          ],
        ),
      )),
    );
  }

  void _showCreateProfileDialog() {
    final nameCtrl       = TextEditingController(text: userCardInfo.name);
    final emailCtrl      = TextEditingController(text: projectInfo.email);
    final supervisorCtrl = TextEditingController(text: projectInfo.supervisor);
    final descCtrl       = TextEditingController(text: projectInfo.description);
    final roleCtrl       = TextEditingController(text: userCardInfo.role);
    showDialog(
      context: context,
      builder: (_) => Theme(data: _dialogTheme, child: AlertDialog(
        backgroundColor: _surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: _border)),
        title: Text('CRÉER UN PROFIL', style: GoogleFonts.sourceCodePro(color: _tealDim, fontSize: 12, letterSpacing: 2)),
        content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: nameCtrl,       style: GoogleFonts.inter(color: _textHi), decoration: const InputDecoration(labelText: 'Nom complet')),
          const SizedBox(height: 12),
          TextField(controller: emailCtrl,      style: GoogleFonts.inter(color: _textHi), decoration: const InputDecoration(labelText: 'Email')),
          const SizedBox(height: 12),
          TextField(controller: supervisorCtrl, style: GoogleFonts.inter(color: _textHi), decoration: const InputDecoration(labelText: 'Encadrant')),
          const SizedBox(height: 12),
          TextField(controller: descCtrl,       style: GoogleFonts.inter(color: _textHi), maxLines: 3, decoration: const InputDecoration(labelText: 'Description')),
          const SizedBox(height: 12),
          TextField(controller: roleCtrl,       style: GoogleFonts.inter(color: _textHi), decoration: const InputDecoration(labelText: 'Rôle')),
        ])),
        actions: [
          _dialogBtn('ANNULER', () => Navigator.pop(context), outlined: true),
          _dialogBtn('CRÉER', () async {
            final ok = await _apiService.createProfile({
              'full_name': nameCtrl.text, 'email': emailCtrl.text,
              'supervisor': supervisorCtrl.text, 'project_description': descCtrl.text, 'role': roleCtrl.text,
            });
            if (ok) { _refreshAllData(); if (mounted) Navigator.pop(context); }
          }),
        ],
      )),
    );
  }

  void _showEditProfileDialog(Map<String, dynamic> profile) {
    final nameCtrl       = TextEditingController(text: profile['full_name']);
    final emailCtrl      = TextEditingController(text: profile['email'] ?? '');
    final supervisorCtrl = TextEditingController(text: profile['supervisor'] ?? '');
    final descCtrl       = TextEditingController(text: profile['project_description'] ?? '');
    final roleCtrl       = TextEditingController(text: profile['role'] ?? '');
    showDialog(
      context: context,
      builder: (_) => Theme(data: _dialogTheme, child: AlertDialog(
        backgroundColor: _surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: _border)),
        title: Text('MODIFIER LE PROFIL', style: GoogleFonts.sourceCodePro(color: _tealDim, fontSize: 12, letterSpacing: 2)),
        content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: nameCtrl,       style: GoogleFonts.inter(color: _textHi), decoration: const InputDecoration(labelText: 'Nom complet')),
          const SizedBox(height: 12),
          TextField(controller: emailCtrl,      style: GoogleFonts.inter(color: _textHi), decoration: const InputDecoration(labelText: 'Email')),
          const SizedBox(height: 12),
          TextField(controller: supervisorCtrl, style: GoogleFonts.inter(color: _textHi), decoration: const InputDecoration(labelText: 'Encadrant')),
          const SizedBox(height: 12),
          TextField(controller: descCtrl,       style: GoogleFonts.inter(color: _textHi), maxLines: 3, decoration: const InputDecoration(labelText: 'Description')),
          const SizedBox(height: 12),
          TextField(controller: roleCtrl,       style: GoogleFonts.inter(color: _textHi), decoration: const InputDecoration(labelText: 'Rôle')),
        ])),
        actions: [
          _dialogBtn('ANNULER', () => Navigator.pop(context), outlined: true),
          _dialogBtn('ENREGISTRER', () async {
            final ok = await _apiService.updateUserProfile(profile['id'], {
              'full_name': nameCtrl.text, 'email': emailCtrl.text,
              'supervisor': supervisorCtrl.text, 'project_description': descCtrl.text, 'role': roleCtrl.text,
            });
            if (ok) { _refreshAllData(); if (mounted) Navigator.pop(context); }
          }),
        ],
      )),
    );
  }

  Widget _dialogBtn(String label, VoidCallback onTap, {bool outlined = false}) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: outlined ? _textLow : _bg,
        backgroundColor: outlined ? Colors.transparent : _teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: outlined ? const BorderSide(color: _border) : BorderSide.none,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      child: Text(label, style: GoogleFonts.sourceCodePro(
        fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1.5)),
    );
  }

  // ── BUILD ─────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: RefreshIndicator(
        color: _teal,
        backgroundColor: _surface,
        onRefresh: () async => _refreshAllData(),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildAppBar(),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 40),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildDynamicUserCard(),
                  const SizedBox(height: 22),
                  _sectionLabel('CHRONOLOGIE DU PROJET', Icons.timeline_rounded),
                  const SizedBox(height: 14),
                  _buildDynamicTimelineBlock(),
                  const SizedBox(height: 22),
                  _sectionLabel('GESTION DES TÂCHES', Icons.task_alt_rounded),
                  const SizedBox(height: 14),
                  _buildDynamicTasksTable(),
                  const SizedBox(height: 22),
                  _sectionLabel('BIBLIOGRAPHIE & RÉFÉRENCES', Icons.menu_book_rounded),
                  const SizedBox(height: 14),
                  _buildDynamicBibliographyBlock(),
                ]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 175,
      backgroundColor: _bg,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh_rounded, color: _teal, size: 20),
          onPressed: _refreshAllData,
        ),
        const SizedBox(width: 4),
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Stack(fit: StackFit.expand, children: [
          CustomPaint(painter: _GridPainter()),
          Positioned(
            top: -60, right: -40,
            child: AnimatedBuilder(
              animation: _pulseCtrl,
              builder: (_, __) => Container(
                width: 280, height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    _amber.withOpacity(0.10 + 0.05 * _pulseCtrl.value),
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
                  _dot(_amber),
                  const SizedBox(width: 8),
                  Text('SYS:DASHBOARD  //  TÂCHES · TIMELINE · BIBLIO',
                    style: GoogleFonts.sourceCodePro(color: _tealDim, fontSize: 9.5, letterSpacing: 1.8, fontWeight: FontWeight.w600)),
                ]),
                const SizedBox(height: 10),
                Text('Dashboard', style: GoogleFonts.rajdhani(
                  color: _textHi, fontSize: 34, fontWeight: FontWeight.w700, height: 1.05, letterSpacing: 0.5)),
              ],
            ),
          ),
          Positioned(bottom: 0, left: 0, right: 0,
            child: Container(height: 1, decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.transparent, _amber.withOpacity(0.4), Colors.transparent]),
            ))),
        ]),
      ),
    );
  }

  Widget _buildFAB() {
    return AnimatedBuilder(
      animation: _pulseCtrl,
      builder: (_, __) => FloatingActionButton(
        backgroundColor: _teal,
        onPressed: _showAddDialog,
        elevation: 0,
        child: Container(
          width: 56, height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(
              color: _teal.withOpacity(0.3 + 0.2 * _pulseCtrl.value),
              blurRadius: 16, spreadRadius: -2,
            )],
          ),
          child: const Icon(Icons.add_rounded, color: Color(0xFF060d12), size: 26),
        ),
      ),
    );
  }

  Widget _sectionLabel(String label, IconData icon) => Row(children: [
    Icon(icon, color: _teal, size: 15),
    const SizedBox(width: 8),
    Text(label, style: GoogleFonts.sourceCodePro(
      color: _tealDim, fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.w700)),
  ]);

  // ── User Card ────────────────────────────────────────────
  Widget _buildDynamicUserCard() {
    return FutureBuilder<List<dynamic>>(
      future: _profilesFuture,
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) return _loadingBox();
        final profile = (snap.hasData && snap.data!.isNotEmpty) ? snap.data!.first : null;
        return GestureDetector(
          onTap: () => profile != null ? _showEditProfileDialog(profile) : _showCreateProfileDialog(),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight,
                colors: [Color(0xFF0d1a22), Color(0xFF112230)],
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: _teal.withOpacity(0.25)),
              boxShadow: [BoxShadow(color: _tealGlow, blurRadius: 20, spreadRadius: -4)],
            ),
            child: Row(children: [
              Container(
                width: 60, height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _teal.withOpacity(0.1),
                  border: Border.all(color: _teal.withOpacity(0.3), width: 2),
                ),
                child: Center(child: Text(
                  profile != null ? '👤' : userCardInfo.avatar,
                  style: const TextStyle(fontSize: 28),
                )),
              ),
              const SizedBox(width: 16),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(profile?['full_name'] ?? userCardInfo.name,
                  style: GoogleFonts.rajdhani(color: _textHi, fontSize: 17, fontWeight: FontWeight.w700)),
                const SizedBox(height: 3),
                Text(profile?['role'] ?? userCardInfo.role,
                  style: GoogleFonts.inter(color: _textMid, fontSize: 12.5)),
                if ((profile?['email'] ?? '').isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(profile!['email'], style: GoogleFonts.sourceCodePro(color: _textLow, fontSize: 10, letterSpacing: 0.5)),
                ],
                const SizedBox(height: 6),
                Text('Encadrant: ${profile?['supervisor'] ?? projectInfo.supervisor}',
                  style: GoogleFonts.inter(color: _textLow, fontSize: 11)),
              ])),
              Icon(Icons.edit_rounded, color: _teal.withOpacity(0.5), size: 18),
            ]),
          ),
        );
      },
    );
  }

  // ── Timeline ─────────────────────────────────────────────
  Widget _buildDynamicTimelineBlock() {
    return FutureBuilder<List<dynamic>>(
      future: _timelineFuture,
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) return _loadingBox();
        if (snap.hasError || !snap.hasData || snap.data!.isEmpty) {
          return _emptyBox('Aucun jalon disponible.');
        }
        final data = snap.data!;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _surface, borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _border),
          ),
          child: Column(
            children: List.generate(data.length, (i) {
              final m = data[i];
              final isLast = i == data.length - 1;
              final done = m['progress_percentage'] == 100;
              return IntrinsicHeight(
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Column(children: [
                    Container(
                      width: 12, height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: done ? _teal : _surface,
                        border: Border.all(color: done ? _teal : _border, width: 2),
                        boxShadow: done ? [BoxShadow(color: _teal.withOpacity(0.5), blurRadius: 6)] : null,
                      ),
                    ),
                    if (!isLast) Expanded(child: Container(
                      width: 2,
                      color: done ? _teal.withOpacity(0.25) : _border,
                    )),
                  ]),
                  const SizedBox(width: 14),
                  Expanded(child: Container(
                    margin: const EdgeInsets.only(bottom: 18),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(m['date_range'] ?? '', style: GoogleFonts.sourceCodePro(
                          color: _textLow, fontSize: 10, letterSpacing: 1.2)),
                        if (done) Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: _teal.withOpacity(0.1), borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: _teal.withOpacity(0.3)),
                          ),
                          child: Text('✓ DONE', style: GoogleFonts.sourceCodePro(
                            color: _teal, fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 1)),
                        ),
                      ]),
                      const SizedBox(height: 4),
                      Text(m['title'] ?? '', style: GoogleFonts.rajdhani(
                        color: _textHi, fontSize: 15, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      Text(m['achievement_details'] ?? '', style: GoogleFonts.inter(
                        color: _textMid, fontSize: 12.5, height: 1.5)),
                    ]),
                  )),
                ]),
              );
            }),
          ),
        );
      },
    );
  }

  // ── Tasks Table ──────────────────────────────────────────
  Widget _buildDynamicTasksTable() {
    return FutureBuilder<List<dynamic>>(
      future: _tasksFuture,
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) return _loadingBox();
        if (snap.hasError || !snap.hasData || snap.data!.isEmpty) {
          return _emptyBox('Aucune tâche disponible.');
        }
        final tasks = snap.data!;
        return Container(
          decoration: BoxDecoration(
            color: _surface, borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _border),
          ),
          child: Column(children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: _bg,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                border: Border(bottom: BorderSide(color: _border)),
              ),
              child: Row(children: [
                Expanded(flex: 4, child: Text('TÂCHE', style: GoogleFonts.sourceCodePro(
                  color: _textLow, fontSize: 9.5, letterSpacing: 1.5, fontWeight: FontWeight.w700))),
                Expanded(flex: 3, child: Text('DESCRIPTION', style: GoogleFonts.sourceCodePro(
                  color: _textLow, fontSize: 9.5, letterSpacing: 1.5, fontWeight: FontWeight.w700))),
                Expanded(flex: 2, child: Text('STATUT', textAlign: TextAlign.center, style: GoogleFonts.sourceCodePro(
                  color: _textLow, fontSize: 9.5, letterSpacing: 1.5, fontWeight: FontWeight.w700))),
              ]),
            ),
            ...tasks.map((task) {
              final isLast = task == tasks.last;
              final done = task['status'] == 'completed';
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  border: isLast ? null : Border(bottom: BorderSide(color: _border.withOpacity(0.5))),
                ),
                child: Row(children: [
                  Expanded(flex: 4, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(task['title'] ?? '', style: GoogleFonts.inter(
                      color: _textHi, fontSize: 13, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: LinearProgressIndicator(
                        value: done ? 1.0 : 0.4, minHeight: 3,
                        backgroundColor: _border,
                        valueColor: AlwaysStoppedAnimation(done ? _teal : _amber),
                      ),
                    ),
                  ])),
                  Expanded(flex: 3, child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(task['description'] ?? '', maxLines: 2, overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(color: _textMid, fontSize: 12)),
                  )),
                  Expanded(flex: 2, child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: done ? _teal.withOpacity(0.1) : _amber.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: done ? _teal.withOpacity(0.3) : _amber.withOpacity(0.3)),
                    ),
                    child: Text(
                      task['status'].toString().toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sourceCodePro(
                        color: done ? _teal : _amber, fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 1),
                    ),
                  )),
                ]),
              );
            }).toList(),
          ]),
        );
      },
    );
  }

  // ── Bibliography ─────────────────────────────────────────
  Widget _buildDynamicBibliographyBlock() {
    return FutureBuilder<List<dynamic>>(
      future: _bibliographyFuture,
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) return _loadingBox();
        if (snap.hasError || !snap.hasData || snap.data!.isEmpty) {
          return _emptyBox('Aucune référence disponible.');
        }
        final refs = snap.data!;
        return Column(
          children: refs.map((ref) {
            final typeColor = _getRefTypeColor(ref['ref_type']);
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _surface, borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _border),
                boxShadow: [BoxShadow(color: typeColor.withOpacity(0.06), blurRadius: 10, spreadRadius: -4)],
              ),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Column(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: typeColor.withOpacity(0.1), borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: typeColor.withOpacity(0.3)),
                    ),
                    child: Text((ref['ref_type'] ?? '').toString().toUpperCase(),
                      style: GoogleFonts.sourceCodePro(
                        color: typeColor, fontSize: 8.5, fontWeight: FontWeight.w700, letterSpacing: 1)),
                  ),
                ]),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(ref['title'] ?? '', style: GoogleFonts.rajdhani(
                    color: _textHi, fontSize: 14, fontWeight: FontWeight.w700)),
                  if ((ref['authors'] ?? '').toString().isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Text(ref['authors'], style: GoogleFonts.inter(
                      color: _textMid, fontSize: 11.5, fontStyle: FontStyle.italic)),
                  ],
                  const SizedBox(height: 3),
                  Text(ref['source_info'] ?? '', style: GoogleFonts.sourceCodePro(
                    color: _textLow, fontSize: 10, letterSpacing: 0.5)),
                ])),
                if ((ref['url'] ?? '').toString().isNotEmpty)
                  IconButton(
                    icon: Icon(Icons.open_in_new_rounded, color: _teal, size: 18),
                    onPressed: () => _launchURL(ref['url']),
                    padding: EdgeInsets.zero, constraints: const BoxConstraints(),
                  ),
              ]),
            );
          }).toList(),
        );
      },
    );
  }

  // ── Shared helpers ────────────────────────────────────────
  Widget _loadingBox() => Container(
    height: 80, alignment: Alignment.center,
    decoration: BoxDecoration(color: _surface, borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _border)),
    child: const SizedBox(width: 20, height: 20,
      child: CircularProgressIndicator(color: _teal, strokeWidth: 2)),
  );

  Widget _emptyBox(String msg) => Container(
    padding: const EdgeInsets.all(20), alignment: Alignment.center,
    decoration: BoxDecoration(color: _surface, borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _border)),
    child: Text(msg, style: GoogleFonts.sourceCodePro(color: _textLow, fontSize: 11, letterSpacing: 0.5)),
  );

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

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }
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