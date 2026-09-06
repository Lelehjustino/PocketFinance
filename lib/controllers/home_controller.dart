import 'package:get/get.dart';
import 'package:pocket/models/categoria_model.dart';
import 'package:pocket/models/transacao_model.dart';

class HomeController extends GetxController {
    RxDouble saldoTotal = 0.0.obs;
    RxDouble receitaMes = 0.0.obs;
    RxDouble despesaMes = 0.0.obs;

    RxList<Transacao> transacoes = <Transacao>[].obs;
}