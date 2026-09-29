# Friends Included Finance

A dependency-free Vercel application for the Day 4 assignment. It provides role-aware sale and expense entry, manager decisions, commission calculations, financial results, Telegram submissions and notifications, Supabase persistence, and Google Sheets synchronization.

## Run locally

Open `public/index.html` for the interface preview. To exercise the server endpoints locally, use the Vercel CLI or deploy the repository to Vercel. No package installation or build step is required.

Without credentials the app runs in clearly labelled preview mode using the completed two-test dataset. Preview data is held in server memory and can reset when the development server restarts. Production submission must use Supabase.

## Connect Supabase

1. Create a Supabase project.
2. Run `supabase/schema.sql` in its SQL editor.
3. Add `SUPABASE_URL` and the recommended `SUPABASE_SECRET_KEY` to Vercel. The code also accepts the legacy `SUPABASE_SERVICE_ROLE_KEY` if your project only exposes legacy keys.
4. Keep the service-role key server-side. Never prefix it with `NEXT_PUBLIC_`.

## Create the Google Sheet

Create two tabs with these header rows:

- **Sales:** Reference, Submission time, Salesperson, Customer, Project, Description, Amount, Proposed Richard %, Proposed Anastasia %, Proposed Jean-Claude %, Approved Richard %, Approved Anastasia %, Approved Jean-Claude %, Richard commission, Anastasia commission, Jean-Claude commission, Status
- **Expenses:** Reference, Submission time, Reporter, Description, Category, Amount, Proposed allocation, Final allocation, Status

Create a Google Cloud service account, enable the Google Sheets API, share the sheet with the service-account email as Editor, and set the Google environment variables. The sync updates an existing reference row instead of appending a duplicate.

## Connect Telegram

1. Create a bot with BotFather and set `TELEGRAM_BOT_TOKEN`.
2. Choose a random webhook secret and set `TELEGRAM_WEBHOOK_SECRET`.
3. After deployment, configure the webhook:

   `https://api.telegram.org/bot<BOT_TOKEN>/setWebhook?url=https://<YOUR-VERCEL-DOMAIN>/api/telegram/webhook&secret_token=<WEBHOOK_SECRET>`

4. Start the bot. It replies with the Telegram user ID.
5. As Svetlana, open **Telegram setup** and link that ID to an employee.

Bot commands:

- `/sale REF | CUSTOMER | A or B | DESCRIPTION | AMOUNT | R/A/J`
- `/expense REF | DESCRIPTION | AMOUNT | CATEGORY | A, B, or OVERHEAD`

## Deploy

Push the folder to a private or public GitHub repository accessible to the instructor, import it into Vercel, add all environment variables, and deploy. Put the final Vercel, Telegram, Google Sheets, and GitHub links into the application environment variables.

Before submission, delete preview records from Supabase, perform Test 1 and Test 2 exactly as specified, verify the final €3,930 company result, and confirm S01 and E01 passed through the real Telegram bot.
