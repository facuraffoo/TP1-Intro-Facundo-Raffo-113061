#!/bin/bash
directorio_inicial="$(dirname "$0")"
archivo_pokemons=$(find "$directorio_inicial" -type f -name "pokemon.csv" | head -n 1)
pokemon_habilidades=$(find "$directorio_inicial" -type f -name "pokemon_abilities.csv" | head -n 1)
archivo_habilidades=$(find "$directorio_inicial" -type f -name "ability_names.csv" | head -n 1)


pedir_pokemones() {
    echo "Ingrese un pokemon o 'ctrl + d' para salir: "
    while read -r nombre_pokemon; do
        encontrado=0
        while IFS=',' read -r id identifier species_id height weight base_experience order is_default; do
            if [[ $nombre_pokemon = $identifier ]]; then
                encontrado=1
                echo "-----------------------------"
                echo "Pokemon: $identifier"
                echo "Altura: $(( height * 10 )) cm."
                echo "Peso: $((weight / 10 )) kg."
                echo "Habilidades: "
                while IFS=',' read -r pokemon_id ability_pokemon_id is_hidden slot; do
                    if [[ $id -eq $pokemon_id ]]; then
                        while IFS=',' read -r ability_id local_language_id name; do
                            if [[ $ability_id -eq $ability_pokemon_id ]]; then
                                echo "* $name"
                            fi
                        done < <(tail -n +2 "$archivo_habilidades")
                    fi
                done < <(tail -n +2 "$pokemon_habilidades")
                echo "-----------------------------"
            fi
        done < <(tail -n +2 "$archivo_pokemons")
        
        if [[ $encontrado -eq 0 ]]; then
            echo "El pokemon '$nombre_pokemon' no existe en la base de datos."
        fi

        echo "Ingrese un pokemon o 'ctrl + d' para salir: "
    done
}

pedir_pokemones "$@"