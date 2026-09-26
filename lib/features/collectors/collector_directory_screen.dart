import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../core/widgets/empty_state.dart';
import '../../data/repositories/collector_repository.dart';
import '../../data/repositories/waste_repository.dart';
import '../../shared/widgets/collector_card.dart';
import 'collector_profile_screen.dart';

/// Collector Discovery and Directory Screen
class CollectorDirectoryScreen extends StatelessWidget {
  final ValueChanged<int>? onTabChange;

  const CollectorDirectoryScreen({super.key, this.onTabChange});

  @override
  Widget build(BuildContext context) {
    final collectorRepo = context.watch<CollectorProvider>();
    final wasteRepo = context.read<WasteProvider>();

    final categories = [
      {'id': 'all', 'label': 'All Categories'},
      {'id': 'plastic', 'label': 'Plastic'},
      {'id': 'paper', 'label': 'Paper'},
      {'id': 'metal', 'label': 'Metal'},
      {'id': 'glass', 'label': 'Glass'},
      {'id': 'clothes', 'label': 'Clothes'},
      {'id': 'e-waste', 'label': 'E-Waste'},
    ];

    final sortOptions = [
      {'id': 'all', 'label': 'All'},
      {'id': 'available', 'label': 'Available Now'},
      {'id': 'rating', 'label': 'Highest Rating'},
      {'id': 'distance', 'label': 'Nearest First'},
    ];

    final list = collectorRepo.filteredCollectors;

    return Scaffold(
      backgroundColor: ReCycloColors.bgApp,
      appBar: AppBar(
        title: const Text('Verified Collectors'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Input
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Colors.white,
              child: TextField(
                onChanged: (val) => collectorRepo.setSearchQuery(val),
                decoration: InputDecoration(
                  hintText: 'Search by collector name, agency, or area...',
                  hintStyle: const TextStyle(fontSize: 13, color: ReCycloColors.textMuted),
                  prefixIcon: const Icon(Icons.search_rounded, color: ReCycloColors.textMuted, size: 20),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  filled: true,
                  fillColor: ReCycloColors.bgApp,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // Category Filter Carousel
            Container(
              color: Colors.white,
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final isSelected = collectorRepo.categoryFilter == cat['id'];

                  return ChoiceChip(
                    label: Text(cat['label']!),
                    selected: isSelected,
                    onSelected: (_) => collectorRepo.setCategoryFilter(cat['id']!),
                    selectedColor: ReCycloColors.primaryLight,
                    backgroundColor: ReCycloColors.bgApp,
                    labelStyle: TextStyle(
                      color: isSelected ? ReCycloColors.primaryActive : ReCycloColors.textSecondary,
                      fontSize: 11.5,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                    side: BorderSide(
                      color: isSelected ? ReCycloColors.primary : Colors.transparent,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                  );
                },
              ),
            ),

            // Sorting Filter Carousel
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(bottom: 8),
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: sortOptions.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final sort = sortOptions[index];
                  final isSelected = collectorRepo.availabilityFilter == sort['id'];

                  return GestureDetector(
                    onTap: () => collectorRepo.setAvailabilityFilter(sort['id']!),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected ? ReCycloColors.brandNavy : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? ReCycloColors.brandNavy : ReCycloColors.border,
                        ),
                      ),
                      child: Text(
                        sort['label']!,
                        style: TextStyle(
                          color: isSelected ? Colors.white : ReCycloColors.textSecondary,
                          fontSize: 11,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 1, color: ReCycloColors.divider),

            // Collector Cards List
            Expanded(
              child: list.isEmpty
                  ? EmptyState(
                      iconName: 'truck',
                      title: 'No Collectors Found',
                      description: 'No matching collectors found for this filter combination. Try clearing your filters.',
                      buttonText: 'Reset Filters',
                      onButtonPressed: () {
                        collectorRepo.setSearchQuery('');
                        collectorRepo.setCategoryFilter('all');
                        collectorRepo.setAvailabilityFilter('all');
                      },
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(20),
                      itemCount: list.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        final col = list[index];
                        return CollectorCard(
                          collector: col,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CollectorProfileScreen(collector: col),
                              ),
                            );
                          },
                          onMessage: () {
                            Navigator.of(context).pushNamed('/chat');
                          },
                          onCall: () {
                            Navigator.of(context).pushNamed(
                              '/call',
                              arguments: col,
                            );
                          },
                          onRequestPickup: () {
                            wasteRepo.setCollector(col);
                            onTabChange?.call(2);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
