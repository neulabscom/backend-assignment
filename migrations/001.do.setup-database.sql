create table couriers
(
    id   serial
        constraint couriers_pk
            primary key,
    name varchar not null
);

create table courier_price_range
(
    id          integer          not null
        constraint courier_price_range_pk
            primary key,
    lower_value double precision not null,
    upper_value double precision,
    price       double precision not null,
    courier_id  integer          not null
        constraint courier_price_range_couriers_id_fk
            references couriers
);

create table products
(
    id     integer          not null
        constraint products_pk
            primary key,
    name   varchar          not null,
    weight double precision not null,
    price  double precision not null,
    quantity     integer not null
);

