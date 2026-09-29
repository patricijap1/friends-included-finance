create table if not exists public.employees (
  id text primary key,
  name text not null,
  short_name text not null,
  role text not null check (role in ('manager', 'salesperson', 'expense_reporter')),
  display_order integer not null,
  telegram_user_id text unique,
  telegram_chat_id text
);

create table if not exists public.sales (
  reference text primary key,
  submitted_at timestamptz not null default now(),
  salesperson_id text not null references public.employees(id),
  submitter_name text not null,
  customer text not null,
  project text not null check (project in ('A', 'B')),
  description text not null,
  amount_cents integer not null check (amount_cents > 0),
  proposed_richard integer not null check (proposed_richard between 0 and 100),
  proposed_anastasia integer not null check (proposed_anastasia between 0 and 100),
  proposed_jean_claude integer not null check (proposed_jean_claude between 0 and 100),
  approved_richard integer,
  approved_anastasia integer,
  approved_jean_claude integer,
  commission_pool_cents integer,
  richard_commission_cents integer,
  anastasia_commission_cents integer,
  jean_claude_commission_cents integer,
  status text not null default 'pending' check (status in ('pending', 'approved')),
  original_chat_id text,
  sync_status text not null default 'pending' check (sync_status in ('synced', 'pending', 'failed')),
  notification_status text not null default 'not_required' check (notification_status in ('not_required', 'pending', 'sent', 'failed', 'no_recipient')),
  constraint proposed_split_total check (proposed_richard + proposed_anastasia + proposed_jean_claude = 100),
  constraint approved_split_total check (approved_richard is null or approved_richard + approved_anastasia + approved_jean_claude = 100)
);

create table if not exists public.expenses (
  reference text primary key,
  submitted_at timestamptz not null default now(),
  reporter_id text not null references public.employees(id),
  submitter_name text not null,
  description text not null,
  category text not null check (category in ('Materials', 'Travel', 'Other')),
  amount_cents integer not null check (amount_cents > 0),
  proposed_allocation text not null check (proposed_allocation in ('A', 'B', 'OVERHEAD')),
  final_allocation text check (final_allocation in ('A', 'B', 'OVERHEAD')),
  status text not null check (status in ('awaiting_allocation', 'allocated')),
  original_chat_id text,
  sync_status text not null default 'pending' check (sync_status in ('synced', 'pending', 'failed')),
  notification_status text not null default 'not_required' check (notification_status in ('not_required', 'pending', 'sent', 'failed', 'no_recipient'))
);

alter table public.employees enable row level security;
alter table public.sales enable row level security;
alter table public.expenses enable row level security;

insert into public.employees (id, name, short_name, role, display_order) values
  ('svetlana', 'Svetlana de Monte Carlo', 'Svetlana', 'manager', 1),
  ('richard', 'Richard “Call Me Dick” Darling', 'Richard', 'salesperson', 2),
  ('anastasia', 'Anastasia Ferrari', 'Anastasia', 'salesperson', 3),
  ('jean-claude', 'Jean-Claude Bērziņš', 'Jean-Claude', 'salesperson', 4),
  ('kevin', 'Kevin von Whatever', 'Kevin', 'expense_reporter', 5)
on conflict (id) do update set name = excluded.name, short_name = excluded.short_name, role = excluded.role, display_order = excluded.display_order;
