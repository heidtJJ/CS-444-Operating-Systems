export

UPROGS=\
	_cat\
	_echo\
	_forktest\
	_grep\
	_init\
	_kill\
	_ln\
	_ls\
	_mkdir\
	_rm\
	_stressfs\
	_usertests\
	_wc\
	_zombie\
	_sh\
	_pwd\
	_1_fork\
	_4_exec\
	_fileopt\
	_getmz\
	_jared\

CFLAGS += -I$(shell pwd)
ULIB = ulib.o usys.o printf.o umalloc.o

all: $(UPROGS)

_%: %.o $(ULIB)
	$(LD) $(LDFLAGS) -N -e main -Ttext 0 -o $@ $^
	$(OBJDUMP) -S $@ > $*.asm
	$(OBJDUMP) -t $@ | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $*.sym

_forktest: forktest.o $(ULIB)
	# forktest has less library code linked in - needs to be small
	# in order to be able to max out the proc table.
	$(LD) $(LDFLAGS) -N -e main -Ttext 0 -o _forktest forktest.o ulib.o usys.o
	$(OBJDUMP) -S _forktest > forktest.asm

clean:
	rm -f *.o *.d *.asm *.sym $(UPROGS)
