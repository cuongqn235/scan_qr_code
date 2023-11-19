// import 'package:dartz/dartz.dart';
// import 'package:injectable/injectable.dart';
// import 'package:joke_app/app/core/usecases/data_usecase.dart';
// import 'package:joke_app/app/core/usecases/no_param_usecase.dart';
// import 'package:joke_app/domain/entities/joke_entity.dart';
// import 'package:joke_app/domain/repositories/joke/i_joke_repository.dart';

// @injectable
// class GetJokeUseCase extends NoParamUseCase<DataUseCase<JokeEntity?>> {
//   final IJokeRepository _jokeRepository;
//   GetJokeUseCase(this._jokeRepository);

//   @override
//   Future<DataUseCase<JokeEntity?>> execute() async {
//     try {
//       final data = await _jokeRepository.getJokeModelDontFunny();
//       return right(data);
//     } on Exception catch (e) {
//       return left(e);
//     }
//   }
// }
