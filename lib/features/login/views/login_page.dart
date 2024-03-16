import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isHidePassword = true;
  bool _enableButton = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DistroColors.primary_400,
      body: Column(
        children: [
          SafeArea(
            child: SizedBox(
              height: SizeConfig.safeBlockVertical*40,
              child: Center(
                child: Image.asset(
                  'assets/illustration/logo.png',
                  width: SizeConfig.safeBlockHorizontal*40, 
                  fit: BoxFit.fitWidth
                ),
              ),
            ),
          ),
          Container(
            height: SizeConfig.safeBlockVertical*60,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              color: DistroColors.white
            ),
            child: Form(
              key: _formKey,
              onChanged: () {
                if(_formKey.currentState!.validate()){
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
                  Text(
                    "Email", 
                    style: DistroTypography.bodyLargeSemiBold.copyWith(
                      color: DistroColors.tertiary_600)),
                  VerticalSeparator(height: 1),
                  DistroTextField(
                    placeholder: 'Email Address',
                    controller: _emailController,
                    validator: (value){
                      if(value == '' || value == null){
                        return 'Please input your email';
                      } else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'Invalid email format';
                      } else {
                        return null;
                      }
                    },
                  ),
                  VerticalSeparator(height: 2),
                  Text(
                    "Password", 
                    style: DistroTypography.bodyLargeSemiBold.copyWith(
                      color: DistroColors.tertiary_600)),
                  VerticalSeparator(height: 1),
                  DistroTextField(
                    placeholder: 'Password',
                    controller: _passwordController,
                    obscureText: _isHidePassword,
                    suffixIcon: InkWell(
                      onTap: ()=>setState(() {
                        _isHidePassword = !_isHidePassword;
                      }),
                      child: Icon( _isHidePassword ? 
                        Icons.visibility_outlined : 
                        Icons.visibility_off_outlined,
                        color: DistroColors.black,
                      ),
                    ),
                    validator: (value) {
                      if(value == '' || value == null){
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
                      style: DistroTypography.bodySmallSemiBold.copyWith(
                        color: DistroColors.tertiary_500
                      ),),
                  ),
                  VerticalSeparator(height: 3),
                  DistroElevatedButton(
                    enabled: _enableButton,
                    fullWidth: true,
                    label: Text(
                      'Login',
                      style: DistroTypography.bodySmallSemiBold
                    ), 
                    onPressed: (){}
                  )
                ],
              ),
            ),            
          )
        ],
      ),
    );
  }
}