#!/usr/bin/env bash

if [ ! -e parte_2.sh ]; then
  # No considerar error si aún no existe el archivo.
  echo "Salteando test porque no hay archivo 'parte_2.sh' para correr";
  exit 0;
fi

echo "metagross" | ./parte_2.sh > resultado_test_2.txt

if grep -iq metagross resultado_test_2.txt \
    && grep -q "160" resultado_test_2.txt \
    && grep -q "550" resultado_test_2.txt \
    && grep -iq "cuerpo puro" resultado_test_2.txt \
    && grep -iq "metal liviano" resultado_test_2.txt; then
    echo "Genial! Funciona la parte 2."
else
    echo "Ups! Algo no funciona en la parte 2: no muestra la información necesaria de los pokemons correctos en las unidades correctas."
    exit 1;
fi