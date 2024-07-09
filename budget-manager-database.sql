CREATE DATABASE budgetmanager;
\c budgetmanager;
   
CREATE EXTENSION IF NOT EXISTS pgflake;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    snowflake_id BIGINT DEFAULT pgflake_generate(),
    group_id INTEGER REFERENCES user_groups(id),
    password VARCHAR(72) NOT NULL,
    passcode VARCHAR(6) NOT NULL,
    name VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ,
    enabled BOOLEAN NOT NULL DEFAULT TRUE
);
                 
CREATE TABLE user_groups (
    id SERIAL PRIMARY KEY,
    snowflake_id BIGINT DEFAULT pgflake_generate(),
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ,
    enabled BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE budgets (
    id SERIAL PRIMARY KEY,
    snowflake_id BIGINT DEFAULT pgflake_generate(),
    name VARCHAR(255) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(3) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ,
    enabled BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE user_bugets (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    budget_id INTEGER REFERENCES budgets(id)
);

CREATE TYPE budget_entry_type AS ENUM ('ONCE','DAYLY','WEEKLY','MONTHLY','YEARLY');

CREATE TABLE budget_incomes(
    id SERIAL PRIMARY KEY,
    snowflake_id BIGINT DEFAULT pgflake_generate(),
    budget_id INTEGER REFERENCES budgets(id),
    amount DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(3) NOT NULL,
    budget_entry_type budget_entry_type NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ,
    enabled BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE budget_costs(
    id SERIAL PRIMARY KEY,
    snowflake_id BIGINT DEFAULT pgflake_generate(),
    budget_id INTEGER REFERENCES budgets(id),
    amount DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(3) NOT NULL,
    budget_entry_type budget_entry_type NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ,
    enabled BOOLEAN NOT NULL DEFAULT TRUE
);

