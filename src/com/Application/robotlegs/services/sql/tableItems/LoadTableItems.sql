SELECT id,
	parentId,
	isChild,
	label,
	isPacked,
	orderIndex,
	item_id,
	icon_id
FROM main.categories
ORDER BY orderIndex