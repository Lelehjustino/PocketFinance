import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pocket/data/database_helper.dart';
import 'package:pocket/models/transacao_model.dart';

class TransacoesController extends GetxController {
  var transacoes = <Transacao>[].obs;

  @override
  void onInit() {
    super.onInit();
    carregarTransacoes();
  }

  Future<void> carregarTransacoes() async {
    final db = await DatabaseHelper.instance.database;

    final resultado = await db.query('transacoes', orderBy: 'data DESC');

    transacoes.value = resultado.map((item) {
      return Transacao(
        id: item['id'] as String,
        nome: item['nome'] as String,
        valor: (item['valor'] as num).toDouble(),
        data: DateTime.parse(item['data'] as String),
        receita: (item['receita'] as int) == 1,
        categoriaId: item['categoria_id'] as int,
        descricao: item['descricao'] as String?,
      );
    }).toList();
  }
}
