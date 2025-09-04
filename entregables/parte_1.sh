#!/bin/bash

cantidad_argumentos=$#
padron=$1
directorio=$2
directorio_inicial="$(dirname "$0")"
archivo_pokemons=$(find "$directorio_inicial" -type f -name "pokemon.csv" | head -n 1)
archivo_tipos=$(find "$directorio_inicial" -type f -name "pokemon_types.csv" | head -n 1)
archivo_pokemon_stats=$(find "$directorio_inicial" -type f -name "pokemon_stats.csv" | head -n 1)
archivo_stats=$(find "$directorio_inicial" -type f -name "stats_names.csv" | head -n 1)


verificar_cantidad_argumentos() {
    if [ $cantidad_argumentos -ne 2 ]; then
        echo "Necesito dos argumentos: el padron y luego el directorio. Ej: ./ejecutable <padron> <directorio>"
        exit 1
    fi
}

verificar_si_es_numero() {
    if [[ ! $padron =~ ^[0-9]+$ ]]; then
        echo "Solo acepto un numero entero positivo como padron"
        exit 1
    fi
}

verificar_directorio() {
    if [ ! -d $directorio ]; then
        mkdir $directorio 
    fi
    touch "$directorio/resultado.txt"
}

filtrar_pokemons() {
    : > "$directorio/resultado.txt"
    local tipo_pokemon=$((padron % 18 + 1))
    local min_estadistica=$((padron%100 + 350))
    while IFS=',' read -r pokemon_id_tipos tipo_id slot; do
        if [[ "$tipo_id" -eq "$tipo_pokemon" ]]; then
            while IFS=',' read -r id identifier species_id height weight base_experience order is_default; do
                if [[ "$id" -eq "$pokemon_id_tipos" ]]; then
                    local contador_estadistica=0
                    while IFS=',' read -r pokemon_id_stats stat_id base_stat effort; do
                        if [[ "$id" -eq "$pokemon_id_stats" ]]; then
                            contador_estadistica=$((contador_estadistica + base_stat))
                        fi
                    done < <(tail -n +2 "$archivo_pokemon_stats")
                    if [[ $contador_estadistica -gt $min_estadistica ]]; then
                        echo "$identifier" >> "$directorio/resultado.txt"
                    fi
                fi
            done < <(tail -n +2 "$archivo_pokemons")
        fi
    done < <(tail -n +2 "$archivo_tipos")
    echo "El programa se ejecuto con exito!"
}

verificar_cantidad_argumentos "$@"
verificar_si_es_numero "$@"
verificar_directorio "$@"
filtrar_pokemons "$@"
