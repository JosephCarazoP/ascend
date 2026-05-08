import '../models/user.dart';

class SubscriptionService {
  const SubscriptionService();

  bool isPro(AppUser user) {
    return user.planType == 'pro' ||
        user.role == 'coach' ||
        user.role == 'admin';
  }

  bool canUseActiveTrainingFeatures(AppUser user) {
    return isPro(user);
  }
}
