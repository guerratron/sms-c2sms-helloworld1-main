# A github template and quickstart project for C2SMS (C programming language) SMS games

## Features

- Everything needed to build a "Hello, World!" project with "c2sms" from a standing start!
- Without dependencies, not devKitSMS, not SMSLib, ..
- Use Github Actions to develop and build in the cloud!
- Or use the `dist/cmd2sms.zip` archive for `windows` from `bash files` to develop locally with or without Visual Studio Code integration!
- Perfect for beginners or those wanting to avoid installing lots of tools to get into SMS development!

## Prerequisites

- SDCC
- Make command

OR ..

### Using Github Actions (easiest quickstart)

You can use this project to build your code in the cloud with Github Actions and in that case you won't need to install anything at all on your computer: you just need your own Github account set up.

### Using dist/cmd2sms.zip Zip archive standalone

You can use the zip archive directly with `.bat files`, without using it as a Visual Studio Code, without devcontainer, ...
In this case [only windows] the only prerequisite is SDCC and Make-Command for Desktop Windows.

### Manual tooling setup (windows)

You can install all the prerequisites manually if you don't want to use a Github-Actions based solution.

- [SDCC](https://sdcc.sourceforge.net/) - note you will also need to install SDCC as documented
- [GNU Make](https://www.gnu.org/software/make/) you need the Make command, in Linux NO-PROBLEM, but for Windows you need to install MinGW or similar.
- exec the `bat/bash files` 

## Usage

### Using Github Actions (easiest quickstart)

1. At the top of this repository page, click the button which says "Use this template" and select "Create a new repository".
2. Give your new repository a name, e.g. 'sms-hello-world'. You can change the name later.
3. Create the repository.
4. (optional) enable discussions on your repo if you want discussion posts to be automatically created for new tag releases.
5. Click the Actions tab. You should see that a build has already started running. When it changes to a green tick, you can click into the build to see the "Artifacts" section. Within the "Artifacts" section should be an artifact called "roms" and clicking that will download a zipfile with the built SMS ROM inside it.
6. Run the ROM in your emulator or flashcart of choice!

To develop in the code, you can use the Github web experience to edit code. Every time you modify code it will rebuild the project and – assuming there are no build errors – will produce a new "roms" artifact in the Actions tab.

You can also produce more "official" releases of your project in Github automatically in two ways:
- when pushing a new tag from a git client, a new release will be created for that tag, and a discussion post created if discussions are enabled for your repo
- creating a new release from the Github web UI will trigger a new release build, and if successful the output of the build will be attached to the release you created

If you want to disable these Github Actions you can either disable them at the repo level in your repository settings in Github, or you can simply delete the files inside the `.github/workflows` folder in the repo. You could also edit the `.yml` files to modify the build process to your needs.

Also if you want to make a change to your source but skip the automatic build steps, add the text `[skip ci]` to your commit message.

## The project structure

### Overview

This is an opinionated project template with a very basic structure:

- All C source code files (except for generated assets) are inside the `src` folder.
- All raw asset files are in the `assets` folder.
- The libraries in the `lib` folder.
- The `inc` folder is the **mini-api** to use.
- Project outputs are built to the `bin` folder.

The Makefiles supplied with this project allow you to nest your source code one level deep inside the `src` folder, but it's easiest to keep the folder flat and without any sub-folders if you can.

### Makefiles

We've supplied a Makefile setup that should be useful for most projects and reflects our typical setup.

From your project root folder:
- `make` (or `make all`) will run the default top level build which builds assets and source code to produce a final ROM.
- `make valid` will _only_ compile the `.sms` and the `.asm` and not the source code.
- `make clean` will wipe all output and generated files from the filesystem and is useful if your build gets in a strange state.

There are many options you can change in the Makefiles to tweak your build, but we recommend that you don't unless you know exactly what you're doing!
A few settings have been designed to be overridden from the command line or with environment variables. In particular the `PROJECTNAME` setting can be overridden. If it's not supplied then it will simply take the name of the folder your project is in. You can override the `PROJECTNAME` setting by adding `-e PROJECTNAME=your-new-project-name` to your `make` commands.

More tools will be added in future.

## Hello World

Minimal code and assets are provided to produce an animated Hello World demo illustrating some basic functionality.
Delete code inside `// EXAMPLE` and `// END:EXAMPLE` blocks and delete the example assets to remove this example functionality.

## README for C2SMS
here to [README-FOR-C2SMS](/README_C2SMS.md)
