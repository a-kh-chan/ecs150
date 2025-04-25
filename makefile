CC = gcc
CFLAGS = -Wall -Wextra -Werror
TARGET = sshell
SRC = sshell.c

all: $(TARGET)

clean:
	rm edit $(TARGET)
