import 'package:client/core/theme/pallete.dart';
import 'package:client/core/widgets/custom_field.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final isLoading = ref
    //     .watch(authViewModelProvider.select((val) => val?.isLoading == true));

    // ref.listen(
    //   authViewModelProvider,
    //   (_, next) {
    //     next?.when(
    //       data: (data) {
    //         Navigator.pushAndRemoveUntil(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => const HomePage(),
    //           ),
    //           (_) => false,
    //         );
    //       },
    //       error: (error, st) {
    //         showSnackBar(context, error.toString());
    //       },
    //       loading: () {},
    //     );
    //   },
    // );

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign In.',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  CustomField(hintText: 'Email', controller: _emailController),
                  const SizedBox(height: 15),
                  CustomField(
                    hintText: 'Password',
                    controller: _passwordController,
                    isObscureText: true,
                  ),
                  const SizedBox(height: 20),
                  AuthGradientButton(
                    buttonText: 'Sign in',
                    onTap: () async {
                      //   if (_formKey.currentState!.validate()) {
                      //     await ref
                      //         .read(authViewModelProvider.notifier)
                      //         .loginUser(
                      //           email: emailController.text,
                      //           password: passwordController.text,
                      //         );
                      //   } else {
                      //     showSnackBar(context, 'Missing fields!');
                      //   }
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupPage(),
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: const [
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              color: Pallete.gradient2,
                              fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
