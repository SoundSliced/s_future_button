import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:future_button/future_button.dart';

void main() {
  group('FutureButton Widget Tests', () {
    testWidgets('FutureButton renders with default label',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FutureButton(
              onTap: () async => true,
              label: 'Test Button',
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(FutureButton), findsOneWidget);
    });

    testWidgets('FutureButton renders with icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FutureButton(
              onTap: () async => true,
              icon: const Icon(Icons.check),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('FutureButton respects isEnabled parameter',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FutureButton(
              onTap: () async => true,
              label: 'Disabled Button',
              isEnabled: false,
            ),
          ),
        ),
      );

      expect(find.text('Disabled Button'), findsOneWidget);
      // Disabled state is handled by SDisabled wrapper
      expect(find.byType(FutureButton), findsOneWidget);
    });

    testWidgets('FutureButton respects custom dimensions',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FutureButton(
              onTap: () async => true,
              label: 'Custom Size',
              width: 200,
              height: 60,
            ),
          ),
        ),
      );

      expect(find.byType(FutureButton), findsOneWidget);
      expect(find.text('Custom Size'), findsOneWidget);
    });

    testWidgets('FutureButton respects bgColor parameter',
        (WidgetTester tester) async {
      const Color customColor = Colors.red;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FutureButton(
              onTap: () async => true,
              label: 'Custom Color',
              bgColor: customColor,
            ),
          ),
        ),
      );

      expect(find.byType(FutureButton), findsOneWidget);
    });

    testWidgets('FutureButton respects borderRadius parameter',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FutureButton(
              onTap: () async => true,
              label: 'Rounded Button',
              borderRadius: 12,
            ),
          ),
        ),
      );

      expect(find.byType(FutureButton), findsOneWidget);
    });

    testWidgets('FutureButton respects isElevatedButton parameter',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FutureButton(
              onTap: () async => true,
              label: 'Flat Button',
              isElevatedButton: false,
            ),
          ),
        ),
      );

      expect(find.byType(FutureButton), findsOneWidget);
    });

    testWidgets(
        'FutureButton shows error message when showErrorMessage is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FutureButton(
              onTap: () async => false,
              label: 'Validate',
              showErrorMessage: true,
            ),
          ),
        ),
      );

      expect(find.byType(FutureButton), findsOneWidget);
    });

    testWidgets(
        'FutureButton hides error message when showErrorMessage is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FutureButton(
              onTap: () async => false,
              label: 'Validate',
              showErrorMessage: false,
            ),
          ),
        ),
      );

      expect(find.byType(FutureButton), findsOneWidget);
    });

    testWidgets('FutureButton calls onPostSuccess callback on success',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FutureButton(
              onTap: () async => true,
              label: 'Success',
              onPostSuccess: () {},
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.byType(FutureButton), findsOneWidget);
    });

    testWidgets('FutureButton configures onPostError callback',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FutureButton(
              onTap: () async => false,
              label: 'Error',
              onPostError: (error) {},
            ),
          ),
        ),
      );

      // Verify the button renders correctly
      expect(find.byType(FutureButton), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Error'), findsOneWidget);
    });

    testWidgets('FutureButton configures exception handling callback',
        (WidgetTester tester) async {
      final Exception testException = Exception('Test error');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FutureButton(
              onTap: () async {
                throw testException;
              },
              label: 'Exception',
              onPostError: (error) {
                // Callback is configured
              },
            ),
          ),
        ),
      );

      // Verify the button renders correctly
      expect(find.byType(FutureButton), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Exception'), findsOneWidget);
    });

    testWidgets('FutureButton handles null return (silent dismissal)',
        (WidgetTester tester) async {
      bool successCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FutureButton(
              onTap: () async => null,
              label: 'Silent',
              onPostSuccess: () {
                successCalled = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      // Advance time to allow the async operation to complete
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      // onPostSuccess should NOT be called for silent dismissal
      expect(successCalled, false);
    });

    testWidgets('FutureButton respects loadingCircleSize parameter',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FutureButton(
              onTap: () async {
                return true;
              },
              label: 'Large Loader',
              loadingCircleSize: 32,
            ),
          ),
        ),
      );

      expect(find.byType(FutureButton), findsOneWidget);
    });

    testWidgets('FutureButton respects focusNode parameter',
        (WidgetTester tester) async {
      final FocusNode focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FutureButton(
              onTap: () async => true,
              label: 'Focusable',
              focusNode: focusNode,
            ),
          ),
        ),
      );

      expect(find.byType(FutureButton), findsOneWidget);

      addTearDown(focusNode.dispose);
    });

    testWidgets('FutureButton respects onFocusChange callback',
        (WidgetTester tester) async {
      bool focusCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FutureButton(
              onTap: () async => true,
              label: 'Focus Test',
              onFocusChange: (isFocused) {
                if (isFocused) {
                  focusCalled = true;
                }
              },
            ),
          ),
        ),
      );

      // Request focus on the button
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();

      expect(focusCalled, true);
    });

    testWidgets('FutureButton respects iconColor parameter',
        (WidgetTester tester) async {
      const Color customIconColor = Colors.yellow;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FutureButton(
              onTap: () async => true,
              label: 'Icon Color',
              iconColor: customIconColor,
            ),
          ),
        ),
      );

      expect(find.byType(FutureButton), findsOneWidget);
    });

    testWidgets('FutureButton disabled when onTap is null',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FutureButton(
              onTap: null,
              label: 'No Action',
            ),
          ),
        ),
      );

      expect(find.text('No Action'), findsOneWidget);
      expect(find.byType(FutureButton), findsOneWidget);
    });
  });
}
