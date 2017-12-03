# Warnings
WFLAGS	:= -Wall -Wextra -Wsign-conversion -Wsign-compare

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

# all : problem1 ref_scan
# all : problem2 ref_reduction

# all : problem1 ref_scan problem2  ref_reduction
# EXEC=problem1 ref_scan problem2 ref_reduction 

# all : problem1 ref_scan problem2  ref_reduction problem3
# EXEC=problem1 ref_scan problem2 ref_reduction problem3

all : problem1 problem2 problem3
EXEC=problem1 problem2 problem3

problem1: problem1.cu
	module load cuda; nvcc -o problem1 $(OPT) problem1.cu
ref_scan: ref_scan.cu
	module load cuda; nvcc -o ref_scan $(OPT) ref_scan.cu
problem2: problem2.cu
	module load cuda; nvcc -o problem2 $(OPT) problem2.cu
ref_reduction: ref_reduction.cu
	module load cuda; nvcc -o ref_reduction $(OPT) ref_reduction.cu
problem3: problem3.cu
	module load cuda; nvcc -o problem3 $(OPT) problem3.cu


.PHONY: clean
clean:
	@ rm -f $(EXEC) 
