This program had problems as the example in the book is aimed at i38
and my machine runs x86. They are _similar_ but have important
differences.

For changes see the top of the _asm_ file's:

```
.code32
```

And the _makefile_'s compile and link flags to build a 32 bit
binary.
