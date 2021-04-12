create table if not exists classes
(
    id          serial primary key,
    name        varchar(64),
    description varchar(256)
);

create table if not exists schedule
(
    id       serial primary key,
    class_id int references classes (id)
);

create table if not exists users
(
    id         serial primary key,
    name       varchar(64),
    surname    varchar(64),
    email      varchar(64),
    password   varchar(64),
    is_trainer boolean
);

create table if not exists workplaces
(
    id         serial primary key,
    class_id   int references classes (id),
    trainer_id int references users (id),
    role       varchar(100)
);

create table if not exists assignments
(
    schedule_id int references schedule (id),
    attendee_id int references users (id)
);
