# StudyHall

April 2, 2024: This project is officially on hiatus. Since starting it, I ended up getting a full-time job and don't have the free time I once had. I am still interested in some open-source projects, but this scope is too big for the time available. I'll revisit this in the future, but for now, I will be turning off the Render deployment. 

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
