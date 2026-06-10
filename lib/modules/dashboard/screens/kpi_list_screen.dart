import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/constants/app_strings.dart';
import '../../../shared/database/database.dart';
import '../providers/dashboard_providers.dart';
import '../widgets/add_kpi_log_sheet.dart';
import '../widgets/add_kpi_sheet.dart';
import '../widgets/edit_kpi_sheet.dart';
import '../widgets/kpi_tile.dart';

class KpiListScreen extends ConsumerWidget {
  const KpiListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kpisAsync = ref.watch(activeKpisProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.kpiList)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddSheet(context),
        icon: const Icon(Icons.add),
        label: const Text(AppStrings.addKpi),
      ),
      body: kpisAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (kpis) {
          if (kpis.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bar_chart_outlined,
                      size: 64,
                      color: Theme.of(context).colorScheme.outline),
                  const SizedBox(height: 16),
                  const Text(AppStrings.noKpis,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.noKpisHint,
                    style: TextStyle(
                        color:
                            Theme.of(context).colorScheme.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            itemCount: kpis.length,
            itemBuilder: (context, i) {
              final kpi = kpis[i];
              return _KpiTileWrapper(kpi: kpi);
            },
          );
        },
      ),
    );
  }

  void _showAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const AddKpiSheet(),
    );
  }
}

class _KpiTileWrapper extends ConsumerWidget {
  const _KpiTileWrapper({required this.kpi});

  final Kpi kpi;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestLogAsync = ref.watch(latestKpiLogProvider(kpi.id));
    final latestLog = latestLogAsync.valueOrNull;

    return KpiTile(
      kpi: kpi,
      latestLog: latestLog,
      onLog: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => AddKpiLogSheet(kpi: kpi),
      ),
      onEdit: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => EditKpiSheet(kpi: kpi),
      ),
      onArchive: () => _confirmArchive(context, ref),
    );
  }

  void _confirmArchive(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(AppStrings.confirmDeleteTitle),
        content: const Text(AppStrings.confirmDeleteBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () {
              ref.read(kpiNotifierProvider.notifier).archiveKpi(kpi.id);
              Navigator.of(context).pop();
            },
            child: Text(
              AppStrings.archive,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}
