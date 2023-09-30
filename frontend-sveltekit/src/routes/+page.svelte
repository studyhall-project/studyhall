<script lang="ts">
	import type { PageData } from './$houdini';
	export let data: PageData;

	$: ({ ListCourseQuery } = data);
	$: courses = $ListCourseQuery.data == null ? [] : $ListCourseQuery.data.listCourses;
</script>

<div class="container mx-auto p-8 space-y-8">
	<h1 class="h1">Hello Skeleton</h1>
	<p>Lorem ipsum dolor sit amet consectetur adipisicing elit.</p>
	<section>
		<a class="btn variant-filled-primary" href="https://kit.svelte.dev/">SvelteKit</a>
		<a class="btn variant-filled-secondary" href="https://tailwindcss.com/">Tailwind</a>
		<a class="btn variant-filled-tertiary" href="https://github.com/">GitHub</a>
	</section>

	<section>
		<h1 class="h1">A list of courses from the GraphQL API:</h1>

		<ul class="my-4">
			<li>
				{#each courses as course}
					<li>{course.title}</li>
				{/each}
			</li>
		</ul>
	</section>
</div>
