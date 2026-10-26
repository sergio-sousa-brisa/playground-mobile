import 'package:flutter/material.dart';
import 'package:playgroundmobile/models/planet.dart';
import 'package:transparent_image/transparent_image.dart';

class GridPlanetsItem extends StatelessWidget {
  const GridPlanetsItem({super.key, required this.planet});

  final Planet planet;

  String _formatPopulation(String population) {
    final value = int.tryParse(population);
    if (value == null) return population;
    if (value >= 1000000000)
      return '${(value / 1000000000).toStringAsFixed(1)}B';
    if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(1)}M';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(1)}K';
    return population;
  }

  @override
  Widget build(BuildContext context) {
    final mainTerrain = planet.terrain.split(',').first.trim();

    return Card(
      elevation: 2, // Leve sombra para destacar do fundo da tela
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip
          .antiAlias, // Fundamental para o Stack respeitar as bordas do Card
      child: Stack(
        fit: StackFit.expand, // Faz a imagem preencher todo o Card
        children: [
          // 1. Imagem de Fundo
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: planet.image,
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[800],
              child: const Icon(
                Icons.image_not_supported_rounded,
                size: 38,
                color: Colors.white54,
              ),
            ),
          ),

          // 2. Gradiente escuro para dar leitura aos textos
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black54, Colors.black87],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.4,
                    0.75,
                    1.0,
                  ], // Controla onde o escurecimento começa
                ),
              ),
            ),
          ),

          // 3. Textos e Ícones por cima do gradiente
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  planet.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.landscape_rounded,
                      size: 14,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        mainTerrain,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.groups_rounded,
                      size: 14,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        _formatPopulation(planet.population),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
