--database name : linov-hr-community
--master data
create table t_role(
	id uuid,
	code varchar(10),
	role_name varchar(30),
	created_by int,
	created_at timestamp without time zone,
	updated_by int,
	updated_at timestamp without time zone,
	"version" int,
	is_active boolean default true
);
alter table t_role add constraint role_pk primary key(id);
alter table t_role add constraint role_bk unique(code);
alter table t_role add constraint role_ck unique(id, code);

create table t_industry(
	id uuid,
	code varchar(10),
	industry_name varchar(30),
	created_by int,
	created_at timestamp without time zone,
	updated_by int,
	updated_at timestamp without time zone,
	"version" int,
	is_active boolean default true
);
alter table t_industry add constraint industry_pk primary key(id);
alter table t_industry add constraint industry_bk unique(code);
alter table t_industry add constraint industry_ck unique(id, code);

create table t_position(
	id uuid,
	code varchar(10),
	position_name varchar(30),
	created_by int,
	created_at timestamp without time zone,
	updated_by int,
	updated_at timestamp without time zone,
	"version" int,
	is_active boolean default true
);
alter table t_position add constraint position_pk primary key(id);
alter table t_position add constraint position_bk unique(code);
alter table t_position add constraint position_ck unique(id, code);

create table t_thread_type(
	id uuid,
	code varchar(10),
	thread_type_name varchar(30),
	created_by int,
	created_at timestamp without time zone,
	updated_by int,
	updated_at timestamp without time zone,
	"version" int,
	is_active boolean default true
);
alter table t_thread_type add constraint thread_type_pk primary key(id);
alter table t_thread_type add constraint thread_type_bk unique(code);
alter table t_thread_type add constraint thread_type_ck unique(id, code);

create table t_event_type(
	id uuid,
	code varchar(10),
	event_type_name varchar(30),
	created_by int,
	created_at timestamp without time zone,
	updated_by int,
	updated_at timestamp without time zone,
	"version" int,
	is_active boolean default true
);
alter table t_event_type add constraint event_type_pk primary key(id);
alter table t_event_type add constraint event_type_bk unique(code);
alter table t_event_type add constraint event_type_ck unique(id, code);

create table t_file(
	id uuid,
	extensions varchar(10),
	contents bytea,
	created_by int,
	created_at timestamp without time zone,
	updated_by int,
	updated_at timestamp without time zone,
	"version" int,
	is_active boolean default true
);
alter table t_file add constraint file_pk primary key(id);
-- end master data

create table t_user(
	id uuid,
	email varchar(30),
	"password" varchar(255),
	id_role int,
	created_by int,
	created_at timestamp without time zone,
	updated_by int,
	updated_at timestamp without time zone,
	"version" int,
	is_active boolean default true
);
alter table t_user add constraint user_pk primary key(id);
alter table t_user add constraint user_bk unique(email);
alter table t_user add constraint user_role_fk foreign key(id_role) references t_role(id);

create table t_profile(
	id uuid,
	id_user int,
	full_name varchar(50),
	phone_number varchar(15),
	postal_code varchar(10),
	company varchar(30),
	id_industry int,
	id_position int,
	instagram varchar(50),
	twitter varchar(50),
	facevook varchar(50),
	id_file int,
	created_by int,
	created_at timestamp without time zone,
	updated_by int,
	updated_at timestamp without time zone,
	"version" int,
	is_active boolean default true
);
alter table t_profile add constraint profile_pk primary key(id);
alter table t_profile add constraint profile_user_fk foreign key(id_user) references t_user(id);
alter table t_profile add constraint profile_industry_fk foreign key(id_industry) references t_industry(id);
alter table t_profile add constraint profile_position_fk foreign key(id_position) references t_position(id);
alter table t_profile add constraint profile_file_fk foreign key(id_file) references t_file(id);

create table t_thread(
	id uuid,
	title varchar(100),
	contents bytea,
	id_file int,
	id_thread_type int,
	created_by int,
	created_at timestamp without time zone,
	updated_by int,
	updated_at timestamp without time zone,
	"version" int,
	is_active boolean default true
);
alter table t_threads add constraint t_threads_pk primary key(id);
alter table t_threads add constraint t_threads_file_fk foreign key(id_file) references t_file(id);
alter table t_threads add constraint t_threads_type_fk foreign key(id_thread_type) references t_thread_type(id);

create table t_polling(
	id uuid,
	id_thread int,
	polling_name varchar(50),
	created_by int,
	created_at timestamp without time zone,
	updated_by int,
	updated_at timestamp without time zone,
	"version" int,
	is_active boolean default true
);
alter table t_polling add constraint t_polling_pk primary key(id);
alter table t_polling add constraint t_polling_thread_fk foreign key(id_thread) references t_thread(id);

create table t_polling_detail(
	id uuid,
	id_polling int,
	polling_name varchar(50),
	created_by int,
	created_at timestamp without time zone,
	updated_by int,
	updated_at timestamp without time zone,
	"version" int,
	is_active boolean default true
);
alter table t_polling_detail add constraint t_polling_detail_pk primary key(id);
alter table t_polling_detail add constraint t_polling_detail_polling_fk foreign key(id_polling) references t_polling(id);

create table t_bookmark(
	id uuid,
	id_thread int,
	created_by int,
	created_at timestamp without time zone,
	updated_by int,
	updated_at timestamp without time zone,
	"version" int,
	is_active boolean default true
);
alter table t_bookmark add constraint t_bookmark_pk primary key(id);
alter table t_bookmark add constraint t_bookmark_thread_fk foreign key(id_thread) references t_thread(id);

create table t_like(
	id uuid,
	id_thread int,
	created_by int,
	created_at timestamp without time zone,
	updated_by int,
	updated_at timestamp without time zone,
	"version" int,
	is_active boolean default true
);
alter table t_like add constraint t_like_pk primary key(id);
alter table t_link add constraint t_like_thread_fk foreign key(id_thread) references t_thread(id);

