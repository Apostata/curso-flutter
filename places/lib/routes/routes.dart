import 'package:places/pages/places_form.dart';
import 'package:places/pages/places_list.dart';
import 'package:places/routes/routes_path.dart';
import 'package:regex_router/regex_router.dart';

final routes = RegexRouter.create({
  RoutesPath.PLACES_LIST: (ctx, _) => const PlacesListPage(),
  RoutesPath.PLACE_FORM: (ctx, _) => const PlaceFormPage(),
});

final onGenerateRoutes = routes.generateRoute;
