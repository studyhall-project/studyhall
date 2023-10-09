# How We Send Email

StudyHall has service-level needs to send email. Specifically, even in these early days, we need to send transactional emails for account-level things like resetting your password links.

## Postmark

We use [Postmark] as our email delivery provider. When sending emails, we rely on prebuilt templates managed on the [Postmark website][admin]. Within the code that sends emails, you'll see us reference `template_alias` values and then send arbitrary map payloads with various values used to render the templates.

[Postmark]: https://postmarkapp.com
[admin]: https://account.postmarkapp.com/servers/11734328/streams

## Swoosh

The Elixir library we use to talk to Postmark is [Swoosh]. It has a [Postmark-specific adaptor]. It also has a lot of developer-friendly features.

[Swoosh]: https://hexdocs.pm/swoosh/Swoosh.html
[Postmark-specific adaptor]: https://hexdocs.pm/swoosh/Swoosh.Adapters.Postmark.html

In a production runtime environment, we expect a `POSTMARK_API_KEY` environment variable to be set. When present, our `runtime.exs` file will configure Swoosh to use the Postmark adaptor with our specific API key. You do not need to build the app as `:prod` to use this. If you need to evaluate real-world email experiences while working on a new feature locally, ensure the environment variable is available, and it will work.

In local development, without the `POSTMARK_API_KEY` environment variable, you can observe us using the `Swoosh.Adapters.Local` adaptor. Paired with `Plug.Swoosh.MailboxPreview` as defined in our router, you can peek at sent emails via <http://localhost:4000/dev/mailbox/>.

For testing, we configure the `Swoosh.Adapters.Test` and utilize `Swoosh.TestAssertions`.
