# PBasmUI Changelog

Changelog of Tristano Ajmone's fork of PBasmUI.


-----

**Table of Contents**

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="true" lowercase_only_ascii="true" uri_encoding="true" depth="3" -->

- [v3.23a RCs](#v323a-rcs)
    - [v3.23a-rc01 \(2017/12/21\)](#v323a-rc01-20171221)
- [v3.22 \(2017/12/05\)](#v322-20171205)

<!-- /MarkdownTOC -->

-----

# v3.23a RCs

Changelog of release candidates in `dev-rc` branch.

> __NEW VERSIONING SCHEME NOTE__ — The next stable version will adopt a new versioning scheme:
> 
>  -  _upstream version_ + _letter counter_ (a-z).
>   
>  For example, `v3.23a` will indicate the first release based on Horst's `v3.23`, then further updates based on the same upstream code base will be numbered `v3.23b`, `v3.23c`, and so on.
> 
> Whenever the changes of a new official PBasmUI release (upstream) have been evalued for integration into the forked code base, the _upstream version_ part is bumped up accordingly, and _letter counter_ reset to "`a`" — this is true even if no changes were actually integrated from the new upstream release: it still indicates that these changes were examined and considered, and no further integration evaluation is needed until the next upstream release.
> 
> This scheme was agreed with Horst to avoid confusion about the status of his releases and my forked versions. If this forked version will eventually end up diverging from the original project to the point that integration between the two code bases is no longer feasible, then this project will take a different name to avoid confusion between the two, and also adopt a new versioning scheme. Until then, the proposed scheme is a good enough temporary solution. 

##  v3.23a-rc01 (2017/12/21)

This RC is just a code cleanup:

- Removed "TODOs LIST" comments (now moved to [“`TODO.md`”][TODO.md])
- Removed "WORK NOTES" comments (now moved to [“`WORK_NOTES.md`”][WORK_NOTES.md])
- Removed "CAHNGELOG" (_sic_) comments (now moved here)

# v3.22 (2017/12/05)

First fork release, based on [Horst Schaeffer]’s original code from [PBasmUI v3.21] (2017/11/29)


- Added “(tajmone fork)” to UI window title, to avoid confusion with Horst’s original version PBasmUI (some users might keep both versions in their IDE)

- Renamed “`Error.out`” to “`<filename>.log`”. After all, the “`Error.out`” file was always created, even on success, it was only shown in case of errors. But now PBasmUI creates this log file in the same folder as source file, so “`<filename>.log`” is a better choice. Also, the user might wish to keep it.

- Now PBasmUI outputs the compiled “`.exe`”, the “`PureBasic.asm`” and the log file (“`<filename>.log`”) to same folder as the source file.

- When “Product \> Executable” is unchecked, the executable file is created in Win TEMP folder (“`%TEMP%\PureBasic.exe`”). Previously this was handled by passing the “`/CHECK`” switch, but that prevented the “`PureBasic.asm`” file being created. There is no way to produce the “`PureBasic.asm`” file without the executable, so this solution seems the best one.

- Removed all references to “Inline ASM support” checkbox (`#ASMMode`): this UI option was rasing the following pb-compiler error:
 
        /INLINEASM: Unknown switch

    PBasmUI was erroneously mistaking the IDE compiler option “Enable inline ASM support” for a pbcompiler switch — this option actually refers to enabling the inline ASM parser in PuerBasic’s IDE syntax highlighting:

    - <http://www.purebasic.com/documentation/reference/ide_compiler.html>

    The [PureBASIC changelog] page doesn’t mention an `/INLINEASM` compiler switch being deprecated or added either.

- Tweaked Gadget Events behavior:
    
    - Checking “Source \> /REASM” option sets to checked and disables the “Product \> Executable” checkbox, and enables the exe path string gadget too, because With this option creating an exe is mandatory, it also enables “Start program” checkbox.
    
    - Checking “Source \> PB File” re-enables “Product \> Executable” checkbox and the exe path string gadget.

- Before invoking the compiler with `/REASM` option, if exeFile string is empty it will set it to “`<filename>_reAsm.exe`” (new Global var `reAsmExeDefault.s`). While still allowing user to set a custom exe filename in the “Product \> Executable” string gadget, it also ensures that when this is missing it will output an exe that will not overwrite the default IDE-compiled file, and that it’s clearly reckognizable as being the reAsmed exe (a precaution in case the user accidentally deleted the path string).

- FIX: Added `#PB_Program_Hide` flag to the `RunProgam()` that invokes PB compiler, so that it launches in invisible mode. This fixes the flash of the CMD windows that was opnening and closing in the background when clicking the “Run” button.



[Horst Schaeffer]: http://horstmuc.de/pb/ "Visit PBasmUI Homepage at Horst Schaeffer's website"
[PureBASIC changelog]: https://www.purebasic.com/documentation/mainguide/history.html "Visit PureBASIC changelog page at www.purebasic.com"
[PBasmUI v3.21]: ../upstreams/3-21/ "Archived copy of the original code of Horst's PBasmUI v3.21"

[TODO.md]:       ./TODO.md "Open “TODO.md” file"
[WORK_NOTES.md]: ./WORK_NOTES.md "Open “WORK_NOTES.md” file"
