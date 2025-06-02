import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/register.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class RegisterPage extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: BlocProvider(
        create:
            (_) => AuthBloc(
              loginUseCase: Login(context.read<AuthRepository>()),
              registerUseCase: Register(context.read<AuthRepository>()),
            ),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => HomePage(),
              //   ),
              // );
            }
            if (state is AuthSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
              Navigator.pop(context);
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: "Nama"),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: "Email"),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: "Password"),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  if (state is AuthLoading)
                    const CircularProgressIndicator()
                  else
                    ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                          RegisterRequested(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                      },
                      child: const Text("Daftar"),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
