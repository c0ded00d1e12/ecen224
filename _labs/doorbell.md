---
title: Doorbell
number: 11
layout: lab
---

## GitHub Classroom
Use the GitHub Classroom link posted in the Slack channel for the lab to accept the assignment.

## Objectives
- Learn about daemons
- Create a program that runs on boot
- Deal with different modes of program operation

## Overview
Welcome to the end of the semester! You have come very far in your abilities to understand how computers work under the hood and how you can control them programmatically. The difference between the computer you are using now and most single-use devices that exist on the market is that your Pi Z2W in its current state still acts as any normal desktop/laptop/phone. When you turn the device on, the operating system loads and then you are expected to start any program that you wish to have running. 

This is not the case for most single-use devices. For example, when you turn on a microwave, it immediately starts heating up your food. When you turn on an electric kettle, it immediately starts heating up your water. When you turn on a doorbell, it immediately starts ringing. This is because these devices are programmed to start running as soon as they are turned on. In this lab, we will work to make the Pi Z2W act as a smart doorbell. This entails having your program run on boot.

### systemd Daemons
To enable our program to run on boot in Linux, we need to understand how Linux manages its processes. Linux uses a system called `systemd` to manage its processes. `systemd` is a system and service manager that runs as PID 1 when the system boots. It is responsible for starting and stopping processes, as well as managing the boot process. 

It also manages programs that run in the background, called daemons. A daemon is a program that runs in the background and is not directly started by the user. Daemons are often used to provide services to the user, such as the `sshd` daemon that provides the ability to connect to the Pi Z2W over SSH.

#### Service Files
For our doorbell to run on boot, we need to create a daemon that runs our program. This is done by creating a `systemd` service file. A `systemd` service file is a file that contains information about a service that `systemd` can be used to start and stop the service.

One specific command that can be used to monitor and control the operations of daemons in `systemd` is called `systemctl`. `systemctl` is a command line utility that can be used to control the `systemd` system and service manager. It can be used to start, stop, restart, and check the status of services.

For example, let's say we want to observe the `sshd` daemon on our Pi Z2W. We can use the following command to see the status of the `sshd` daemon:

```bash
sudo systemctl status sshd    # Shows status of the sshd daemon
```

Likewise, if we wanted to start or stop the daemon, we could use the following commands:

```bash
sudo systemctl start sshd     # Starts the sshd daemon
sudo systemctl stop sshd      # Stops the sshd daemon
```

However, these commands only work for daemons that are already installed on the Pi Z2W. If we want to create our own daemon, we need to create a service file that `systemd` can use to start and stop our program.

To create a service file, we need to create a file in the `/etc/systemd/system` directory. The name of the file must end in `.service`. The contents of the file must be in the following format:

```ini
[Unit]
Description=Name of your service

[Service]
ExecStart=command to start your program

[Install]
WantedBy=multi-user.target
```

Once we have created out `.service` file, we can use the commands above to start and stop our program. However, what if I want to start my program when the computer boots? We need to **enable** our service. To do this, we can use the following command:

```bash
sudo systemctl enable my-service.service    # Enables the my-service service
```

This will make it so that my-service.service will run whenever I turn on the Pi Z2W. If I don't want my program to run when my Pi Z2W boots, I can use the following command to disable my service:

```bash
sudo systemctl disable my-service.service    # Disables the my-service service
```

## Requirements
Now that we know how to create a daemon, we can start working on our doorbell. Your doorbell should have the following features:
1. The program should run on boot.

2. When the program starts, it should show a welcome message on the screen.

3. When the center button is pressed, do the following in a thread:

    - Your doorbell should take a picture and save it to your viewer folder.
    - Send your saved image to the web site.
4. Change the display to show the message to let the user know that doorbell was rung (i.e. "Ding dong!"). Make this message visible for 5 seconds and then change back to the initial welcome message. (This part will require threading)

5. When the following sequence of buttons are pressed (Up-Up-Down), take the user to the file browser menu. To go back to the original welcome message, the sequence (Left-Right-Left-Right) should be entered.

## Submission

### Compilation
Since a large portion of this lab's grade depends on me successfully compiling your code, the following points must be adhered to to ensure consistency in the grading process. Any deviation in this will result in points off your grade:

- The code in this lab will be compiled at the root of this lab repository (i.e. `doorbell-<your-github-username>`). It is your responsibility to ensure that `gcc` will work from this directory.
- Your binary must output to a folder called `bin`. This folder will be marked to be ignored by `git`, meaning that I will not receive your final compiled binary to test, but rather your code which must compile successfully on my Pi Z2W.

### Gitignore
In this lab you are expected to ignore the following:

- `.vscode` folders
- the `bin` folder where your binary is generated

### Normal Stuff
- Complete all of the requirements.

- Answer the questions in the `README.md`. 

- To successfully submit your lab, you will need to follow the instructions in the [Lab Setup]({{ site.baseurl }}/lab-setup) page, especially the **Commiting and Pushing Files** and **Tagging Submissions** section.

- **MAKE SURE YOUR CODE FOLLOWS THE CODING STANDARD!** More info on how to set that up is available on the Coding Standard page. 


## Explore More!
- [What is systemd?](https://en.wikipedia.org/wiki/Systemd)
- [systemd's website](https://systemd.io/)
- [Creating a systemd Service](https://medium.com/@benmorel/creating-a-linux-service-with-systemd-611b5c8b91d6)