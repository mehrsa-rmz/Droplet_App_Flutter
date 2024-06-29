
class TValidator{

  /// Empty Text Validation
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty || value == '') {
      return '$fieldName is required.';
    }

    return null;
  }

  /// Email Validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty || value == '') {
      return 'Email is required.';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }

    return null;
  }

  /// Password Validation
  static String? validatePassword(String? value){
    if(value == null || value.isEmpty || value == ''){
      return 'Password is required.';
    }

    // Check for minimum password length
    if (value.length < 8){
      return 'Password must be at least 8 characters long.';
    }

    // Check for capital letter
    if (!value.contains(RegExp(r'[A-Z]'))){
      return 'Password must contain at least 1 capital letter.';
    }

    // Check for lowercase letter
    if (!value.contains(RegExp(r'[a-z]'))){
      return 'Password must contain at least 1 lowercase letter.';
    }

    // Check for number
    if (!value.contains(RegExp(r'[0-9]'))){
      return 'Password must contain at least 1 number.';
    }

    // Check for special character
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
      return 'Password must contain at least 1 special character.';
    }

    return null;
  }

  /// Repeat Password Validation
  static String? validateRepeatPassword(String? password, String? value){
    if(value == null || value.isEmpty || value == ''){
      return 'Repeating password is required';
    }

    if(value != password){
      return 'Passwords do not match';
    }

    return null;
  }

  /// Phone Number Validation
  static String? validatePhoneNumber(String? value){
    if(value == null || value.isEmpty || value == ''){
      return 'Phone number is required';
    }
  
    // Regular expression for phone validation
    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)){
      return "Invalid phone number format (10 digits).";
    }

    return null;
  }

  /// Phone Number Validation
  static String? validatePhoneNumberCanBeNull(String? value){
    // Regular expression for phone validation
    final phoneRegExp = RegExp(r'^\d{10}$');

    if (value != null && !phoneRegExp.hasMatch(value)){
      return "Invalid phone number format (10 digits).";
    }

    return null;
  }

  // others if needed
}