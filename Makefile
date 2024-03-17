CSRC = \
	./csrc/*.cpp

VSRC = \
	./vsrc/*.v

VL_FLAGS = --cc
VL_FLAGS += --trace
VL_FLAGS += --exe
VL_FLAGS += --build
VL_FLAGS += -j 0
VL_FLAGS += -Wall
VL_FLAGS += -Ivsrc
VL_FLAGS += --top-module j101_top

all:
	verilator $(VL_FLAGS) $(CSRC) $(VSRC)

sim: all
	$(call git_commit, "sim RTL")
	./obj_dir/Vj101_top && \
		gtkwave ./dump.vcd

clean:
	rm -rf obj_dir dump.vcd

include ../Makefile
