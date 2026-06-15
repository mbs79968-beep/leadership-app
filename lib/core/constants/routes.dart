/// Central route paths/names used by go_router.
class Routes {
  Routes._();

  static const splash = '/';
  static const onboarding = '/onboarding';
  static const shell = '/home'; // bottom-nav shell
  static const home = '/home';
  static const library = '/library';
  static const growth = '/growth';
  static const mentor = '/mentor';

  static const simulation = '/simulation'; // expects Scenario as `extra`
  static const feedback = '/feedback'; // expects FeedbackResult as `extra`
}
