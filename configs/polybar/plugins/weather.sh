#!/usr/bin/env bash

# Configurações de Localização e Unidades
NOME_DA_CIDADE="Ibaretama"
UNIDADES="metric" # 'metric' para Celsius
LATITUDE="-4.79723"
LONGITUDE="-38.7529"
USER_AGENT="MinhaPolybarClient/1.0 (marcondes@voidmachine)"

# Configuração da API (MET Norway)
BASE_URL="https://api.met.no/weatherapi/locationforecast/2.0/compact/?lat=${LATITUDE}&lon=${LONGITUDE}"

# 1. Busca de Dados
RESPONSE=$(curl -s -A "$USER_AGENT" "$BASE_URL")

# 2. Verificação de Erro (Se a tag 'properties' não existir, houve falha)
if ! echo "$RESPONSE" | jq -e '.properties' > /dev/null; then
    echo "API Erro"
    exit 1
fi

# 3. Extração de Dados (jq)
TEMP=$(echo "$RESPONSE" | jq -r '.properties.timeseries[0].data.instant.details.air_temperature')
CONDICAO_CODIGO=$(echo "$RESPONSE" | jq -r '.properties.timeseries[0].data.next_1_hours.summary.symbol_code')

# Mapeamento de Ícones (Substitua os símbolos por caracteres da sua Nerd Font se necessário)
case "$CONDICAO_CODIGO" in
    "clearsky_day" | "clearsky_night") ICON="" ;;        # Sol/Lua
    "partlycloudy_day" | "partlycloudy_night" | "partlycloudy") ICON="" ;;    # Sol/Lua com nuvem
    "cloudy") ICON="" ;;
    "fog") ICON="🌫️" ;;                 # Névoa
    "rain" | "lightrain" | "rainshowers" | "lightrainshowers") ICON="" ;; # Chuva
    "snow" | "lightsnow" | "snowshowers") ICON="" ;; # Neve
    *) ICON="" ;; # Desconhecido
esac

# 4. Saída Final para a Polybar
if [ -z "$TEMP" ] || [ "$TEMP" == "null" ]; then
    echo "N/A"
else
    # Saída final formatada
    echo "${ICON} ${TEMP}°C"
fi

