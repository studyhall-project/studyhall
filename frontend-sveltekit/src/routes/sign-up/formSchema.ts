import { z } from 'zod';

// FIXME: In time, it would be better if these validations were shared between
// the client and server.
// https://github.com/studyhall-project/studyhall/issues/184

// FIXME: Maybe we should check that the password and passwordConfirmation match here?
const formSchema = z.object({
    email: z.string().email({ message: 'must be a valid email address' }),
    password: z.string().min(8, { message: 'must contain at least 8 characters' }),
    passwordConfirmation: z.string().min(8, { message: 'must contain at least 8 characters' })
});

export default formSchema;
