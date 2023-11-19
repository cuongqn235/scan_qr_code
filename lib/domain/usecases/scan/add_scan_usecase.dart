// import 'package:dartz/dartz.dart';
// import 'package:injectable/injectable.dart';
// import 'package:joke_app/app/core/usecases/data_usecase.dart';
// import 'package:joke_app/app/core/usecases/pram_usecase.dart';
// import 'package:joke_app/domain/entities/add_joke_feedback_input.dart';
// import 'package:joke_app/domain/repositories/joke/i_joke_repository.dart';

// @injectable
// class AddJokeFeedbackUseCase
//     extends ParamUseCase<DataUseCase<Unit>, AddJokeFeedbackInput> {
//   final IJokeRepository _jokeRepository;
//   AddJokeFeedbackUseCase(this._jokeRepository);

//   @override
//   Future<DataUseCase<Unit>> execute(AddJokeFeedbackInput params) async {
//     try {
//       await _jokeRepository.addJokeFeedback(params);
//       return right(unit);
//     } on Exception catch (e) {
//       return left(e);
//     }
//   }
// }
