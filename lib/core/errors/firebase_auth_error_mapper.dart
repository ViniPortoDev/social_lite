import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthErrorMapper {
  static String title(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Email inválido';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Credenciais inválidas';
      case 'email-already-in-use':
        return 'Email já cadastrado';
      case 'too-many-requests':
        return 'Muitas tentativas';
      case 'network-request-failed':
        return 'Sem conexão';
      default:
        return 'Não foi possível entrar';
    }
  }

  static String message(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Digite um email válido para continuar.';
      case 'user-not-found':
        return 'Não encontramos uma conta com esse email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Email ou senha incorretos.';
      case 'email-already-in-use':
        return 'Já existe uma conta com esse email. Tente fazer login ou use outro email.';
      case 'user-disabled':
        return 'Essa conta foi desativada.';
      case 'too-many-requests':
        return 'Você tentou muitas vezes. Aguarde um pouco e tente novamente.';
      case 'network-request-failed':
        return 'Verifique sua internet e tente novamente.';
      case 'operation-not-allowed':
        return 'Método de login não habilitado no Firebase.';
      default:
        return 'Tente novamente em instantes.';
    }
  }
}
