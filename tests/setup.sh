#!/usr/bin/env bash

rm -rf resultados_tests
rm -f resultado_test_2.txt
rm -f resultado_test_3.txt
if [ -e parte_1.sh ]; then
    chmod +x parte_1.sh;
fi
if [ -e parte_2.sh ]; then
    chmod +x parte_2.sh;
fi
if [ -e parte_3.sh ]; then
    chmod +x parte_3.sh;
fi