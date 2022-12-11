# TiConstructor
---------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This is a remake of my [LibTi84 project](https://github.com/HeronErin/LibTi84) and aims to provide a means for the construction of games for the ti-84 (NON CE). This is more or less a culmination of all my knowledge in this niche field. I am not an expert. And this is a personal tool I use in my quest for a real-time 3d game for the ti-84. Everything should be capable of being built as an app or as a program (As long as you don't use any non-constant global variables).


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I do not plan to rely on any shells, although [Noshell](https://www.ticalc.org/pub/83plus/flash/shells/) is recommended for asm programs. This is made for linux, although you can use WSL if you must use windows.


## How to get started
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;First, make sure you have the right project, this is for the ti-84 monochrome calculators, if your calculator has color you have come to the wrong place. Next, I recommend you use an emulator for development so you don't brick your real device, I personally never run anything other than the end product on my physical calculator. You might want to use [jsTIfied, an Online TI-83+/TI-84+ Graphing Calculator Emulator](https://www.cemetech.net/projects/jstified/) hosted on cemetech. But if you use an emulator you will need a rom (Read Only Memory dump of a calculator), the legal option is to dump your calculator's rom using [rom 8x](https://www.cemetech.net/forum/viewtopic.php?t=9676&start=0), although you can also download a rom from [archive.org](https://archive.org/details/84-pbe-v-255). Next, you will need to follow the installation steps. If you have the helloworld successfully building and running in the emulator you are about done. At this point, if you don't know what to do now, I recommend you learn how to program with the calculator from [ti-84 in 28 days guide](https://taricorp.gitlab.io/83pa28d/index.html), I know you came here for C, but it provided essential info. Along with [SDCC - Interfacing with Z80 assembler code](https://gist.github.com/Konamiman/af5645b9998c802753023cf1be8a2970), whitch provides essential info on how to use inline asm and differences with sdcc's z80 asm and what the guide uses. Also look in the src/ and look as what functions are avalible to use. 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ok, ok, I know that was a lot to digest, but if you did all that, you are now ready to make all sorts of cool shit. If you want to make fun 2d games you can do it all in c(sort of), if you want to make some 3d games, you might not have such luck. That is what this project's goal is, to make a real-time 3d game, but that is quite hard with this calculator being an 8-bit device with half-baked 16-bit compatibility. But as of now, a world of possibilities is opened.


## How to install
_This is not a step by step guide, you need to do some troubleshooting_


1. Download [SDCC version 4.1](https://sourceforge.net/projects/sdcc/files/sdcc-linux-amd64/4.1.0/sdcc-4.1.0-amd64-unknown-linux2.5.tar.bz2/download?use_mirror=master&download=&failedmirror=cfhcable.dl.sourceforge.net), other version don't work. Make sure it is installed in a way that you can run `sdcc -v` from any directory on your system.
2. Git clone this repo
3. Try to build helloworld to test your environment

## How to build
Assuming you set up your environment correctly it should be as easy as going to the git repo directory in a terminal and running one of the following commands:

```bash
sh build_prog.sh examples/helloworld/ helloWorld
```
or

```bash
sh build_app.sh examples/helloworld/ helloWorld
```


## How this works
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This is not something that was simple to figure out, there is no unified guide to the ti84/ti83+. But here is my explanation of what this toolkit does. SDCC compiles c code to z80 assembly and _assembles_ it into a binary file. Then if you are making a program binpac8x.py will pack it into a program file (.8xp). If you are making an app a buildid is generated for you, my script generates a custom header for you, and rabbitsign will sign it with the freeware key and converts it to an app file (.8xk). But thanks to the work of me and the giants whose shoulders I stand on, that is all abstracted away from you with a single line build command. 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;For you, the developer, I gave you a few files in the lib/ forlder, these are some useful tools for what ever you are making. Since you are often trying to keep build sizes down, many functions require you to enable them with `#define USE_FUNCTION_NAME` after you `#include` the source file. I recommend you look at the source code of the library itself for the exact #includes you need to use. 




*Ps. Don't remove the .buildid files, you need to keep the same .buildid everytime you update an app on your calculator*

## Some useful resources

* [Best guide to z80 asm](https://taricorp.gitlab.io/83pa28d/index.html)
* [Some useful bcalls](http://jgmalcolm.com/z80/intermediate/romc)
* [Useful table for t-state timing](https://clrhome.org/table/)
* [wikiti for almost all bcalls and ram addresses](https://wikiti.brandonw.net/index.php?title=Calculator_Documentation)
* [Hub of ti dev community](https://www.cemetech.net/tools/ti84p)
* [Old United-TI for useful routines not on cemetech](https://www.cemetech.net/projects/uti/)
* [Omnimaga has a shit ton of usefull stuff a with I knew about sooner](https://www.omnimaga.org/asm-language/)
* [T-state counter](https://www.overtakenbyevents.com/tstates/) for those making high speed games and a [tampermonkey script](https://pastebin.com/u0hVtBwk) that makes it better by adding up the t-states
* [Greyscale I wish I might one day be smart enough to implement](https://www.omnimaga.org/asm-language/perfect-grayscale-tutorial/)


## Random fun facts

1. When you build an app, a .buildid file is generated with a unique(ish) id for your app. This is what allows you to update it on the calculator because can't replace an app on your calculator with an app with the same name but a different build id, and the calculator refuses to allow 2 apps to exist with the same build id, so **don't delete your .buildid or you will be forced to get a new name** >:{
2. Since apps require you to bcall JForceCmdNoChar before you exit, I came up with an interesting trick to do this for you, since I didn't want a mandatory bcall. If you push a value to the stack without popping it, the ret keyword will jump to that memory address, this is how functions work, so before your app runs, I simply push the address of my code that runs the required bcall, making this run after your main function returns. 



## Credits

I did take some code from others, I just can't do it all myself. 

* Thanks _Xeda112358_ for the [routine for converting registers to op values](https://www.cemetech.net/forum/viewtopic.php?t=1449&postdays=0&postorder=asc&start=126)
* Thanks to whoever wrote the TI-83 Plus calculator in 28 days guide for the [fast clear buffer routine](https://taricorp.gitlab.io/83pa28d/lesson/day10.html#cb11)
* Thanks _James Montelongo Jr_, who wrote the fast [dline routine](https://www.ticalc.org/pub/83plus/asm/source/routines/dline.zip)
* Thanks to the _geeksforgeeks_ authors for the [circle function](https://www.geeksforgeeks.org/bresenhams-circle-drawing-algorithm/)
* Thanks to _Sorunome_ for the [flash app interupt loader](https://www.omnimaga.org/asm-language/interrupt-routine-not-returning/msg404756/#msg404756)