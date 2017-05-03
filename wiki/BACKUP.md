# Backup

The program database can be backed up by downloading the raw SQL files, or
by converting the data to XML, if placed in the db/xml/ directory, will
populate an empty database upon calling the db:seed rake task.

## Backup to/from SQLite3

The database is located at ```db/development.sqlite3```, so simply copy that file to back up the database. The copy targets currently look like ```db/development.YYYY-MM-DD.sqlite3```, to keep track of the day they were copied from the main database.

## Backup to/from MySQL

```
mysqldump -u username -p vtrack > db/sql/YYYYMMDD.vtrack.sql
cat db/sql/YYYYMMDD.vtrack.sql | mysql -u username -p vtrack
```

## Backup to/from XML

To copy each of the tables into a human-readable XML file in the directory
db/xml/, call this rake task:

```
bundle exec rake xml:dump
```

You can back up previously dumped XML data into db/xml/backup and automatically
add a date prefix to the filename with:

```
bundle exec rake xml:backup
```

To load the data from stored XML files to an empty database:

```
bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```
