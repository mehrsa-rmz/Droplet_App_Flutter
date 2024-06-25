import 'package:flutter_application/features/appointments/screens/appointments_history.dart';
import 'package:flutter_application/features/appointments/screens/future_appointments.dart';
import 'package:flutter_application/features/appointments/screens/new_appointment/new_appointments.dart';
import 'package:flutter_application/features/appointments/screens/new_appointment/new_appointments_pick_specialist.dart';
import 'package:flutter_application/features/appointments/screens/new_appointment/new_appointments_pick_time.dart';
import 'package:flutter_application/features/appointments/screens/new_appointment/new_appointments_pick_type.dart';
import 'package:flutter_application/features/appointments/screens/new_appointment/new_appointments_specialist_reviews.dart';
import 'package:flutter_application/features/appointments/screens/new_appointment/new_appointments_success.dart';
import 'package:flutter_application/features/articles/screens/articles.dart';
import 'package:flutter_application/features/articles/screens/opened_article.dart';
import 'package:flutter_application/features/authentication/screens/login/login.dart';
import 'package:flutter_application/features/authentication/screens/reset/reset.dart';
import 'package:flutter_application/features/authentication/screens/signup/signup.dart';
import 'package:flutter_application/features/authentication/screens/signup/signup_success.dart';
import 'package:flutter_application/features/customer_service/screens/customer_service.dart';
import 'package:flutter_application/features/explore/screens/explore.dart';
import 'package:flutter_application/features/order/screens/checkout.dart';
import 'package:flutter_application/features/order/screens/order_success.dart';
import 'package:flutter_application/features/order/screens/shopping_cart.dart';
import 'package:flutter_application/features/products/screens/favorites.dart';
import 'package:flutter_application/features/products/screens/gift_guide.dart';
import 'package:flutter_application/features/products/screens/gift_guide_categories.dart';
import 'package:flutter_application/features/products/screens/hypoallergenic.dart';
import 'package:flutter_application/features/products/screens/personal_rec.dart';
import 'package:flutter_application/features/products/screens/product_categories.dart';
import 'package:flutter_application/features/products/screens/products.dart';
import 'package:flutter_application/features/profile/screens/edit_profile.dart';
import 'package:flutter_application/features/profile/screens/loyalty_program.dart';
import 'package:flutter_application/features/profile/screens/profile.dart';
import 'package:flutter_application/features/stores_map/screens/stores_map.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static final pages = [
    // Authentication
    GetPage(name: '/login', page: () => const LoginScreen()),
    GetPage(name: '/signup', page: () => const SignupScreen()),
    GetPage(name: '/signup_success', page: () => const SignupSuccessScreen()),
    GetPage(name: '/reset', page: () => const ResetScreen()),
    // Explore
    GetPage(name: '/explore', page: () => const ExploreScreen()),
    GetPage(name: '/stores', page: () => const StoresMapScreen()),
    GetPage(name: '/appointments_history', page: () => const AppointmentsHistoryScreen()),
    GetPage(name: '/future_appointments', page: () => const FutureAppointmentsScreen()),
    GetPage(name: '/new_appointment', page: () => const NewAppointmentsScreen()),
    GetPage(name: '/specialist_reviews', page: () => const NewAppointmentsReviewsScreen()),
    GetPage(name: '/pick_appointment_specialist', page: () => const NewAppointmentsPickSpecialistScreen()),
    GetPage(name: '/pick_appointment_type', page: () => const NewAppointmentsPickTypeScreen()),
    GetPage(name: '/pick_appointment_time', page: () => const NewAppointmentsPickTimeScreen()),
    GetPage(name: '/appointment_success', page: () => const NewAppointmentsSuccessScreen()),
    GetPage(name: '/customer_support', page: () => const CustomerSupportScreen()),
    GetPage(name: '/personal_recommendations', page: () => const PersonalRecScreen()),
    GetPage(name: '/hypoallergenic_products', page: () => const HypoallergenicScreen()),
    GetPage(name: '/gift_guide_categories', page: () => const GiftGuideCategoriesScreen()),
    GetPage(name: '/gift_guide_products', page: () => GiftGuideScreen()),
    GetPage(name: '/articles', page: () => const ArticlesScreen()),
    GetPage(name: '/article', page: () => OpenedArticleScreen()),
    //Products
    GetPage(name: '/product_categories', page: () => const ProductCategoriesScreen()),
    GetPage(name: '/products', page: () => ProductsScreen()),
    //GetPage(name: '/product', page: () => const ProductDetailsScreen()),
    //Profile
    GetPage(name: '/profile', page: () => ProfileScreen()),
    GetPage(name: '/edit', page: () => const EditProfileScreen()),
    GetPage(name: '/loyalty_program', page: () => const LoyaltyProgramScreen()),
    //Favorites
    GetPage(name: '/favorites', page: () => const FavoritesScreen()),
    //Cart
    GetPage(name: '/cart', page: () => const ShoppingCartScreen()),
    GetPage(name: '/checkout', page: () => const CheckoutScreen()),
    GetPage(name: '/checkout_success', page: () => const OrderSuccessScreen()),
  ];
}


  
