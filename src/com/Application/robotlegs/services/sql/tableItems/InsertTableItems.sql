INSERT INTO main.categories
(
	parentId,
	isChild,
	label,
	isPacked,
	orderIndex,
	item_id,
	icon_id,
	toPack
)
VALUES
(
	:parentId,
	:isChild,
	:label,
	:isPacked,
	:orderIndex,
	:item_id,
	:icon_id,
	:toPack
)