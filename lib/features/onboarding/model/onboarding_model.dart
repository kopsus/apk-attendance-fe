class OnboardingModel {
  final String title;
  final String description;
  final String imageUrl;
  final String buttonLabel;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.buttonLabel
  });

  static List<OnboardingModel> generateOnboardingList() {
    return [
      OnboardingModel(
        title: 'Welcome to the HR Application',
        description: 'Welcome to HRD App! elevate your attendance experience with ease and efficiency! begin your productive journey today!',
        imageUrl: 'assets/illustration/onboarding_1.svg',
        buttonLabel: 'Next'
      ),
      OnboardingModel(
        title: 'Seamless design and feature improvement',
        description: 'Simplify your HR processes and enhance your workflow with our intuitive features designed for ultimate flexibility',
        imageUrl: 'assets/illustration/onboarding_2.svg',
        buttonLabel: 'Next'
      ),
      OnboardingModel(
        title: 'All employee duty in one app!',
        description: 'Ready for peak productivity? Let\'s dive in and elevate your efficiency!',
        imageUrl: 'assets/illustration/onboarding_3.svg',
        buttonLabel: 'Login'
      ),
    ];
  }
}