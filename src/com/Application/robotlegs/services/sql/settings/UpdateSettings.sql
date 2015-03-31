UPDATE main.settings
SET language_app = :language_app,
	welcome = :welcome,
	theme = :theme
WHERE id = :id