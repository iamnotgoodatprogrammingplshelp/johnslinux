# Makefile
# Toolchain prefix (Adjust if yours is different, e.g., riscv64-linux-gnu-)
CROSS_COMPILE = riscv64-unknown-elf-
CC = $(CROSS_COMPILE)gcc
AS = $(CROSS_COMPILE)as
LD = $(CROSS_COMPILE)ld

# Files
SRCS = entry.s kernel.s   # kernel.s is your renamed menu.s
OBJS = entry.o kernel.o
TARGET = os.elf

# Flags
ASFLAGS = -g -march=rv64gc -mabi=lp64
LDFLAGS = -T linker.ld -nostdlib -static

all: $(TARGET)

# Compile Assembly
%.o: %.s
	$(AS) $(ASFLAGS) -c $< -o $@

# Link everything together
$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS) -o $@

# Run in QEMU
run: $(TARGET)
	qemu-system-riscv64 -machine virt -bios none -kernel $(TARGET) -nographic

clean:
	rm -f *.o *.elf