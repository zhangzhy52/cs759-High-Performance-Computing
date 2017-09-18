# Warnings
WFLAGS	:= -Wall -Wextra -Wsign-conversion -Wsign-compare
EXEC 	:= problem1.exe problem2.exe problem3.exe
# Optimization and architecture
OPT		:= -O3
ARCH   	:= -march=native

# Language standard
CCSTD	:= -std=c99
CXXSTD	:= -std=c++11

# Linker options
LDOPT 	:= $(OPT)
LDFLAGS := 

.DEFAULT_GOAL := all

.PHONY: debug
debug : OPT  := -O0 -g -fno-omit-frame-pointer -fsanitize=address
debug : LDFLAGS := -fsanitize=address
debug : ARCH :=
debug : $(EXEC) 

all : Makefile $(EXEC)
#problem1 : problem1.cpp
#		g++ -o3 problem1.c -o problem1.exe

%.o : %.c Makefile
	@ echo Compiling $<...
	$(CC) $(CCSTD) $(WFLAGS) $(OPT) $(ARCH) $(CFLAGS) -c $< -o $@

%.o : %.cpp Makefile
	@ echo Compiling $<...
	$(CXX) $(CXXSTD) $(WFLAGS) $(OPT) $(ARCH) $(CXXFLAGS) -c $< -o $@

# TODO: add targets for building executables
problem1.exe: problem1.cpp
	@ echo Building $@...
	@ $(CXX) -o $@ $< $(LDFLAGS) $(LDFLAGS)

problem2.exe: problem2.cpp
	@ echo Building $@...
	@ $(CXX) -o $@ $< $(LDFLAGS) $(LDFLAGS)

problem3.exe: problem3.cpp
	@ echo Building $@...
	@ $(CXX) -o $@ $< $(LDFLAGS) $(LDFLAGS)
.PHONY: clean
clean:
	@ rm -f $(EXEC) $(OBJS)
