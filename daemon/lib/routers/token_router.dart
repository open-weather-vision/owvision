import 'package:daemon/controllers/token_controller.dart';
import 'package:daemon/middlewares/authentification.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/models/token_role.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

@singleton
class TokenRouter {
  final TokenController _tokenController;

  TokenRouter(this._tokenController);

  Handler get router {
    final pipe = Pipeline();
    pipe.addMiddleware(
      requireRole([TokenRole.admin]),
    ); // only admins can generate tokens

    final tokensRouter = Router();
    tokensRouter.post("/", _tokenController.generate);

    return pipe.addHandler(tokensRouter.call).call;
  }
}
