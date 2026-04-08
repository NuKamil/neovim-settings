# Kickstart + Twoje dodatki

To jest gotowy zestaw oparty o najnowszy `init.lua` z Kickstart.nvim, ale z zachowaniem Twoich dodatków.

## Struktura

- `init.lua` — nowa baza Kickstarta z Twoimi zmianami:
  - Nerd Font = true
  - relative numbers = true
  - J/K do przesuwania zaznaczonych linii
  - LSP dla Vue / VTSLS / Tailwind / OmniSharp / HTML / CSS
  - prettier w Conform
  - import `custom.plugins`
- `lua/custom/plugins/opencode.lua`
- `lua/custom/plugins/nuget.lua`
- `lua/custom/plugins/dap.lua`
- `lua/custom/plugins/colors.lua`
- `lua/custom/plugins/coding.lua`
- `lua/custom/plugins/frontend.lua`

## Jak to wgrać

1. Zrób kopię obecnego configu:
   - Windows: skopiuj `%LOCALAPPDATA%\nvim`
   - Linux: skopiuj `~/.config/nvim`

2. Podmień pliki:
   - `init.lua` -> do głównego katalogu configu Neovim
   - cały folder `lua/custom/plugins/` -> do Twojego `lua/custom/plugins/`

3. Uruchom Neovim i wykonaj:
   - `:Lazy sync`
   - `:Mason`
   - `:checkhealth`
   - `:TSUpdate`

4. Zrestartuj Neovim.

## Szybkie testy

- `:LspInfo` w pliku `.vue` -> powinny być `vue_ls` i `vtsls`
- wpisanie tagu w `.vue` -> powinno działać lepiej dzięki `nvim-ts-autotag`
- `:Mason` -> sprawdź czy są `vue-language-server`, `vtsls`, `tailwindcss-language-server`, `omnisharp`, `prettier`, `netcoredbg`

## Uwaga

Jeżeli masz już własne pliki w `lua/custom/plugins/`, porównaj je przed nadpisaniem.
Największe miejsca potencjalnego konfliktu:
- inny colorscheme
- inna konfiguracja DAP
- własne dodatkowe pluginy w `custom.plugins`
