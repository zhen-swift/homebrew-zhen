# CI

`.github/workflows/ci.yml` runs on every push to `main`, on every pull request, and by hand.
It has one job on a `macos-26` runner:

1. `Homebrew/actions/setup-homebrew` installs Homebrew and taps the checkout as
   `zhen-swift/zhen`.
2. `Scripts/check.sh` runs:
   - `brew trust --formula zhen-swift/zhen/zhen`, because Homebrew won't load a formula
     from a tap that isn't official unless it is trusted
   - `brew style`
   - `brew audit --strict --online`
   - `brew install --build-from-source`
   - `brew test`

It runs with `contents: read`, uses no secrets and never writes to the repository. A pull
request from a fork runs it unchanged.

To run it locally:

```sh
brew tap zhen-swift/zhen "$(git rev-parse --show-toplevel)"   # once
Scripts/check.sh
```
