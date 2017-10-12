# Warnings
WFLAGS := -Wall -Wextra -Wsign-conversion -Wsign-compare

# Optimization and architecture
OPT  := -O3 -mavx -fopenmp

# Language standard
CCSTD	:= -std=c99
CXXSTD	:= -std=c++14

# Linker options
LDFLAGS := -fopenmp

# Names of executables to create
EXEC := problem1 problem2

.DEFAULT_GOAL := all

.PHONY: debug
debug : OPT  := -O0 -g -fno-omit-frame-pointer -fsanitize=address
debug : LDFLAGS := -fsanitize=address
debug : $(EXEC)

all : Makefile $(EXEC)

%.o : %.c Makefile
	@ echo Compiling $<...
	@ $(CC) $(CCSTD) $(WFLAGS) -Wno-unused-result $(OPT) $(CFLAGS) -c $< -o $@

%.o : %.cpp Makefile
	@ echo Compiling $<...
	@ $(CXX) $(CXXSTD) $(WFLAGS) $(OPT) $(CXXFLAGS) -c $< -o $@

$(EXEC) : % : %.o
	@ echo Building $@...
	@ $(CXX) -o $@ $< $(LDFLAGS)

problem1.o : problem1.cpp 
	@ echo Compiling $<...
	$(CXX) $(CXXSTD) $(WFLAGS) $(OPT) $(ARCH) $(CXXFLAGS) -c $< -o $@ -fopenmp

problem1: problem1.o
	@ echo Building $@...
	@ $(CXX) -o $@ $< $(LDFLAGS) $(OPT) -fopenmp


problem2.o : problem2.cpp 
	@ echo Compiling $<...
	$(CXX) $(CXXSTD) $(WFLAGS) $(OPT) $(ARCH) $(CXXFLAGS) -c $< -o $@ -fopenmp
problem2 : problem2.o
	@ echo Building $@...
	@ $(CXX) -o $@ $< $(LDFLAGS) $(OPT) -fopenmp


.PHONY: clean
clean:
	@ rm -f *.o $(EXEC) *.in
