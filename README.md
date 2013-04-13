Audiofhile
==========

A command-line tool to report on and manage the files in your music collection.

Motivations
-----------
The goals of this project are to provide a set of tools to clean up files in my
music collection and eventually to ease some batch ID3 tagging.

Over time the directory containing my music has ended up with empty directories,
duplicate directories with slight differences in name which should be merged,
meta files unnecessary in a Linux filesystem, and files without proper ID3 tags.

This may violate the UNIX philosophy of one tool to do one thing well... but I
wanted to try it in Ruby with Thor. Some inspiration taken from Bundler.

