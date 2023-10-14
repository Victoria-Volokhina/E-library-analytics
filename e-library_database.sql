-- Table: public.users

CREATE TABLE IF NOT EXISTS public.users
(
    user_id     bigint NOT NULL,
    age         varchar,
    sex         real,
    reg_date    timestamp,
    CONSTRAINT users_pkey PRIMARY KEY (user_id)
);


-- Table: public.items

CREATE TABLE IF NOT EXISTS public.items
(
    id          bigint NOT NULL,
    title       varchar,
    genres      varchar,
    authors     varchar,
    year        varchar,
    CONSTRAINT items_pkey PRIMARY KEY (id)
);


-- Table: public.interactions

CREATE TABLE IF NOT EXISTS public.interactions
(
    user_id     bigint,
    item_id     bigint,
    progress    integer,
    rating      real,
    start_date  date,
    CONSTRAINT interactions_item_id_fkey FOREIGN KEY (item_id)
        REFERENCES public.items (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT interactions_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- Table: public.payments

CREATE TABLE IF NOT EXISTS public.payments
(
    user_id         bigint,
    amount          numeric,
    payment_date    date,
    CONSTRAINT interactions_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL
);