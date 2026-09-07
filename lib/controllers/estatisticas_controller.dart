

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pocket/data/database_helper.dart';

class EstatisticasController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    carregarTudo();
  }

  void carregarTudo() async {
    await totalReceitas();
    await totalDespesas();
    await quantidadeTransacoes();
    await gastosPorCategoria();
  }

  // Total de receitas
  Future<double> totalReceitas() async {
    final db = await DatabaseHelper.instance.database;

    final resultado = await db.rawQuery('''
      SELECT SUM(valor) total
      FROM transacoes
      WHERE receita = 1
    ''');

    return (resultado.first['total'] as num?)?.toDouble() ?? 0;
  }

  // Total de despesas
  Future<double> totalDespesas() async {
    final db = await DatabaseHelper.instance.database;

    final resultado = await db.rawQuery('''
      SELECT SUM(valor) total
      FROM transacoes
      WHERE receita = 0
    ''');

    return (resultado.first['total'] as num?)?.toDouble() ?? 0;
  }

  // Quantidade de transações
  Future<int> quantidadeTransacoes() async {
    final db = await DatabaseHelper.instance.database;

    final resultado = await db.rawQuery('''
      SELECT COUNT(*) total
      FROM transacoes
    ''');

    return resultado.first['total'] as int;
  }

  // Gasto por categoria
  Future<List<Map<String, dynamic>>> gastosPorCategoria() async {
    final db = await DatabaseHelper.instance.database;

    return await db.rawQuery('''
      SELECT
        categorias.nome,
        categorias.cor,
        SUM(transacoes.valor) AS total
      FROM transacoes
      INNER JOIN categorias
      ON categorias.id = transacoes.categoria_id
      WHERE receita = 0
      GROUP BY categorias.id
      ORDER BY total DESC
    ''');
  }
}