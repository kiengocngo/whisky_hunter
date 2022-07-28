import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:whisky_hunter/%20bloc/blocs/signin/sign_in_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/signin/sign_in_event.dart';
import 'package:whisky_hunter/%20bloc/blocs/signin/sign_in_state.dart';
import 'package:whisky_hunter/%20bloc/module/bloc_module.dart';
import 'package:whisky_hunter/src/comp/button.dart/tm_button.dart';
import 'package:whisky_hunter/src/comp/dialog/tm_dialog.dart';
import 'package:whisky_hunter/src/constant/constant.dart';
import 'package:whisky_hunter/src/route/tm_route.dart';
import 'package:whisky_hunter/theme/tm_theme_data.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SignIn(),
        TextButton(
            onPressed: () {
              Get.toNamed(TMRoute.signup.name!);
            },
            child: const Text("Sign Up"))
      ],
    ));
  }
}

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalManager globalManager = Get.find();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      if (state is SignInLoadFailure) {
        TMDialog.show(context, title: state.error.toString());
        log(state.error);
      }
      return Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'LOGIN',
              style: TMThemeData.fromContext(context).textNameWhiskyBlack,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (email) => getIt.get<SignInBloc>().add(
                    GetEmailAndPasswordEvent(email: email),
                  ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (password) => getIt.get<SignInBloc>().add(
                    GetEmailAndPasswordEvent(
                      password: password,
                    ),
                  ),
            ),
            const SizedBox(
              height: 12,
            ),
            TMButton(
              content: 'Login',
              onTap: () {
                getIt.get<SignInBloc>().add(LoginEvent());
              },
            ),
          ],
        ),
      );
    });
  }
}
