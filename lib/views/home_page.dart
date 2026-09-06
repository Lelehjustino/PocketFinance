import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:pocket/controllers/categorias_controller.dart';
import 'package:pocket/controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.find<HomeController>();
  final CategoriasController categoriasController = Get.find<CategoriasController>();

  String mesSelecionado = 'Setembro';
  String categoriaSeleciona = 'Todos';

  List<String> meses = ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro',];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Color(0xFFF8FAF9),

      // APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Pocket Finance',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: colorScheme.onSurface.withOpacity(0.8),
            ),
            onPressed: () {},
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  // SALDO ATUAL
                  
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Color(0xFFE0E0E0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'SALDO ATUAL',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF718096),
                            letterSpacing: 0.5,
                          ),
                        ),

                        SizedBox(height: 7),

                        Text(
                          'R\$ ${homeController.saldoTotal.value.toStringAsFixed(2).replaceAll('.', ',')}',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF218739),
                          ),
                        ),

                        SizedBox(height: 12),

                        // SELEÇÃO DO MÊS
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color(0xFFE0E0E0),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: mesSelecionado,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Color(0xFF78909C),
                              ),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                              items: meses.map((mes) {
                                return DropdownMenuItem(
                                  value: mes,
                                  child: Text(mes),
                                );
                              }).toList(),
                              onChanged: (valor) {
                                if (valor != null) {
                                  setState(() {
                                    mesSelecionado = valor;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),

                  
                  // RECEITAS E DESPESAS
                  
                  Row(
                    children: [
                      Expanded(
                        child: _cardResumo(
                          titulo: 'RECEITAS',
                          valor: homeController.receitaMes.value,
                          cor:  Color(0xFF218739),
                          prefixo: '+ R\$ ',
                        ),
                      ),

                       SizedBox(width: 10),

                      Expanded(
                        child: _cardResumo(
                          titulo: 'DESPESAS',
                          valor: homeController.despesaMes.value,
                          cor: Colors.red,
                          prefixo: '- R\$ ',
                        ),
                      ),
                    ],
                  ),

                   SizedBox(height: 12),

                  
                  // CATEGORIAS
                  SizedBox(
                    height: 36,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoriasController.categorias.length,
                      itemBuilder: (context, index) {
                        final categoria = categoriasController.categorias[index];

                        bool selecionada = categoriaSeleciona == categoria;

                        return Padding(
                          padding:  EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                categoriaSeleciona = categoria.nome;
                              });
                            },
                            child: Container(
                              padding:  EdgeInsets.symmetric(
                                horizontal: 13,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: selecionada
                                    ?  Color(0xFFE9F7EC)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: selecionada
                                      ?  Color(0xFF218739)
                                      :  Color(0xFFE0E0E0),
                                ),
                              ),
                              child: Text(
                                categoria.nome,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: selecionada
                                      ?  Color(0xFF218739)
                                      :  Color(0xFF718096),
                                  fontWeight: selecionada
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 18),

                  
                  // ÚLTIMAS TRANSAÇÕES
                  
                  Text(
                    'Últimas transações',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF263238),
                    ),
                  ),

                  SizedBox(height: 8),

                  // LISTA
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: homeController.transacoes.length,
                    itemBuilder: (context, index) {
                      final transacao =
                          homeController.transacoes[index];

                      bool receita = transacao.valor >= 0;

                      return Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFE0E0E0),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            // ÍCONE
                            Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: receita
                                    ? Color(0xFFE9F7EC)
                                    : Color(0xFFFFEEEE),
                                borderRadius:
                                    BorderRadius.circular(10),
                              ),
                              child: Icon(
                                receita
                                    ? Icons.attach_money
                                    : Icons.shopping_bag_outlined,
                                size: 18,
                                color: receita
                                    ? Color(0xFF218739)
                                    : Colors.red,
                              ),
                            ),

                            SizedBox(width: 10),

                            // NOME E DATA
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    transacao.nome,
                                    style:  TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF263238),
                                    ),
                                  ),

                                  SizedBox(height: 3),

                                  Text(
                                    'Receita · ${transacao.data.toString().substring(0, 10)}',
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Color(0xFF78909C),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // VALOR
                            Text(
                              receita
                                  ? '+ R\$ ${transacao.valor.toStringAsFixed(2).replaceAll('.', ',')}'
                                  : '- R\$ ${transacao.valor.abs().toStringAsFixed(2).replaceAll('.', ',')}',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: receita
                                    ? Color(0xFF218739)
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          
          // BOTTOM NAVIGATION
          
          Container(
            height: 58,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Color(0xFFE0E0E0),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _bottomItem(
                  icon: Icons.home,
                  texto: 'Início',
                  selecionado: true,
                ),

                _bottomItem(
                  icon: Icons.swap_horiz,
                  texto: 'Transações',
                  selecionado: false,
                ),

                _bottomItem(
                  icon: Icons.bar_chart,
                  texto: 'Estatísticas',
                  selecionado: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // CARD DE RECEITA / DESPESA

  Widget _cardResumo({
    required String titulo,
    required double valor,
    required Color cor,
    required String prefixo,
  }) {
    return Container(
      height: 64,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(0xFFE0E0E0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: TextStyle(
              fontSize: 9,
              color: Color(0xFF718096),
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 6),

          Text(
            '$prefixo${valor.toStringAsFixed(2).replaceAll('.', ',')}',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: cor,
            ),
          ),
        ],
      ),
    );
  }

  // ITEM DO MENU INFERIOR

  Widget _bottomItem({
    required IconData icon,
    required String texto,
    required bool selecionado,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 20,
          color: selecionado
              ? Color(0xFF218739)
              : Color(0xFF78909C),
        ),

        SizedBox(height: 2),

        Text(
          texto,
          style: TextStyle(
            fontSize: 9,
            color: selecionado
                ? Color(0xFF218739)
                : Color(0xFF78909C),
          ),
        ),
      ],
    );
  }
}