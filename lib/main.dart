// import 'dart:developer';

// import 'package:fitness_app_riverpod/services/counter_service.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'firebase_options.dart';

// final counterStreamProvider = StreamProvider.autoDispose<int?>(
//   ((ref) => CounterService.counterValue()),
// );

// final counterNotifyerProvider =
//     StateNotifierProvider.autoDispose<CounterNotifier, int?>(
//   ((ref) {
//     final AsyncValue<int?> counterValue = ref.watch(counterStreamProvider);
//     return CounterNotifier(counterValue: counterValue);
//   }),
// );

// class CounterNotifier extends StateNotifier<int?> {
//   final AsyncValue<int?> counterValue;

//   CounterNotifier({required this.counterValue})
//       : super(counterValue.value ?? 0);

//   increment() {
//     if (state != null) {
//       state = state! + 1;
//       return CounterService.incrementCounter(state!);
//     }
//   }

//   resetCounter() {
//     state = 0;
//     return CounterService.incrementCounter(state!);
//   }

//   bool enableButton() {
//     return state != null;
//   }
// }

// void main() async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(
//     const ProviderScope(
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends HookConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               ref.watch(counterNotifyerProvider).toString(),
//               style: Theme.of(context).textTheme.headline4,
//             ),
//             TextButton(
//               onPressed: ref
//                       .watch(counterNotifyerProvider.notifier)
//                       .enableButton()
//                   ? () =>
//                       ref.read(counterNotifyerProvider.notifier).resetCounter()
//                   : null,
//               child: const Text('reset'),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: ref.watch(counterNotifyerProvider.notifier).enableButton()
//             ? () => ref.read(counterNotifyerProvider.notifier).increment()
//             : null,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app_riverpod/app/auth/onboarding/onboarding_page.dart';
import 'package:fitness_app_riverpod/app/auth/registration/registration_page.dart';
import 'package:fitness_app_riverpod/app/workouts/wokrouts_tab.dart';
import 'package:fitness_app_riverpod/firebase_options.dart';
import 'package:fitness_app_riverpod/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authStateChangesProvider = StreamProvider.autoDispose<User?>((ref) {
  return UserService.getAuthStateChanges();
});

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: ref.watch(authStateChangesProvider).when(
        data: (user) {
          if (user != null) {
            return const WorkoutsPage();
          } else {
            return OnboardingPage();
          }
        },
        error: (_, __) {
          print(_);
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
