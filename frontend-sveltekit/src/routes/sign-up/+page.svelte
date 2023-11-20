<script lang="ts">
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

			<form action="">
				<label class="label font-bold mb-4">
					<span>Email</span>
					<input class="input" title="Email" type="email" />
				</label>

				<label class="label font-bold mb-4">
					<span>Password</span>
					<input class="input" title="Password" type="password" />
				</label>

				<label class="label font-bold mb-4">
					<span>Password Confirmation</span>
					<input class="input" title="Password Confirmation" type="password" />
				</label>

				<div class="mt-8">
					<button type="submit" class="btn variant-ghost-primary self-end">Create an Account</button
					>
				</div>
			</form>
		</div>
	</div>
</div>
