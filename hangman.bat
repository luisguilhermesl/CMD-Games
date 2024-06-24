@echo off
chcp 65001 > nul
title Jogo da Forca
color 0a

setlocal enabledelayedexpansion

:: Define a palavra secreta
set "palavra_secreta=PROGRAMACAO"
set "palavra_oculta="
for /l %%i in (1,1,%=palavra_secreta:~0,-1%=%) do set "palavra_oculta=!palavra_oculta!_ "

set tentativas=6
set letras_tentadas=

:: Desenha o tabuleiro
:desenha_tabuleiro
cls
echo.
echo Palavra: !palavra_oculta!
echo Tentativas restantes: !tentativas!
echo Letras tentadas: !letras_tentadas!
echo.

:: Solicita uma letra ao jogador
set /p "letra=Digite uma letra: "
set "letra=!letra:~0,1!"
set "letra=!letra:~0,1!"

:: Verifica se a letra já foi tentada
if "!letras_tentadas:!letra!=!" neq "!letras_tentadas!" (
    echo Você já tentou a letra "!letra!".
    timeout /t 2 > nul
    goto desenha_tabuleiro
)

:: Adiciona a letra às letras tentadas
set "letras_tentadas=!letras_tentadas!!letra!"

:: Verifica se a letra está na palavra
set encontrado=0
for /l %%i in (0,1,%=palavra_secreta:~0,-1%=%) do (
    if "!palavra_secreta:~%%i,1!"=="!letra!" (
        set "palavra_oculta=!palavra_oculta:~0,%%i!!letra!!palavra_oculta:~%%i+1!"
        set "encontrado=1"
    )
)

:: Se a letra não foi encontrada, decrementa as tentativas
if !encontrado!==0 (
    set /a tentativas-=1
)

:: Verifica se o jogador ganhou ou perdeu
if "!palavra_oculta: =!"=="!palavra_secreta!" (
    echo Parabéns! Você adivinhou a palavra "!palavra_secreta!".
    pause
    goto fim
)

if !tentativas! leq 0 (
    echo Você perdeu! A palavra era "!palavra_secreta!".
    pause
    goto fim
)

goto desenha_tabuleiro

:fim
exit /b
