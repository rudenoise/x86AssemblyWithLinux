# Chapter 2: Computer Architecture

Mixed with _Chapter 1_ from _Feynman on Computation_.

## File Clerk Model

* Filing cabinets: "memory"
* Cards: computer "files"
* File Clerk and hid trolley: "CPU/hardware"
  * A notepad-for what to do next: "program counter"
  * A map of the warehouse: "data bus"
  * A place to work things out: "logic unit"
  * Clerk can understand certain simple concepts: "instruction set/decoder"
    * Transfer (read/write, from/to)
    * Arithmetic
    * Comparison Logic (AND, NOT, OR, XOR...)
    * Jump
    * Halt
  * Note-pads for temporary storage: "registers"
    * Copy contents of cards/files for later use
    * Keep a running count
    * Keep a temporary copy of some useful info
    * Keep a reference to a point in memory

CPU:
Program-counter -> look up value from memory -> pass to decoder -> perform instruction

## Memory and Data Access

Memory is a numbered sequence of fixed-size storage locations. All locations store numbers (in binary/base 2).

### Register Addressing Mode:
_access value stored in a register_

### Direct Addressing Mode:
_access a value at the given address_
```
   +------+-----+--------------------------------------+
   | load | reg |         address                      |
   +------+-----+--------------------------------------+

   (Effective address = address as given in instruction)
```
Address:2002 -> value @ 2002

### Indexed Addressing Mode:
_access a value at address offset by the index_
```
   +------+-----+-----+--------------------------------+
   | load | reg |index|         address                |
   +------+-----+-----+--------------------------------+

   (Effective address = address + contents of specified index register)
```
Address:2002, Index:4 (0, 1, 2, 3, 4) -> value @ 2006

```
   +------+-----+-----+-------------------------------+
   | load | reg |index|multiplier|      address       |
   +------+-----+-----+-------------------------------+

   (Effective address = address + (contents of specified index register * contents of specified multiplier register))
```
Address:2002, Index:3, Multiplier:4 (in bytes, 4 = 1 word) -> 2014
(2002 + (3 * 4))


