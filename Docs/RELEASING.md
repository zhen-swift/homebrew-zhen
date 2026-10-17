# Releasing

The formula follows zhen-core. A new zhen version reaches Homebrew in this order.

1. **zhen-core:** the release commit bumps the version, and the tag is pushed. Tags have no
   `v` prefix, e.g. `0.8.0`.
2. **This repository:** one pull request that bumps the formula.

## Bumping the formula

```sh
VERSION=0.9.0
git ls-remote https://github.com/zhen-swift/zhen-core.git "refs/tags/$VERSION^{}"
```

1. In `Formula/zhen.rb`, set `tag:` to `$VERSION` and `revision:` to the commit printed
   above. It is the `^{}` line: tags are annotated, and `revision:` is the commit, not the
   tag object.
2. Add `- zhen $VERSION` under **Unreleased** in `CHANGELOG.md`.
3. Run the checks:

   ```sh
   brew tap zhen-swift/zhen "$(git rev-parse --show-toplevel)"   # once
   Scripts/check.sh
   ```

   `brew test` checks that `zhen --version` contains the new version, so a tag whose
   `ZhenVersion.current` wasn't bumped fails here.

4. Commit, and open the pull request.

Read **Known rough edges** in `Docs/ARCHITECTURE.md` before a bump.
