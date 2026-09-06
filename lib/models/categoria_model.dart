import 'package:flutter/material.dart';

class Categoria {
  final int id;
  final String nome;
  final IconData icone;
  final String cor;

  Categoria({
    required this.id,
    required this.nome,
    required this.icone,
    required this.cor,
  });
}