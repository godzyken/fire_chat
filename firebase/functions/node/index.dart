
import 'authentication.dart';

// const timeout = Duration(seconds: 5);

Future<void> main(List<String> args) async {
  Authentication.handle();
 /* runZoned(
        () {
      final completer = Completer();
      // never completes, will be reported
      completer.future.then(print);
    },
    zoneSpecification: ZoneSpecification(
      // you'd have to copy this for registerCallback and registerBinaryCallback
      registerUnaryCallback: <R, T>(self, parent, zone, f) {
        final stack = StackTrace.current;
        final timer = Zone.root.createTimer(timeout, () {
          print('timeout!! $stack');
        });

        return (a) {
          timer.cancel();
          return f(a);
        };
      },
    ),
  );*/

}