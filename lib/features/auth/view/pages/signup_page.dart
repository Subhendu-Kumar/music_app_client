import 'package:client/core/utils.dart';
import 'package:client/core/widgets/custom_field.dart';
import 'package:client/core/theme/pallete.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/auth/view/pages/signin_page.dart';
import 'package:client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client/features/auth/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      authViewModelProvider.select((val) => val?.isLoading == true),
    );

    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        data: (data) {
          showSnackBar(context, 'Account created successfully! Please  login.');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SigninPage()),
          );
        },
        error: (error, st) {
          showSnackBar(context, error.toString());
        },
        loading: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child:
            isLoading
                ? const Loader()
                : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Sign Up.',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),
                          CustomField(
                            hintText: 'Name',
                            controller: _nameController,
                          ),
                          const SizedBox(height: 15),
                          CustomField(
                            hintText: 'Email',
                            controller: _emailController,
                          ),
                          const SizedBox(height: 15),
                          CustomField(
                            hintText: 'Password',
                            controller: _passwordController,
                            isObscureText: true,
                          ),
                          const SizedBox(height: 20),
                          AuthGradientButton(
                            buttonText: 'Sign up',
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                await ref
                                    .read(authViewModelProvider.notifier)
                                    .signUpUser(
                                      name: _nameController.text.trim(),
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    );
                              } else {
                                showSnackBar(context, 'Missing fields!');
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SigninPage(),
                                ),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'Already have an account? ',
                                style: Theme.of(context).textTheme.titleMedium,
                                children: const [
                                  TextSpan(
                                    text: 'Sign In',
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
