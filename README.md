# StudyHall

## About

StudyHall is an open-source courseware platform that (aspires -- it's very early) to help people publish and consume courses focused on improving programming and technical skills. 

The early user experience will lean towards maximizing student success through tooling that:

* helps teachers understand student goals and progress
* provides streamlined communication tools to ask for and provide help
* allows students to provide content feedback to help improve courses over time

You can track early development efforts via the project board:

https://github.com/orgs/studyhall-project/projects/1

## Early Deployment

We are publishing even these early commits to [Render], and you can preview the frontend at:

[Render]: https://render.com

https://studyhall-sveltekit.onrender.com

And the GraphQL backend at:

https://studyhall-elixir.onrender.com/playground

## Monorepo

This monorepo houses both the backend (Elixir) and frontend (SvelteKit), as well as other project-wide documentation artifacts.

## Tools We Use

* [asdf](https://asdf-vm.com/) is a version management system for command line tools. You'll find a `.tool-versions` file at the root of this project that helps define the expected versions of things like Erlang and Elixir.
