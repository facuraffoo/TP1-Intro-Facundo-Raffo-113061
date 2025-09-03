#!/usr/bin/env bash

if [ ! -e parte_3.sh ]; then
  # No considerar error si aún no existe el archivo.
  echo "Salteando test porque no hay archivo 'parte_3.sh' para correr";
  exit 0;
fi

./parte_3.sh
if [ ! -e output.txt ]; then
  echo "La parte 3 no crea el archivo necesario.";
  exit 1;
fi

./parte_1.sh 99779 resultados_tests
cat resultados_tests/resultado.txt | ./parte_2.sh > resultado_test_3.txt

if grep -iq golem resultado_test_3.txt \
    && grep -q "140" resultado_test_3.txt \
    && grep -q "300" resultado_test_3.txt \
    && grep -iq "cabeza roca" resultado_test_3.txt \
    && grep -iq "robustez" resultado_test_3.txt \
    && grep -iq "velo arena" resultado_test_3.txt; then
    echo "Genial! Parece funcionar la parte 3."
else
    echo "Ups! Algo no funciona en la parte 3 sobre cómo se debieran comunicar parte 1 y 2. O no muestra la información necesaria de los pokemons correctos en las unidades correctas."
    exit 1;
fi