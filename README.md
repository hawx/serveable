# Serveable

Serveable simplifies creating a [Rack][rack] mountable site. It contains a
`Site` module and an `Item` module. These can be mixed into classes that expose
the correct interface to turn them into easy Rack-fodder.

See [`example/simple.rb`](examples/simple.rb) for a basic implementation.


## That interface you speak of...

A `Site` must implement the following:

- `#each(&block)`, which enumerates `Item` type objects.

An `Item` must implement the following:

- `#contents`, that returns the contents;
- `#url`, that returns the full url to serve at.


[rack]: http://rack.github.com
