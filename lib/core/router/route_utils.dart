enum APP_PAGE {
  splash,
  onBoarding,
  login,
  signup,
  home,
  product,
  productDetails,
  sharedProductDetails,
  aboutUs,
  contactUs,
  affiliateProfile,
  affiliateProducts,
  affiliateProductDetails,
  affiliateWallet,
  forgotPassword,
  recoveryPassword,
  editEmail,
  editPassword,
  error
}

extension AppPageExtension on APP_PAGE {
  String get toPath {
    switch (this) {
      case APP_PAGE.home:
        return "/";
      case APP_PAGE.splash:
        return "/splash";
      case APP_PAGE.onBoarding:
        return "/boarding";
      case APP_PAGE.login:
        return "/login";
      case APP_PAGE.signup:
        return "/signup";
      case APP_PAGE.product:
        return "/products";
      case APP_PAGE.sharedProductDetails:
        return "/s_products";
      case APP_PAGE.productDetails:
        return "/product_details";
      case APP_PAGE.aboutUs:
        return "/about_us";
      case APP_PAGE.contactUs:
        return "/contact_us";
      case APP_PAGE.affiliateProfile:
        return "/affiliate_profile";
      case APP_PAGE.affiliateProducts:
        return "/affiliate_products";
      case APP_PAGE.affiliateProductDetails:
        return "/affiliate_product_details";
      case APP_PAGE.affiliateWallet:
        return "/affiliate_wallet";
      case APP_PAGE.forgotPassword:
        return "/forgot_password";
      case APP_PAGE.recoveryPassword:
        return "/recovery_password";
      case APP_PAGE.editEmail:
        return "/edit_email";
      case APP_PAGE.editPassword:
        return "/edit_password";
      case APP_PAGE.error:
        return "/error";
      default:
        return "/";
    }
  }

  String get toName {
    switch (this) {
      case APP_PAGE.splash:
        return "SPLASH";
      case APP_PAGE.onBoarding:
        return "BOARDING";
      case APP_PAGE.home:
        return "HOME";
      case APP_PAGE.login:
        return "LOGIN";
      case APP_PAGE.signup:
        return "SIGNUP";
      case APP_PAGE.product:
        return "PRODUCTS";
      case APP_PAGE.productDetails:
        return "/PRODUCT_DETAILS";
      case APP_PAGE.sharedProductDetails:
        return "/SHARED_PRODUCT_DETAILS";
      case APP_PAGE.aboutUs:
        return "ABOUT_US";
      case APP_PAGE.contactUs:
        return "CONTACT_US";
      case APP_PAGE.affiliateProfile:
        return "AFFILIATE_PROFILE";
      case APP_PAGE.affiliateProducts:
        return "AFFILIATE_PRODUCTS";
      case APP_PAGE.affiliateProductDetails:
        return "AFFILIATE_PRODUCT_DETAILS";
      case APP_PAGE.affiliateWallet:
        return "AFFILIATE_WALLET";
      case APP_PAGE.forgotPassword:
        return "FORGOT_PASSWORD";
      case APP_PAGE.recoveryPassword:
        return "RECOVERY_PASSWORD";
      case APP_PAGE.editEmail:
        return "EDIT_EMAIL";
      case APP_PAGE.editPassword:
        return "EDIT_PASSWORD";
      case APP_PAGE.error:
        return "ERROR";
      default:
        return "SPLASH";
    }
  }
}
