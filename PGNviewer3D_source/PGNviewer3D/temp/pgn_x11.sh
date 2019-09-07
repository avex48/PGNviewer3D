#!/bin/bash
# parametri: $1=file.pgn

## init
[[ -s $1 ]] && fpgn="$1" || { echo "il file '${1}' non esiste oppure è vuoto"; exit 1; }
# file senza annotazioni (accodo '_sa' al nome originale)
#fmoves="${fpgn%.*}_moves.pgn"

fmoves="${fpgn%/*}/moves.pgn"
fuci="${fpgn%.*}.uci"
## main
# eseguo conversione e esco
pgn-extract -Wuci -C -N -V -o "$fuci" "$fpgn"
pgn-extract --nomovenumbers --noresults --notags -C -N -V -o "$fmoves" "$fpgn"
exit $?
