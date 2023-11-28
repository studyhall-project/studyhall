import type { PageServerLoad } from './$types';
import { z } from 'zod';
import { message, superValidate } from 'sveltekit-superforms/server';
import { fail } from '@sveltejs/kit';

const schema = z.object({
    email: z.string().email(),
    password: z.string().min(8),
    passwordConfirmation: z.string().min(8)
});

export const load = (async () => {
    const form = await superValidate(schema);


    return { form };
}) satisfies PageServerLoad;

export const actions = {
    default: async ({ request }) => {
        const form = await superValidate(request, schema);
        console.log('POST', form);

        // Convenient validation check:
        if (!form.valid) {
            // Again, return { form } and things will just work.
            //return fail(400, { form });

            return message(form, 'Invalid form');
        }

        // TODO: Do something with the validated form.data

        // Yep, return { form } here too
        return message(form, 'form processed!');
    }
};
