# Releasing

The formula follows zhen-core. A new zhen version reaches Homebrew in this order.

1. **zhen-core:** the release commit bumps the version, and the tag is pushed. Tags have no
   `v` prefix, e.g. `0.8.0`.
2. **This repository:** one pull request that bumps the formula.

## Bumping the formula

```sh
VERSION=0.8.0
curl -sSL "https://github.com/zhen-swift/zhen-core/archive/refs/tags/$VERSION.tar.gz" \
    | shasum -a 256
```

1. In `Formula/zhen.rb`, set `url` to that tag's tarball and `sha256` to the hash printed
   above.
2. Add `- zhen $VERSION` under **Unreleased** in `CHANGELOG.md`.
3. Run the checks:

   ```sh
   brew tap zhen-swift/zhen "$(git rev-parse --show-toplevel)"   # once
   Scripts/check.sh
   ```

   `brew test` checks that `zhen --version` contains the new version, so a tag whose
   `ZhenVersion.current` wasn't bumped fails here.

4. Commit, and open the pull request.

Read **Known rough edges** in `Docs/ARCHITECTURE.md` before bumping to 0.8.0.
