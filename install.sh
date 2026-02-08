#!/usr/bin/env bash

# IMPORTANTE - Caso o de algum erro, ele vai parar
set -e

# -----------------------------------------------------------------------------
# install.sh - roteiro para montar seu bootstrap de dotfiles
# -----------------------------------------------------------------------------
# Objetivo:
# - Ter 1 comando para preparar uma máquina nova sem instalar tudo manualmente.
# - Fazer isso de forma idempotente (rodar 2x não deve quebrar nada).
#
# Como usar este arquivo:
# - Comece pequeno: implemente um bloco por vez.
# - A cada bloco implementado, teste em uma máquina limpa/VM.
# - Só avance quando o bloco anterior estiver estável.
#
# Regra de ouro:
# - NÃO apagar arquivos do usuário sem confirmação.
# - Sempre fazer backup antes de sobrescrever configs existentes.

# [STEP 1] - DETECTAR OS

detect_distro() {
	local distro

	if [[ -r /etc/release ]]; then
		. /etc/os-release
		distro="${ID:-linux}"
		echo "DIIISTRO"
		echo "$distro"
	fi

}

detect_os() {
	local kernel
	kernel="$(uname -s)"

	case "$kernel" in
	Darwin)
		echo "macOS"
		;;
	Linux)
		echo "Você usa Linux"
		if [[ -r /etc/os-release ]]; then
			. /etc/os-release
		fi

		;;
	*)
		echo "Você está utilizando o Ruindows"
		exit -1
		;;
	esac
}

detect_os
detect_distro
