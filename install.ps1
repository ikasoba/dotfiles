function which($Cmd) {
  (Get-Command $Cmd)[0].Path
}

function Resolve-PathString([Parameter(ValueFromPipeline)] $Path) {
  $Path -replace "[^/\\]*[/\\]\.\.", "" -replace "\.[/\\]", ""
}

function ConfigRoot {
  if ($env:Appdata -eq $null) {
    return "$env:HOME/.config"
  }
  else {
    return $env:Appdata
  }
}

New-Item -ItemType SymbolicLink -Target (Resolve-Path "./helix/config.toml")   -Path "$(ConfigRoot)/helix/config.toml"
New-Item -ItemType SymbolicLink -Target (Resolve-Path "./helix/languages.toml")   -Path "$(ConfigRoot)/helix/languages.toml"
New-Item -ItemType SymbolicLink -Target (Resolve-Path "./wezterm/wezterm.lua") -Path (Join-Path (which "wezterm") "../wezterm.lua" | Resolve-PathString)