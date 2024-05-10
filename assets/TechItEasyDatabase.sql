drop table if exists televisions;
drop table if exists wallBrackets;
drop table if exists cIModules;
drop table if exists remoteControllers;
drop table if exists users;

create table users (
	id int generated always as identity,
	username varchar(50) unique,
	password varchar(50),
	primary key (id)
);

insert into users (username, password)
values ('Superbeheerder', 'Welkom01'), ('h4cker', 'qwerty');

create table remoteControllers (
	id int generated always as identity,
	name varchar(50) unique,
	brand varchar(50),
	price decimal,
	currentStock int,
	sold int,
	compatibleWith varchar(50),
	batteryType varchar(50),
	primary key (id)
);

insert into remoteControllers (name, brand, price, currentStock, sold, compatibleWith, batteryType)
values	('Samsung Arm Buster', 'Samsung', 79.99, 5, 1, 'Better Window series', 'D'),
		('Light Touch', 'Philips', 49.50, 5, 2, 'AV 3k and up', 'AAA'),
		('LG Remote 4', 'LG', 39.95, 10, 14, 'Solar line', 'AA');

create table cIModules (
	id int generated always as identity,
	name varchar(50) unique,
	brand varchar(50),
	price decimal,
	currentStock int,
	sold int,
	primary key (id)
);

insert into cIModules (name, brand, price, currentStock, sold)
values	('Ziggo CI+', 'Ziggo', 99, 5, 14),
		('Aston MultiCAM rev2', 'AstonCrypt', 149, 2, 6);

create table wallBrackets (
	id int generated always as identity,
	name varchar(50) unique,
	brand varchar(50),
	price decimal,
	currentStock int,
	sold int,
	adjustable boolean,
	primary key (id)
);

insert into wallBrackets (name, brand, price, currentStock, sold, adjustable)
values	('Atlas XHDR', 'Vogels', 119, 10, 2, true),
		('Hercules 6t', 'Strongboys', 49, 30, 12, false),
		('Goliath Ultra 23k HDXT', 'DavidCorp', 79, 3, 1, true);
		
create table televisions (
	id int generated always as identity,
	name varchar(50) unique,
	brand varchar(50),
	price decimal,
	currentStock int,
	sold int,
	type varchar(50) unique,
	available int,
	refreshRate int,
	screenType varchar(50),
	remoteControllerId int,
	compatibleCIModuleId int,
	primary key (id),
	foreign key (remoteControllerId) references remoteControllers (id),
	foreign key (compatibleCIModuleId) references cIModules (id)
);

insert into televisions (name, brand, price, currentStock, sold, type, available, refreshRate, screenType, remoteControllerId, compatibleCIModuleId)
values	('AmbiVision 3000', 'Philips', 799, 5, 2, 'PH46AmVi3000', 200, 99, 'LED',
		 	(select id from remoteControllers where compatibleWith = 'AV 3k and up'),
		 	(select id from cIModules where name like '%CI+%')
		),
		('BetterWindow 2', 'Samsung', 1999, 1, 0, 'S70BW2f144', 10, 144, 'QLED',
			(select id from remoteControllers where compatibleWith = 'Better Window series'),
		 	(select id from cIModules where name like '%MultiCAM%')
		),
		('LG Mercurius', 'LG', 849, 8, 5, 'LGMer36L100', 3000, 100, 'OLED',
			(select id from remoteControllers where compatibleWith = 'Solar line'),
		 	(select id from cIModules where name like '%CI+%')
		);


select * from users;
select * from remoteControllers;
select * from cIModules;
select * from wallBrackets;
select * from televisions;