mixin ValidationsMixin {
  String? isNotEmpty(String? value, [String? message]) {
    if (value!.isEmpty) return message ?? "Este campo é obrigatório";
    return null;
  }

  String? hasFiveChars(String? value, [String? message]) {
    if (value!.length < 5) {
      return message ?? "Este campo deve contar mais de 5 caracteres!";
    }
    return null;
  }

  String? validacaoEmail(String value) {
    if (!value.contains('@')) {
      return 'Por Favor Digite um Email Valido';
    }
    return null;
  }

  String? validarSenha(String value) {
    if (value.length < 4) {
      return 'A senha deve ter mais de 4 caracteres';
    }
    if (value.contains(RegExp(r'[A-Z]'))) {
      return 'A senha deve ter pelo menos 1 letra maiúscula';
    }
    if (value.contains(RegExp(r'(?=.*[0-9])'))) {
      return 'A senha deve ter pelo menos um número';
    }

    return null;
  }

  String? combine(List<String? Function()> validators) {
    for (final func in validators) {
      final validation = func();
      if (validation != null) return validation;
    }
    return null;
  }
}
