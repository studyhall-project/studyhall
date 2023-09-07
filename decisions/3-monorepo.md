# Monorepo

While there are many diverse language parts to the StudyHall platform, we will use a single repo for the majority of the codebase.

Published on: September 6, 2023

## Problem Context

Do we use multiple language/scope-based repos or a single monorepo?

## Decision Made

When structuring project repos, you could keep each unit (frontend, backend, etc) in different repos since they each have their own CI norms and requirements, but I think this is a poor idea for StudyHall.

Since the backend and frontend will be very coupled and mostly deployed together, I think it would make things a lot easier to use one monorepo. Additionally this will make things like shared issues, project boards, codespaces and project document easier, since it will all be in one place.

## Consequences & Tradeoffs

This is a low risk decision.

In time the size and activity of the repo might become distracting. If so, extracting would not be impossible.
