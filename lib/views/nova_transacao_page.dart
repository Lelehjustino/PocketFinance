import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:pocket/controllers/categorias_controller.dart';
import 'package:pocket/controllers/home_controller.dart';
import 'package:pocket/controllers/transacoes_controller.dart';
import 'package:pocket/data/database_helper.dart';
import 'package:pocket/models/transacao_model.dart';
import 'package:pocket/views/transacoes_page.dart';
import 'package:sqflite/sqflite.dart';

class NovaTransacaoPage extends StatefulWidget {
  const NovaTransacaoPage({super.key});

  @override
  State<NovaTransacaoPage> createState() => _NovaTransacaoPageState();
}

class _NovaTransacaoPageState extends State<NovaTransacaoPage> {
  final CategoriasController categoriasController =
      Get.find<CategoriasController>();
  final HomeController homeController = Get.find<HomeController>();
  final TransacoesController transacoesController =
      Get.find<TransacoesController>();

  bool isReceita = false;

  int categoriaSelecionada = -1;
  int? categoriaIdSelecionada;

  final nomeController = TextEditingController();
  final valorController = TextEditingController();
  final dataController = TextEditingController();
  final descricaoController = TextEditingController();

  final nomeFocus = FocusNode();
  final valorFocus = FocusNode();
  final dataFocus = FocusNode();
  final descricaoFocus = FocusNode();

  String nomeCategoriaSelecionada = "";

  Future<void> salvarTransacao(Transacao transacao) async {
    final db = await DatabaseHelper.instance.database;

    await db.insert(
      'transacoes',
      transacao.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void limparPage() {
    nomeController.clear();
    valorController.clear();
    dataController.clear();
    descricaoController.clear();

    setState(() {
      isReceita = false;
      categoriaSelecionada = -1;
      categoriaIdSelecionada = null;
      nomeCategoriaSelecionada = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Nova transação'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// RECEITA / DESPESA
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isReceita = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isReceita
                              ? colorScheme.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            "Receita",
                            style: TextStyle(
                              color: isReceita
                                  ? colorScheme.surface
                                  : colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isReceita = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: !isReceita ? Colors.red : Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            "Despesa",
                            style: TextStyle(
                              color: !isReceita
                                  ? colorScheme.surface
                                  : colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            /// NOME
            TextField(
              controller: nomeController,
              focusNode: nomeFocus,
              decoration: InputDecoration(
                labelText: "Nome da transação",
                hintText: "Ex: Mercado",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 15),

            /// VALOR
            TextField(
              controller: valorController,
              focusNode: valorFocus,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Valor",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 15),

            /// DATA
            TextField(
              controller: dataController,
              focusNode: dataFocus,
              readOnly: false,
              decoration: InputDecoration(
                labelText: "Data",
                suffixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 15),

            /// DESCRIÇÃO
            TextField(
              controller: descricaoController,
              focusNode: descricaoFocus,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Descrição",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 20),

            Text("Categoria", style: TextStyle(fontWeight: FontWeight.bold)),

            SizedBox(height: 10),

            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: categoriasController.categorias.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: .9,
              ),
              itemBuilder: (context, index) {
                final categoria = categoriasController.categorias[index];
                bool selecionada = categoriaSelecionada == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      categoriaSelecionada = index;
                      categoriaIdSelecionada = categoria.id;
                      nomeCategoriaSelecionada = categoria.nome;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selecionada
                            ? Colors.orange
                            : Colors.grey.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          categoria.icone,
                          color: Color(int.parse(categoria.cor)),
                        ),

                        SizedBox(height: 5),

                        Text(categoria.nome, style: TextStyle(fontSize: 11)),
                      ],
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.error,
                      ),
                      onPressed: () async {
                        limparPage();

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => TransacoesPage()),
                        );
                      },
                      child: Text(
                        "Cancelar",
                        style: TextStyle(color: colorScheme.surface),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                      ),
                      onPressed: () async {
                        final valor = double.tryParse(
                          valorController.text.replaceAll(',', '.'),
                        );

                        if (nomeController.text.isEmpty || valor == null ) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Preencha todos os campos!"),
                            ),
                          );
                          return;
                        }
                        // salvar shared preferences
                        final transacao = Transacao(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          nome: nomeController.text,
                          valor: valor,
                          data: DateTime.now(),
                          receita: isReceita,
                          categoriaId: categoriaIdSelecionada!,
                          descricao: descricaoController.text,
                        );

                        await salvarTransacao(transacao);
                        await transacoesController.carregarTransacoes();
                        await homeController.carregarTransacoes();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Transação salva!")),
                        );

                        limparPage();

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => TransacoesPage()),
                        );
                      },
                      child: Text(
                        "Salvar transação",
                        style: TextStyle(color: colorScheme.surface),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
