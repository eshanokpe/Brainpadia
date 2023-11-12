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
    title: "Trade Anywhere Anytime",
    desc:
        "Experience the freedom of trading BPCoins at your fingertips. Our mobile app allows you to buy and sell BPCoins anytime, anywhere. Stay ahead in the crypto game with swift and secure transactions.",
  ),
  OnboardingContents(
    image: "assets/logo.png",
    imagescreen: "assets/images/onboard_2.png",
    title: "Save & Invest all at once",
    desc:
        "Unlock the potential of BPCoins with Brainepedia Wallet. With us, you can save and invest seamlessly. Grow your wealth while keeping your BPCoins safe. It's savings and investment combined, effortlessly.",
  ),
  OnboardingContents(
    image: "assets/logo.png",
    imagescreen: "assets/images/onboard_3.png",
    title: "Transact Fast & easy",
    desc:
        "Say goodbye to slow and complicated transactions. Brainepedia Wallet ensures your BPCoin transactions are lightning-fast and effortless. Send and receive with speed and simplicity, just as it should be.",
  ),
];
