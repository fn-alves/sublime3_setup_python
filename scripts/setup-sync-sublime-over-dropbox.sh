#!/bin/bash
# Sincroniza configurações + plugins instalados
#
# Testado no sistema windows rodando o git bash
#
# Nota: Se houver uma instalação existente no Dropbox,
# ira substituir as configurações pela do computador local

# Pasta onde esta isntalado o dropbox
DROPBOX="$HOME/Dropbox"

# Pasta onde é salvo as configurações do sublime no nosso Dropbox
SYNC_FOLDER="$DROPBOX/SublimeText3"

# Configurações do sublime
if [ `uname` = "MINGW64_NT-*" ]; then
    SOURCE="$HOME/AppData/Roaming/Sublime Text 3"
elif [ `uname` = "Linux" ]; then
    SOURCE="$HOME/.config/sublime-text-3"
else
    echo "Sistema operacional desconhecido"
    exit 1
fi

# Checa se realmente existe as configurações no computador
if [ ! -e "$SOURCE/Packages/" ]; then
    echo "Não foi encontrado $SOURCE/Packages/"
    exit 1
fi

# Verifica que não tentamos instalar duas vezes e estragar
if [ -L "$SOURCE/Packages" ]; then
    echo "Configurações do Dropbox já com simbolização"
    exit 1
fi

# Checa se p Drópbox não foi configurado em nenhum computador antes
if [ ! -e "$SYNC_FOLDER" ]; then
    echo "Configurando a pasta de sincronização no Dropbox"

    # Cria as pastas separadas por categorias
    mkdir -p "$SYNC_FOLDER/Installed Packages"
    mkdir -p "$SYNC_FOLDER/Packages"
    #mkdir -p "$SYNC_FOLDER/Settings"

    # Copia os arquivos em suas respectivas pastas
    cp -r "$SOURCE/Installed Packages/" "$SYNC_FOLDER/Installed Packages"
    cp -r "$SOURCE/Packages/" "$SYNC_FOLDER/Packages"
#        cp -r "$SOURCE/Settings/" "$SYNC_FOLDER/Settings"


# Agora, com as configurações no Dropbox, apague os arquivos locais existentes
    rm -rf "$SOURCE/Installed Packages"
    rm -rf "$SOURCE/Packages"
    #rm -rf "$SOURCE/Settings"

# Cria o link simbolico do Dropbox para as configurações locais
    ln -s "$SYNC_FOLDER/Installed Packages" "$SOURCE/Installed Packages"
    ln -s "$SYNC_FOLDER/Packages" "$SOURCE/Packages"
    #ln -s "$SYNC_FOLDER/Settings" "$SOURCE/Settings"
