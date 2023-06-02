import '../headers/headers.dart';

const kLightBg = Color(0xff465A61);
const kDarkBg = Color(0xff293939);
const kLightW = Color(0xffEDF5FF);
const kDarkW = Color(0xffD5E8FE);
const kLightp = Color(0xff76E2F8);
const kDarkp = Color(0xff4BB9EC);

const kBgGradeint = LinearGradient(
  colors: [
    kDarkBg,
    kLightW,
    Colors.white,
  ],
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
);
const kBtnGradeint = LinearGradient(
  colors: [
    // kDarkBg,
    kDarkBg,
    // kDarkW,
    kDarkBg,
    // kLightW,
    // Colors.white,
  ],
  begin: Alignment.centerRight,
  end: Alignment.centerLeft,
);
