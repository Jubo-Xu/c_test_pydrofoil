CC=aarch64-linux-gnu-gcc
OBJCOPY=aarch64-linux-gnu-objcopy
AS=aarch64-linux-gnu-as
LD=aarch64-linux-gnu-ld

.PHONY: initramfs

%.o: %.S
	$(CC) -nostdlib -c $<

%.o: %.c
	$(CC) -nostdlib -fno-builtin -c $<

%.dtb: %.dts
	dtc -O dtb $< -o $@

c_test: start.o c_test.o c_test.ld system.h
	$(LD) -T c_test.ld -verbose

c_test.bin: c_test
	$(OBJCOPY) -O binary c_test c_test.bin

initramfs: init.S
	$(CC) $< -nostdlib -static -o initramfs/init

clean:
	-rm -f c_test
	-rm -f *.o
	-rm -f *.bin
	-rm -f *.dtb
	-rm -f initramfs/init
