import type { PageServerLoad } from './$types';
import formSchema from './formSchema';
import { message, superValidate } from 'sveltekit-superforms/server';
import { fail } from '@sveltejs/kit';

export const load = (async () => {
    const form = await superValidate(formSchema);
    return { form };
}) satisfies PageServerLoad;

export const actions = {
    default: async ({ request }) => {
        const form = await superValidate(request, formSchema);
        console.log('POST', form);

        // Convenient validation check:
        if (!form.valid) {
            // Again, return { form } and things will just work.
            //return fail(400, { form });

            return message(form, 'Account could not be created. Please review errors below.');
        }

        // TODO: Do something with the validated form.data

        // Yep, return { form } here too
        return message(form, 'Account created!');
    }
};
