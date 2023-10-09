
class OnboardingContents {
  final String imagescreen;
  final String image;
  final String title;
  final String desc;

  OnboardingContents(
      {required this.imagescreen,
      required this.image,
      required this.title,
      required this.desc});
}

List<OnboardingContents> contents = [
  OnboardingContents(
    image: "assets/logo.png",
    imagescreen: "assets/images/onboard_1.png",
    title: "Trade anytime anywhere",
    desc:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.",
  ),
  OnboardingContents(
    image: "assets/logo.png",
    imagescreen: "assets/images/onboard_2.png",
    title: "Save and invest at the same time",
    desc:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.",
  ),
  OnboardingContents(
    image: "assets/logo.png",
    imagescreen: "assets/images/onboard_3.png",
    title: "Transact fast and easy",
    desc:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.",
  ),
];
