import 'package:ecommerceapp/core/components/widgets/app_dialog.dart';
import 'package:ecommerceapp/core/components/widgets/app_text_field.dart';
import 'package:ecommerceapp/core/components/widgets/main_button.dart';
import 'package:ecommerceapp/core/controllers/auth_controller.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/routes/routes.dart';
import 'package:ecommerceapp/core/utils/app_assets.dart';
import 'package:ecommerceapp/core/utils/app_messages.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/theme/app_validator.dart';
import 'package:ecommerceapp/features/auth/presentation/views/widgets/social_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'action_text_widget.dart';
import 'suffix_icon_widget.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  Future<void> submit(AuthController model) async {
    final result = await model.signInUser();
    if (result == true) {
      if (!mounted) return;
      model.clearAuth();
      context.pushReplacementNamed(Routes.homepage);
    } else if (result == false) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AppDialog(message: AppMessages.loginErrorMessage),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (_, model, _) => Form(
        autovalidateMode: model.autovalidateMode,
        key: model.loginKey,
        child: Column(
          spacing: 12,
          children: [
            AppTextField(
              onChangedFunction: (_) => model.validateEmail(),
              labelText: "Email",
              focusNodeType: model.emailFocusNode,
              validator: AppValidator.emailValidator,
              controller: model.emailController,
              suffixIcon: SuffixIconWidget.getSuffixIcon(model.isValidEmail),
              textInputAction: TextInputAction.next,
              onEditingCompleteFun: () =>
                  FocusScope.of(context).requestFocus(model.passwordFocusNode),
            ),
            AppTextField(
              onChangedFunction: (_) => model.validatePassword(),
              suffixIcon: SuffixIconWidget.getSuffixIcon(model.isValidPassword),
              labelText: "Password",
              controller: model.passwordController,
              focusNodeType: model.passwordFocusNode,
              validator: AppValidator.passwordValidator,
              textInputAction: TextInputAction.done,
            ),
            ActionTextWidget(
              title: 'Forgot your password?',
              routeName: Routes.forgotPassword,
            ),
            5.verticalSizedBox,
            MainButton(title: "LOGIN", onTap: () async => submit(model)),
            110.verticalSizedBox,
            Text(
              "Or login with social account",
              style: AppTextStyles.font14blackWeight500,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialWidget(image: AppAssets.gmailImg),
                SocialWidget(image: AppAssets.facebookImg).allPading(20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
