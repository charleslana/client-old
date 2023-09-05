import 'package:routemaster/routemaster.dart';

import 'components/my_observer.dart';
import 'routes/app_route_generator.dart';

final routemaster = RoutemasterDelegate(
  observers: [MyObserver()],
  routesBuilder: (context) => routes,
);
