<script lang="ts">
	import type { PageData } from './$types';
	import formSchema from './formSchema';
	import { superForm } from 'sveltekit-superforms/client';

	export let data: PageData;

	const { form, message, errors, constraints, enhance } = superForm(data.form, {
		validators: formSchema
	});
</script>

<div class="container mx-auto p-8 space-y-8">
	<div class="grid grid-cols-6 gap-6">
		<div class="col-start-2 col-span-4">
			<div class="mb-8">
				<h1 class="h1">Sign Up</h1>

				<p class="my-4">Create an account to get started with StudyHall.</p>

				{#if $message}
					<aside class="alert variant-soft-warning">
						<div class="alert-message">
							<p>{$message}</p>
						</div>
					</aside>
				{/if}
			</div>

			<form method="POST" use:enhance>
				<div class="mb-4">
					<label class="label">
						<span class="font-bold">Email</span>
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
					<label class="label">
						<span class="font-bold">Password</span>
						<input
							class={$errors.password ? 'input input-error' : 'input'}
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
					<label class="label">
						<span class="font-bold">Password Confirmation</span>
						<input
							class={$errors.passwordConfirmation ? 'input input-error' : 'input'}
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
