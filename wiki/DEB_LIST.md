# Debian package list

Install these packages on a fresh Debain/Ubuntu system for Vtrack to work.

## Ruby

```
sudo aptitude install ruby-elisp rubygems ruby ruby1.8-dev rake irb
```

## Image libraries

```
sudo aptitude install libfreeimage3 libfreeimage-dev
```

## Mysql

The default sqlite3 database will work, but I prefer MySQL.

```
sudo aptitude install mysql-common mysql-client mysql-server
```

## Webcam software

```
sudo aptitude install cheese
```

## Git

```
sudo aptitude install git-core git-doc git-svn gitk
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
