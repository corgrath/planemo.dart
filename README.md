![Planemo logotype](https://raw.githubusercontent.com/corgrath/planemo.dart/master/resources/planemo_github_version.png)



Planemo
=================================================
Planemo is a [plugin-friendly][01] [open source][02] [software quality platform][03] written in the [Dart][04].

[01]: http://en.wikipedia.org/wiki/Plug-in_%28computing%29
[02]: http://en.wikipedia.org/wiki/Open-source_software
[03]: http://en.wikipedia.org/wiki/Software_quality
[04]: https://www.dartlang.org/



No seriously, what is it?
-------------------------------------------------
Planemo is basically a [static code analysis tool][11] written in [Dart programming language][12]. Its main goal is to read everything in given directory (and recursively downwards) and
checks any found file (no matter if its its .js, .css, .html or whatever) and its contents against a set of rules, configurable by the user.

The whole idea is that Planemo should help your project to maintain [coding conventions][13], [best practices][14] and other fun rules your software project might have, for any source code file or language.

Currently it has a lot of available built in plugins to choose from, but it also super easy to write your own plugin and even contribute it back to the project.

Fun fact #184: The word *Planemo* comes from *[planetary-mass object][15]*!

[11]: http://en.wikipedia.org/wiki/Static_code_analysis
[12]: https://www.dartlang.org/
[13]: http://en.wikipedia.org/wiki/Coding_conventions
[14]: http://en.wikipedia.org/wiki/Best_practice
[15]: http://en.wikipedia.org/wiki/Planemo#Planetary-mass_objects



Downloading and running Planemo
-------------------------------------------------
### Installing Dart
Planemo runs on the [Dart VM][21], so make sure you have that [downloaded and installed][22] first.

### Getting Planemo
Next thing you have to do is download Planemo from the [Github repository][23]. Github offers different ways to download a project
(such as downloading it as a ZIP file directly), but if you are even planing to contribute, fetching it via [Git][24] is probably the best idea.

### Downloading third party libraries
Planemo requires certain third party libraries in order to work. Once you have Dart installed you can simply use the [pub tool][25] by type `pub install`, standing in the project folder.
This should download any third party libraries and put them in the *packages* folder in the project folder.

### Creating configuration script that launches Planemo
Launching Planemo requires that you have very basic understanding of the [Dart language][26], or at least [Object-oriented programming][27].

In order to start Planemo you actually need to create a Dart source code file, in the newly downloaded project folder, and inside that invoke an instance
of the `Planemo` class with a set of configurations (an instance of the `PlanemoConfiguration` class). It is on the `PlanemoConfiguration` instance you then setup
all the various configurations (such as the root folder, what reporters to use, etc) and plugins you want to enable. The best way to understand how exactly
this can be done is by looking at a real example.




[21]: https://www.dartlang.org/docs/dart-up-and-running/contents/ch04-tools-dart-vm.html
[22]: https://www.dartlang.org/tools/download.html
[23]: https://github.com/corgrath/planemo.dart
[24]: https://help.github.com/articles/set-up-git/
[25]: https://www.dartlang.org/tools/pub/
[26]: https://www.dartlang.org/
[27]: http://en.wikipedia.org/wiki/Object-oriented_programming


