import 'package:flutter_test/flutter_test.dart';
import 'package:recyclo/data/repositories/auth_repository.dart';
import 'package:recyclo/data/repositories/waste_repository.dart';
import 'package:recyclo/data/repositories/collector_repository.dart';
import 'package:recyclo/data/repositories/request_repository.dart';
import 'package:recyclo/data/repositories/chat_repository.dart';
import 'package:recyclo/data/mock/mock_data.dart';

void main() {
  group('ReCyclo Unit & Workflow Tests', () {
    test('MockData contains valid categories and collectors', () {
      final categories = MockData.categories;
      final collectors = MockData.collectors;

      expect(categories.length, equals(7));
      expect(categories.any((c) => c.id == 'plastic'), isTrue);
      expect(categories.any((c) => c.id == 'e-waste'), isTrue);

      expect(collectors.length, greaterThanOrEqualTo(4));
      expect(collectors.first.name, equals('Rajesh Kumar'));
      expect(collectors.first.verified, isTrue);
    });

    test('AuthProvider logs in and updates profile properly', () async {
      final auth = AuthProvider();
      expect(auth.isAuthenticated, isTrue);
      expect(auth.currentUser?.name, equals('Alex Rivers'));

      await auth.updateProfile(name: 'Alexandre Rivers');
      expect(auth.currentUser?.name, equals('Alexandre Rivers'));
    });

    test('WasteProvider calculates estimated amount correctly', () {
      final waste = WasteProvider();
      final plastic = waste.categories.firstWhere((c) => c.id == 'plastic');
      waste.setCategory(plastic);
      waste.setDetails(
        quantity: 10.0,
        unit: 'kg',
        description: 'Clean PET bottles',
        address: 'Test Address',
      );

      // plastic rateValue is 18.0 * 10 = 180.0
      expect(waste.draft.estimatedAmount, equals(180.0));
      expect(waste.draft.quantity, equals(10.0));
    });

    test('CollectorProvider filters by search query and category', () {
      final collectorRepo = CollectorProvider();

      collectorRepo.setCategoryFilter('e-waste');
      for (final col in collectorRepo.filteredCollectors) {
        expect(col.acceptedCategories.contains('e-waste'), isTrue);
      }

      collectorRepo.setSearchQuery('Priya');
      expect(collectorRepo.filteredCollectors.length, equals(0)); // Priya doesn't accept e-waste

      collectorRepo.setCategoryFilter('all');
      expect(collectorRepo.filteredCollectors.length, equals(1));
      expect(collectorRepo.filteredCollectors.first.name, equals('Priya Sharma'));
    });

    test('RequestProvider advances stages in tracking simulator', () {
      final requestRepo = RequestProvider();
      final initialReq = requestRepo.activeRequest;
      expect(initialReq, isNotNull);
      expect(initialReq!.status, equals('on_the_way'));

      requestRepo.advanceStatus();
      expect(requestRepo.activeRequest!.status, equals('collected'));

      requestRepo.advanceStatus();
      expect(requestRepo.activeRequest!.status, equals('completed'));
    });

    test('ChatProvider dispatches message and stores history', () {
      final chat = ChatProvider();
      final initialCount = chat.messages.length;

      chat.sendMessage('Testing collector message');
      expect(chat.messages.length, equals(initialCount + 1));
      expect(chat.messages.last.text, equals('Testing collector message'));
      expect(chat.messages.last.isUser, isTrue);
    });
  });
}
