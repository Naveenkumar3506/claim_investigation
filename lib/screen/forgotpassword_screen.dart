
import 'package:claim_investigation/base/base_page.dart';
import 'package:claim_investigation/providers/auth_provider.dart';
import 'package:claim_investigation/widgets/adaptive_widgets.dart';
import 'package:claim_investigation/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends BasePage {
  static const routeName = '/forgotPasswordScreen';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends BaseState<BasePage> {
  final _passwordFormKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  bool _passwordObscureText = true;

  bool _validateInputs() {
    if (_passwordFormKey.currentState.validate()) {
      print('Form is valid');
      _passwordFormKey.currentState.save();
      return true;
    } else {
      print('Form is invalid');
      return false;
    }
  }

  Future<void> _handleForgotPassword() async {
    if (_validateInputs()) {
      try {
        showLoadingDialog();
        final success = await Provider.of<AuthProvider>(context, listen: false)
            .forgotPassword(_emailTextController.text.trim());
        Navigator.pop(context);
        if (success) {
        } else {}
      } catch (error) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/ic_bg.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor, //change your color here
          ),
          title: Text(""),
          centerTitle: true,
          elevation: 0,
          brightness: Brightness.light,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _passwordFormKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     SizedBox(height: 40),
                      Text(
                        'Reset Password',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 40),
                      AppFormTextField(
                        hintText: 'Enter your email',
                        hintLabel: 'Email ID',
                        controller: _emailTextController,
                        ctx: context,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.emailAddress,
                        onSubmit: (_) {
                          FocusScope.of(context)
                              .requestFocus(new FocusNode());
                        },
                        validator: (email) {
                          if (email == "") {
                            return 'Please enter email Id';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      AppFormTextField(
                        hintText: 'Enter your new password',
                        hintLabel: 'Password',
                        controller: _passwordTextController,
                        ctx: context,
                        obscureText: _passwordObscureText,
                        suffix: IconButton(
                          icon: _passwordObscureText
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _passwordObscureText = !_passwordObscureText;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == "") {
                            return 'Please enter password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        height: 50,
                        child: CupertinoButton(
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            'Reset Password',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            _handleForgotPassword();
                          },
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
