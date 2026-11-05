# Baixa os JSON do PokéIdle Hub para data/jogo/ (uso offline).
# Depois, no HTML, altere ORIGEM_DADOS para './data/jogo/'

$base = "https://pokeidle-gg.pages.dev/data/jogo"
$dest = Join-Path $PSScriptRoot "data\jogo"
New-Item -ItemType Directory -Force -Path $dest | Out-Null

$arquivos = @(
  "assets/creatures.json",
  "assets/creatures-novos.json",
  "assets/creatures-outland-novos.json",
  "assets/creatures-formas.json",
  "assets/creatures-audit-overrides.json",
  "constantes.json",
  "versao.json",
  "ritmo-mapas.json",
  "hunts.json"
)

foreach ($rel in $arquivos) {
  $url = "$base/$rel"
  $out = Join-Path $dest ($rel -replace '/', [IO.Path]::DirectorySeparatorChar)
  $dir = Split-Path $out -Parent
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  Write-Host "Baixando $rel ..."
  Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing
}

Write-Host "Pronto. Os modulos shared/ continuam no CDN (ORIGEM_JS no HTML)."
