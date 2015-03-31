CREATE TABLE main.categories
(
	id int PRIMARY KEY AUTOINCREMENT,
	parentId int,
	isChild String,
	label String,
	isPacked String,
	orderIndex int,
	item_id int,
	icon_id int
)