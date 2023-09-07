# Early Architecture

A quick overview of the planed architecture.

Published on: September 6, 2023, by [@zorn].

[@zorn]: https://github.com/zorn

## Problem Context

There are many ways to build a web app. These are my early plans for StudyHall and will likely change in the future, but this document captures my thinking in these early moments of creation.

Aside: I'm writing this in the singular. Hopefully, in time, I can find some help and contributors, and they will have some thoughts too.

## Decision Made: Backend

I've worked with [Elixir] and [Phoenix] for many years and find they provide an incredible environment for web application building. For this specific app, I plan to lean on the [Ash Framework] to help me model the business domain and then use [AshGraphql] to help me generate a GraphQL API for the frontend.

I also want to use tools like [Oban] for job processing and [Sentry] and [Honeycomb] for observability.

[Elixir]: https://elixir-lang.org/
[Phoenix]: https://www.phoenixframework.org/
[Ash Framework]: https://ash-hq.org/
[AshGraphql]: https://ash-hq.org/docs/guides/ash_graphql/latest/tutorials/getting-started-with-graphql
[Oban]: https://getoban.pro/
[Honeycomb]: https://www.honeycomb.io/
[Sentry]: https://sentry.io/

### Consequences & Tradeoffs: Backend

Not much else was considered. The use of Ash, which I experimented with before this kickoff, is a new choice for me. Ideally, it will help replace a lot of manual business context construction and help provide solved problems like authentication, pagination, role-based authorization, and GraphQL generation. I've done manual GraphQL development before, and creating whole new nouns can be pretty involved.

When I build tests for the backend, I will do so using a plain GraphQL experience, such that if Ash does not work out, I can swap it out for a more manual [Absinthe] implementation and maintain the graph schema.

[Absinthe]: https://hexdocs.pm/absinthe/overview.html

The use of Honeycomb will also be new for me. I am hopeful it will work out, but I might consider other open-source tools in the future, like [Grafana] or [Prometheus]. To start, however, considering the solo nature of this project, I want to lean on platform-as-a-service help as much as possible.

[Grafana]: https://grafana.com/
[Prometheus]: https://prometheus.io/docs/introduction/overview/

For databases I will use [PostgreSQL]. It is rock solid.

[PostgreSQL]: https://www.postgresql.org/

## Decision Made: Frontend

For the frontend, I'll be using [Svelte] and [SvelteKit]. These are very new technologies for me, and I expect extra learning time.

[Svelte]: https://svelte.dev/
[SvelteKit]: https://kit.svelte.dev/

To help build the UI, I'll lean on [Skeleton] and [Tailwind]. I'll also use [Houdini] as a JavaScript library to help me consume GraphQL in a Svelte-friend way. For validation and forms, I'll be using [Zod] and [Superforms]. The code itself will use TypeScript. Despite TypeScript's recent dismissal by some library authors, Skeleton and Houdini, in particular, favor [TypeScript], and it would be a helpful skill for me to get familiar with.

[Skeleton]: https://www.skeleton.dev/
[Tailwind]: https://tailwindcss.com/
[Houdini]: https://houdinigraphql.com/
[Zod]: https://zod.dev/
[Superforms]: https://superforms.rocks/
[TypeScript]: https://www.typescriptlang.org/

### Consequences & Tradeoffs

Considering my significant experience with [LiveView], the decision to use SvelteKit is significant. There are a few things in my head:

1. I am interested in building some complex UI interactions, animations, and view transitions -- and while it's not ridiculous to imagine using JavaScript through LiveView injections to accomplish this, there is part of me that feels like if I am going to go this route, I should just embrace the JavaScript environment for what it is.
2. While I am happy that LiveView has enhanced its component primitives, they still seem lacking compared to what I see in JavaScript. Furthermore, the number of community efforts for solving frontend UI concerns is just way more plentiful. Ultimately, I feel like I will be able to experiment and more quickly produce complex UI experiences with Svelte over LiveView.
3. I'm still not sold on the reliability of websockets for broad use-case web experiences. It can be the right call for admin desktop-browser work or heavy real-time experiences. However, there are real-world experiences of the mobile web on the phone that leave me concerned. For StudyHall, I'd like that mobile web experience to be solid.
4. I am hungry to learn new things. When I spent a summer learning Rust, it made me a better developer. If I learn other UI systems, it will make me a better developer.
5. Nothing is ever final. One hope is that by building a GraphQL API, new UI approaches could come in (mobile apps?) and use the existing business interfaces without an entire platform rewrite.
6. Regarding GraphQL, I want this platform to empower people to access, edit, and own their data. Forcing myself to use an API will ensure the users can do the same. 

The significant tradeoff is, of course, added tech complexity. Doing the whole thing in Elixir, a single language and paradigm, has advantages. Having an entire separate toolchain to manage the frontend is not free, it will be more work to do, and for me specifically, it will involve a lot of learning.

One negative I always associate with JavaScript is the quickness with which libraries evolve and break things. In this respect, things are even. LiveView continues to reinvite itself all the time, too, and while some enhancements are optional, on the whole, you need to be constantly refactoring to keep up with LiveView norms. Is there any web UI outside of plain HTML that lasts?

Before I finish this section, I also want to plug SvelteKit's approach to [progressive enhancement]. It is very admirable how Rich does demos and shapes this framework to support no JavaScript fallbacks and then enhanced experiences when available. Coming into Svelte, I was heavily leaning towards building a lot of this as a client-side logic, but I will give Svelte's progressive enhancement a good attempt. 

[LiveView]: https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html
[progressive enhancement]: https://learn.svelte.dev/tutorial/progressive-enhancement

## Decision Made: Deployment

The deployment story for StudyHall is still a little foggy. I suspect I will try to deploy using [Render] and hope to take advantage of [GitHub Actions] as much as possible for CI/CD. 

[Render]: https://render.com/
[GitHub Actions]: https://docs.github.com/en/actions

### Consequences & Tradeoffs

The other platform I considered was of course, [Fly.io]. I may tinker with them, but I do want a fully managed database, which they do not offer. I've also heard some flaky stories of their deployment uptime, but I've heard that of Render as well, so who knows? All I do know is I want to avoid managing machines myself. 

[Fly.io]: https://fly.io/

## Decision Made: Project Management

I will use [GitHub] to host the code and track Issues and various [GitHub Project boards]. I have been using GitHub Projects in various other work, and it's a good balance of simplicity.

[GitHub]: https://github.com/studyhall-project
[GitHub Project boards]: https://docs.github.com/en/issues/planning-and-tracking-with-projects/learning-about-projects/about-projects

There was no real consideration of a GitHub alternative. While I agree with some who say that we are giving Microsoft too much power with GitHub tooling, I can't fight that it is the place to be for open source, and overall, the tooling is very well done. 

I hope to share project progress but will likely do that on my personal YouTube channel and socials until StudyHall reaches a growth point worthy of its own accounts.
