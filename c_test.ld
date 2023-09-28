ENTRY(_start)
OUTPUT(c_test)
STARTUP(start.o)
INPUT(c_test.o)

SECTIONS
{
  .text.start (0x00010000) : {
    start.o( .text )
  }

  .text : ALIGN(0x1000) {
_TEXT_START_ = .;
    *(.text)
_TEXT_END_ = .;
   }

  .rodata : ALIGN(0x1000) {
_DATA_START_ = .;
    *(.rodata)
_DATA_END_ = .;
  }
}
