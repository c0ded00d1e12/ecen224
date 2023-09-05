---
title: Command Line
number: 2
layout: lab
---

## GitHub Classroom
Use the GitHub Classroom link posted in the Learning Suite for the lab to accept the assignment. Make sure to clone the repository.

## Objectives

- Become familiar with the Linux environment, commands, and some applications.
- Be able to navigate a directory tree from the command line.
- Use a text editor to create and edit text files.

## Overview

In this lab you will learn some basic Linux features and skills that are useful throughout a technical career. The Linux environment is used commonly in the engineering, scientific and research communities. One of the reasons for this stems from the openness of Linux and the many applications that run on it. The source code to most everything that runs on Linux, and the [kernel](http://www.kernel.org/) itself, is available on the Web. If you don’t like something or want to improve it, nothing is stopping you from getting the source code and changing it. You are encouraged to learn and explore beyond what is presented here on your own. We can only touch on a few Linux features. Discovering the flexibility that is available to the creative mind is left to you. 

### Explore Common Linux Commands
Work through Modules 1, 2, and 4 of the [Linux Survival tutorial](http://linuxsurvival.com/). It has a simulated Linux terminal for practicing what you learn in the modules.

For a brief list of commonly used commands, see the [Linux Command Summary]({{site.baseurl}}/resources#linux_commands_summary/).

### Install ZSH
Inside of every terminal is the program that runs and executes the commands typed inside of it. This is known as the **shell**. Most Linux operating have the `bash` shell running by default. For this class we will be using the `zsh` shell due to its more advanced and modern features. To install this, SSH into your Pi Z2W. Then execute the following commands:

```bash
sudo apt install zsh    # This installs the zsh program
chsh -s /bin/zsh        # This will change your default shell to zsh
```

Once this finishes installing, close the ssh session by typing in
```bash
exit
```
and then enter back into the Pi Z2W through SSH. You will be greeted with a setup screen like the following:
```
This is the Z Shell configuration function for new users,
zsh-newuser-install.
You are seeing this message because you have no zsh startup files
(the files .zshenv, .zprofile, .zshrc, .zlogin in the directory
~).  This function can help you with a few settings that should
make your use of the shell easier.

You can:

(q)  Quit and do nothing.  The function will be run again next time.

(0)  Exit, creating the file ~/.zshrc containing just a comment.
     That will prevent this function being run again.

(1)  Continue to the main menu.

(2)  Populate your ~/.zshrc with the configuration recommended
     by the system administrator and exit (you will need to edit
     the file by hand, if so desired).

--- Type one of the keys in parentheses --- 

```

Quit this menu by pressing `q`. This allows us to create our own configuration file. This is done by running
```bash
nano .zshrc
```

This creates a new file named `.zshrc` that is empty. Copy and paste the following into the text editor and then save and close the file:

```sh
# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

```

Once you have done this, you can apply these configurations to your current terminal session by running
```bash
source .zshrc
```

Your terminal prompt (or text before every command) should now look something like the following:
```
username@doorbell-netid%
```

### Keyboard Shortcuts
Even though using the command line to do things in Linux may seem like a lot of typing, there are shortcuts in place that can tremendously reduce the number of keystrokes. With a little practice, the shortcuts become a natural part of doing work on the command line and can even be more efficient than pointing, clicking, and navigating menus in a graphical interface. With a graphical interface, a user will often need to move their hand back and forth between the keyboard and the mouse. This motion is inefficient, even though most of us get used to it. With command line operation, our fingers never need to leave the keyboard and reach for the mouse.

#### Command History
When you type a command on the keyboard, there is a good chance you will want to execute it again, exactly the same way, or with a small variation. Using the up and down arrows on the keyboard allows you to navigate through a history of commands you have typed on the command line. When you hit the up arrow key the first time, the last command you executed will appear on the command line. If you hit up arrow again, you will see the next to the last and so forth. Typing down arrow will show more recent commands. After you have selected a previous command with the arrow keys, hitting the `Enter` key will execute the command.

#### Command Editing
Once you have selected a prior command with the up and down arrow keys, you may want to slightly change it before you execute it again. The left and right arrow keys allow you to move the cursor to a location where you want to change the command. Use the backspace key to remove characters and then type new text at that location. When satisfied with the modified command, hit `Enter` to execute it. This is useful, for example, when you want to execute the same command on a different filename. Just hit up arrow to get the previous command, then backspace over the old file name and type the new one.

#### Command Completion
Another helpful shortcut is called command or tab completion. If the tab key is pressed while a partial command or file name is typed, the shell will complete the rest of the text based on what has already been typed. Open a terminal window to your home directory (you can do this by typing `Ctrl`+`Alt`+`T`) and type the following and then hit `Tab`.
```bash
ls /d
```
After hitting `Tab` you should see that “/d” was extended to “/dev/”. Now type `Enter` to execute the command. When navigating deep directory hierarchies, tab completion can assist in typing what could otherwise be very long path names. For example, tab can be pressed multiple times to keep extending the path name after typing a few characters, enough to make the name unique.

Command names can also be tab completed. In a terminal window, type the following and then hit `Tab`.
```bash
mkd
```
Pressing the tab key should complete the command to mkdir. Press `Enter` to start the web browser. If you press `Tab` and you don’t get a response, you have mistyped the leading characters or there are other options that are ambiguous. Typing `Tab` again a second time will list the remaining options that begin with the characters you have typed. For example type in 
```bash
mk
```
Now hit `Tab` a couple of times and you should see something like this:
```
mkdir        mk_modmap    mksh         mktemp       mkvinfo      mkvpropedit  
mkfifo       mknod        mksh-static  mkvextract   mkvmerge
```
You can `Tab` through the possible commands and hit `Enter` to select the highlighted command. 

### Set and Read Environment Variables
The Linux environment holds configuration variables used by application programs. These variables are set in the environment by a user or by the system as needed. Knowing how to set environment variables and view them is important, since some Linux application programs may depend on you setting these up properly before running them. For example, the shell inside your terminal uses environment variables to indicate the location of where all the commands are stored. Now let’s see how to set an environment variable. The following example will set the variable MYLAB to a value of 02.
```bash
export MYLAB=02
```
After typing the command in the terminal, you can view the value that was last set by typing:
```bash
echo $MYLAB
```
You can also see your variable among all the others by typing:
```bash
env
```

### Get Familiar with a Text Editor
Several text editors are installed on your system, for example, `code`, `gedit`, `nano`, and `vim`. Some applications can only be run from the command line, while others can be launched graphically by clicking on its icon in the application screen. Choose an editor, and use it to create a new file. (Hint: If you are doing this lab SSHed into your Pi Z2W, `code` and `gedit` will not work.)

Open a new file in the cloned lab directory and create a note to yourself.
Experiment with deleting text, copying, and pasting.
Save the file.
Open a terminal window and type `ls -l` to see details about the text file you created.

### Setup Shell Configuration Files
If the default configuration of your command line environment is not what you would prefer, you can change it to your liking. Let’s go through how to customize your environment.

When you first open a terminal window, if your home directory contains a file named `.zshrc`, the command shell (`zsh`) will read and execute commands from that file before giving you the command prompt. 

Since the file names begin with a dot `.`, they are hidden from the ls command unless you use the `-a` option (e.g. `ls -a`).

Use your text editor of choice to view these files and make any changes according to your preferences. For example:
```bash
nano .zshrc
```
If you are not familiar with a command and want to know what it does, type `man` and the name of the command to see a help manual for that command. You can open another terminal window at the same time to type the `man` command and see the helpful text. Many of the commands used in `.zshrc`, like `alias`, are built into zsh. For these, type `man zsh` to get help. If you type `man <command>` and the response is `No manual entry for <command>`, it is likely built into zsh. Online help is also available for [shell built-in commands](https://www.gnu.org/software/bash/manual/html_node/Shell-Builtin-Commands.html) and other [core commands](https://www.gnu.org/software/coreutils/manual/html_node/index.html).

One of the preferences set in the example .zshrc file you copied over is to define an alias for typing `ll` at the command line. When the alias is defined, typing `ll` will actually execute `ls -alF` with the long listing option. To customize this for pass-off, remove the `a` and `F` options so that the line reads `alias ll='ls -l'`. Lines beginning with a `#` in shell scripts are comments and are not executed.

Save any changes you have made to `.zshrc`. Test that your preferences are working by closing the terminal window and opening a new one. Then type some commands that exercise the preference. Files listed with ls should now be shown with color.

### Shell Challenge

To round out your shell learning experience, you are **required** to complete the shell challenge. In the lab repo, uncompress the `challenge.tar.xz` package. (You may want to Google on how to do this.) Complete the challenge at each level to beat this challenge. 

**To ensure this is graded successfully, make sure you commit the decompressed files!**

## Lab Submission
- Answer the questions in the `README.md`. 

- To successfully submit your lab, you will need to follow the instructions in the [Lab Setup]({{ site.baseurl }}/lab-setup) page, especially the **Commiting and Pushing Files** and **Tagging Submissions** section.

## Explore More!

- [The Linux Command Line for Beginners (tutorial)](http://ubuntu.com/tutorials/command-line-for-beginners)
- [The Linux Command Line (book online)](http://linuxcommand.org/tlcl.php)
- [Shell (bash) Built-in Commands - cd, pwd, echo, etc.](https://www.gnu.org/software/bash/manual/html_node/Shell-Builtin-Commands.html)
- [GNU Coreutils - cp, mv, rm, mkdir, chown, etc.](https://www.gnu.org/software/coreutils/manual/html_node/index.html)
- [Oh My Zsh + PowerLevel10k](https://dev.to/abdfnx/oh-my-zsh-powerlevel10k-cool-terminal-1no0)