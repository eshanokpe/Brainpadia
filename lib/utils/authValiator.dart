class AuthValidator {
  static String validateEmail(String text) {
    return RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(text)
        ? 'good'
        : 'Invalid Email';
  }

  static String validateNumber(String text) {
    String digit =
        r'^(?=.*?[0-9])'; // Regular expression to check for numeric characters

    if (text.isEmpty) return 'Please enter a number';
    if (!RegExp(digit).hasMatch(text)) return 'Please enter only numbers';

    return 'Valid'; // You can customize the success message as needed
  }

  static String validatePassword(String text) {
    // String pattern =
    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

    //String cap = r'^(?=.*?[A-Z])';
    //String small = r'^(?=.*?[a-z])';
    //String digit = r'^(?=.*?[0-9])';
    // String char = r'^(?=.*?[!"#$%&€£()*+,-./:;<=>?@[\]^_`{|}~])';

    if (text.isEmpty) {
      //return 'Your password should have a mixture of numbers, letters (uppercase and lowercase) with a special character.';
      return 'Please enter your Password';
    }
    if (text.length < 6) return 'Minimum of 6 characters';
    //if (!RegExp(cap).hasMatch(text)) return 'One upper case letter';
    //if (!RegExp(small).hasMatch(text)) return 'One lower case letter';
    //if (!RegExp(digit).hasMatch(text)) return 'One number';
    // if (!RegExp(char).hasMatch(text)) return 'One special character';

    return 'good';
  }

  static String validateConfirm(String password, String text) {
    return password == text ? 'good' : 'Doesn\'t match';
  }

  static String validateName(String text) {
    return 'good';
  }
}
