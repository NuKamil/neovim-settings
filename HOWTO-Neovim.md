# Neovim — moja konfiguracja i aktualizacje

Stan po migracji: **17 października 2026**. Komputer: **fsociety**, użytkownik **nurek**.
Wersja Neovima podczas migracji: **0.12.6**.

## 1. Najważniejsze na co dzień

Zwykły Neovim z bieżącego katalogu projektu — polecenie w terminalu:

```bash
nvim .
```

Wersja testowa z tego samego projektu — polecenie w terminalu:

```bash
NVIM_APPNAME=nvim-kickstart-test nvim .
```

`NVIM_APPNAME` wybiera osobne katalogi konfiguracji, danych i stanu.
Dotyczy tego jednego uruchomienia. Zwykłe `nvim` nadal używa konfiguracji codziennej.

**Polecenia zaczynające się od `:` wpisujemy w Neovimie po naciśnięciu Esc.
Polecenia `git` i `NVIM_APPNAME=...` wpisujemy w terminalu.**

## 2. Gdzie są moje pliki?

| Miejsce | Zadanie |
| --- | --- |
| `~/.config/nvim` | Codzienna konfiguracja i repo Git, zwykle gałąź `main`. |
| `~/.config/nvim-kickstart-test` | Osobny katalog roboczy tego samego repo — środowisko testowe. |
| `init.lua` | Baza Kickstarta; nasze zmiany to włączenie custom loadera i Nerd Font. |
| `lua/custom/plugins/colorscheme.lua` | Wybór motywu `one_dark_devmentors`. |
| `colors/` | Własne definicje motywów: FlatUI i dwie wersje One Dark DevMentors. |
| `lua/custom/plugins/snippets.lua` | Friendly Snippets i własne szablony C#. |
| `lua/custom/plugins/csharp.lua` | Roslyn dla C#. |
| `lua/custom/plugins/frontend.lua` | Vue, TypeScript, HTML, CSS, Tailwind i domykanie tagów. |
| `lua/custom/plugins/formatting.lua` | Prettier, formatowanie przy zapisie i zapasowe formatowanie przez LSP. |
| `lua/custom/plugins/editor.lua` | Względne numery linii i przesuwanie zaznaczenia przez J/K. |
| `lua/custom/plugins/tools.lua` | Lista narzędzi, które ma doinstalować Mason. |
| `nvim-pack-lock.json` | Zapis wersji wtyczek; śledzimy ten plik w Git. Nie edytujemy go ręcznie. |

Pełna ścieżka do przykładowego modułu:
`/home/nurek/.config/nvim/lua/custom/plugins/frontend.lua`.

Aby go otworzyć w codziennym Neovimie:

```vim
:edit ~/.config/nvim/lua/custom/plugins/frontend.lua
```

W testowym edytujemy analogiczny plik w `nvim-kickstart-test`.
Nie mieszamy obu katalogów podczas testowania.

Loader na końcu `init.lua`, czyli `require 'custom.plugins'`, uruchamia pliki Lua
z katalogu `lua/custom/plugins/`. Ich kolejność nie jest gwarantowana.
Powiązane kroki konfiguracji trzymamy razem w jednym module.

**Ikonki:** `vim.g.have_nerd_font = true` zostaje wcześnie w `init.lua`,
przed konfiguracją wtyczek. Kitty używa JetBrainsMono Nerd Font.

## 3. Skróty

`Space f` oznacza: naciśnij spację, potem małe `f`, w trybie normalnym.
Spacja jest klawiszem *leader*. To nie jest Shift+F.

| Skrót | Działanie |
| --- | --- |
| `Space f` | Formatuj plik lub zaznaczenie. |
| `K` (Shift+K) | Informacje o symbolu pod kursorem. |
| `Ctrl+Space` w trybie pisania | Otwórz podpowiedzi. |
| `Ctrl+N` / `Ctrl+P` | Następna / poprzednia podpowiedź. |
| `Ctrl+Y` | Przyjmij wybraną podpowiedź. |
| `grd` | Przejdź do definicji. |
| `grr` | Znajdź użycia. |
| `grn` | Zmień nazwę symbolu. |
| `gra` | Akcje kodu. |
| `Ctrl+O` | Wróć do poprzedniego miejsca. |
| `Space sf` | Wyszukaj plik. |
| `Space sg` | Szukaj tekstu w projekcie. |
| `Space sn` | Wyszukaj plik konfiguracji bieżącego Neovima. |
| `Space sk` | Przegląd skrótów. |
| `Space sd` | Wyszukaj diagnostykę. |
| `J` / `K` w trybie wizualnym | Przesuń zaznaczony tekst w dół / górę. |

Snippety C#: `clsK`, `sclsK`, `recK`, `srecK`, `ifaceK`.
Wpisz nazwę w pliku C#, wybierz podpowiedź i zaakceptuj przez Ctrl+Y.
Namespace jest wyliczany z najbliższego `.csproj` i podkatalogów;
nazwa typu pochodzi z nazwy pliku.

## 4. Co odpowiada za języki i formatowanie?

- **C#: Roslyn** (`roslyn_ls`), zamiast starego OmniSharp.
  Otwieramy plik z rzeczywistego projektu z `.csproj` lub rozwiązaniem.
- **Vue: `vue_ls` + `vtsls`**. Oba serwery powinny być podłączone do komponentu.
  Tailwind dołącza się, gdy wykryje odpowiedni projekt.
- **Frontend: Prettier**, ręcznie przez Space f i automatycznie przy zapisie.
  W projekcie Salon test pokazał użycie lokalnego `node_modules/.bin/prettier`.
- **Lua: StyLua**, dostarczony w bazie Kickstarta jako LSP.
  W naszym module formatowania usunęliśmy osobne przypisanie Lua do zewnętrznego formatera.
- **Mason** instaluje narzędzia z `tools.lua`; `auto_update = false`
  oznacza brak automatycznego aktualizowania już zainstalowanych narzędzi.

.NET SDK/runtime oraz Node.js/npm są zależnościami systemowymi.
Samo sklonowanie konfiguracji ich nie instaluje.

## 5. Trzy różne rodzaje aktualizacji

| Co zmieniam? | Mechanizm |
| --- | --- |
| Kod bazowej konfiguracji Kickstart | Git: pobranie z `upstream`, zwykły merge na gałęzi testowej. |
| Wersje wtyczek | `vim.pack`; wynik zapisujemy w `nvim-pack-lock.json`. |
| Serwery językowe i formatery | Mason; sprawdzamy osobno w `:Mason`. |

`pacman -Syu` aktualizuje systemowe pakiety. Nie zastępuje powyższych kroków.

## 6. Przed aktualizacją: przygotuj test

Zapisz pracę i zamknij instancje Neovima edytujące konfigurację.
Sprawdź obydwa katalogi:

```bash
git -C ~/.config/nvim status --short --branch
git -C ~/.config/nvim-kickstart-test status --short --branch
```

Jeśli są pozycje `M`, `??` lub zmiany w indeksie, najpierw je przejrzyj
i zapisz w odpowiednim commicie. Poniższe kroki zakładają czyste katalogi.

Zachowaj wskazanie obecnej wersji, a w środowisku testowym utwórz nową gałąź
od aktualnego `main`:

```bash
git -C ~/.config/nvim branch "nvim-backup-$(date +%Y%m%d-%H%M%S)"
git -C ~/.config/nvim-kickstart-test switch -c "nvim-update-$(date +%Y%m%d-%H%M%S)" main
```

To kopia historii konfiguracji i lockfile, nie kopia danych projektów ani narzędzi systemowych.
Gałęzie obu katalogów należą do jednego repo Git.

## 7. Aktualizacja samego Kickstarta

Adresy repo:
- moje `origin`: https://github.com/NuKamil/neovim-settings
- autor `upstream`: https://github.com/nvim-lua/kickstart.nvim
- śledzona gałąź autora podczas migracji: `upstream/master`

Najpierw pobierz zmiany i obejrzyj listę:

```bash
git -C ~/.config/nvim fetch upstream
git --no-pager -C ~/.config/nvim log --oneline HEAD..upstream/master
```

Pusta lista oznacza brak nowych commitów autora do włączenia.
Samo `fetch` nie zmienia plików konfiguracji.

Jeżeli są zmiany, przeczytaj ich opis i wymagania. Przygotuj środowisko
według punktu 6, a następnie:

```bash
git -C ~/.config/nvim-kickstart-test merge upstream/master
```

Przy konflikcie **zatrzymaj się i przejrzyj obie wersje**.
Status pokaże pliki wymagające rozwiązania.
Aby zrezygnować z trwającego, niedokończonego merge:

```bash
git -C ~/.config/nvim-kickstart-test merge --abort
```

Po udanym merge uruchom testową konfigurację z katalogu projektu:

```bash
NVIM_APPNAME=nvim-kickstart-test nvim .
```

Sprawdź C#, Vue i formatowanie według punktu 9.
Potem przejdź do zatwierdzenia z punktu 10.

**Ważne:** podczas migracji użyliśmy jednorazowo strategii `ours`, żeby połączyć
dwie wcześniej niezależne historie. Przy następnych aktualizacjach autora
używamy zwykłego `merge upstream/master`; `ours` pominęłoby jego zmiany w plikach.

## 8. Aktualizacja wtyczek

Najpierw przygotuj czyste środowisko testowe według punktu 6.
Uruchom testowego Neovima i wpisz:

```vim
:lua vim.pack.update()
```

Pojawi się widok proponowanych zmian. Przejrzyj go:
- `:write` zatwierdza aktualizacje.
- `:quit` odrzuca propozycję.

Po zatwierdzeniu zamknij edytor i uruchom go ponownie.
Przetestuj konfigurację, a zmieniony `nvim-pack-lock.json` zapisz w Git.

Mason ma osobne narzędzia. Do ich podglądu używaj `:Mason`.
Nie aktualizuj wszystkich warstw naraz — łatwiej ustalisz przyczynę ewentualnego problemu.

## 9. Krótki test przed przyjęciem nowej wersji

1. `:messages` — sprawdź błędy startu; komunikaty o instalacji parserów są normalne.
2. Otwórz C# w Salonie: K, podpowiedzi i przejście do definicji.
3. Sprawdź rozwijanie `clsK`.
4. Otwórz komponent Vue: K oraz podpowiedzi w części TypeScript.
5. `:checkhealth vim.lsp` — sprawdź aktywne serwery.
6. `:ConformInfo` — sprawdź dostępność formatera dla bieżącego pliku.
7. Space f i formatowanie przy zapisie; przejrzyj zmiany w projekcie.

Po instalacji narzędzi poczekaj na jej zakończenie; w razie potrzeby uruchom edytor ponownie.
Wynik testu dotyczy konfiguracji oraz wersji narzędzi na danym komputerze.

## 10. Zapisz test i przyjmij go jako codzienną konfigurację

Najpierw sprawdź zmiany w środowisku testowym:

```bash
git -C ~/.config/nvim-kickstart-test status --short --branch
git --no-pager -C ~/.config/nvim-kickstart-test diff
```

Jeśli aktualizacja wtyczek zmieniła lockfile, dodaj go i zapisz commit:

```bash
git -C ~/.config/nvim-kickstart-test add -- nvim-pack-lock.json
git -C ~/.config/nvim-kickstart-test commit -m "Update tested Neovim plugin versions"
```

Jeśli zmieniałeś inne pliki, dodaj również te konkretne pliki.
Gdy nie ma zmian, dodatkowy commit nie jest potrzebny.
Po zakończeniu testowa gałąź musi być czysta.

Zamknij Neovima. Sprawdź, czy codzienny katalog nadal jest czysty i stoi na `main`:

```bash
git -C ~/.config/nvim status --short --branch
```

Przyjmij dokładnie commit z aktualnie sprawdzanej gałęzi testowej:

```bash
git -C ~/.config/nvim merge --ff-only "$(git -C ~/.config/nvim-kickstart-test rev-parse HEAD)"
```

Jeżeli Git odmówi fast-forward, zatrzymaj się i sprawdź historię — nie wymuszaj nadpisania.

Uruchom zwykłe `nvim`, poczekaj na ewentualne instalacje i sprawdź działanie.
Jeżeli wszystko działa:

```bash
git -C ~/.config/nvim status --short --branch
git -C ~/.config/nvim push origin main
```

Jeśli instalacja zmieniła śledzone pliki, najpierw przejrzyj i zapisz te zmiany.
`origin` dostaje moje sprawdzone ustawienia; `upstream` służy do pobierania zmian autora.

## 11. Gdy coś nie działa

Bieżące komunikaty:

```vim
:messages
```

Informacje o LSP — używamy tego polecenia zamiast starego `:LspInfo`:

```vim
:checkhealth vim.lsp
```

Tylko nazwy serwerów podłączonych do aktualnego pliku:

```vim
:lua vim.print(vim.tbl_map(function(c) return c.name end, vim.lsp.get_clients({ bufnr = 0 })))
```

Brak klientów sprawdzaj z otwartego pliku źródłowego, nie z widoku katalogu.
Dla C# oczekujemy `roslyn_ls`; dla Vue przede wszystkim `vue_ls` i `vtsls`.

Formater i aktywny motyw:

```vim
:ConformInfo
:colorscheme
```

Aby skopiować historię komunikatów klawiaturą:

```vim
:new
:put =execute('messages')
```

Potem `gg`, `V`, zaznaczanie przez `j/k` i `"+y` do schowka.

Nie usuwaj całych katalogów konfiguracji lub danych jako pierwszego kroku naprawy.
Zachowana gałąź `kickstart-update` wskazuje dawny zestaw z Lazy;
commit tej wersji to `b5cd74b`.
Gałęzie `nvim-backup-...` z punktu 6 wskazują wersje sprzed kolejnych aktualizacji.

## 12. Co zostało na później?

- Dopasowanie kolorowania Vue. Stary i nowy Neovim wyglądały tak samo;
  nie jest to potwierdzony błąd migracji.
- Debugger .NET; dawna konfiguracja DAP nie została przeniesiona.
- Opcjonalne OpenCode, Fugitive i konfiguracja Neovide.
- Dawne osobne dodatki NuGet UI i lazydev nie zostały przeniesione.
- Ujednolicenie kopii konfiguracji Neovima w repo `NuKamil/fsociety-dotfiles`.
  Ta migracja została wysłana do `NuKamil/neovim-settings`.

Nie kasujemy teraz środowiska testowego — przyda się do kolejnych aktualizacji.
Stare archiwa `OldFiles`, `Rider` i `README_INSTALL.txt` pozostały w starej historii Git.

Punkt zakończenia migracji: **`2f495c4` na `main` i `origin/main`**.
Commit łączy nową bazę z dawną historią: rodzice `adcd7f7` oraz `b5cd74b`.

## Źródła techniczne

- [Kickstart — README](https://github.com/nvim-lua/kickstart.nvim)
- [Neovim — vim.pack i aktualizowanie wtyczek](https://neovim.io/doc/user/pack/)
- [Neovim — LSP](https://neovim.io/doc/user/lsp/)
- [Vue — konfiguracja Neovima](https://github.com/vuejs/language-tools/wiki/Neovim)
- [Konfiguracja Roslyn w nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/blob/master/lsp/roslyn_ls.lua)

Instrukcja opisuje stan sprawdzony w naszej sesji. Przy dużych aktualizacjach
sprawdź wymagania Neovima i informacje o zmianach autora.

