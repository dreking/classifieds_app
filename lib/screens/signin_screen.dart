import 'package:classifieds_app/components/custom_button.dart';
import 'package:classifieds_app/components/custom_dialog.dart';
import 'package:classifieds_app/components/custom_dismiss_keyboard.dart';
import 'package:classifieds_app/components/custom_input_card.dart';
import 'package:classifieds_app/components/custom_loading.dart';
import 'package:classifieds_app/models/user.dart';
import 'package:classifieds_app/providers/auth_logic.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/signin';

  SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;

  User _user = User();

  void _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) return;

    _form.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    final response = await Provider.of<AuthLogic>(
      context,
      listen: false,
    ).signIn(_user);

    setState(() {
      _isLoading = false;
    });

    await showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: 'Login Status',
        text: response.message,
        status: response.status,
        onTap: () => Navigator.of(context).pop(),
      ),
    );

    if (response.status!) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: _isLoading
          ? CustomLoading()
          : Form(
              key: _form,
              child: CustomDismissKeyboard(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            CustomInputCard(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  labelText: 'Enter Email',
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter email';
                                  } else if (!EmailValidator.validate(value)) {
                                    return 'Email is invalid';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  setState(() {
                                    _user.email = value;
                                  });
                                },
                              ),
                            ),
                            CustomInputCard(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  labelText: 'Enter Password',
                                  border: InputBorder.none,
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter a password';
                                  } else if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  setState(() {
                                    _user.password = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomButton(
                        onTap: _saveForm,
                        text: 'Login',
                        icon: Icons.login,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
