// import 'package:get/get.dart';
// import 'package:gitview/domain/entities/repository.dart';
// import 'package:gitview/domain/entities/user.dart';
// import 'package:gitview/domain/usecases/get_repository_details_usecase.dart';
// import 'package:gitview/presentation/controllers/repository_details_controller.dart';

// class RepositoryDetailsBinding extends Bindings {
//   @override
//   void dependencies() {
//     final args = Get.arguments as Map<String, dynamic>;
//     final user = args['user'] as User;
//     final repository = args['repository'] as Repository;

//     // Create controller with injected dependencies
//     Get.put(
//       RepositoryDetailsController(
//         Get.find<GetRepositoryDetailsUseCase>(),
//         user: user,
//         repository: repository,
//       ),
//       tag: '${user.login}/${repository.name}', // unique tag per repo
//     );
//   }
// }
