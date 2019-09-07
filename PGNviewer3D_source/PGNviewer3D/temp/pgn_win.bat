
PUSHD %APPDATA%\Godot\app_userdata\PGNviewer3D\temp

pgn-extract -Wuci -C -N -V -o current.uci current.pgn
pgn-extract --nomovenumbers --noresults --notags -C -N -V -o moves.pgn current.pgn

POPD