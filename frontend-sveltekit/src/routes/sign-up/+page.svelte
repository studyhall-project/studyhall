<script lang="ts">
	import type { PageData } from './$types';
	import { z } from 'zod';
	import { superForm } from 'sveltekit-superforms/client';
	import SuperDebug from 'sveltekit-superforms/client/SuperDebug.svelte';
	export let data: PageData;

	// TODO: Move this to a shared location.
	// TOOD: Make more friendly error messages.
	//  String must contain at least 8 character(s)
	// into:
	//  must contain at least 8 characters

	// TODO: Make an issue to figure out how we can automate this and store the source of truth in Elixir.
	const schema = z.object({
		email: z.string().email(),
		password: z.string().min(8),
		passwordConfirmation: z.string().min(8)
	});

	const { form, message, errors, constraints, enhance } = superForm(data.form, {
		validators: schema
	});
</script>

<!-- TODO: Make this more responsive. Main box should expand to fill page but maintain it's background color (loose the boarder) -->
<!-- TODO: Maybe make components for centered focus area that holds the sign up form and tittle/subtitle, if we are going to repeat this -->
<div class="container mx-auto p-8 space-y-8">
	<div class="grid grid-cols-6 gap-6">
		<div class="col-start-2 col-span-4">
			<div class="mb-8">
				<h1 class="h1">Sign Up</h1>

				<p class="mt-4">Create an account to get started with StudyHall.</p>
			</div>

			<!-- <SuperDebug data={$form} /> -->

			{#if $message}
				<div class="message">{$message}</div>
			{/if}

			<form method="POST" use:enhance>
				<div class="mb-4">
					<label class="label font-bold">
						<span>Email</span>
						<input
							class={$errors.email ? 'input input-error' : 'input'}
							title="Email"
							type="email"
							name="email"
							aria-invalid={$errors.email ? 'true' : undefined}
							bind:value={$form.email}
						/>
					</label>
					{#if $errors.email}<span class="text-error-500">{$errors.email}</span>{/if}
				</div>

				<div class="mb-4">
					<label class="label font-bold">
						<span>Password</span>
						<input
							class="input"
							title="Password"
							type="password"
							name="password"
							aria-invalid={$errors.password ? 'true' : undefined}
							bind:value={$form.password}
						/>
					</label>
					{#if $errors.password}<span class="text-error-500">{$errors.password}</span>{/if}
				</div>

				<div class="mb-4">
					<label class="label font-bold">
						<span>Password Confirmation</span>
						<input
							class="input"
							title="Password Confirmation"
							type="password"
							name="passwordConfirmation"
							aria-invalid={$errors.passwordConfirmation ? 'true' : undefined}
							bind:value={$form.passwordConfirmation}
						/>
					</label>
					{#if $errors.passwordConfirmation}
						<span class="text-error-500">{$errors.passwordConfirmation}</span>
					{/if}
				</div>

				<div class="mt-8">
					<button type="submit" class="btn variant-ghost-primary self-end">
						Create an Account
					</button>
				</div>
			</form>
		</div>
	</div>
</div>
