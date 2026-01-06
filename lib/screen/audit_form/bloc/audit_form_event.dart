part of 'audit_form_bloc.dart';

abstract class AuditFormEvent extends Equatable {
  const AuditFormEvent();
  @override
  List<Object> get props => [];
}

class GetAuditList extends AuditFormEvent {
  final String layoutId;
  const GetAuditList(this.layoutId);
}

class SelectAuditRadioButton extends AuditFormEvent {
  final int selectedIndex;
  final int? values;
  final String? questionId;
  const SelectAuditRadioButton(this.selectedIndex,this.values, this.questionId);
}

class SelectHandoverRadioButton extends AuditFormEvent {
 final  int? values;
 final String? questionId;
  const SelectHandoverRadioButton(this.values, this.questionId);
}

class SaveAuditAnswer extends AuditFormEvent {
  final String layoutId;
  final String questionId;
  final String answer;
  const SaveAuditAnswer(this.layoutId, this.questionId, this.answer);
}

class DeleteAuditImage extends AuditFormEvent {
  final String imageId;
  const DeleteAuditImage(this.imageId);
}

class SaveOrSubmitAnswers extends AuditFormEvent {
  final String layoutId;
  final String saveType;
  const SaveOrSubmitAnswers(this.layoutId, this.saveType);
}

class FinalSubmitAnswers extends AuditFormEvent {
  final String layoutId;
  const FinalSubmitAnswers(this.layoutId);
}

class MultipleImageEvent extends AuditFormEvent {
  final int imageIndex;

const MultipleImageEvent(this.imageIndex);

}

class MultipleCameraEvent extends AuditFormEvent {
 final int imageIndex;
  const MultipleCameraEvent(this.imageIndex);
}

class RemoveImageEvent extends AuditFormEvent {
final  int? selectIndex;
 final int questionIndex;
  const  RemoveImageEvent(this.selectIndex,this.questionIndex);
}