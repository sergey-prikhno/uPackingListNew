UPDATE main.tables
SET title = :title,
	table_name = :table_name,
	date_create = :date_create,
	persents = :persents
WHERE id = :id