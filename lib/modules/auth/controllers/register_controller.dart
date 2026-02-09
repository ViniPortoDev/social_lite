import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../core/validators/input_validators.dart';
import '../../../core/errors/firebase_auth_error_mapper.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/ui/dialogs/app_dialogs.dart';
import '../../../routes/app_routes.dart';
import '../services/user_db_service.dart';

class RegisterController extends GetxController {
  RegisterController({
    required this.authService,
    required this.userDb,
    required this.dialog,
  });

  final AuthService authService;
  final UserDbService userDb;
  final AppDialogs dialog;

  final isLoading = false.obs;

  Future<void> register({
    required String name,
    required String phone,
    required String cpf,
    required String birthDate,
    required String email,
    required String password,
  }) async {
    final n = name.trim();
    final p = phone.trim();
    final c = cpf.trim();
    final b = birthDate.trim();
    final e = email.trim();
    final pass = password;

    if (n.isEmpty ||
        p.isEmpty ||
        c.isEmpty ||
        b.isEmpty ||
        e.isEmpty ||
        pass.isEmpty) {
      dialog.showError(
        title: 'Dados incompletos',
        message: 'Preencha todos os campos.',
      );
      return;
    }

    if (n.length < 3) {
      dialog.showError(
        title: 'Nome inválido',
        message: 'Informe seu nome completo.',
      );
      return;
    }

    if (!InputValidators.isValidBrPhone(p)) {
      dialog.showError(
        title: 'Telefone inválido',
        message: 'Digite um telefone válido com DDD.',
      );
      return;
    }

    if (!InputValidators.isValidCpf(c)) {
      dialog.showError(
        title: 'CPF inválido',
        message: 'Digite um CPF válido.',
      );
      return;
    }

    if (InputValidators.parseBrazilDate(b) == null) {
      dialog.showError(
        title: 'Data inválida',
        message: 'Digite uma data válida no formato dd/MM/aaaa.',
      );
      return;
    }

    if (!InputValidators.isValidEmail(e)) {
      dialog.showError(
        title: 'Email inválido',
        message: 'Digite um email válido para continuar.',
      );
      return;
    }
    if (pass.length < 6) {
      dialog.showError(
        title: 'Senha fraca',
        message: 'Use uma senha com pelo menos 6 caracteres.',
      );
      return;
    }

    try {
      isLoading.value = true;

      final cred = await authService.registerWithEmail(
        email: e,
        password: pass,
      );
      final uid = cred.user?.uid;
      if (uid == null) {
        throw Exception('UID não encontrado após cadastro.');
      }

      await userDb.saveUserProfile(
        uid: uid,
        name: n,
        phone: p,
        cpf: c,
        birthDate: b,
        email: e,
        createdAt: DateTime.now(),
      );

      await dialog.showSuccess(
        title: 'Conta criada',
        message: 'Sua conta foi criada com sucesso.',
      );
      Get.offAllNamed(Routes.home);
    } on FirebaseAuthException catch (e) {
      dialog.showError(
        title: FirebaseAuthErrorMapper.title(e),
        message: FirebaseAuthErrorMapper.message(e),
      );
    } catch (e) {
      dialog.showError(
        title: 'Erro inesperado',
        message: 'Não foi possível criar sua conta. Tente novamente.',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
