import 'package:ecommerce_app/Utils/routes/app_pages.dart';
import 'package:ecommerce_app/utils/local_storage.dart';
import 'package:ecommerce_app/utils/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../utils/common_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();

  bool emailValidation = true;
  bool passwordValidation = true;

  String emailError = '';
  String passwordError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding).copyWith(top: defaultPadding * 3),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: defaultPadding),
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/login.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                (defaultPadding * 2).verticalSpace,
                TextFormField(
                  controller: emailCon,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: AppColors.error, fontSize: 11.sp),
                    errorText: emailValidation ? null : emailError, // Show error only if validation fails
                    hintText: 'Enter email',
                    hintStyle: TextStyle(color: AppColors.greyColor),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.lightGrey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(defaultRadius),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.lightGrey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(defaultRadius),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.lightGrey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(defaultRadius),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: AppColors.lightGreyTextColor,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      emailValidation = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$").hasMatch(value);
                    });
                  },
                ),
                const SizedBox(
                  height: defaultPadding / 1.5,
                ),
                TextFormField(
                  controller: passwordCon,
                  keyboardType: TextInputType.text,
                  obscureText: true, // Ensure password is hidden
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: AppColors.error, fontSize: 11.sp),
                    errorText: passwordValidation ? null : passwordError, // Show error only if validation fails
                    hintText: 'Enter password',
                    hintStyle: TextStyle(color: AppColors.greyColor),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.lightGrey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(defaultRadius),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.lightGrey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(defaultRadius),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.lightGrey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(defaultRadius),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: AppColors.lightGreyTextColor,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      passwordValidation = value.isNotEmpty;
                    });
                  },
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      emailValidation = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$").hasMatch(emailCon.text);
                      passwordValidation = passwordCon.text.isNotEmpty;

                      emailError = emailValidation ? '' : 'Enter a valid email';
                      passwordError = passwordValidation ? '' : 'Enter password';
                    });

                    if (emailValidation && passwordValidation) {
                      GoRouter.of(context).pushNamed(AppPages.allProductsPage);
                      LocalStorage.setUserData(email: emailCon.text, name: '');
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Theme.of(context).primaryColor),
                    shape: WidgetStatePropertyAll(
                      ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(defaultRadius),
                        ),
                      ),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(color: AppColors.whiteColor, fontSize: 17),
                  ),
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                InkWell(
                  onTap: () {},
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account?",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        TextSpan(
                          text: " Sign up",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
