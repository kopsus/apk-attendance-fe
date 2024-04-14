import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/dashboard/views/dashboard_page.dart';
import 'package:myapp/features/login/bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isHidePassword = true;
  bool _enableButton = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DistroColors.primary_600,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SafeArea(
            child: SizedBox(
              height: SizeConfig.safeBlockVertical * 40,
              child: Center(
                child: Image.asset('assets/illustration/logo.png',
                    width: SizeConfig.safeBlockHorizontal * 60,
                    fit: BoxFit.fitWidth),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                color: DistroColors.white),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: SizeConfig.safeBlockVertical * 60,
              ),
              child: Form(
                key: _formKey,
                onChanged: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _enableButton = true;
                    });
                  } else {
                    setState(() {
                      _enableButton = false;
                    });
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email",
                        style: DistroTypography.bodyLargeSemiBold
                            .copyWith(color: DistroColors.tertiary_600)),
                    VerticalSeparator(height: 1),
                    DistroTextField(
                      placeholder: 'Email Address',
                      controller: _emailController,
                      validator: (value) {
                        if (value == '' || value == null) {
                          return 'Please input your email';
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'Invalid email format';
                        } else {
                          return null;
                        }
                      },
                    ),
                    VerticalSeparator(height: 2),
                    Text("Password",
                        style: DistroTypography.bodyLargeSemiBold
                            .copyWith(color: DistroColors.tertiary_600)),
                    VerticalSeparator(height: 1),
                    DistroTextField(
                      placeholder: 'Password',
                      controller: _passwordController,
                      obscureText: _isHidePassword,
                      suffixIcon: InkWell(
                        onTap: () => setState(() {
                          _isHidePassword = !_isHidePassword;
                        }),
                        child: Icon(
                          _isHidePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: DistroColors.black,
                        ),
                      ),
                      validator: (value) {
                        if (value == '' || value == null) {
                          return 'Please input your password';
                        } else {
                          return null;
                        }
                      },
                    ),
                    VerticalSeparator(height: 2),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password?',
                        style: DistroTypography.bodySmallSemiBold
                            .copyWith(color: DistroColors.tertiary_500),
                      ),
                    ),
                    VerticalSeparator(height: 3),
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state.status == LoginStatus.success) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => DashboardPage()),
                              (route) => false);
                        }
                        if (state.status == LoginStatus.failed) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: DistroColors.warning_500,
                              content: Text(
                                state.errorMessage,
                                style: TextStyle(color: Colors.white),
                              )));
                        }
                      },
                      builder: (context, state) {
                        if (state.status == LoginStatus.loading) {
                          return DistroElevatedButton(
                              fullWidth: true,
                              loading: true,
                              label: Text('Login',
                                  style: DistroTypography.bodySmallSemiBold),
                              onPressed: () {});
                        }
                        return DistroElevatedButton(
                            enabled: _enableButton,
                            fullWidth: true,
                            label: Text('Login',
                                style: DistroTypography.bodySmallSemiBold),
                            onPressed: () {
                              context.read<LoginBloc>().add(Login(
                                  email: _emailController.text,
                                  password: _passwordController.text));
                            });
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
