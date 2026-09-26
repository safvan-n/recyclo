import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/custom_buttons.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/widgets/recyclo_icons.dart';
import '../../core/widgets/status_badge.dart';
import '../../data/repositories/waste_repository.dart';
import '../../data/repositories/collector_repository.dart';
import '../../data/repositories/request_repository.dart';
import 'request_confirmed_screen.dart';

/// 5-Step Multi-Stage Add Waste Submission Flow
class AddWasteScreen extends StatefulWidget {
  const AddWasteScreen({super.key});

  @override
  State<AddWasteScreen> createState() => _AddWasteScreenState();
}

class _AddWasteScreenState extends State<AddWasteScreen> {
  final _quantityController = TextEditingController(text: '5.0');
  final _descController = TextEditingController(text: 'Clean sorted recyclables in cardboard box');
  final _addressController = TextEditingController(text: '402 Oakwood Heights, Green Glen Layout, Bengaluru');

  final List<String> _timeSlots = ['09:00 AM', '11:00 AM', '02:00 PM', '04:00 PM'];
  final List<String> _dateOptions = ['Today', 'Tomorrow', 'Day After'];

  @override
  void dispose() {
    _quantityController.dispose();
    _descController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _nextStep(WasteProvider provider) {
    if (provider.draft.currentStep < 5) {
      provider.setStep(provider.draft.currentStep + 1);
    }
  }

  void _prevStep(WasteProvider provider) {
    if (provider.draft.currentStep > 1) {
      provider.setStep(provider.draft.currentStep - 1);
    }
  }

  void _submitBooking(BuildContext context, WasteProvider waste, RequestProvider requestRepo) {
    final draft = waste.draft;
    final collector = draft.selectedCollector ?? context.read<CollectorProvider>().allCollectors.first;
    final category = draft.category ?? waste.categories.first;
    final quantity = double.tryParse(_quantityController.text) ?? 5.0;

    requestRepo.createRequest(
      collector: collector,
      category: category,
      quantity: quantity,
      unit: draft.unit,
      pickupAddress: _addressController.text,
      pickupDate: draft.pickupDate,
      pickupTime: draft.pickupTime,
      paymentMethod: draft.paymentMethod,
      estimatedAmount: '₹${(quantity * category.rateValue).toStringAsFixed(2)}',
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => RequestConfirmedScreen(
          collector: collector,
          category: category,
          quantity: '$quantity ${draft.unit}',
          date: draft.pickupDate,
          time: draft.pickupTime,
          address: _addressController.text,
          paymentMethod: draft.paymentMethod,
          estimatedAmount: '₹${(quantity * category.rateValue).toStringAsFixed(2)}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final waste = context.watch<WasteProvider>();
    final collectorRepo = context.watch<CollectorProvider>();
    final requestRepo = context.watch<RequestProvider>();
    final currentStep = waste.draft.currentStep;

    return Scaffold(
      backgroundColor: ReCycloColors.bgApp,
      appBar: AppBar(
        title: Text(_getStepTitle(currentStep)),
        leading: currentStep > 1
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                onPressed: () => _prevStep(waste),
              )
            : null,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: ReCycloColors.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Step $currentStep / 5',
                  style: ReCycloTypography.labelSmall.copyWith(
                    color: ReCycloColors.primaryActive,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Linear Progress Bar
            LinearProgressIndicator(
              value: currentStep / 5.0,
              backgroundColor: ReCycloColors.border,
              valueColor: const AlwaysStoppedAnimation<Color>(ReCycloColors.primary),
              minHeight: 3.5,
            ),

            // Step Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: _buildCurrentStepView(currentStep, waste, collectorRepo),
              ),
            ),

            // Bottom CTA Navigation Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: ReCycloColors.border)),
              ),
              child: Row(
                children: [
                  if (currentStep > 1) ...[
                    SecondaryButton(
                      text: 'Back',
                      width: 90,
                      isOutlined: true,
                      onPressed: () => _prevStep(waste),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: PrimaryButton(
                      text: currentStep == 5 ? 'Confirm Pickup Request' : 'Continue',
                      onPressed: () {
                        if (currentStep == 2) {
                          // Validate details
                          final q = double.tryParse(_quantityController.text);
                          if (q == null || q <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter a valid quantity.'),
                                backgroundColor: ReCycloColors.danger,
                              ),
                            );
                            return;
                          }
                          waste.setDetails(
                            quantity: q,
                            unit: waste.draft.unit,
                            description: _descController.text,
                            address: _addressController.text,
                          );
                        }

                        if (currentStep < 5) {
                          _nextStep(waste);
                        } else {
                          _submitBooking(context, waste, requestRepo);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getStepTitle(int step) {
    switch (step) {
      case 1:
        return '1. Waste Photo';
      case 2:
        return '2. Waste Details';
      case 3:
        return '3. Select Collector';
      case 4:
        return '4. Schedule Pickup';
      case 5:
        return '5. Payment & Review';
      default:
        return 'Add Waste';
    }
  }

  Widget _buildCurrentStepView(int step, WasteProvider waste, CollectorProvider collectorRepo) {
    switch (step) {
      case 1:
        return _buildStep1Photo(waste);
      case 2:
        return _buildStep2Details(waste);
      case 3:
        return _buildStep3Collector(waste, collectorRepo);
      case 4:
        return _buildStep4Schedule(waste);
      case 5:
        return _buildStep5Payment(waste);
      default:
        return const SizedBox();
    }
  }

  // ---------- STEP 1: PHOTO ----------
  Widget _buildStep1Photo(WasteProvider waste) {
    final photo = waste.draft.photoPath;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Capture or Upload Waste Photo',
          style: ReCycloTypography.headingMedium.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text(
          'A clear photo helps collectors estimate quantity and arrive with appropriate collection sacks.',
          style: ReCycloTypography.bodyMedium,
        ),
        const SizedBox(height: 20),

        // Photo Preview Card
        Container(
          width: double.infinity,
          height: 230,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: photo != null ? ReCycloColors.primary : ReCycloColors.border,
              width: photo != null ? 2.0 : 1.2,
            ),
          ),
          child: photo != null
              ? Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        photo,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Center(
                          child: Icon(Icons.recycling, size: 64, color: ReCycloColors.primary),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Row(
                        children: [
                          IconButton.filled(
                            onPressed: () => waste.setPhoto(null),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: ReCycloColors.danger,
                            ),
                            icon: const Icon(Icons.delete_outline_rounded, size: 20),
                            tooltip: 'Remove',
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: ReCycloColors.primaryLight,
                          shape: BoxShape.circle,
                        ),
                        child: const ReCycloIcon('camera', size: 36, color: ReCycloColors.primaryActive),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No photo selected yet',
                        style: ReCycloTypography.titleMedium.copyWith(
                          color: ReCycloColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Take a photo or choose from sample gallery below',
                        style: ReCycloTypography.bodySmall,
                      ),
                    ],
                  ),
                ),
        ),
        const SizedBox(height: 16),

        // Photo action buttons
        Row(
          children: [
            Expanded(
              child: SecondaryButton(
                text: 'Take Photo',
                icon: const ReCycloIcon('camera', size: 18, color: ReCycloColors.primaryActive),
                onPressed: () {
                  waste.setPhoto(
                    'https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=500&auto=format&fit=crop&q=80',
                    suggestedType: 'Plastic Bottles & PET (Suggested)',
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SecondaryButton(
                text: 'Upload Gallery',
                icon: const ReCycloIcon('gallery', size: 18, color: ReCycloColors.primaryActive),
                isOutlined: true,
                onPressed: () {
                  waste.setPhoto(
                    'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=500&auto=format&fit=crop&q=80',
                    suggestedType: 'Cardboard & Paper Scrap (Suggested)',
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // AI / Suggested classification banner
        if (photo != null) ...[
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: ReCycloColors.primarySurface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: ReCycloColors.primaryLight),
            ),
            child: Row(
              children: [
                const ReCycloIcon('plastic', size: 22, color: ReCycloColors.primaryActive, active: true),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Suggested waste type:',
                        style: ReCycloTypography.bodySmall.copyWith(fontSize: 11),
                      ),
                      Text(
                        waste.draft.suggestedType ?? 'Plastic Bottles & Containers',
                        style: ReCycloTypography.labelLarge.copyWith(
                          color: ReCycloColors.primaryActive,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Change in Step 2',
                  style: ReCycloTypography.bodySmall.copyWith(
                    color: ReCycloColors.textMuted,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  // ---------- STEP 2: DETAILS ----------
  Widget _buildStep2Details(WasteProvider waste) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Category',
          style: ReCycloTypography.headingMedium.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text(
          'Choose the primary waste type for this collection.',
          style: ReCycloTypography.bodyMedium,
        ),
        const SizedBox(height: 14),

        // Categories Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.95,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: waste.categories.length,
          itemBuilder: (context, index) {
            final cat = waste.categories[index];
            final isSelected = waste.draft.category?.id == cat.id;

            return InkWell(
              onTap: () => waste.setCategory(cat),
              borderRadius: BorderRadius.circular(14),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected ? ReCycloColors.primaryLight : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected ? ReCycloColors.primary : ReCycloColors.border,
                    width: isSelected ? 2.0 : 1.0,
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReCycloIcon(
                      cat.icon,
                      size: 26,
                      color: isSelected ? ReCycloColors.primary : ReCycloColors.textSecondary,
                      active: isSelected,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      cat.name,
                      textAlign: TextAlign.center,
                      style: ReCycloTypography.labelSmall.copyWith(
                        fontSize: 11,
                        color: isSelected ? ReCycloColors.primaryActive : ReCycloColors.textPrimary,
                        fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      cat.avgRate,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 9.5,
                        color: isSelected ? ReCycloColors.primaryActive : ReCycloColors.textMuted,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 22),

        // Quantity & Unit
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: CustomTextField(
                controller: _quantityController,
                label: 'Approximate Quantity',
                hint: 'e.g. 5.0',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                prefixIcon: const Icon(Icons.scale_rounded, size: 20, color: ReCycloColors.textMuted),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Unit', style: ReCycloTypography.labelLarge),
                  const SizedBox(height: 8),
                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: ReCycloColors.border),
                    ),
                    child: Row(
                      children: [
                        _buildUnitOption('kg', waste),
                        _buildUnitOption('pcs', waste),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Description
        CustomTextField(
          controller: _descController,
          label: 'Notes / Description (Optional)',
          hint: 'e.g. Broken glass separated, packed in bags',
          maxLines: 2,
        ),
        const SizedBox(height: 16),

        // Pickup Location
        CustomTextField(
          controller: _addressController,
          label: 'Pickup Address',
          hint: 'Enter your doorstep address',
          prefixIcon: const Icon(Icons.location_on_outlined, size: 20, color: ReCycloColors.textMuted),
        ),
      ],
    );
  }

  Widget _buildUnitOption(String unit, WasteProvider waste) {
    final isSelected = waste.draft.unit == unit;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            waste.draft.unit = unit;
          });
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? ReCycloColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            unit,
            style: TextStyle(
              color: isSelected ? Colors.white : ReCycloColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  // ---------- STEP 3: COLLECTORS ----------
  Widget _buildStep3Collector(WasteProvider waste, CollectorProvider collectorRepo) {
    final selectedCat = waste.draft.category?.id ?? 'plastic';
    final matchingCollectors = collectorRepo.allCollectors.where((c) {
      return c.acceptedCategories.contains(selectedCat);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Collectors Near You',
          style: ReCycloTypography.headingMedium.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text(
          'Matched based on accepted category (${waste.draft.category?.name}) and proximity.',
          style: ReCycloTypography.bodyMedium,
        ),
        const SizedBox(height: 16),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: matchingCollectors.isNotEmpty ? matchingCollectors.length : collectorRepo.allCollectors.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final collector = matchingCollectors.isNotEmpty
                ? matchingCollectors[index]
                : collectorRepo.allCollectors[index];
            final isSelected = waste.draft.selectedCollector?.id == collector.id;

            return GestureDetector(
              onTap: () => waste.setCollector(collector),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isSelected ? ReCycloColors.primary : ReCycloColors.border,
                    width: isSelected ? 2.5 : 1.0,
                  ),
                  boxShadow: [
                    if (isSelected)
                      const BoxShadow(
                        color: Color(0x1800A884),
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                  ],
                ),
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        collector.avatar,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 50,
                          height: 50,
                          color: ReCycloColors.primaryLight,
                          child: const Icon(Icons.person, color: ReCycloColors.primary),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  collector.name,
                                  style: ReCycloTypography.titleMedium.copyWith(fontWeight: FontWeight.w700),
                                ),
                              ),
                              StatusBadge(status: collector.availability),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            collector.agency,
                            style: ReCycloTypography.bodySmall,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.star_rounded, size: 16, color: Color(0xFFF59E0B)),
                              const SizedBox(width: 3),
                              Text(
                                collector.rating.toStringAsFixed(1),
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              Text(' (${collector.reviewCount})', style: ReCycloTypography.bodySmall),
                              const SizedBox(width: 8),
                              const Text('•', style: TextStyle(color: ReCycloColors.textMuted)),
                              const SizedBox(width: 8),
                              Text('${collector.distanceKm} km away', style: ReCycloTypography.bodySmall),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? ReCycloColors.primary : ReCycloColors.border,
                          width: 2.0,
                        ),
                      ),
                      child: isSelected
                          ? Center(
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: ReCycloColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // ---------- STEP 4: SCHEDULE ----------
  Widget _buildStep4Schedule(WasteProvider waste) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Schedule Pickup Time',
          style: ReCycloTypography.headingMedium.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text(
          'Choose a convenient pickup date and time window.',
          style: ReCycloTypography.bodyMedium,
        ),
        const SizedBox(height: 20),

        // Date selection chips
        Text('Select Day', style: ReCycloTypography.labelLarge),
        const SizedBox(height: 10),
        Row(
          children: _dateOptions.map((date) {
            final isSelected = waste.draft.pickupDate == date;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() => waste.draft.pickupDate = date);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? ReCycloColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? ReCycloColors.primary : ReCycloColors.border,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      date,
                      style: TextStyle(
                        color: isSelected ? Colors.white : ReCycloColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),

        // Time slots
        Text('Select Time Slot', style: ReCycloTypography.labelLarge),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.6,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _timeSlots.length,
          itemBuilder: (context, index) {
            final slot = _timeSlots[index];
            final isSelected = waste.draft.pickupTime == slot;

            return GestureDetector(
              onTap: () {
                setState(() => waste.draft.pickupTime = slot);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected ? ReCycloColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected ? ReCycloColors.primary : ReCycloColors.border,
                    width: isSelected ? 2.0 : 1.0,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReCycloIcon(
                      'clock',
                      size: 16,
                      color: isSelected ? Colors.white : ReCycloColors.textSecondary,
                      active: isSelected,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      slot,
                      style: TextStyle(
                        color: isSelected ? Colors.white : ReCycloColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 13.5,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),

        // Location Confirmation Summary
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ReCycloColors.border),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ReCycloIcon('location', size: 20, color: ReCycloColors.primaryActive, active: true),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Doorstep Pickup Address',
                      style: ReCycloTypography.titleMedium.copyWith(fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _addressController.text,
                      style: ReCycloTypography.bodySmall.copyWith(color: ReCycloColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------- STEP 5: PAYMENT ----------
  Widget _buildStep5Payment(WasteProvider waste) {
    final qty = double.tryParse(_quantityController.text) ?? 5.0;
    final rate = waste.draft.category?.rateValue ?? 18.0;
    final estPayout = qty * rate;

    final paymentMethods = [
      {'id': 'UPI Digital Payment', 'label': 'UPI (GPay / PhonePe / Paytm)', 'icon': 'card', 'sub': 'Instant payout to bank account'},
      {'id': 'Card / Bank Transfer', 'label': 'Bank Account IMPS', 'icon': 'card', 'sub': 'Direct credit upon collection verification'},
      {'id': 'Cash on Collection', 'label': 'Cash on Collection', 'icon': 'cash', 'sub': 'Receive physical cash on doorstep scale'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment & Booking Summary',
          style: ReCycloTypography.headingMedium.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text(
          'Select your preferred payout method and review booking details.',
          style: ReCycloTypography.bodyMedium,
        ),
        const SizedBox(height: 18),

        // Payout Summary Card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: ReCycloColors.primaryLight,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: ReCycloColors.primary.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Estimated Payout',
                    style: ReCycloTypography.titleMedium.copyWith(
                      color: ReCycloColors.brandDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '₹${estPayout.toStringAsFixed(2)}',
                    style: ReCycloTypography.headingLarge.copyWith(
                      color: ReCycloColors.primaryActive,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(height: 1, color: Color(0x3000A884)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Category & Rate', style: ReCycloTypography.bodySmall),
                  Text('${waste.draft.category?.name} • ₹$rate / kg', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Weight Quantity', style: ReCycloTypography.bodySmall),
                  Text('$qty ${waste.draft.unit}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Payout Method Radio options
        Text('Payout Option', style: ReCycloTypography.labelLarge),
        const SizedBox(height: 10),
        ...paymentMethods.map((m) {
          final isSelected = waste.draft.paymentMethod == m['id'];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected ? ReCycloColors.primary : ReCycloColors.border,
                width: isSelected ? 2.0 : 1.0,
              ),
            ),
            child: InkWell(
              onTap: () {
                setState(() => waste.draft.paymentMethod = m['id']!);
              },
              borderRadius: BorderRadius.circular(14),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? ReCycloColors.primary : ReCycloColors.border,
                          width: 2.0,
                        ),
                      ),
                      child: isSelected
                          ? Center(
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: ReCycloColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            m['label']!,
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            m['sub']!,
                            style: ReCycloTypography.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
