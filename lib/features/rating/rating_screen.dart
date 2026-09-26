import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/custom_buttons.dart';
import '../../core/widgets/custom_text_field.dart';

/// Rating & Review Screen
class RatingScreen extends StatefulWidget {
  final String collectorName;
  final String requestId;

  const RatingScreen({
    super.key,
    this.collectorName = 'Rajesh Kumar',
    this.requestId = 'REQ-8492',
  });

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _selectedRating = 5;
  final _reviewController = TextEditingController();
  final List<String> _tags = ['On Time', 'Accurate Digital Scale', 'Polite & Professional', 'Instant Payment', 'Clean Collection'];
  final Set<String> _selectedTags = {'On Time', 'Accurate Digital Scale'};

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _submitReview() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: ReCycloColors.primary),
            const SizedBox(width: 8),
            Text('Thank You!', style: ReCycloTypography.headingMedium),
          ],
        ),
        content: const Text('Thank you for your feedback. Your review helps maintain top service quality across the ReCyclo community.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx); // close dialog
              Navigator.pop(context); // back to previous screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ReCycloColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Rate Collection'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: ReCycloColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.rate_review_outlined, size: 36, color: ReCycloColors.primary),
              ),
              const SizedBox(height: 18),

              Text(
                'How was your collection experience?',
                textAlign: TextAlign.center,
                style: ReCycloTypography.headingLarge.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 21,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'With ${widget.collectorName} for booking ${widget.requestId}',
                textAlign: TextAlign.center,
                style: ReCycloTypography.bodyMedium,
              ),
              const SizedBox(height: 24),

              // Interactive Star Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final starIndex = index + 1;
                  final isFilled = starIndex <= _selectedRating;

                  return IconButton(
                    onPressed: () => setState(() => _selectedRating = starIndex),
                    iconSize: 42,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    icon: Icon(
                      isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: isFilled ? const Color(0xFFF59E0B) : ReCycloColors.border,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 12),
              Text(
                _getRatingLabel(_selectedRating),
                style: ReCycloTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFB45309),
                ),
              ),
              const SizedBox(height: 28),

              // Feedback Tags
              Align(
                alignment: Alignment.centerLeft,
                child: Text('What went well?', style: ReCycloTypography.labelLarge),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _tags.map((tag) {
                  final isSelected = _selectedTags.contains(tag);
                  return FilterChip(
                    label: Text(tag),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedTags.add(tag);
                        } else {
                          _selectedTags.remove(tag);
                        }
                      });
                    },
                    selectedColor: ReCycloColors.primaryLight,
                    backgroundColor: ReCycloColors.bgApp,
                    labelStyle: TextStyle(
                      color: isSelected ? ReCycloColors.primaryActive : ReCycloColors.textPrimary,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      fontSize: 12,
                    ),
                    side: BorderSide(
                      color: isSelected ? ReCycloColors.primary : Colors.transparent,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Optional Review Text Field
              CustomTextField(
                controller: _reviewController,
                label: 'Write an optional review',
                hint: 'Share any details about the scale accuracy, friendliness, or overall pickup...',
                maxLines: 4,
              ),
              const SizedBox(height: 32),

              // Submit Review Button
              PrimaryButton(
                text: 'Submit Review',
                onPressed: _submitReview,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getRatingLabel(int rating) {
    switch (rating) {
      case 5:
        return 'Excellent! 🌟';
      case 4:
        return 'Very Good! 👍';
      case 3:
        return 'Average 👌';
      case 2:
        return 'Needs Improvement';
      case 1:
        return 'Poor Experience';
      default:
        return '';
    }
  }
}
