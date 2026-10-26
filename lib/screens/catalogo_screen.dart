import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../widgets/produto_card.dart';
import 'detalhes_produto_screen.dart';

class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  final List<Produto> _produtos = [
    const Produto(id: '1', nome: 'Smartphone Galaxy S24', preco: 4500.00, categoria: 'Eletrônicos', icone: '📱'),
    const Produto(id: '2', nome: 'Notebook Dell XPS', preco: 8900.00, categoria: 'Informática', icone: '💻'),
    const Produto(id: '3', nome: 'Fone Bluetooth Sony', preco: 1200.00, categoria: 'Áudio', icone: '🎧'),
    const Produto(id: '4', nome: 'Smartwatch Garmin', preco: 2300.00, categoria: 'Wearables', icone: '⌚'),
    const Produto(id: '5', nome: 'Teclado Mecânico RGB', preco: 450.00, categoria: 'Periféricos', icone: '⌨️'),
  ];

  // Nível 1: adiciona um produto novo e atualiza a tela com setState
  void _adicionarProduto() {
    setState(() {
      _produtos.add(
        Produto(
          // timestamp evita ids repetidos depois de remover itens
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          nome: 'Novo Produto ${_produtos.length + 1}',
          preco: 99.90,
          categoria: 'Geral',
          icone: '🆕',
        ),
      );
    });
  }

  // Nível 2: remove o produto pelo id
  void _removerProduto(Produto produto) {
    setState(() {
      _produtos.removeWhere((p) => p.id == produto.id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${produto.nome} removido'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // Nível 3: navega para a tela de detalhes passando o produto pelo construtor
  void _abrirDetalhes(Produto produto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetalhesProdutoScreen(produto: produto),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Produtos'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                'Itens: ${_produtos.length}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _produtos.length,
        itemBuilder: (context, index) {
          final produto = _produtos[index];
          return Dismissible(
            key: ValueKey(produto.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) => _removerProduto(produto),
            child: ProdutoCard(
              produto: produto,
              onTap: () => _abrirDetalhes(produto),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarProduto,
        child: const Icon(Icons.add),
      ),
    );
  }
}
