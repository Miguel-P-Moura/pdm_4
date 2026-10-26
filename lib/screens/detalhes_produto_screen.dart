import 'package:flutter/material.dart';
import '../models/produto.dart';

class DetalhesProdutoScreen extends StatelessWidget {
  final Produto produto;

  const DetalhesProdutoScreen({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(produto.nome)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(produto.icone, style: const TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            Text(
              produto.nome,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text('Categoria: ${produto.categoria}'),
            const SizedBox(height: 8),
            Text(
              'R\$ ${produto.preco.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 4),
            Text('ID: ${produto.id}'),
          ],
        ),
      ),
    );
  }
}
