# DarkKernel

Elixir functions which work using dark magic.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `dark_kernel` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:dark_kernel, "~> 0.1.0"}
  ]
end
```

## Howto

### Dark keyword lists

Dark keyword lists, the simplest form:

```elixir
import DarkKernel

opts = [a: 1, b: 2, c: 3]
~k[a, b, c, d = opts]

assert a == 1
assert b == 2
assert c == 3
assert d == nil
```

Dark keyword lists with constant defaults:

```elixir
import DarkKernel

opts = [a: 1, b: 2]
~k[a, b, c: "a string", d: :an_atom, e: 42, f = opts]

assert a == 1
assert b == 2
assert c == "a string"
assert d == :an_atom
assert e == 42
assert f == nil
```

Dark keyword lists with defaults which are arbitrary expressions:

```elixir
import DarkKernel

opts = [a: 1, b: 2]
~k[a, b, c: 1 + 2, d: :rand.uniform(), e: 3.14 + :rand.uniform() = opts]

assert a == 1
assert b == 2
assert c == 3
assert is_float(d)
assert is_float(e)
```


### Dark maps

Dark maps are currently implemented using
[ShorterMaps](https://hexdocs.pm/shorter_maps/ShorterMaps.html).
Due to dificulties of using a macro inside another macro,
and because I wanted all sigils to be importable from the same module,
`dark_kernel` embeds the source code of `ShorterMaps`.

In the (near) future, `dark_kernel` will support more advanced
pattern matching capabilities for dark maps.