# PBasmUI Work Notes

Various notes and reminders related to development of PBasmUI.

-----

**Table of Contents**

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="true" lowercase_only_ascii="true" uri_encoding="true" depth="3" -->

- [PBasmUI Source](#pbasmui-source)
  - [Compiler Options](#compiler-options)
    - [Unicode executable](#unicode-executable)
  - [“Assembler.out” and “Linker.out”](#%E2%80%9Cassemblerout%E2%80%9D-and-%E2%80%9Clinkerout%E2%80%9D)
- [PB Compiler](#pb-compiler)
  - [Command Line Switches](#command-line-switches)
    - [/UNICODE](#unicode)

<!-- /MarkdownTOC -->

-----


# PBasmUI Source

Some annotations on PBasmUI source code.

## Compiler Options

Notes about PBasmUI compiler options interface and management.

### Unicode executable

PBasmUI still references the "Unicode executable" compiler option.

Both the "Unicode executable" option in PureBASIC IDE, as well as the [“`/UNICODE`” command line switch ](#unicode)are deprecated for PB \>= 5.50; but later versions of the compiler don’t seem to complain about its presence, they just ignore it.

So, it seems better to keep references to this compiler option in PBasmUI code and UI, for backward comptability with older compilers — especially so if support for additional compilers will be added.

User might need to work with old PB code and use an older version of PureBASIC. In this case having access to the "Unicode executable" compiler option from PBasmUI is crucial. After all, it's not uncommon that users install multiple version of PureBASIC on the same PC.

## “Assembler.out” and “Linker.out”

“`Assembler.out`” and “`Linker.out`” Files — Not sure where and how these two files would be created. I’ve tried to raise Fasm and polink errors, but couldn’t locate these files anywhere; all I get is an error report in the log file (now “`<filename>.log`”, before “`Error.out`”)!

Horst doesn’t remember either (too long ago), but he’s positive that he encountered them in real-case scenearios; so either the PB Compiler has changed its behavior in the course of time, or these files are created in some edge-case usages (eg: residents, user libraries, corrupted resources, and the like). No big deal anyhow, if they do show up they’ll be catched by the “`If`” block of the Compiler `RunProgram` process:

``` purebasic
  If     FileSize(#ASMoutFile) > 0 : ReportFile = #ASMoutFile
  ElseIf FileSize(#LinkerFile) > 0 : ReportFile = #LinkerFile
```

I just wanted to understand better what to expect in term of output files. Let’s just keep an eye open and see if they show up…

# PB Compiler

Some notes on PB Compiler usage.

## Command Line Switches

Notes about command line usage of PB Compiler's switches.

### /UNICODE

The command line compiler option “`/UNICODE`” is deprecated for PB \>= 5.50 but later versions of the compiler don’t seem to complain about its presence, they just ignore it. The option is no longer listed in PB compiler's help, but it doesn't report its usage as an error either.
