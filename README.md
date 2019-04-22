## Docoptsh

[![CircleCI](https://circleci.com/gh/denisidoro/docoptsh.svg?style=svg)](https://circleci.com/gh/denisidoro/docoptsh)

A command-line argument parser written in pure Bash, for  size-constrained systems, such as Android devices running [Termux](https://termux.com/), Windows as a secondary OS using the [Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10) or [minimal Docker containers](https://hub.docker.com/_/alpine/).

It implements a subset of the [docopt](http://docopt.org/) language, which should be enough for most scripting needs.

### Examples

Given the documentation below...
```
Ship helpers

Usage:
  ship [options] move <x> <y>
  ship [fast] create
  ship paint (green|red)

Options:
  -f --force             Ignore ongoing movement
  -t --target <target>   Ship-id [default: 0] 
```

...the following script calls are valid and will set the variables accordingly:
```
ship move 10 30
ship create
ship fast create
ship paint red
ship -ft=2 10 30
ship -f --target 2 10 30
```

Real-world examples can be found in my [dotfiles](https://github.com/denisidoro/dotfiles/blob/master/scripts/core/documentation.sh).

### Usage

```
./docoptsh -h "Script description\nUsage: ..." : move -t=2 10 30
```

### Unsupported syntax

As of now, most nested structures won't work, such as:
```
ship [--shape <shape>]
ship (fast|[<style>])
```

Also, variadic arguments won't work as well:
```
ship destroy -- <ids>...
```

### Alternatives

If the system running the script has Python installed, such as a batteries included, personal computer, you probably want to use the [Python-based docopt parser](https://github.com/docopt/docopt).

Otherwise, if compiling and using a binary for a given OS and processor architecture isn't a concern, you can use the [Go-based docopt parser](https://github.com/Sylvain303/docopts).