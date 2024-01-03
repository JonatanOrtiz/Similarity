#!/bin/sh

check_program_installed() {
    if ! command -v $1 &> /dev/null; then
        echo "É necessário ter instalado o \033[0;32m$1\033[0m para que possa executar o comando atual. Para isso execute \033[0;32mbrew install $1\033[0m\n"
        exit 1;
    fi
}