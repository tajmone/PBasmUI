# PBasmUI Changelog

Changelog of Tristano Ajmone's fork of PBasmUI.

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
