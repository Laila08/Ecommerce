import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/widgets/loading_button_widget.dart';
import '../../../components/widgets/main_button.dart';
import '../../../controllers/auth/auth_cubit.dart';
import '../../../routes/routes.dart';
import '../../../utils/app_colors.dart';

class SubmitButton extends StatelessWidget {
  final AuthCubit authCubit;
  final String title;
  final Future<void> Function(AuthCubit) submit;

  const SubmitButton({super.key, required this.authCubit, required this.submit, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: authCubit,
      listenWhen: (previous, current) => current is AuthSuccess || current is AuthFailed,
      listener: (context, state) {
        if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: AppColors.primaryColor),
          );
        }
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, Routes.homepage, arguments: 0);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) return LoadingButtonWidget();
        return MainButton(
          title: title,
          onTap: () async => await submit(authCubit),
        );
      },
    );
  }
}