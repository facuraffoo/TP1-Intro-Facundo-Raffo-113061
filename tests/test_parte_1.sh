#!/usr/bin/env bash

if [ ! -e parte_1.sh ]; then
  # No considerar error si aún no existe el archivo.
  echo "Salteando test porque no hay archivo 'parte_1.sh' para correr";
  exit 0;
fi

# First use should return the correct pokemons
./parte_1.sh 99779 resultados_tests

RESULT1=$(head -n 5 resultados_tests/resultado.txt | tr ' ' '\n' | tr -d '\r')
EXPECTED1=$(printf '%s\n' "golem rhydon omastar kabutops aerodactyl" | tr ' ' '\n')

if diff -u <(echo "$EXPECTED1") <(echo "$RESULT1"); then
  :
else
  echo "Ups, hubo un error.\n*** Resultado esperado:\n"$EXPECTED1"\n*** Resultado obtenido:\n"$RESULT1;
  exit 1;
fi

# Seconds use should clean previous file and use new correct pokemons.
./parte_1.sh 100020 resultados_tests

RESULT2=$(head -n 5 resultados_tests/resultado.txt | tr ' ' '\n' | tr -d '\r')
EXPECTED2=$(printf '%s\n' "raichu magneton electrode electabuzz jolteon" | tr ' ' '\n')

if diff -u <(echo "$EXPECTED2") <(echo "$RESULT2"); then
  echo "Genial! Funciona la parte 1.";
else
  echo "Ups, hubo un error.\n*** Resultado esperado:\n"$EXPECTED2"\n*** Resultado obtenido:\n"$RESULT2;
  exit 1;
fi