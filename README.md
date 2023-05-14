# redesigned-potato

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]

# CSC 225 

[<img src="assets/img/risc-v-logo.png" align="right" width="150">](https://github.com/Kaweees/csc-225)

All of my course files (labs and projects) for CSC 225 (Introduction to Computer Organization) taken through Cal Poly, with Professor John Planck.

## User Guide

Available Cal Poly Unix Machines:
- username@unix1.csc.calpoly.edu
- username@unix2.csc.calpoly.edu
- username@unix3.csc.calpoly.edu

### Secure Shell (ssh) Usage

Once ssh is installed on your machine, you can connect to the Cal Poly servers and interface with the machines via the commands line. To connect to the server, use the following command:
```sh
ssh username@machinename
exit # to exit the server
```

### Safe File Transfer Protocol (sftp) Usage
Once a sftp client is installed on your machine, you can connect to the Cal Poly servers and move files from your machine to the Cal Poly servers and vice versa via the command line. To connect to the server, use the following command:
```sh
sftp username@machinename
quit # to exit the server
```
Available commands:
```sh
put file1 file2 (optional) # copy a file from the local machine to the remote machine
get file1 file2 (optional) # copy a file from the remote machine to the local machine
ls # get a directory listing on the remote machine
cd # change your current working directory on the remote machine
lls # get a directory listing on the local machine
lcd # change your current working directory on the local machine
```
Flags available for `put` and `get`:
```sh
-r # recursive
-a # archive
-v # verbose
-p # preserve
```

### GNU Compiler Collection (gcc) Usage

Once gcc is installed on your machine, you can compile and run C programs via the command line. To compile a C program, use the following command:
```sh
gcc -ansi -Wall -pedantic -Werror -o programname programname.c
./programname # to run the program
```
The `-ansi` flag specifies that the compiler should implement the ANSI C standard, `-Wall` enables all compiler warnings, `-pedantic` tells the compiler to be adhere strictly to the ANSI C standard, and `-Werror` tells the compiler to treat all warnings as errors.

[contributors-shield]: https://img.shields.io/github/contributors/Kaweees/csc-225.svg?style=for-the-badge
[contributors-url]: https://github.com/Kaweees/csc-225/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Kaweees/csc-225.svg?style=for-the-badge
[forks-url]: https://github.com/Kaweees/csc-225/network/members
[stars-shield]: https://img.shields.io/github/stars/Kaweees/csc-225.svg?style=for-the-badge
[stars-url]: https://github.com/Kaweees/csc-225/stargazers