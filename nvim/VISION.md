# Neovim Config Rewrite 2026 — Project Vision

> **Status**: vision agreed, technical decisions in progress
> **Branch**: `feat/2026-new` (dotfiles repo rooted at `~/.config`; this config lives in `nvim/`)
> **Owner**: Stoyko Tolev · macOS (Apple Silicon) · fish shell · tmux user · Neovim via Homebrew
> **Created**: 2026-07-04

This document is the single source of truth for the rewrite. A fresh AI session
should be able to read this file and continue the project without re-asking
anything in §2–§7. Open items are explicitly listed in §8.

## 1. What this is

A **full from-scratch rewrite** of the Neovim configuration (not an in-place
migration). The old config remains readable in git history on `main`
(`lua/stoykotolev/`, last nvim commit `db1feef`). The new config is built on
the current stable of everything, keeps the exact muscle memory of the old
one, trims unused subsystems, and adds a small number of new capabilities.

**Prime directive: staying current.** The user's core frustration is being
stuck on old versions (Neovim 0.11.5, a broken nvim-treesitter pin, legacy
lspconfig APIs). Every choice must favor the actively-developed track:
latest stable Neovim, treesitter `main` branch, native LSP config, and only
actively-maintained plugins. Updating should be routine, not scary.

## 2. Why (state of the old config)

Known defects the rewrite must eliminate:

1. **Double-formatting on TS/JS saves**: a `BufWritePre` autocmd in `lsp.lua`
   calls `conform.format()` explicitly, *and* conform's `format_on_save`
   fires on the same event → two format passes per save, visible buffer jump.
2. **Broken treesitter pin**: `lazy-lock.json` pins nvim-treesitter to the
   rewritten `main` branch while the config calls
   `require("nvim-treesitter.configs").setup()` — the old `master` API that
   doesn't exist on `main`.
3. **Legacy + new LSP APIs mixed**: `require("lspconfig")[server].setup()`
   (deprecated framework) combined with `mason-lspconfig automatic_enable = true`
   → servers likely configured twice.
4. **Broken blink.cmp snippet keymaps**: `"<C-l"` / `"<C-h"` are missing the
   closing `>` — snippet forward/backward navigation silently never worked.
5. **Keymap collision**: `<leader>ds` is both mini.surround "delete
   surrounding" and LSP "document symbols".
6. Stale pins: rustaceanvim `^4` (current v6), telescope `0.1.x`
   (maintenance mode), norcalli/nvim-colorizer (unmaintained).

## 3. User & workload profile

- **Day job**: TypeScript/React with Tailwind. Tooling is **eslint + prettier**
  (not biome). GraphQL is used at work.
- **Go**: significant daily Go work.
- **DevOps**: YAML, Dockerfiles, Kubernetes manifests, Helm charts.
- **Personal**: blog written in **Astro**.
- **Tests**: Vitest (JS/TS), standard `go test` (Go).
- **Debugging**: wants in-editor DAP for **Go and JS/TS** (old config was Go-only).
- Uses Claude Code in the terminal; wants **no AI plugins in the editor**.
- Not a distro user: config is hand-rolled and understood piece by piece.

## 4. Hard requirements

### 4.1 Platform & currency

- Neovim **0.12.3 stable** via `brew upgrade neovim` (currently on 0.11.5).
  Config targets 0.12 APIs; no compatibility shims for older versions.
- **nvim-treesitter `main` branch** with its new API (`require("nvim-treesitter").install(...)`,
  filetype-driven `vim.treesitter.start()`), not the frozen `master` API.
- **Native LSP config**: `vim.lsp.config()` / `vim.lsp.enable()` (and/or `lsp/`
  directory), with mason for binary installation. No legacy
  `require("lspconfig")[x].setup()` calls.
- lazy.nvim stays as plugin manager; `lazy-lock.json` stays committed.
- Only actively-maintained plugins. Where an old plugin is unmaintained, use
  the maintained successor.

### 4.2 Language matrix

| Domain | LSP | Format (conform) | Lint (nvim-lint) | Test | Debug |
|---|---|---|---|---|---|
| TS / JS / React | **vtsls** (tsgo later, see D2) + **eslint-lsp** + emmet | prettierd | (eslint via LSP, see D3) | neotest + neotest-vitest | nvim-dap + js-debug-adapter |
| HTML / CSS | html-ls, css-ls, emmet | prettierd | — | — | — |
| Tailwind | tailwindcss-ls (+ tailwind-tools.nvim, `cva`/`cx` class functions, smart_increment off) | — | — | — | — |
| Astro | astro-ls + eslint-lsp | prettierd | (eslint via LSP) | — | — |
| Go | gopls (completeUnimported, usePlaceholders, unusedparams) | gofumpt, golines, goimports-reviser | golangci-lint | neotest + go adapter | nvim-dap + delve (dap-go) |
| YAML / k8s | yaml-ls (+ Kubernetes schemas) | yamlfmt | — | — | — |
| Docker | dockerfile-ls | — | — | — | — |
| Helm | helm-ls | — | — | — | — |
| GraphQL | graphql-ls (graphql, gql filetypes) | prettierd | — | — | — |
| Lua | lua_ls + lazydev | stylua | — | — | — |
| Markdown | marksman | prettierd | markdownlint | — | — |
| JSON | jsonls | prettierd | — | — | — |

Treesitter grammars: everything from the old list minus `rust`:
lua, luadoc, markdown, markdown_inline, regex, vim, vimdoc, dockerfile, bash,
go, json, yaml, astro, tsx, typescript, javascript, html, css, graphql.

**Biome is dropped entirely** (formatter, linter, and the biome.json root-marker
gating logic).

### 4.3 Formatting pipeline (fixes defect #1)

Exactly **one** format pass per save:

- conform `format_on_save` is the *only* thing that formats on save.
- The TS on-save behavior is preserved: **add missing imports → organize
  imports → format** — but the import actions must not trigger a second
  format (they run before conform's single pass, with no explicit
  `conform.format()` call in the autocmd).
- ESLint runs as a native LSP server that attaches only in projects with an
  eslint config (built-in root detection replaces the old hand-rolled
  root-marker gating). nvim-lint remains for markdownlint + golangci-lint only.

### 4.4 Completion

- **blink.cmp** (kept), friendly-snippets, signature help on, docs auto-show,
  auto-brackets off, same menu layout.
- The **custom env-var completion source** (`blink-cmp-env.lua`, completes
  `$VAR` and `env.VAR` from the process environment) carries over as-is.
- lazydev source with score_offset 100 for Lua.
- Fix the snippet forward/backward keymaps (defect #4): `<C-l>` / `<C-h>` in
  insert mode.

### 4.5 Muscle memory — keymaps carry over 1:1

Leader is `<Space>`. The full contract (from old `map.lua` + plugin configs):

**Global (normal mode unless noted)**
| Key | Action |
|---|---|
| `<Esc>` | clear search highlight |
| `<C-a>` | select entire file (intentionally shadows increment) |
| `<C-d>` / `<C-u>` | half-page down/up, centered |
| `n` / `N` | next/prev match, centered |
| `yw` | yank inner word |
| `x` | delete char without yanking |
| `Y` | `yVaB` (yank surrounding block) |
| `<leader>q` / `<leader>w` / `<leader>x` | quit / write / write-quit |
| `<C-h/j/k/l>` (insert) | cursor left/down/up/right |
| `<leader>sv` / `<leader>ss` | vertical / horizontal split |
| `<C-h/j/k/l>` | window navigation |
| `<C-p>` / `<C-n>` | prev/next diagnostic (with float) |
| `<leader>e` | diagnostic float |
| `<leader>oq` | diagnostics to loclist |

**LSP (buffer-local on attach)**: `gd` definition · `gr` references · `gI`
implementation · `<leader>D` type definition · `<leader>ws` workspace
symbols · `<leader>rn` rename · `<leader>ca` code action · `K` hover · `gD`
declaration. Document-highlight on CursorHold, cleared on move.
*(`<leader>ds` document symbols removed per D8 — unused; re-add later if missed.)*

**Picker** (currently telescope; must port to whatever picker wins the open
decision): `<leader>ff` files · `<leader>fw` live grep · `<leader>fcw` grep
word under cursor · `<leader><leader>` buffers · `<leader>/` buffer fuzzy ·
`<leader>s/` grep open files · `<leader>sh` help · `<leader>sk` keymaps ·
`<leader>st` builtin pickers · `<leader>sd` diagnostics · `<leader>sr` resume ·
`<leader>s.` oldfiles · `<leader>sn` nvim config files. In-picker: `<C-j>/<C-k>`
move, `<C-q>` to quickfix, `<C-d>` delete buffer, q/dd/x in normal mode.

**Harpoon 2**: `<leader>a` add · `<C-e>` quick menu · `<leader>h/j/k/l` slots 1–4.

**Oil**: `<leader>t` parent dir · `<leader>ft` float · `<M-h>` open in split
(`<C-h>` unbound inside oil to keep window nav).

**DAP**: `<leader>dc` continue · `<leader>dsi` step into · `<leader>dso` step
over · `<leader>dsu` step out · `<leader>b` breakpoint · `<leader>B`
conditional breakpoint · `<leader>du` toggle UI.

**Go (gopher.nvim)**: `<leader>jgs` add json struct tags · `<leader>ygs` yaml tags.

**mini.surround**: `<leader>as` add · `<leader>fs` find · `sF` find left ·
`<leader>hs` highlight · `<leader>rs` replace · `sn` update n_lines.
*(delete-surround unbound per D8 — `<leader>ds` retired entirely; re-add later if missed.)*

**blink.cmp (insert)**: `<C-j>/<C-k>` select next/prev · `<C-n>` show ·
`<C-l>/<C-h>` snippet forward/backward (fixed).

**Treesitter incremental selection**: `<Enter>` init/expand · `<BS>` shrink.

~~**eslint-code-actions.nvim**: `<leader>da`~~ — retired (D3); ESLint fixes now
appear under the standard `<leader>ca` code-action menu.

### 4.6 Editor behavior contract (options & autocmds)

Relative + absolute line numbers · system clipboard (`unnamedplus`) ·
persistent undo · ignorecase+smartcase · signcolumn always · updatetime 250 ·
timeoutlen 300 · splits right/below · listchars (tab `» `, trail `·`, nbsp `␣`) ·
`inccommand=split` · cursorline · scrolloff 10 · no showmode (statusline has it) ·
nerd font assumed · conceallevel 0 for json/markdown · highlight on yank ·
quickfix window closes after selecting an entry · folds open by default
(foldlevel 99), fold impl is an open decision · indent auto-detection
(vim-sleuth or equivalent).

### 4.7 Carried-over plugins/behaviors (beyond the above)

- **gitsigns** with current-line blame (eol virt_text, 1s delay, same sign chars).
- **treesitter-context** capped at 1 line.
- **nvim-ts-autotag**, **template-string.nvim** (auto-backtick in JS/TS/Astro),
  **nvim-autopairs**, **todo-comments** (no signs), colorizer (**maintained
  fork** — catgoose/nvim-colorizer.lua), **fidget** for LSP progress,
  **mini.ai** (n_lines 500), **mini.surround**, **mini.statusline**
  (location `%2l:%-2v`).
- **mason** + a tool-installer mechanism so a fresh machine bootstraps all
  LSPs/formatters/linters/debuggers automatically.

### 4.8 New capabilities

1. **Test runner**: neotest with **vitest** and **Go** adapters. Keymaps: new,
   to be proposed (no existing muscle memory).
2. **Markdown preview** for the Astro blog (plugin choice: open decision).
3. **JS/TS debugging**: js-debug-adapter wired into nvim-dap alongside delve.

## 5. Explicit removals (agreed)

| Removed | Reason / replacement |
|---|---|
| rustaceanvim + rust toolchain | No Rust work. Re-addable in ~10 lines. |
| jikan-kanshi (own plugin) | No longer used. |
| noice.nvim + nvim-notify + nui.nvim | Messages UI was already disabled; native 0.12 UI is fine. Fidget stays. |
| Comment.nvim + nvim-ts-context-commentstring | Built-in `gc` + ts-comments.nvim for JSX/TSX node-aware comments (D7). |
| nvim-spectre | Replaced by grug-far.nvim (D6): ripgrep-based, live preview, editable results buffer, actively maintained. |
| Biome (formatter + linter + gating) | Work is eslint+prettier; simplifies pipeline. |
| eslint_d + eslint-code-actions.nvim (own plugin) | Replaced by the ESLint language server (D3): native diagnostics + fix actions under `<leader>ca`. |
| telescope + fzf-native + ui-select | Replaced by mini.pick + mini.extra (decision D1); `vim.ui.select` routes through mini.pick. |
| Rust treesitter grammar | With Rust support. |

## 6. Non-goals / constraints

- **No distro** (LazyVim, kickstart, etc.) — hand-rolled, understood config.
- **No AI plugins** — Claude Code lives in the terminal, editor stays clean.
- No session management, no git UI beyond gitsigns — explicitly declined;
  feature set is otherwise considered complete ("fairly solid for my use cases").
- Config stays at `~/.config/nvim` inside the dotfiles repo.

## 7. Success criteria

1. Neovim 0.12.3; `:checkhealth` clean; **zero deprecation warnings** at
   startup and after loading all plugins.
2. Every keymap in §4.5 works identically (except the resolved `<leader>ds`
   collision and the *fixed* snippet keys).
3. Saving a TS file produces **exactly one** format pass, with imports
   added/organized first.
4. `nvim --startuptime` not worse than the old config.
5. neotest runs a vitest suite and a Go package; DAP sessions work for both.
6. Markdown preview renders a blog post.
7. `lazy-lock.json` committed; a short UPDATING section in the config README
   documents the routine (`:Lazy update`, mason updates, `:TSUpdate`,
   `brew upgrade neovim`) so staying current is a habit, not a project.

## 8. Open technical decisions (walked through one at a time)

1. ~~**Picker**~~ **DECIDED 2026-07-04**: mini.pick + mini.extra (see §9, D1).
2. ~~**TS server**~~ **DECIDED 2026-07-04**: vtsls now, tsgo when ready (see §9, D2).
3. ~~**ESLint integration**~~ **DECIDED 2026-07-04**: ESLint LSP (see §9, D3).
4. ~~**Theme**~~ **DECIDED 2026-07-04**: trial trio — kanagawa (dragon) default,
   nightfox (nordfox) + nordic installed as alternates (see §9, D4).
5. ~~**Folding**~~ **DECIDED 2026-07-04**: native `vim.treesitter.foldexpr()`;
   ufo + promise-async dropped (see §9, D5).
6. ~~**Search/replace UI**~~ **DECIDED 2026-07-04**: grug-far.nvim (see §9, D6).
7. ~~**Comment strategy**~~ **DECIDED 2026-07-04**: built-in `gc` + ts-comments.nvim (D7).
8. ~~**`<leader>ds` collision**~~ **DECIDED 2026-07-04**: `<leader>ds` removed
   entirely — no document-symbols keymap, surround-delete unbound (D8).
9. ~~**Markdown preview**~~ **DECIDED 2026-07-04**: render-markdown.nvim,
   in-editor only; browser-accurate preview stays `astro dev`'s job (D9).
10. ~~**Config layout**~~ **DECIDED 2026-07-04**: conventional layout —
    `lua/config/{options,keymaps,autocmds,lazy}.lua` + `lua/plugins/*.lua` +
    top-level `lsp/` dir, one file per server (D11).
11. ~~**Indent detection**~~ **DECIDED 2026-07-04**: keep vim-sleuth (D10).
12. **Neotest + DAP keymaps**: new bindings to propose (no prior art in the
    old config) — concrete proposal ships with the build plan.

## 9. Decision log

Decisions get appended here as they're made, with rationale.

- **D1 (2026-07-04) — Picker: mini.pick + mini.extra, on trial.** User previously
  bounced off mini.pick (paste into prompt, keybind transfer), but those gaps are
  configurable: paste = built-in `<C-r>` + register action; `<C-j>/<C-k>` remap to
  move_down/move_up; `<C-q>` → `choose_marked` (sends to quickfix natively);
  buffer-delete in buffers picker via custom mapping recipe; missing pickers
  (diagnostics, keymaps, oldfiles, help, buf_lines) come from mini.extra;
  `vim.ui.select = MiniPick.ui_select`. Known feel-change: preview is a `<Tab>`
  toggle, not an always-on side pane. **Undo plan**: all picker keymaps live in
  one file mapping keys→functions; if the trial fails, swap engine to
  snacks.picker (runner-up) by rewriting that one file. Consolidates further on
  the already-used, very actively maintained mini.nvim ecosystem.
- **D2 (2026-07-04) — TS server: vtsls, with a planned move to tsgo.** User's
  first choice is tsgo (microsoft/typescript-go native LSP), but as of now its
  LSP lacks most code actions on save — including `source.addMissingImports`
  (tracked in microsoft/typescript-go#2444), which §4.3's on-save import flow
  hard-requires. vtsls (VS Code's TS service as a standard LSP server, current
  community default) is used until then. Must replicate: diagnostic 6133
  filter ("declared but never read" — eslint covers it), non-relative import
  preference, on-save addMissingImports → organizeImports → single format.
  **Revisit trigger**: when typescript-go#2444 closes / code actions ship,
  swap by enabling the upstream `tsgo` lspconfig instead of vtsls (~2 lines).
  typescript-tools.nvim is retired (slowed maintenance, bespoke non-LSP API).
- **D3 (2026-07-04) — ESLint via the ESLint language server.** Replaces
  nvim-lint+eslint_d diagnostics and retires the personal
  eslint-code-actions.nvim plugin: fix/disable-rule actions are native LSP
  code actions under `<leader>ca`. Attaches only where an eslint config
  exists (native root detection). nvim-lint's remaining scope: markdownlint,
  golangci-lint.
- **D4 (2026-07-04) — Theme: trial trio.** kanagawa (dragon variant) boots as
  default; nightfox (nordfox variant, Nord-derived like the old look) and
  nordic.nvim ship installed but inactive. Startup default is a single line in
  the theme spec — user flips at will during the trial, then the losers get
  removed.
- **D5 (2026-07-04) — Folding: native.** `foldmethod=expr` +
  `vim.treesitter.foldexpr()`, keeping the current off-by-default behavior
  (foldenable=false, foldlevel 99). nvim-ufo + promise-async removed — fold
  usage is too light to justify two plugins.
- **D6 (2026-07-04) — Search/replace: grug-far.nvim.** Maintained successor to
  spectre; ripgrep engine, live replacement preview, editable results buffer.
- **D7 (2026-07-04) — Comments: built-in `gc` + ts-comments.nvim** for
  JSX/TSX node-aware commentstring. Replaces Comment.nvim +
  ts_context_commentstring (two plugins → one tiny one).
- **D8 (2026-07-04) — `<leader>ds` retired entirely.** User doesn't recall
  using it under either meaning. No document-symbols keymap (workspace
  symbols `<leader>ws` remains); mini.surround delete unbound. Either is a
  one-line re-add if missed.
- **D9 (2026-07-04) — Markdown: render-markdown.nvim, in-editor only.**
  Browser-accurate blog preview is `astro dev`'s job; no browser-mirror plugin.
- **D10 (2026-07-04) — Indent detection: keep vim-sleuth.** Finished
  software; age is not a liability here.
- **D11 (2026-07-04) — Layout: conventional.** `init.lua` →
  `lua/config/{options,keymaps,autocmds,lazy}.lua`, plugin specs in
  `lua/plugins/*.lua` (one file per concern), native LSP server definitions
  in top-level `lsp/<server>.lua` (auto-discovered by `vim.lsp.config`).
  The `lua/stoykotolev/` namespace is retired with the old config.
