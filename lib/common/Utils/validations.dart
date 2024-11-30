class Validations {
  static String? emailValidation(String? val) {
    if (val!.isEmpty) {
      return "Enter email!";
    } else {
      return null;
    }
  }

  static String? numberValidation(String? val) {
    if (val!.isEmpty) {
      return "Enter number!";
    }
    if (val.trim().length < 10 || val.trim().length > 13) {
      return "Enter valid number!";
    } else {
      return null;
    }
  }

  static String? userNameValidation(String? val) {
    if (val!.isEmpty) {
      return "Enter userName!";
    } else {
      return null;
    }
  }

  static String? nameValidation(String? val) {
    if (val!.isEmpty) {
      return "Enter name!";
    } else if (val.length < 3) {
      return "minimum 3 character required";
    } else {
      return null;
    }
  }

  static String? countryValidation(String? val) {
    if (val == null || val.isEmpty) {
      return "Select country!";
    } else {
      return null;
    }
  }

  static String? genderValidation(String? val) {
    if (val == null || val.isEmpty) {
      return "Select gender!";
    } else {
      return null;
    }
  }

  static String? companyNameValidation(String? val) {
    if (val == null || val.isEmpty) {
      return "Enetr company name!";
    } else {
      return null;
    }
  }

  static String? designationValidation(String? val) {
    if (val == null || val.isEmpty) {
      return "Enter designation!";
    } else {
      return null;
    }
  }

  static String? whatsappValidation(String? val) {
    if (val == null || val.isEmpty) {
      return "Enter whatsapp number!";
    } else {
      return null;
    }
  }

  static String? addressValidation(String? val) {
    if (val == null || val.isEmpty) {
      return "Enter address!";
    } else {
      return null;
    }
  }

  static String? validEmailValidation(String? value) {
    if (value!.isNotEmpty) {
      bool result = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value);
      if (!result) {
        return 'Please enter valid url!';
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static String? websiteValidation(String? value) {
    if (value!.isNotEmpty) {
      bool result = RegExp(
              r'(http|https|www)(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?')
          .hasMatch(value);
      if (!result) {
        return 'Please enter valid url!';
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
