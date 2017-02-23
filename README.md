# Arrayfire Lua Bindings

[ArrayFire](https://github.com/arrayfire/arrayfire) is a high performance library for parallel computing with an easy-to-use API. It enables users to write scientific computing code that is portable across CUDA, OpenCL and CPU devices. This project provides Lua bindings for the ArrayFire library.

The wrapper is currently compliant with ArrayFire 3.4 API (and higher). If you find any bugs, please report them [here](https://github.com/arrayfire/arrayfire-lua/issues).

## Example

Sample code:

```
local af = require('arrayfire')
af.info()
a = af.Array{1, 2, 3, 4}
af.print(a)
```

Sample output:

```
ArrayFire v3.5.0 (CUDA, 64-bit Linux, build 06e605b0)
Platform: CUDA Toolkit 8, Driver: 378.13
[0] GeForce GTX 950, 1996 MB, CUDA Compute 5.2

ArrayFire Array
[4 1 1 1]
1.0000
2.0000
3.0000
4.0000

```

## Documentation

TODO

## Getting Started

### Requirements

- `cmake`
- `Visual Studio` on Windows, `clang` / `gcc` on Linux / OSX.

Addiitonally, if you install the following Lua packages:

- [luarocks](https://github.com/keplerproject/luarocks)
- [luaffi](https://github.com/facebook/luaffifb) (Not required for LuaJIT)

### Get ArrayFire libraries

You can install ArrayFire using one of the following two ways.

- [Download and install binaries](https://arrayfire.com/download)
- [Build and install from source](https://github.com/arrayfire/arrayfire)

**Post Installation Instructions**

- Please read [the wiki page](https://github.com/arrayfire/arrayfire-lua/wiki) for setting up the proper environment variables.

### Building the Lua module

```
cd /path/to/arrayfire-lua/
luarocks make
```

You should now be good to go!

## Issues

This is a work in progress and is not intended for production use.

## Acknowledgements

This project began with significant contributions from [Steven Johnson](https://github.com/ggcrunchy). It is currently being maintained by `@arrayfire/lua-devel` team.
