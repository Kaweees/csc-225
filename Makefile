rm -rf hello
riscv64-linux-gnu-as hello.s -o hello.o
riscv64-linux-ghu-gcc -o hello hello.o -nostdlib -static 