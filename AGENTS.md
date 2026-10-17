# homebrew-zhen — the Homebrew tap for the zhen CLI

One formula, `Formula/zhen.rb`, which builds the `zhen` command line from a tagged
zhen-core release. Users install it with `brew install zhen-swift/zhen/zhen`.

## Source of execution truth

This repository is worked on from the InfinityCastle hub. Read `zhen-agents/README.md`
first. Precedence on conflict: **`zhen-agents/`** first, then this file, then `Docs/`.

## Rules

- **Tagged releases only.** `url` points to a pushed zhen-core tag's tarball, and `sha256`
  is that tarball's hash. A formula change is never a branch or an untagged commit. `head`
  exists for local testing and nothing else.
- **Core first.** A version bump here follows the zhen-core release it names. It is one PR
  in this repository, opened after the core tag is pushed.
- **No `zhen-helper`.** The helper is an `SMAppService` daemon that only the
  Developer-ID-signed app can register. The CLI does not use it.
- **No bottles.** Bottles would need a workflow that commits back with a write token, and
  workflows never write. CI is read-only and needs no secrets.
- **The local check is CI's check.** `Scripts/check.sh` is what CI runs, word for word.
- **Nothing from a real network is committed**, not even in a test.
- **Pushing, and opening pull requests, is JC's.** The repository is public. Commit locally,
  and leave the push unless JC says "push".

## Where things are

| Path | What |
|---|---|
| `Formula/zhen.rb` | The formula |
| `Scripts/check.sh` | Style, audit, build from source and `brew test`. What CI runs |
| `Docs/ARCHITECTURE.md` | Why it is shaped this way, and its known rough edges |
| `Docs/RELEASING.md` | Bumping the formula after a zhen-core tag |
| `Docs/CI.md` | What CI checks |
