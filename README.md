# homebrew-tap for Sigstore

> [!IMPORTANT]
> **This tap is no longer maintained.**
>
> The Sigstore formulae have been migrated to
> [homebrew/core](https://github.com/Homebrew/homebrew-core), so you no longer
> need this tap. Existing installs of `sigstore/tap/<formula>` are automatically
> redirected to their `homebrew/core` equivalents.

## Installation

Install directly from `homebrew/core` (no `brew tap` required):

```
brew install cosign
brew install gitsign
brew install rekor-cli
```

`gitsign-credential-cache` is included with the `gitsign` formula.

## Formulae

| Formula | Status | Replacement |
| ------- | ------ | ----------- |
| [cosign](https://github.com/sigstore/cosign)                    | Migrated  | `brew install cosign` (homebrew/core) |
| [gitsign](https://github.com/sigstore/gitsign)                  | Migrated  | `brew install gitsign` (homebrew/core) |
| gitsign-credential-cache                                        | Migrated  | Ships with `brew install gitsign` (homebrew/core) |
| [rekor-cli](https://github.com/sigstore/rekor)                  | Migrated  | `brew install rekor-cli` (homebrew/core) |
| [policy-tester](https://github.com/sigstore/policy-controller)  | Disabled  | No `homebrew/core` equivalent |
| [sget](https://github.com/sigstore/cosign)                      | Disabled  | Discontinued upstream |

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh/)
