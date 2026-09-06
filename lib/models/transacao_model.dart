import 'categoria_model.dart';

class Transacao {
    String id;
    String nome;
    double valor;
    DateTime data;
    bool receita;
    String categoria;
    
    Transacao({
        required this.id,
        required this.nome,
        required this.valor,
        required this.data,
        required this.receita,
        required this.categoria,
    });
}