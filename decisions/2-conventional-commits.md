# Conventional Commits

Each commit on `main` will follow the [Conventional Commits][2] structure.

Published on: September 6, 2023

## Problem Context

Allowing freeform commit messages with no structure can make it hard for casual project observers to understand what is changing and if those changes are breaking in any capacity.

## Decision Made

This project will require and enforce, [via GitHub Actions][1], pull request titles to match the [Conventional Commits][2] specification. The individual commits of a pull request will be squashed into `main`, allowing a single commit message to express what changed in a formatted way.

[1]: https://github.com/studyhall-project/studyhall/blob/32eda9073767760543c58d03c28547465e73ffff/.github/workflows/lint-pr.yaml
[2]: https://www.conventionalcommits.org

The benefit of this approach is that later, we might be better able to automate changelogs and have informed signals to a proper [semantic version][3]. It also encourages people to make small and focused pull requests.

[3]: https://semver.org

## Consequences & Tradeoffs

Getting better about writing in this format will take a little time, but the automated GitHub Action to lint the PR title should help nudge us in the right direction.

While we encourage people to include an issue number in related pull requests, this is not something we enforce since we want to allow people to make PRs with no related issue (for small things like typos).

Currently, we do not allow commits directly on `main` (a GitHub-protected branch), so there is little risk of commits ending up without this new format requirement.

If an outlier commit ended up on there without this format, it is also not a big deal.
