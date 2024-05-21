# Makefile for compiling and simulating with VCS

# VCS compiler and simulation flags
VCS = vcs
VCS_FLAGS = -full64 -sverilog -timescale=1ns/1ps -debug_all

# Source files
SV_SOURCES = ahb_pkg.sv tb_top.sv sram_control.sv sram_interface.sv
VHDL_SOURCES = package_timing.vhd package_utility.vhd async.vhd

# Output executable
SIMV = simv

# Waveform file
WAVEFORM = waveform.vcd

# Default target
all: $(SIMV)

# Compile the design and testbench
$(SIMV): $(SV_SOURCES) $(VHDL_SOURCES)
	$(VCS) $(VCS_FLAGS) $(SV_SOURCES) $(VHDL_SOURCES) -o $(SIMV)

# Run the simulation
run: $(SIMV)
	./$(SIMV)

# View the waveform
view: $(WAVEFORM)
	gtkwave $(WAVEFORM)

# Clean up generated files
clean:
	rm -rf $(SIMV) csrc DVEfiles ucli.key $(WAVEFORM) *.vpd *.vcd *.fsdb *.log

# Generate the waveform
$(WAVEFORM): run
	# Ensure the waveform file is generated
	@echo "Waveform generated: $(WAVEFORM)"

# Phony targets
.PHONY: all run view clean
