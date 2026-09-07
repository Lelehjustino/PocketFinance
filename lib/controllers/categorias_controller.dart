import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pocket/data/database_helper.dart';
import 'package:pocket/models/categoria_model.dart';

class CategoriasController extends GetxController {
  RxList<Categoria> categorias = <Categoria>[].obs;

  @override
  void onInit() async {
    await carregarTudo();
    super.onInit();
  }

  Future<void> carregarTudo() async {
    await carregarCategorias();
  }

   Future<void> carregarCategorias() async {
    final db = await DatabaseHelper.instance.database;

    final resultado = await db.query(
      'categorias',
      orderBy: 'id ASC',
    );

    categorias.value = resultado.map((categoria) {
      return Categoria(
        id: categoria['id'] as int,
        nome: categoria['nome'] as String,
        icone: iconePorNome(categoria['icone'] as String),
        cor: categoria['cor'] as String,
      );
    }).toList();
  }

  IconData iconePorNome(String nome) {
    switch (nome) {
      case 'Alimentação':
        return Icons.fastfood;

      case 'Transporte':
        return Icons.directions_bus;

      case 'Moradia':
        return Icons.home;

      case 'Saúde':
        return Icons.health_and_safety;

      case 'Educação':
        return Icons.school;

      case 'Lazer':
        return Icons.emoji_emotions;

      case 'Outros':
        return Icons.category;

      default:
        return Icons.category;
    }
  }
}