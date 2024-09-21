# Pega o caminho completo do arquivo de configuração do Neovim
MYVIMRC_PATH="$MYVIMRC"

# Usa 'dirname' para pegar somente o diretório
CONFIG_DIR=$(dirname "$MYVIMRC_PATH")

# Exibe o diretório
echo "$CONFIG_DIR"
