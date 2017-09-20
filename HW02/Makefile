# Warnings
WFLAGS	:= -Wall -Wextra -Wsign-conversion -Wsign-compare
EXEC 	:= problem1a.exe problem1b.exe problem1c.exe problem2a.exe problem2b.exe problem3a.exe problem3b.exe problem3c.exe
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

%.o : %.c Makefile
	@ echo Compiling $<...
	$(CC) $(CCSTD) $(WFLAGS) $(OPT) $(ARCH) $(CFLAGS) -c $< -o $@

%.o : %.cpp Makefile
	@ echo Compiling $<...
	$(CXX) $(CXXSTD) $(WFLAGS) $(OPT) $(ARCH) $(CXXFLAGS) -c $< -o $@

# TODO: add targets for building executables
problem1a.exe: problem1a.cpp
	@ echo Building $@...
	@ $(CXX) $(CXXSTD) -o $@ $< $(LDFLAGS) $(LDFLAGS)

problem1b.exe: problem1b.cpp
	@ echo Building $@...
	@ $(CXX) $(CXXSTD) -o $@ $< $(LDFLAGS) $(LDFLAGS)
problem1c.exe: problem1c.cpp
	@ echo Building $@...
	@ $(CXX) $(CXXSTD) -o $@ $< $(LDFLAGS) $(LDFLAGS)

problem2a.exe: problem2a.cpp
	@ echo Building $@...
	@ $(CXX) $(CXXSTD) -o $@ $< $(LDFLAGS) $(LDFLAGS)
problem2b.exe: problem2b.cpp
	@ echo Building $@...
	@ $(CXX) $(CXXSTD) -o $@ $< $(LDFLAGS) $(LDFLAGS)

problem3a.exe: problem3a.cpp
	@ echo Building $@...
	@ $(CXX) $(CXXSTD) -o $@ $< $(LDFLAGS) $(LDFLAGS)
problem3b.exe: problem3b.cpp
	@ echo Building $@...
	@ $(CXX) $(CXXSTD) -o $@ $< $(LDFLAGS) $(LDFLAGS)
problem3c.exe: problem3c.cpp
	@ echo Building $@...
	@ $(CXX) $(CXXSTD) -o $@ $< $(LDFLAGS) $(LDFLAGS)	


.PHONY: clean
clean:
	@ rm -f $(EXEC) $(OBJS)
