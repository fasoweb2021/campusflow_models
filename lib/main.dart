import 'package:flutter/material.dart';

import 'models/campus_deadline.dart';
import 'screens/deadline_detail_screen.dart';
import 'screens/deadline_form_screen.dart';
import 'screens/deadline_list_screen.dart';

void main() {
  runApp(const CampusFlowApp());
}

class CampusFlowApp extends StatelessWidget {
  const CampusFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFF28645A);

    return MaterialApp(
      title: 'CampusFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
        scaffoldBackgroundColor: const Color(0xFFF5F7F6),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF5F7F6),
          surfaceTintColor: Colors.transparent,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Color(0xFFE1E8E4)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFDCE4DF)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFDCE4DF)),
          ),
        ),
      ),
      home: const CampusFlowHomePage(),
    );
  }
}

class CampusFlowHomePage extends StatefulWidget {
  const CampusFlowHomePage({super.key});

  @override
  State<CampusFlowHomePage> createState() => _CampusFlowHomePageState();
}

class _CampusFlowHomePageState extends State<CampusFlowHomePage> {
  late List<CampusDeadline> _deadlines;
  int _selectedTab = 0;
  int? _selectedDeadlineId;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    _deadlines = [
      CampusDeadline(
        id: 1,
        title: 'Finaliser le projet Flutter',
        course: 'Développement mobile',
        description: 'Terminer les écrans de l’application et préparer une courte démonstration.',
        dueDate: DateTime(today.year, today.month, today.day + 2),
      ),
      CampusDeadline(
        id: 2,
        title: 'Rapport de veille technologique',
        course: 'Intelligence artificielle',
        description:
            'Présenter les tendances récentes et citer les sources utilisées.',
        dueDate: DateTime(today.year, today.month, today.day + 5),
      ),
      CampusDeadline(
        id: 3,
        title: 'Réviser les bases de données',
        course: 'Systèmes d’information',
        description: 'Réviser les jointures, les index et les transactions.',
        dueDate: DateTime(today.year, today.month, today.day + 8),
      ),
      CampusDeadline(
        id: 4,
        title: 'Exercices de conception',
        course: 'Génie logiciel',
        description: 'Exercices sur les diagrammes de séquence.',
        dueDate: DateTime(today.year, today.month, today.day - 1),
        isCompleted: true,
      ),
    ];
    _selectedDeadlineId = _deadlines.first.id;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 840;
        final visibleDeadlines = _visibleDeadlines;
        final selectedDeadline = _findDeadline(_selectedDeadlineId);

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 20,
            title: Row(
              children: [
                Icon(
                  Icons.school_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 10),
                const Text(
                  'CampusFlow',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedTab == 0 ? 'Bonjour 👋' : 'Bien joué !',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _selectedTab == 0
                          ? 'Gardez le rythme, une tâche à la fois.'
                          : 'Retrouvez ici vos échéances accomplies.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: isWide
                    ? _buildWideLayout(visibleDeadlines, selectedDeadline)
                    : DeadlineListScreen(
                        deadlines: visibleDeadlines,
                        selectedId: _selectedDeadlineId,
                        onSelected: _openDeadline,
                        isWide: false,
                        showCompleted: _selectedTab == 1,
                      ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: _createDeadline,
            icon: const Icon(Icons.add),
            label: const Text('Nouvelle échéance'),
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedTab,
            onDestinationSelected: _selectTab,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.event_note_outlined),
                selectedIcon: Icon(Icons.event_note),
                label: 'Échéances',
              ),
              NavigationDestination(
                icon: Icon(Icons.task_alt_outlined),
                selectedIcon: Icon(Icons.task_alt),
                label: 'Terminées',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWideLayout(
    List<CampusDeadline> visibleDeadlines,
    CampusDeadline? selectedDeadline,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 360,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                  child: Text(
                    _selectedTab == 0 ? 'À venir' : 'Terminées',
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  child: DeadlineListScreen(
                    deadlines: visibleDeadlines,
                    selectedId: _selectedDeadlineId,
                    onSelected: _openDeadline,
                    isWide: true,
                    showCompleted: _selectedTab == 1,
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(width: 32, indent: 12, endIndent: 12),
          Expanded(
            child:
                selectedDeadline == null ||
                    !visibleDeadlines.any(
                      (item) => item.id == selectedDeadline.id,
                    )
                ? const Center(
                    child: Text(
                      'Sélectionnez une échéance pour afficher son détail.',
                    ),
                  )
                : DeadlineDetailScreen(
                    key: ValueKey(selectedDeadline.id),
                    deadline: selectedDeadline,
                    onChanged: _updateDeadline,
                  ),
          ),
        ],
      ),
    );
  }

  List<CampusDeadline> get _visibleDeadlines {
    final deadlines =
        _deadlines
            .where((deadline) => deadline.isCompleted == (_selectedTab == 1))
            .toList()
          ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return deadlines;
  }

  CampusDeadline? _findDeadline(int? id) {
    for (final deadline in _deadlines) {
      if (deadline.id == id) return deadline;
    }
    return null;
  }

  void _selectTab(int index) {
    setState(() {
      _selectedTab = index;
      final visible =
          _deadlines
              .where((deadline) => deadline.isCompleted == (index == 1))
              .toList()
            ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
      _selectedDeadlineId = visible.isEmpty ? null : visible.first.id;
    });
  }

  void _openDeadline(CampusDeadline deadline) {
    setState(() => _selectedDeadlineId = deadline.id);
    if (MediaQuery.sizeOf(context).width >= 840) return;

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Détail')),
          body: DeadlineDetailScreen(
            deadline: deadline,
            onChanged: _updateDeadline,
          ),
        ),
      ),
    );
  }

  void _updateDeadline(CampusDeadline updated) {
    setState(() {
      final index = _deadlines.indexWhere(
        (deadline) => deadline.id == updated.id,
      );
      if (index != -1) _deadlines[index] = updated;
      if (updated.isCompleted && _selectedTab == 0) _selectedTab = 1;
    });
  }

  Future<void> _createDeadline() async {
    final deadline = await Navigator.of(context).push<CampusDeadline>(
      MaterialPageRoute<CampusDeadline>(
        builder: (context) => const DeadlineFormScreen(),
      ),
    );
    if (!mounted || deadline == null) return;

    setState(() {
      _deadlines.add(deadline);
      _selectedTab = 0;
      _selectedDeadlineId = deadline.id;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Nouvelle échéance ajoutée.')));
  }
}
