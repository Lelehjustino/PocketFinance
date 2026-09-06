import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pocket/models/categoria_model.dart';

class CategoriasController extends GetxController {
  RxList<Categoria> categorias = <Categoria>[].obs;

  @override
  void onInit() async {
    await carregarCategorias();
    super.onInit();
  }

  Future<void> carregarCategorias() async {
    categorias.value = [
      Categoria(id: 1, nome: 'Alimentação', icone: Icons.fastfood, cor: '0xFFE57373'),
      Categoria(id: 2, nome: 'Transporte', icone: Icons.directions_bus, cor: '0xFF81C784'),
      Categoria(id: 3, nome: 'Moradia', icone: Icons.home, cor: '0xFF9575CD'),
      Categoria(id: 4, nome: 'Saúde', icone: Icons.health_and_safety, cor: '0xFF64B5F6'),
      Categoria(id: 5, nome: 'Educação', icone: Icons.school, cor: '0xFFFFB74D'),
      Categoria(id: 6, nome: 'Lazer', icone: Icons.emoji_emotions, cor: '0xFFBA68C8'),
      Categoria(id: 7, nome: 'Outros', icone: Icons.category, cor: '0xFFDCE775'),
    ];
  }
}