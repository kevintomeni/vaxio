import 'package:flutter_test/flutter_test.dart';
import 'package:vaxio/Vue/Loading_page/loadingPage.dart';
// import 'package:vaxio/Vue/Onboarding/onboarding_page.dart';
import 'package:vaxio/main.dart'; 

void main() {
	testWidgets('Should ', (tester) async {
	});
    testWidgets('LoadingPage is displayed initially', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the LoadingPage is displayed.
    expect(find.byType(LoadingPage), findsOneWidget);
    expect(find.text('Vaxio'), findsOneWidget); // Vérifie si le texte "Vaxio" est affiché.
  });

// testWidgets('Navigates to OnboardingPage after LoadingPage', (WidgetTester tester) async {
//   await tester.pumpWidget(const MyApp());

//   // Vérifie que LoadingPage est bien affichée
//   expect(find.byType(Loadingpage), findsOneWidget);

//   // Attendre 3 secondes (simulateur de delay dans LoadingPage)
//   await tester.pump(const Duration(seconds: 3));

//   // Permet aux animations/navigation de se terminer
//   await tester.pumpAndSettle();

//   // Vérifie que OnboardingPage est bien affichée
//   expect(find.byType(OnboardingPage), findsOneWidget);
// });
}
