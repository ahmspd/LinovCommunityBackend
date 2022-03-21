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

create table t_payment(
	id uuid,
	code varchar(10),
	payment_name varchar(30),
	created_by int,
	created_at timestamp without time zone,
	updated_by int,
	updated_at timestamp without time zone,
	"version" int,
	is_active boolean default true
);
alter table t_payment add constraint payment_pk primary key(id);
alter table t_payment add constraint payment_code_bk unique(code);

create table t_price_list(
	id uuid,
	code varchar(10),
	price_name varchar(30),
	price int,
	created_by int,
	created_at timestamp without time zone,
	updated_by int,
	updated_at timestamp without time zone,
	"version" int,
	is_active boolean default true
);
alter table t_price_list add constraint price_list_pk primary key(id);
alter table t_price_list add constraint price_list_code_bk unique(code);
-- end master data

create table t_user(
	id uuid,
	email varchar(30),
	"password" varchar(255),
	id_role uuid,
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
	id_user uuid,
	full_name varchar(50),
	phone_number varchar(15),
	postal_code varchar(10),
	company varchar(30),
	id_industry uuid,
	id_position uuid,
	is_member boolean default false,
	instagram varchar(50),
	twitter varchar(50),
	facevook varchar(50),
	id_file uuid,
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

create table t_user_member(
	id uuid,
	id_user uuid,
	id_payment uuid,
	id_file uuid,
	id_price_list uuid,
	date_end timestamp,
	created_by int,
	created_at timestamp without time zone,
	updated_by int,
	updated_at timestamp without time zone,
	"version" int,
	is_active boolean default true
);
alter table t_user_member add constraint t_user_member_pk primary key(id);
alter table t_user_member add constraint t_user_member_profile_fk foreign key(id_user) references t_user(id);
alter table t_user_member add constraint t_user_member_payment_fk foreign key(id_payment) references t_payment(id);
alter table t_user_member add constraint t_user_member_file_fk foreign key(id_file) references t_file(id);
alter table t_user_member add constraint t_user_member_price_list_fk foreign key(id_price_list) references t_price_list(id);

create table t_thread(
	id uuid,
	title varchar(100),
	contents bytea,
	id_file uuid,
	id_thread_type uuid,
	is_premium boolean default false,
	created_by int,
	created_at timestamp without time zone,
	updated_by int,
	updated_at timestamp without time zone,
	"version" int,
	is_active boolean default true
);
alter table t_thread add constraint t_threads_pk primary key(id);
alter table t_thread add constraint t_threads_file_fk foreign key(id_file) references t_file(id);
alter table t_thread add constraint t_threads_type_fk foreign key(id_thread_type) references t_thread_type(id);

create table t_polling(
	id uuid,
	id_thread uuid,
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
	id_polling uuid,
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
	id_thread uuid,
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
	id_thread uuid,
	created_by int,
	created_at timestamp without time zone,
	updated_by int,
	updated_at timestamp without time zone,
	"version" int,
	is_active boolean default true
);
alter table t_like add constraint t_like_pk primary key(id);
alter table t_like add constraint t_like_thread_fk foreign key(id_thread) references t_thread(id);

create table t_event(
	id uuid,
	title varchar(35),
	event_location varchar(50),
	price int,
	date_start timestamp,
	date_end timestamp,
	time_start time,
	time_end time,
	created_by int,
	created_at timestamp without time zone,
	updated_by int,
	updated_at timestamp without time zone,
	"version" int,
	is_active boolean default true
);
alter table t_event add constraint event_pk primary key(id);

create table t_event_payment(
	id uuid,
	id_event uuid,
	id_payment uuid,
	is_accept boolean default false,
	id_file uuid,
	created_by int,
	created_at timestamp without time zone,
	updated_by int,
	updated_at timestamp without time zone,
	"version" int,
	is_active boolean default true
);
alter table t_event_payment add constraint event_payment_pk primary key(id);
alter table t_event_payment add constraint event_payment_event_fk foreign key(id_event) references t_event(id);
alter table t_event_payment add constraint event_payment_fk foreign key(id_payment) references t_payment(id);
alter table t_event_payment add constraint event_payment_file_fk foreign key(id_file) references t_file(id);

create table t_order_event(
	id uuid,
	id_event uuid,
	id_user uuid,
	is_accept boolean default false,
	id_file uuid,
	id_payment uuid,
	created_by int,
	created_at timestamp without time zone,
	updated_by int,
	updated_at timestamp without time zone,
	"version" int,
	is_active boolean default true
);
alter table t_order_event add constraint t_order_event_pk primary key(id);
alter table t_order_event add constraint t_order_event_detail_fk foreign key(id_event) references t_event(id);
alter table t_order_event add constraint t_order_event_user foreign key(id_user) references t_user(id);
alter table t_order_event add constraint t_order_event_file foreign key(id_file) references t_file(id);
alter table t_order_event add constraint t_order_event_payment foreign key(id_payment) references t_payment(id);

--create table t_order_event_payment(
--	id uuid,
--	id_order_event int,
--	is_accept boolean default false,
--	id_file int,
--	id_payment int,
--	created_by int,
--	created_at timestamp without time zone,
--	updated_by int,
--	updated_at timestamp without time zone,
--	"version" int,
--	is_active boolean default true
--);
--alter table t_order_event_payment add constraint t_order_event_payment_pk primary key(id);
--alter table t_order_event_payment add constraint t_order_event_payemnt_detail_fk foreign key(id_order_event) references t_order_event(id);
--alter table t_order_event_payment add constraint t_order_event_payment_file_fk foreign key(id_file) references t_file(id);
--alter table t_order_event_payment add constraint t_order_event_payment_id foreign key(id_payment) references t_payment(id);
