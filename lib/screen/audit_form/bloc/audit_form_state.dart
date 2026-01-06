part of 'audit_form_bloc.dart';

abstract class AuditFormState extends Equatable {
  const AuditFormState();
  @override
  List<Object> get props => [];
}

class AuditFormInitial extends AuditFormState {}

class AuditFormLoading extends AuditFormState {}

class AuditFormEmpty extends AuditFormState {}

class AuditFormLoaded extends AuditFormState {
  const AuditFormLoaded();
}

class AuditFormConfirmation extends AuditFormState {
  final String? message;
  const AuditFormConfirmation(this.message);

}class AuditLocationDisable extends AuditFormState {
  final String? message;
  const AuditLocationDisable(this.message);
}

class AuditFormAlert extends AuditFormState {
  final String? message;
  const AuditFormAlert(this.message);
}

class ApisCallSuccess extends AuditFormState {
  final String? message;
  const ApisCallSuccess(this.message);
}

class AuditAuthorization extends AuditFormState {}

class AuditFormError extends AuditFormState {
  final String? message;
  const AuditFormError(this.message);
}

class AuditFormException extends AuditFormState {
  final String? message;
  const AuditFormException(this.message);
}

class AuditFormImageDelete extends AuditFormState {}