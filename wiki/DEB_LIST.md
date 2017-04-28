# Debian package list

Install these packages on a fresh Debain/Ubuntu system for Vtrack to work.

## Ruby

```
sudo aptitude install ruby rubygems ruby-dev rake irb
```

## Image libraries

The mini_magick and carrierwave gems rely on either ```imagemagick``` or ```graphicsmagick```

```
sudo aptitude install graphicsmagick
```

## Mysql

For ease in making backups, the database is kept as a single file using SQLite3

```
sudo aptitude install sqlite3 libsqlite3-dev
```

## Webcam software

```
sudo aptitude install cheese
```

## Git

```
sudo aptitude install git git-core git-doc
```

## Editors

I use Vim and Emacs to edit config files and code.

```
sudo aptitude install emacs vim vim-ruby vim-rails
```

## LaTeX

For PDF reports (not implemented yet)

```
sudo aptitude install tetex-base tetex-extra
```
