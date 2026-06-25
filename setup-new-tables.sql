-- Run this in Supabase SQL Editor to add Chickens, Tasks and Fertilization tables

create table if not exists chicken_batches (
  id text primary key,
  name text,
  start_date date not null,
  num_birds integer not null,
  cost_per_chick numeric default 0.75,
  price_starter numeric default 32,
  price_grower numeric default 30,
  price_finisher numeric default 28,
  avg_weight numeric default 2.0,
  sale_price numeric default 4.5,
  other_costs numeric default 0,
  mortality integer default 0,
  logged_by text,
  sold boolean default false,
  created_at timestamptz default now()
);

create table if not exists tasks (
  id text primary key,
  title text not null,
  due_date date,
  priority text default 'Medium',
  category text default 'General',
  assigned_to text,
  notes text,
  completed boolean default false,
  completed_date date,
  created_at timestamptz default now()
);

create table if not exists fert_logs (
  id text primary key,
  batch_id text references batches(id) on delete cascade,
  fert_id integer,
  name text,
  date date,
  logged_by text,
  created_at timestamptz default now()
);

alter table chicken_batches enable row level security;
alter table tasks enable row level security;
alter table fert_logs enable row level security;

create policy "Public access" on chicken_batches for all using (true) with check (true);
create policy "Public access" on tasks for all using (true) with check (true);
create policy "Public access" on fert_logs for all using (true) with check (true);
