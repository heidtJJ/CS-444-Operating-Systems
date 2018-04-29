
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc d0 b5 10 80       	mov    $0x8010b5d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 f0 2e 10 80       	mov    $0x80102ef0,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 14 b6 10 80       	mov    $0x8010b614,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 00 74 10 80       	push   $0x80107400
80100051:	68 e0 b5 10 80       	push   $0x8010b5e0
80100056:	e8 b5 43 00 00       	call   80104410 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 2c fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd2c
80100062:	fc 10 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 30 fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd30
8010006c:	fc 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba dc fc 10 80       	mov    $0x8010fcdc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 07 74 10 80       	push   $0x80107407
80100097:	50                   	push   %eax
80100098:	e8 63 42 00 00       	call   80104300 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d dc fc 10 80       	cmp    $0x8010fcdc,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 e0 b5 10 80       	push   $0x8010b5e0
801000e4:	e8 47 43 00 00       	call   80104430 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 30 fd 10 80    	mov    0x8010fd30,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 2c fd 10 80    	mov    0x8010fd2c,%ebx
80100126:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 e0 b5 10 80       	push   $0x8010b5e0
80100162:	e8 a9 44 00 00       	call   80104610 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ce 41 00 00       	call   80104340 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if(!(b->flags & B_VALID)) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 4d 1f 00 00       	call   801020d0 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 0e 74 10 80       	push   $0x8010740e
80100198:	e8 d3 01 00 00       	call   80100370 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 2d 42 00 00       	call   801043e0 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 07 1f 00 00       	jmp    801020d0 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 1f 74 10 80       	push   $0x8010741f
801001d1:	e8 9a 01 00 00       	call   80100370 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 ec 41 00 00       	call   801043e0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 9c 41 00 00       	call   801043a0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
8010020b:	e8 20 42 00 00       	call   80104430 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 e0 b5 10 80 	movl   $0x8010b5e0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 af 43 00 00       	jmp    80104610 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 26 74 10 80       	push   $0x80107426
80100269:	e8 02 01 00 00       	call   80100370 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 bb 14 00 00       	call   80101740 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 9f 41 00 00       	call   80104430 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e 9a 00 00 00    	jle    8010033b <consoleread+0xcb>
    while(input.r == input.w){
801002a1:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
801002a6:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
801002ac:	74 24                	je     801002d2 <consoleread+0x62>
801002ae:	eb 58                	jmp    80100308 <consoleread+0x98>
      if(proc->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b0:	83 ec 08             	sub    $0x8,%esp
801002b3:	68 20 a5 10 80       	push   $0x8010a520
801002b8:	68 c0 ff 10 80       	push   $0x8010ffc0
801002bd:	e8 ce 3c 00 00       	call   80103f90 <sleep>
    while(input.r == input.w){
801002c2:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
801002c7:	83 c4 10             	add    $0x10,%esp
801002ca:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
801002d0:	75 36                	jne    80100308 <consoleread+0x98>
      if(proc->killed){
801002d2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801002d8:	8b 40 24             	mov    0x24(%eax),%eax
801002db:	85 c0                	test   %eax,%eax
801002dd:	74 d1                	je     801002b0 <consoleread+0x40>
        release(&cons.lock);
801002df:	83 ec 0c             	sub    $0xc,%esp
801002e2:	68 20 a5 10 80       	push   $0x8010a520
801002e7:	e8 24 43 00 00       	call   80104610 <release>
        ilock(ip);
801002ec:	89 3c 24             	mov    %edi,(%esp)
801002ef:	e8 6c 13 00 00       	call   80101660 <ilock>
        return -1;
801002f4:	83 c4 10             	add    $0x10,%esp
801002f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002ff:	5b                   	pop    %ebx
80100300:	5e                   	pop    %esi
80100301:	5f                   	pop    %edi
80100302:	5d                   	pop    %ebp
80100303:	c3                   	ret    
80100304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100308:	8d 50 01             	lea    0x1(%eax),%edx
8010030b:	89 15 c0 ff 10 80    	mov    %edx,0x8010ffc0
80100311:	89 c2                	mov    %eax,%edx
80100313:	83 e2 7f             	and    $0x7f,%edx
80100316:	0f be 92 40 ff 10 80 	movsbl -0x7fef00c0(%edx),%edx
    if(c == C('D')){  // EOF
8010031d:	83 fa 04             	cmp    $0x4,%edx
80100320:	74 39                	je     8010035b <consoleread+0xeb>
    *dst++ = c;
80100322:	83 c6 01             	add    $0x1,%esi
    --n;
80100325:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
80100328:	83 fa 0a             	cmp    $0xa,%edx
    *dst++ = c;
8010032b:	88 56 ff             	mov    %dl,-0x1(%esi)
    if(c == '\n')
8010032e:	74 35                	je     80100365 <consoleread+0xf5>
  while(n > 0){
80100330:	85 db                	test   %ebx,%ebx
80100332:	0f 85 69 ff ff ff    	jne    801002a1 <consoleread+0x31>
80100338:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
8010033b:	83 ec 0c             	sub    $0xc,%esp
8010033e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100341:	68 20 a5 10 80       	push   $0x8010a520
80100346:	e8 c5 42 00 00       	call   80104610 <release>
  ilock(ip);
8010034b:	89 3c 24             	mov    %edi,(%esp)
8010034e:	e8 0d 13 00 00       	call   80101660 <ilock>
  return target - n;
80100353:	83 c4 10             	add    $0x10,%esp
80100356:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100359:	eb a1                	jmp    801002fc <consoleread+0x8c>
      if(n < target){
8010035b:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010035e:	76 05                	jbe    80100365 <consoleread+0xf5>
        input.r--;
80100360:	a3 c0 ff 10 80       	mov    %eax,0x8010ffc0
80100365:	8b 45 10             	mov    0x10(%ebp),%eax
80100368:	29 d8                	sub    %ebx,%eax
8010036a:	eb cf                	jmp    8010033b <consoleread+0xcb>
8010036c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100370 <panic>:
{
80100370:	55                   	push   %ebp
80100371:	89 e5                	mov    %esp,%ebp
80100373:	56                   	push   %esi
80100374:	53                   	push   %ebx
80100375:	83 ec 38             	sub    $0x38,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100378:	fa                   	cli    
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
80100379:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  cons.locking = 0;
8010037f:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100386:	00 00 00 
  getcallerpcs(&s, pcs);
80100389:	8d 5d d0             	lea    -0x30(%ebp),%ebx
8010038c:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
8010038f:	0f b6 00             	movzbl (%eax),%eax
80100392:	50                   	push   %eax
80100393:	68 2d 74 10 80       	push   $0x8010742d
80100398:	e8 c3 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
8010039d:	58                   	pop    %eax
8010039e:	ff 75 08             	pushl  0x8(%ebp)
801003a1:	e8 ba 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003a6:	c7 04 24 26 79 10 80 	movl   $0x80107926,(%esp)
801003ad:	e8 ae 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003b2:	5a                   	pop    %edx
801003b3:	8d 45 08             	lea    0x8(%ebp),%eax
801003b6:	59                   	pop    %ecx
801003b7:	53                   	push   %ebx
801003b8:	50                   	push   %eax
801003b9:	e8 42 41 00 00       	call   80104500 <getcallerpcs>
801003be:	83 c4 10             	add    $0x10,%esp
801003c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cprintf(" %p", pcs[i]);
801003c8:	83 ec 08             	sub    $0x8,%esp
801003cb:	ff 33                	pushl  (%ebx)
801003cd:	83 c3 04             	add    $0x4,%ebx
801003d0:	68 49 74 10 80       	push   $0x80107449
801003d5:	e8 86 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003da:	83 c4 10             	add    $0x10,%esp
801003dd:	39 f3                	cmp    %esi,%ebx
801003df:	75 e7                	jne    801003c8 <panic+0x58>
  panicked = 1; // freeze other CPU
801003e1:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801003e8:	00 00 00 
801003eb:	eb fe                	jmp    801003eb <panic+0x7b>
801003ed:	8d 76 00             	lea    0x0(%esi),%esi

801003f0 <consputc>:
  if(panicked){
801003f0:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801003f6:	85 d2                	test   %edx,%edx
801003f8:	74 06                	je     80100400 <consputc+0x10>
801003fa:	fa                   	cli    
801003fb:	eb fe                	jmp    801003fb <consputc+0xb>
801003fd:	8d 76 00             	lea    0x0(%esi),%esi
{
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 b8 00 00 00    	je     801004ce <consputc+0xde>
    uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 01 5c 00 00       	call   80106020 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100434:	89 ca                	mov    %ecx,%edx
80100436:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100437:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	c1 e0 08             	shl    $0x8,%eax
8010043f:	89 c6                	mov    %eax,%esi
80100441:	b8 0f 00 00 00       	mov    $0xf,%eax
80100446:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100447:	89 ca                	mov    %ecx,%edx
80100449:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
8010044a:	0f b6 c0             	movzbl %al,%eax
8010044d:	09 f0                	or     %esi,%eax
  if(c == '\n')
8010044f:	83 fb 0a             	cmp    $0xa,%ebx
80100452:	0f 84 0b 01 00 00    	je     80100563 <consputc+0x173>
  else if(c == BACKSPACE){
80100458:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045e:	0f 84 e6 00 00 00    	je     8010054a <consputc+0x15a>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100464:	0f b6 d3             	movzbl %bl,%edx
80100467:	8d 78 01             	lea    0x1(%eax),%edi
8010046a:	80 ce 07             	or     $0x7,%dh
8010046d:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100474:	80 
  if(pos < 0 || pos > 25*80)
80100475:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
8010047b:	0f 8f bc 00 00 00    	jg     8010053d <consputc+0x14d>
  if((pos/80) >= 24){  // Scroll up.
80100481:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100487:	7f 6f                	jg     801004f8 <consputc+0x108>
80100489:	89 f8                	mov    %edi,%eax
8010048b:	8d 9c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ebx
80100492:	89 f9                	mov    %edi,%ecx
80100494:	c1 e8 08             	shr    $0x8,%eax
80100497:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100499:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010049e:	b8 0e 00 00 00       	mov    $0xe,%eax
801004a3:	89 fa                	mov    %edi,%edx
801004a5:	ee                   	out    %al,(%dx)
801004a6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004ab:	89 f0                	mov    %esi,%eax
801004ad:	ee                   	out    %al,(%dx)
801004ae:	b8 0f 00 00 00       	mov    $0xf,%eax
801004b3:	89 fa                	mov    %edi,%edx
801004b5:	ee                   	out    %al,(%dx)
801004b6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004bb:	89 c8                	mov    %ecx,%eax
801004bd:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004be:	b8 20 07 00 00       	mov    $0x720,%eax
801004c3:	66 89 03             	mov    %ax,(%ebx)
}
801004c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c9:	5b                   	pop    %ebx
801004ca:	5e                   	pop    %esi
801004cb:	5f                   	pop    %edi
801004cc:	5d                   	pop    %ebp
801004cd:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004ce:	83 ec 0c             	sub    $0xc,%esp
801004d1:	6a 08                	push   $0x8
801004d3:	e8 48 5b 00 00       	call   80106020 <uartputc>
801004d8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004df:	e8 3c 5b 00 00       	call   80106020 <uartputc>
801004e4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004eb:	e8 30 5b 00 00       	call   80106020 <uartputc>
801004f0:	83 c4 10             	add    $0x10,%esp
801004f3:	e9 2a ff ff ff       	jmp    80100422 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f8:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801004fb:	83 ef 50             	sub    $0x50,%edi
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004fe:	be 07 00 00 00       	mov    $0x7,%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100503:	68 60 0e 00 00       	push   $0xe60
80100508:	68 a0 80 0b 80       	push   $0x800b80a0
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010050d:	8d 9c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100514:	68 00 80 0b 80       	push   $0x800b8000
80100519:	e8 f2 41 00 00       	call   80104710 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010051e:	b8 80 07 00 00       	mov    $0x780,%eax
80100523:	83 c4 0c             	add    $0xc,%esp
80100526:	29 f8                	sub    %edi,%eax
80100528:	01 c0                	add    %eax,%eax
8010052a:	50                   	push   %eax
8010052b:	6a 00                	push   $0x0
8010052d:	53                   	push   %ebx
8010052e:	e8 2d 41 00 00       	call   80104660 <memset>
80100533:	89 f9                	mov    %edi,%ecx
80100535:	83 c4 10             	add    $0x10,%esp
80100538:	e9 5c ff ff ff       	jmp    80100499 <consputc+0xa9>
    panic("pos under/overflow");
8010053d:	83 ec 0c             	sub    $0xc,%esp
80100540:	68 4d 74 10 80       	push   $0x8010744d
80100545:	e8 26 fe ff ff       	call   80100370 <panic>
    if(pos > 0) --pos;
8010054a:	85 c0                	test   %eax,%eax
8010054c:	8d 78 ff             	lea    -0x1(%eax),%edi
8010054f:	0f 85 20 ff ff ff    	jne    80100475 <consputc+0x85>
80100555:	bb 00 80 0b 80       	mov    $0x800b8000,%ebx
8010055a:	31 c9                	xor    %ecx,%ecx
8010055c:	31 f6                	xor    %esi,%esi
8010055e:	e9 36 ff ff ff       	jmp    80100499 <consputc+0xa9>
    pos += 80 - pos%80;
80100563:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100568:	f7 ea                	imul   %edx
8010056a:	89 d0                	mov    %edx,%eax
8010056c:	c1 e8 05             	shr    $0x5,%eax
8010056f:	8d 04 80             	lea    (%eax,%eax,4),%eax
80100572:	c1 e0 04             	shl    $0x4,%eax
80100575:	8d 78 50             	lea    0x50(%eax),%edi
80100578:	e9 f8 fe ff ff       	jmp    80100475 <consputc+0x85>
8010057d:	8d 76 00             	lea    0x0(%esi),%esi

80100580 <printint>:
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d6                	mov    %edx,%esi
80100588:	83 ec 1c             	sub    $0x1c,%esp
  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
8010058d:	74 04                	je     80100593 <printint+0x13>
8010058f:	85 c0                	test   %eax,%eax
80100591:	78 57                	js     801005ea <printint+0x6a>
    x = xx;
80100593:	31 ff                	xor    %edi,%edi
  i = 0;
80100595:	31 c9                	xor    %ecx,%ecx
80100597:	eb 09                	jmp    801005a2 <printint+0x22>
80100599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
801005a0:	89 d9                	mov    %ebx,%ecx
801005a2:	31 d2                	xor    %edx,%edx
801005a4:	8d 59 01             	lea    0x1(%ecx),%ebx
801005a7:	f7 f6                	div    %esi
801005a9:	0f b6 92 78 74 10 80 	movzbl -0x7fef8b88(%edx),%edx
  }while((x /= base) != 0);
801005b0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005b2:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
801005b6:	75 e8                	jne    801005a0 <printint+0x20>
  if(sign)
801005b8:	85 ff                	test   %edi,%edi
801005ba:	74 08                	je     801005c4 <printint+0x44>
    buf[i++] = '-';
801005bc:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
801005c1:	8d 59 02             	lea    0x2(%ecx),%ebx
  while(--i >= 0)
801005c4:	83 eb 01             	sub    $0x1,%ebx
801005c7:	89 f6                	mov    %esi,%esi
801005c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    consputc(buf[i]);
801005d0:	0f be 44 1d d8       	movsbl -0x28(%ebp,%ebx,1),%eax
  while(--i >= 0)
801005d5:	83 eb 01             	sub    $0x1,%ebx
    consputc(buf[i]);
801005d8:	e8 13 fe ff ff       	call   801003f0 <consputc>
  while(--i >= 0)
801005dd:	83 fb ff             	cmp    $0xffffffff,%ebx
801005e0:	75 ee                	jne    801005d0 <printint+0x50>
}
801005e2:	83 c4 1c             	add    $0x1c,%esp
801005e5:	5b                   	pop    %ebx
801005e6:	5e                   	pop    %esi
801005e7:	5f                   	pop    %edi
801005e8:	5d                   	pop    %ebp
801005e9:	c3                   	ret    
    x = -xx;
801005ea:	f7 d8                	neg    %eax
  if(sign && (sign = xx < 0))
801005ec:	bf 01 00 00 00       	mov    $0x1,%edi
    x = -xx;
801005f1:	eb a2                	jmp    80100595 <printint+0x15>
801005f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100600 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100609:	ff 75 08             	pushl  0x8(%ebp)
{
8010060c:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
8010060f:	e8 2c 11 00 00       	call   80101740 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010061b:	e8 10 3e 00 00       	call   80104430 <acquire>
80100620:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100623:	83 c4 10             	add    $0x10,%esp
80100626:	85 f6                	test   %esi,%esi
80100628:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062b:	7e 12                	jle    8010063f <consolewrite+0x3f>
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 b5 fd ff ff       	call   801003f0 <consputc>
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 a5 10 80       	push   $0x8010a520
80100647:	e8 c4 3f 00 00       	call   80104610 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 0b 10 00 00       	call   80101660 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100669:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100670:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100673:	0f 85 27 01 00 00    	jne    801007a0 <cprintf+0x140>
  if (fmt == 0)
80100679:	8b 75 08             	mov    0x8(%ebp),%esi
8010067c:	85 f6                	test   %esi,%esi
8010067e:	0f 84 40 01 00 00    	je     801007c4 <cprintf+0x164>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100684:	0f b6 06             	movzbl (%esi),%eax
80100687:	31 db                	xor    %ebx,%ebx
80100689:	8d 7d 0c             	lea    0xc(%ebp),%edi
8010068c:	85 c0                	test   %eax,%eax
8010068e:	75 51                	jne    801006e1 <cprintf+0x81>
80100690:	eb 64                	jmp    801006f6 <cprintf+0x96>
80100692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    c = fmt[++i] & 0xff;
80100698:	83 c3 01             	add    $0x1,%ebx
8010069b:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
8010069f:	85 d2                	test   %edx,%edx
801006a1:	74 53                	je     801006f6 <cprintf+0x96>
    switch(c){
801006a3:	83 fa 70             	cmp    $0x70,%edx
801006a6:	74 7a                	je     80100722 <cprintf+0xc2>
801006a8:	7f 6e                	jg     80100718 <cprintf+0xb8>
801006aa:	83 fa 25             	cmp    $0x25,%edx
801006ad:	0f 84 ad 00 00 00    	je     80100760 <cprintf+0x100>
801006b3:	83 fa 64             	cmp    $0x64,%edx
801006b6:	0f 85 84 00 00 00    	jne    80100740 <cprintf+0xe0>
      printint(*argp++, 10, 1);
801006bc:	8d 47 04             	lea    0x4(%edi),%eax
801006bf:	b9 01 00 00 00       	mov    $0x1,%ecx
801006c4:	ba 0a 00 00 00       	mov    $0xa,%edx
801006c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006cc:	8b 07                	mov    (%edi),%eax
801006ce:	e8 ad fe ff ff       	call   80100580 <printint>
801006d3:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006d6:	83 c3 01             	add    $0x1,%ebx
801006d9:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801006dd:	85 c0                	test   %eax,%eax
801006df:	74 15                	je     801006f6 <cprintf+0x96>
    if(c != '%'){
801006e1:	83 f8 25             	cmp    $0x25,%eax
801006e4:	74 b2                	je     80100698 <cprintf+0x38>
      consputc('%');
801006e6:	e8 05 fd ff ff       	call   801003f0 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006eb:	83 c3 01             	add    $0x1,%ebx
801006ee:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801006f2:	85 c0                	test   %eax,%eax
801006f4:	75 eb                	jne    801006e1 <cprintf+0x81>
  if(locking)
801006f6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801006f9:	85 c0                	test   %eax,%eax
801006fb:	74 10                	je     8010070d <cprintf+0xad>
    release(&cons.lock);
801006fd:	83 ec 0c             	sub    $0xc,%esp
80100700:	68 20 a5 10 80       	push   $0x8010a520
80100705:	e8 06 3f 00 00       	call   80104610 <release>
8010070a:	83 c4 10             	add    $0x10,%esp
}
8010070d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100710:	5b                   	pop    %ebx
80100711:	5e                   	pop    %esi
80100712:	5f                   	pop    %edi
80100713:	5d                   	pop    %ebp
80100714:	c3                   	ret    
80100715:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
80100718:	83 fa 73             	cmp    $0x73,%edx
8010071b:	74 53                	je     80100770 <cprintf+0x110>
8010071d:	83 fa 78             	cmp    $0x78,%edx
80100720:	75 1e                	jne    80100740 <cprintf+0xe0>
      printint(*argp++, 16, 0);
80100722:	8d 47 04             	lea    0x4(%edi),%eax
80100725:	31 c9                	xor    %ecx,%ecx
80100727:	ba 10 00 00 00       	mov    $0x10,%edx
8010072c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010072f:	8b 07                	mov    (%edi),%eax
80100731:	e8 4a fe ff ff       	call   80100580 <printint>
80100736:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      break;
80100739:	eb 9b                	jmp    801006d6 <cprintf+0x76>
8010073b:	90                   	nop
8010073c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100740:	b8 25 00 00 00       	mov    $0x25,%eax
80100745:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100748:	e8 a3 fc ff ff       	call   801003f0 <consputc>
      consputc(c);
8010074d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100750:	89 d0                	mov    %edx,%eax
80100752:	e8 99 fc ff ff       	call   801003f0 <consputc>
      break;
80100757:	e9 7a ff ff ff       	jmp    801006d6 <cprintf+0x76>
8010075c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100760:	b8 25 00 00 00       	mov    $0x25,%eax
80100765:	e8 86 fc ff ff       	call   801003f0 <consputc>
8010076a:	e9 7c ff ff ff       	jmp    801006eb <cprintf+0x8b>
8010076f:	90                   	nop
      if((s = (char*)*argp++) == 0)
80100770:	8d 47 04             	lea    0x4(%edi),%eax
80100773:	8b 3f                	mov    (%edi),%edi
80100775:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100778:	85 ff                	test   %edi,%edi
8010077a:	75 0c                	jne    80100788 <cprintf+0x128>
8010077c:	eb 3a                	jmp    801007b8 <cprintf+0x158>
8010077e:	66 90                	xchg   %ax,%ax
      for(; *s; s++)
80100780:	83 c7 01             	add    $0x1,%edi
        consputc(*s);
80100783:	e8 68 fc ff ff       	call   801003f0 <consputc>
      for(; *s; s++)
80100788:	0f be 07             	movsbl (%edi),%eax
8010078b:	84 c0                	test   %al,%al
8010078d:	75 f1                	jne    80100780 <cprintf+0x120>
      if((s = (char*)*argp++) == 0)
8010078f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80100792:	e9 3f ff ff ff       	jmp    801006d6 <cprintf+0x76>
80100797:	89 f6                	mov    %esi,%esi
80100799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    acquire(&cons.lock);
801007a0:	83 ec 0c             	sub    $0xc,%esp
801007a3:	68 20 a5 10 80       	push   $0x8010a520
801007a8:	e8 83 3c 00 00       	call   80104430 <acquire>
801007ad:	83 c4 10             	add    $0x10,%esp
801007b0:	e9 c4 fe ff ff       	jmp    80100679 <cprintf+0x19>
801007b5:	8d 76 00             	lea    0x0(%esi),%esi
      for(; *s; s++)
801007b8:	b8 28 00 00 00       	mov    $0x28,%eax
        s = "(null)";
801007bd:	bf 60 74 10 80       	mov    $0x80107460,%edi
801007c2:	eb bc                	jmp    80100780 <cprintf+0x120>
    panic("null fmt");
801007c4:	83 ec 0c             	sub    $0xc,%esp
801007c7:	68 67 74 10 80       	push   $0x80107467
801007cc:	e8 9f fb ff ff       	call   80100370 <panic>
801007d1:	eb 0d                	jmp    801007e0 <consoleintr>
801007d3:	90                   	nop
801007d4:	90                   	nop
801007d5:	90                   	nop
801007d6:	90                   	nop
801007d7:	90                   	nop
801007d8:	90                   	nop
801007d9:	90                   	nop
801007da:	90                   	nop
801007db:	90                   	nop
801007dc:	90                   	nop
801007dd:	90                   	nop
801007de:	90                   	nop
801007df:	90                   	nop

801007e0 <consoleintr>:
{
801007e0:	55                   	push   %ebp
801007e1:	89 e5                	mov    %esp,%ebp
801007e3:	57                   	push   %edi
801007e4:	56                   	push   %esi
801007e5:	53                   	push   %ebx
  int c, doprocdump = 0;
801007e6:	31 f6                	xor    %esi,%esi
{
801007e8:	83 ec 18             	sub    $0x18,%esp
801007eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
801007ee:	68 20 a5 10 80       	push   $0x8010a520
801007f3:	e8 38 3c 00 00       	call   80104430 <acquire>
  while((c = getc()) >= 0){
801007f8:	83 c4 10             	add    $0x10,%esp
801007fb:	90                   	nop
801007fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100800:	ff d3                	call   *%ebx
80100802:	85 c0                	test   %eax,%eax
80100804:	89 c7                	mov    %eax,%edi
80100806:	78 48                	js     80100850 <consoleintr+0x70>
    switch(c){
80100808:	83 ff 10             	cmp    $0x10,%edi
8010080b:	0f 84 3f 01 00 00    	je     80100950 <consoleintr+0x170>
80100811:	7e 5d                	jle    80100870 <consoleintr+0x90>
80100813:	83 ff 15             	cmp    $0x15,%edi
80100816:	0f 84 dc 00 00 00    	je     801008f8 <consoleintr+0x118>
8010081c:	83 ff 7f             	cmp    $0x7f,%edi
8010081f:	75 54                	jne    80100875 <consoleintr+0x95>
      if(input.e != input.w){
80100821:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100826:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
8010082c:	74 d2                	je     80100800 <consoleintr+0x20>
        input.e--;
8010082e:	83 e8 01             	sub    $0x1,%eax
80100831:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
80100836:	b8 00 01 00 00       	mov    $0x100,%eax
8010083b:	e8 b0 fb ff ff       	call   801003f0 <consputc>
  while((c = getc()) >= 0){
80100840:	ff d3                	call   *%ebx
80100842:	85 c0                	test   %eax,%eax
80100844:	89 c7                	mov    %eax,%edi
80100846:	79 c0                	jns    80100808 <consoleintr+0x28>
80100848:	90                   	nop
80100849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100850:	83 ec 0c             	sub    $0xc,%esp
80100853:	68 20 a5 10 80       	push   $0x8010a520
80100858:	e8 b3 3d 00 00       	call   80104610 <release>
  if(doprocdump) {
8010085d:	83 c4 10             	add    $0x10,%esp
80100860:	85 f6                	test   %esi,%esi
80100862:	0f 85 f8 00 00 00    	jne    80100960 <consoleintr+0x180>
}
80100868:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010086b:	5b                   	pop    %ebx
8010086c:	5e                   	pop    %esi
8010086d:	5f                   	pop    %edi
8010086e:	5d                   	pop    %ebp
8010086f:	c3                   	ret    
    switch(c){
80100870:	83 ff 08             	cmp    $0x8,%edi
80100873:	74 ac                	je     80100821 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100875:	85 ff                	test   %edi,%edi
80100877:	74 87                	je     80100800 <consoleintr+0x20>
80100879:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
8010087e:	89 c2                	mov    %eax,%edx
80100880:	2b 15 c0 ff 10 80    	sub    0x8010ffc0,%edx
80100886:	83 fa 7f             	cmp    $0x7f,%edx
80100889:	0f 87 71 ff ff ff    	ja     80100800 <consoleintr+0x20>
        input.buf[input.e++ % INPUT_BUF] = c;
8010088f:	8d 50 01             	lea    0x1(%eax),%edx
80100892:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100895:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
80100898:	89 15 c8 ff 10 80    	mov    %edx,0x8010ffc8
        c = (c == '\r') ? '\n' : c;
8010089e:	0f 84 c8 00 00 00    	je     8010096c <consoleintr+0x18c>
        input.buf[input.e++ % INPUT_BUF] = c;
801008a4:	89 f9                	mov    %edi,%ecx
801008a6:	88 88 40 ff 10 80    	mov    %cl,-0x7fef00c0(%eax)
        consputc(c);
801008ac:	89 f8                	mov    %edi,%eax
801008ae:	e8 3d fb ff ff       	call   801003f0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008b3:	83 ff 0a             	cmp    $0xa,%edi
801008b6:	0f 84 c1 00 00 00    	je     8010097d <consoleintr+0x19d>
801008bc:	83 ff 04             	cmp    $0x4,%edi
801008bf:	0f 84 b8 00 00 00    	je     8010097d <consoleintr+0x19d>
801008c5:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
801008ca:	83 e8 80             	sub    $0xffffff80,%eax
801008cd:	39 05 c8 ff 10 80    	cmp    %eax,0x8010ffc8
801008d3:	0f 85 27 ff ff ff    	jne    80100800 <consoleintr+0x20>
          wakeup(&input.r);
801008d9:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
801008dc:	a3 c4 ff 10 80       	mov    %eax,0x8010ffc4
          wakeup(&input.r);
801008e1:	68 c0 ff 10 80       	push   $0x8010ffc0
801008e6:	e8 55 38 00 00       	call   80104140 <wakeup>
801008eb:	83 c4 10             	add    $0x10,%esp
801008ee:	e9 0d ff ff ff       	jmp    80100800 <consoleintr+0x20>
801008f3:	90                   	nop
801008f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      while(input.e != input.w &&
801008f8:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
801008fd:	39 05 c4 ff 10 80    	cmp    %eax,0x8010ffc4
80100903:	75 2b                	jne    80100930 <consoleintr+0x150>
80100905:	e9 f6 fe ff ff       	jmp    80100800 <consoleintr+0x20>
8010090a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100910:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
80100915:	b8 00 01 00 00       	mov    $0x100,%eax
8010091a:	e8 d1 fa ff ff       	call   801003f0 <consputc>
      while(input.e != input.w &&
8010091f:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100924:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
8010092a:	0f 84 d0 fe ff ff    	je     80100800 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100930:	83 e8 01             	sub    $0x1,%eax
80100933:	89 c2                	mov    %eax,%edx
80100935:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100938:	80 ba 40 ff 10 80 0a 	cmpb   $0xa,-0x7fef00c0(%edx)
8010093f:	75 cf                	jne    80100910 <consoleintr+0x130>
80100941:	e9 ba fe ff ff       	jmp    80100800 <consoleintr+0x20>
80100946:	8d 76 00             	lea    0x0(%esi),%esi
80100949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      doprocdump = 1;
80100950:	be 01 00 00 00       	mov    $0x1,%esi
80100955:	e9 a6 fe ff ff       	jmp    80100800 <consoleintr+0x20>
8010095a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
80100960:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100963:	5b                   	pop    %ebx
80100964:	5e                   	pop    %esi
80100965:	5f                   	pop    %edi
80100966:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100967:	e9 c4 38 00 00       	jmp    80104230 <procdump>
        input.buf[input.e++ % INPUT_BUF] = c;
8010096c:	c6 80 40 ff 10 80 0a 	movb   $0xa,-0x7fef00c0(%eax)
        consputc(c);
80100973:	b8 0a 00 00 00       	mov    $0xa,%eax
80100978:	e8 73 fa ff ff       	call   801003f0 <consputc>
8010097d:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100982:	e9 52 ff ff ff       	jmp    801008d9 <consoleintr+0xf9>
80100987:	89 f6                	mov    %esi,%esi
80100989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100990 <consoleinit>:

void
consoleinit(void)
{
80100990:	55                   	push   %ebp
80100991:	89 e5                	mov    %esp,%ebp
80100993:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100996:	68 70 74 10 80       	push   $0x80107470
8010099b:	68 20 a5 10 80       	push   $0x8010a520
801009a0:	e8 6b 3a 00 00       	call   80104410 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  picenable(IRQ_KBD);
801009a5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  devsw[CONSOLE].write = consolewrite;
801009ac:	c7 05 8c 09 11 80 00 	movl   $0x80100600,0x8011098c
801009b3:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009b6:	c7 05 88 09 11 80 70 	movl   $0x80100270,0x80110988
801009bd:	02 10 80 
  cons.locking = 1;
801009c0:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009c7:	00 00 00 
  picenable(IRQ_KBD);
801009ca:	e8 d1 28 00 00       	call   801032a0 <picenable>
  ioapicenable(IRQ_KBD, 0);
801009cf:	58                   	pop    %eax
801009d0:	5a                   	pop    %edx
801009d1:	6a 00                	push   $0x0
801009d3:	6a 01                	push   $0x1
801009d5:	e8 b6 18 00 00       	call   80102290 <ioapicenable>
}
801009da:	83 c4 10             	add    $0x10,%esp
801009dd:	c9                   	leave  
801009de:	c3                   	ret    
801009df:	90                   	nop

801009e0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009e0:	55                   	push   %ebp
801009e1:	89 e5                	mov    %esp,%ebp
801009e3:	57                   	push   %edi
801009e4:	56                   	push   %esi
801009e5:	53                   	push   %ebx
801009e6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
801009ec:	e8 ef 21 00 00       	call   80102be0 <begin_op>

  if((ip = namei(path)) == 0){
801009f1:	83 ec 0c             	sub    $0xc,%esp
801009f4:	ff 75 08             	pushl  0x8(%ebp)
801009f7:	e8 94 14 00 00       	call   80101e90 <namei>
801009fc:	83 c4 10             	add    $0x10,%esp
801009ff:	85 c0                	test   %eax,%eax
80100a01:	0f 84 a3 01 00 00    	je     80100baa <exec+0x1ca>
    end_op();
    return -1;
  }
  ilock(ip);
80100a07:	83 ec 0c             	sub    $0xc,%esp
80100a0a:	89 c3                	mov    %eax,%ebx
80100a0c:	50                   	push   %eax
80100a0d:	e8 4e 0c 00 00       	call   80101660 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100a12:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a18:	6a 34                	push   $0x34
80100a1a:	6a 00                	push   $0x0
80100a1c:	50                   	push   %eax
80100a1d:	53                   	push   %ebx
80100a1e:	e8 fd 0e 00 00       	call   80101920 <readi>
80100a23:	83 c4 20             	add    $0x20,%esp
80100a26:	83 f8 33             	cmp    $0x33,%eax
80100a29:	77 25                	ja     80100a50 <exec+0x70>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a2b:	83 ec 0c             	sub    $0xc,%esp
80100a2e:	53                   	push   %ebx
80100a2f:	e8 9c 0e 00 00       	call   801018d0 <iunlockput>
    end_op();
80100a34:	e8 17 22 00 00       	call   80102c50 <end_op>
80100a39:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a3c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a41:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a44:	5b                   	pop    %ebx
80100a45:	5e                   	pop    %esi
80100a46:	5f                   	pop    %edi
80100a47:	5d                   	pop    %ebp
80100a48:	c3                   	ret    
80100a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100a50:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a57:	45 4c 46 
80100a5a:	75 cf                	jne    80100a2b <exec+0x4b>
  if((pgdir = setupkvm()) == 0)
80100a5c:	e8 7f 63 00 00       	call   80106de0 <setupkvm>
80100a61:	85 c0                	test   %eax,%eax
80100a63:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100a69:	74 c0                	je     80100a2b <exec+0x4b>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a6b:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a72:	00 
80100a73:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100a79:	0f 84 a1 02 00 00    	je     80100d20 <exec+0x340>
80100a7f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100a86:	00 00 00 
80100a89:	31 ff                	xor    %edi,%edi
80100a8b:	eb 18                	jmp    80100aa5 <exec+0xc5>
80100a8d:	8d 76 00             	lea    0x0(%esi),%esi
80100a90:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100a97:	83 c7 01             	add    $0x1,%edi
80100a9a:	83 c6 20             	add    $0x20,%esi
80100a9d:	39 f8                	cmp    %edi,%eax
80100a9f:	0f 8e ab 00 00 00    	jle    80100b50 <exec+0x170>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100aa5:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100aab:	6a 20                	push   $0x20
80100aad:	56                   	push   %esi
80100aae:	50                   	push   %eax
80100aaf:	53                   	push   %ebx
80100ab0:	e8 6b 0e 00 00       	call   80101920 <readi>
80100ab5:	83 c4 10             	add    $0x10,%esp
80100ab8:	83 f8 20             	cmp    $0x20,%eax
80100abb:	75 7b                	jne    80100b38 <exec+0x158>
    if(ph.type != ELF_PROG_LOAD)
80100abd:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100ac4:	75 ca                	jne    80100a90 <exec+0xb0>
    if(ph.memsz < ph.filesz)
80100ac6:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100acc:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100ad2:	72 64                	jb     80100b38 <exec+0x158>
80100ad4:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ada:	72 5c                	jb     80100b38 <exec+0x158>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100adc:	83 ec 04             	sub    $0x4,%esp
80100adf:	50                   	push   %eax
80100ae0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100ae6:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100aec:	e8 7f 65 00 00       	call   80107070 <allocuvm>
80100af1:	83 c4 10             	add    $0x10,%esp
80100af4:	85 c0                	test   %eax,%eax
80100af6:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100afc:	74 3a                	je     80100b38 <exec+0x158>
    if(ph.vaddr % PGSIZE != 0)
80100afe:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b04:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b09:	75 2d                	jne    80100b38 <exec+0x158>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b0b:	83 ec 0c             	sub    $0xc,%esp
80100b0e:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b14:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b1a:	53                   	push   %ebx
80100b1b:	50                   	push   %eax
80100b1c:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b22:	e8 89 64 00 00       	call   80106fb0 <loaduvm>
80100b27:	83 c4 20             	add    $0x20,%esp
80100b2a:	85 c0                	test   %eax,%eax
80100b2c:	0f 89 5e ff ff ff    	jns    80100a90 <exec+0xb0>
80100b32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    freevm(pgdir);
80100b38:	83 ec 0c             	sub    $0xc,%esp
80100b3b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b41:	e8 4a 66 00 00       	call   80107190 <freevm>
80100b46:	83 c4 10             	add    $0x10,%esp
80100b49:	e9 dd fe ff ff       	jmp    80100a2b <exec+0x4b>
80100b4e:	66 90                	xchg   %ax,%ax
80100b50:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100b56:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100b5c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80100b62:	8d be 00 20 00 00    	lea    0x2000(%esi),%edi
  iunlockput(ip);
80100b68:	83 ec 0c             	sub    $0xc,%esp
80100b6b:	53                   	push   %ebx
80100b6c:	e8 5f 0d 00 00       	call   801018d0 <iunlockput>
  end_op();
80100b71:	e8 da 20 00 00       	call   80102c50 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b76:	83 c4 0c             	add    $0xc,%esp
80100b79:	57                   	push   %edi
80100b7a:	56                   	push   %esi
80100b7b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b81:	e8 ea 64 00 00       	call   80107070 <allocuvm>
80100b86:	83 c4 10             	add    $0x10,%esp
80100b89:	85 c0                	test   %eax,%eax
80100b8b:	89 c6                	mov    %eax,%esi
80100b8d:	75 2a                	jne    80100bb9 <exec+0x1d9>
    freevm(pgdir);
80100b8f:	83 ec 0c             	sub    $0xc,%esp
80100b92:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b98:	e8 f3 65 00 00       	call   80107190 <freevm>
80100b9d:	83 c4 10             	add    $0x10,%esp
  return -1;
80100ba0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ba5:	e9 97 fe ff ff       	jmp    80100a41 <exec+0x61>
    end_op();
80100baa:	e8 a1 20 00 00       	call   80102c50 <end_op>
    return -1;
80100baf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bb4:	e9 88 fe ff ff       	jmp    80100a41 <exec+0x61>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bb9:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100bbf:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100bc2:	31 ff                	xor    %edi,%edi
80100bc4:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bc6:	50                   	push   %eax
80100bc7:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100bcd:	e8 3e 66 00 00       	call   80107210 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100bd2:	8b 45 0c             	mov    0xc(%ebp),%eax
80100bd5:	83 c4 10             	add    $0x10,%esp
80100bd8:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100bde:	8b 00                	mov    (%eax),%eax
80100be0:	85 c0                	test   %eax,%eax
80100be2:	74 71                	je     80100c55 <exec+0x275>
80100be4:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100bea:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100bf0:	eb 0b                	jmp    80100bfd <exec+0x21d>
80100bf2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(argc >= MAXARG)
80100bf8:	83 ff 20             	cmp    $0x20,%edi
80100bfb:	74 92                	je     80100b8f <exec+0x1af>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100bfd:	83 ec 0c             	sub    $0xc,%esp
80100c00:	50                   	push   %eax
80100c01:	e8 7a 3c 00 00       	call   80104880 <strlen>
80100c06:	f7 d0                	not    %eax
80100c08:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c0a:	58                   	pop    %eax
80100c0b:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c0e:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c11:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c14:	e8 67 3c 00 00       	call   80104880 <strlen>
80100c19:	83 c0 01             	add    $0x1,%eax
80100c1c:	50                   	push   %eax
80100c1d:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c20:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c23:	53                   	push   %ebx
80100c24:	56                   	push   %esi
80100c25:	e8 36 67 00 00       	call   80107360 <copyout>
80100c2a:	83 c4 20             	add    $0x20,%esp
80100c2d:	85 c0                	test   %eax,%eax
80100c2f:	0f 88 5a ff ff ff    	js     80100b8f <exec+0x1af>
  for(argc = 0; argv[argc]; argc++) {
80100c35:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c38:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c3f:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c42:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c48:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c4b:	85 c0                	test   %eax,%eax
80100c4d:	75 a9                	jne    80100bf8 <exec+0x218>
80100c4f:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c55:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c5c:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100c5e:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c65:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100c69:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100c70:	ff ff ff 
  ustack[1] = argc;
80100c73:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c79:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100c7b:	83 c0 0c             	add    $0xc,%eax
80100c7e:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c80:	50                   	push   %eax
80100c81:	52                   	push   %edx
80100c82:	53                   	push   %ebx
80100c83:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c89:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c8f:	e8 cc 66 00 00       	call   80107360 <copyout>
80100c94:	83 c4 10             	add    $0x10,%esp
80100c97:	85 c0                	test   %eax,%eax
80100c99:	0f 88 f0 fe ff ff    	js     80100b8f <exec+0x1af>
  for(last=s=path; *s; s++)
80100c9f:	8b 45 08             	mov    0x8(%ebp),%eax
80100ca2:	0f b6 10             	movzbl (%eax),%edx
80100ca5:	84 d2                	test   %dl,%dl
80100ca7:	74 1a                	je     80100cc3 <exec+0x2e3>
80100ca9:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100cac:	83 c0 01             	add    $0x1,%eax
80100caf:	90                   	nop
      last = s+1;
80100cb0:	80 fa 2f             	cmp    $0x2f,%dl
  for(last=s=path; *s; s++)
80100cb3:	0f b6 10             	movzbl (%eax),%edx
      last = s+1;
80100cb6:	0f 44 c8             	cmove  %eax,%ecx
80100cb9:	83 c0 01             	add    $0x1,%eax
  for(last=s=path; *s; s++)
80100cbc:	84 d2                	test   %dl,%dl
80100cbe:	75 f0                	jne    80100cb0 <exec+0x2d0>
80100cc0:	89 4d 08             	mov    %ecx,0x8(%ebp)
  safestrcpy(proc->name, last, sizeof(proc->name));
80100cc3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100cc9:	83 ec 04             	sub    $0x4,%esp
80100ccc:	6a 10                	push   $0x10
80100cce:	ff 75 08             	pushl  0x8(%ebp)
80100cd1:	83 c0 6c             	add    $0x6c,%eax
80100cd4:	50                   	push   %eax
80100cd5:	e8 66 3b 00 00       	call   80104840 <safestrcpy>
  oldpgdir = proc->pgdir;
80100cda:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  proc->pgdir = pgdir;
80100ce0:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = proc->pgdir;
80100ce6:	8b 78 04             	mov    0x4(%eax),%edi
  proc->sz = sz;
80100ce9:	89 30                	mov    %esi,(%eax)
  proc->pgdir = pgdir;
80100ceb:	89 48 04             	mov    %ecx,0x4(%eax)
  proc->tf->eip = elf.entry;  // main
80100cee:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100cf4:	8b 8d 3c ff ff ff    	mov    -0xc4(%ebp),%ecx
80100cfa:	8b 50 18             	mov    0x18(%eax),%edx
80100cfd:	89 4a 38             	mov    %ecx,0x38(%edx)
  proc->tf->esp = sp;
80100d00:	8b 50 18             	mov    0x18(%eax),%edx
80100d03:	89 5a 44             	mov    %ebx,0x44(%edx)
  switchuvm(proc);
80100d06:	89 04 24             	mov    %eax,(%esp)
80100d09:	e8 82 61 00 00       	call   80106e90 <switchuvm>
  freevm(oldpgdir);
80100d0e:	89 3c 24             	mov    %edi,(%esp)
80100d11:	e8 7a 64 00 00       	call   80107190 <freevm>
  return 0;
80100d16:	83 c4 10             	add    $0x10,%esp
80100d19:	31 c0                	xor    %eax,%eax
80100d1b:	e9 21 fd ff ff       	jmp    80100a41 <exec+0x61>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d20:	bf 00 20 00 00       	mov    $0x2000,%edi
80100d25:	31 f6                	xor    %esi,%esi
80100d27:	e9 3c fe ff ff       	jmp    80100b68 <exec+0x188>
80100d2c:	66 90                	xchg   %ax,%ax
80100d2e:	66 90                	xchg   %ax,%ax

80100d30 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d30:	55                   	push   %ebp
80100d31:	89 e5                	mov    %esp,%ebp
80100d33:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d36:	68 89 74 10 80       	push   $0x80107489
80100d3b:	68 e0 ff 10 80       	push   $0x8010ffe0
80100d40:	e8 cb 36 00 00       	call   80104410 <initlock>
}
80100d45:	83 c4 10             	add    $0x10,%esp
80100d48:	c9                   	leave  
80100d49:	c3                   	ret    
80100d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d50 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d50:	55                   	push   %ebp
80100d51:	89 e5                	mov    %esp,%ebp
80100d53:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d54:	bb 14 00 11 80       	mov    $0x80110014,%ebx
{
80100d59:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100d5c:	68 e0 ff 10 80       	push   $0x8010ffe0
80100d61:	e8 ca 36 00 00       	call   80104430 <acquire>
80100d66:	83 c4 10             	add    $0x10,%esp
80100d69:	eb 10                	jmp    80100d7b <filealloc+0x2b>
80100d6b:	90                   	nop
80100d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d70:	83 c3 18             	add    $0x18,%ebx
80100d73:	81 fb 74 09 11 80    	cmp    $0x80110974,%ebx
80100d79:	73 25                	jae    80100da0 <filealloc+0x50>
    if(f->ref == 0){
80100d7b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d7e:	85 c0                	test   %eax,%eax
80100d80:	75 ee                	jne    80100d70 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100d82:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100d85:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100d8c:	68 e0 ff 10 80       	push   $0x8010ffe0
80100d91:	e8 7a 38 00 00       	call   80104610 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100d96:	89 d8                	mov    %ebx,%eax
      return f;
80100d98:	83 c4 10             	add    $0x10,%esp
}
80100d9b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100d9e:	c9                   	leave  
80100d9f:	c3                   	ret    
  release(&ftable.lock);
80100da0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100da3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100da5:	68 e0 ff 10 80       	push   $0x8010ffe0
80100daa:	e8 61 38 00 00       	call   80104610 <release>
}
80100daf:	89 d8                	mov    %ebx,%eax
  return 0;
80100db1:	83 c4 10             	add    $0x10,%esp
}
80100db4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100db7:	c9                   	leave  
80100db8:	c3                   	ret    
80100db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100dc0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100dc0:	55                   	push   %ebp
80100dc1:	89 e5                	mov    %esp,%ebp
80100dc3:	53                   	push   %ebx
80100dc4:	83 ec 10             	sub    $0x10,%esp
80100dc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dca:	68 e0 ff 10 80       	push   $0x8010ffe0
80100dcf:	e8 5c 36 00 00       	call   80104430 <acquire>
  if(f->ref < 1)
80100dd4:	8b 43 04             	mov    0x4(%ebx),%eax
80100dd7:	83 c4 10             	add    $0x10,%esp
80100dda:	85 c0                	test   %eax,%eax
80100ddc:	7e 1a                	jle    80100df8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100dde:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100de1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100de4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100de7:	68 e0 ff 10 80       	push   $0x8010ffe0
80100dec:	e8 1f 38 00 00       	call   80104610 <release>
  return f;
}
80100df1:	89 d8                	mov    %ebx,%eax
80100df3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100df6:	c9                   	leave  
80100df7:	c3                   	ret    
    panic("filedup");
80100df8:	83 ec 0c             	sub    $0xc,%esp
80100dfb:	68 90 74 10 80       	push   $0x80107490
80100e00:	e8 6b f5 ff ff       	call   80100370 <panic>
80100e05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e10 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e10:	55                   	push   %ebp
80100e11:	89 e5                	mov    %esp,%ebp
80100e13:	57                   	push   %edi
80100e14:	56                   	push   %esi
80100e15:	53                   	push   %ebx
80100e16:	83 ec 28             	sub    $0x28,%esp
80100e19:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100e1c:	68 e0 ff 10 80       	push   $0x8010ffe0
80100e21:	e8 0a 36 00 00       	call   80104430 <acquire>
  if(f->ref < 1)
80100e26:	8b 47 04             	mov    0x4(%edi),%eax
80100e29:	83 c4 10             	add    $0x10,%esp
80100e2c:	85 c0                	test   %eax,%eax
80100e2e:	0f 8e 9b 00 00 00    	jle    80100ecf <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e34:	83 e8 01             	sub    $0x1,%eax
80100e37:	85 c0                	test   %eax,%eax
80100e39:	89 47 04             	mov    %eax,0x4(%edi)
80100e3c:	74 1a                	je     80100e58 <fileclose+0x48>
    release(&ftable.lock);
80100e3e:	c7 45 08 e0 ff 10 80 	movl   $0x8010ffe0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e45:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e48:	5b                   	pop    %ebx
80100e49:	5e                   	pop    %esi
80100e4a:	5f                   	pop    %edi
80100e4b:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e4c:	e9 bf 37 00 00       	jmp    80104610 <release>
80100e51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100e58:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100e5c:	8b 1f                	mov    (%edi),%ebx
  release(&ftable.lock);
80100e5e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100e61:	8b 77 0c             	mov    0xc(%edi),%esi
  f->type = FD_NONE;
80100e64:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
  ff = *f;
80100e6a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e6d:	8b 47 10             	mov    0x10(%edi),%eax
  release(&ftable.lock);
80100e70:	68 e0 ff 10 80       	push   $0x8010ffe0
  ff = *f;
80100e75:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100e78:	e8 93 37 00 00       	call   80104610 <release>
  if(ff.type == FD_PIPE)
80100e7d:	83 c4 10             	add    $0x10,%esp
80100e80:	83 fb 01             	cmp    $0x1,%ebx
80100e83:	74 13                	je     80100e98 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100e85:	83 fb 02             	cmp    $0x2,%ebx
80100e88:	74 26                	je     80100eb0 <fileclose+0xa0>
}
80100e8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e8d:	5b                   	pop    %ebx
80100e8e:	5e                   	pop    %esi
80100e8f:	5f                   	pop    %edi
80100e90:	5d                   	pop    %ebp
80100e91:	c3                   	ret    
80100e92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100e98:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100e9c:	83 ec 08             	sub    $0x8,%esp
80100e9f:	53                   	push   %ebx
80100ea0:	56                   	push   %esi
80100ea1:	e8 ca 25 00 00       	call   80103470 <pipeclose>
80100ea6:	83 c4 10             	add    $0x10,%esp
80100ea9:	eb df                	jmp    80100e8a <fileclose+0x7a>
80100eab:	90                   	nop
80100eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100eb0:	e8 2b 1d 00 00       	call   80102be0 <begin_op>
    iput(ff.ip);
80100eb5:	83 ec 0c             	sub    $0xc,%esp
80100eb8:	ff 75 e0             	pushl  -0x20(%ebp)
80100ebb:	e8 d0 08 00 00       	call   80101790 <iput>
    end_op();
80100ec0:	83 c4 10             	add    $0x10,%esp
}
80100ec3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ec6:	5b                   	pop    %ebx
80100ec7:	5e                   	pop    %esi
80100ec8:	5f                   	pop    %edi
80100ec9:	5d                   	pop    %ebp
    end_op();
80100eca:	e9 81 1d 00 00       	jmp    80102c50 <end_op>
    panic("fileclose");
80100ecf:	83 ec 0c             	sub    $0xc,%esp
80100ed2:	68 98 74 10 80       	push   $0x80107498
80100ed7:	e8 94 f4 ff ff       	call   80100370 <panic>
80100edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ee0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100ee0:	55                   	push   %ebp
80100ee1:	89 e5                	mov    %esp,%ebp
80100ee3:	53                   	push   %ebx
80100ee4:	83 ec 04             	sub    $0x4,%esp
80100ee7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100eea:	83 3b 02             	cmpl   $0x2,(%ebx)
80100eed:	75 31                	jne    80100f20 <filestat+0x40>
    ilock(f->ip);
80100eef:	83 ec 0c             	sub    $0xc,%esp
80100ef2:	ff 73 10             	pushl  0x10(%ebx)
80100ef5:	e8 66 07 00 00       	call   80101660 <ilock>
    stati(f->ip, st);
80100efa:	58                   	pop    %eax
80100efb:	5a                   	pop    %edx
80100efc:	ff 75 0c             	pushl  0xc(%ebp)
80100eff:	ff 73 10             	pushl  0x10(%ebx)
80100f02:	e8 e9 09 00 00       	call   801018f0 <stati>
    iunlock(f->ip);
80100f07:	59                   	pop    %ecx
80100f08:	ff 73 10             	pushl  0x10(%ebx)
80100f0b:	e8 30 08 00 00       	call   80101740 <iunlock>
    return 0;
80100f10:	83 c4 10             	add    $0x10,%esp
80100f13:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f15:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f18:	c9                   	leave  
80100f19:	c3                   	ret    
80100f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100f20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f25:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f28:	c9                   	leave  
80100f29:	c3                   	ret    
80100f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f30 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f30:	55                   	push   %ebp
80100f31:	89 e5                	mov    %esp,%ebp
80100f33:	57                   	push   %edi
80100f34:	56                   	push   %esi
80100f35:	53                   	push   %ebx
80100f36:	83 ec 0c             	sub    $0xc,%esp
80100f39:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f3c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f3f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f42:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f46:	74 60                	je     80100fa8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f48:	8b 03                	mov    (%ebx),%eax
80100f4a:	83 f8 01             	cmp    $0x1,%eax
80100f4d:	74 41                	je     80100f90 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f4f:	83 f8 02             	cmp    $0x2,%eax
80100f52:	75 5b                	jne    80100faf <fileread+0x7f>
    ilock(f->ip);
80100f54:	83 ec 0c             	sub    $0xc,%esp
80100f57:	ff 73 10             	pushl  0x10(%ebx)
80100f5a:	e8 01 07 00 00       	call   80101660 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f5f:	57                   	push   %edi
80100f60:	ff 73 14             	pushl  0x14(%ebx)
80100f63:	56                   	push   %esi
80100f64:	ff 73 10             	pushl  0x10(%ebx)
80100f67:	e8 b4 09 00 00       	call   80101920 <readi>
80100f6c:	83 c4 20             	add    $0x20,%esp
80100f6f:	85 c0                	test   %eax,%eax
80100f71:	89 c6                	mov    %eax,%esi
80100f73:	7e 03                	jle    80100f78 <fileread+0x48>
      f->off += r;
80100f75:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100f78:	83 ec 0c             	sub    $0xc,%esp
80100f7b:	ff 73 10             	pushl  0x10(%ebx)
80100f7e:	e8 bd 07 00 00       	call   80101740 <iunlock>
    return r;
80100f83:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80100f86:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f89:	89 f0                	mov    %esi,%eax
80100f8b:	5b                   	pop    %ebx
80100f8c:	5e                   	pop    %esi
80100f8d:	5f                   	pop    %edi
80100f8e:	5d                   	pop    %ebp
80100f8f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80100f90:	8b 43 0c             	mov    0xc(%ebx),%eax
80100f93:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100f96:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f99:	5b                   	pop    %ebx
80100f9a:	5e                   	pop    %esi
80100f9b:	5f                   	pop    %edi
80100f9c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100f9d:	e9 9e 26 00 00       	jmp    80103640 <piperead>
80100fa2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80100fa8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80100fad:	eb d7                	jmp    80100f86 <fileread+0x56>
  panic("fileread");
80100faf:	83 ec 0c             	sub    $0xc,%esp
80100fb2:	68 a2 74 10 80       	push   $0x801074a2
80100fb7:	e8 b4 f3 ff ff       	call   80100370 <panic>
80100fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100fc0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100fc0:	55                   	push   %ebp
80100fc1:	89 e5                	mov    %esp,%ebp
80100fc3:	57                   	push   %edi
80100fc4:	56                   	push   %esi
80100fc5:	53                   	push   %ebx
80100fc6:	83 ec 1c             	sub    $0x1c,%esp
80100fc9:	8b 75 08             	mov    0x8(%ebp),%esi
80100fcc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fcf:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80100fd3:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100fd6:	8b 45 10             	mov    0x10(%ebp),%eax
80100fd9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
80100fdc:	0f 84 aa 00 00 00    	je     8010108c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80100fe2:	8b 06                	mov    (%esi),%eax
80100fe4:	83 f8 01             	cmp    $0x1,%eax
80100fe7:	0f 84 c2 00 00 00    	je     801010af <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100fed:	83 f8 02             	cmp    $0x2,%eax
80100ff0:	0f 85 e4 00 00 00    	jne    801010da <filewrite+0x11a>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80100ff6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100ff9:	31 ff                	xor    %edi,%edi
80100ffb:	85 c0                	test   %eax,%eax
80100ffd:	7f 34                	jg     80101033 <filewrite+0x73>
80100fff:	e9 9c 00 00 00       	jmp    801010a0 <filewrite+0xe0>
80101004:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101008:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010100b:	83 ec 0c             	sub    $0xc,%esp
8010100e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101011:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101014:	e8 27 07 00 00       	call   80101740 <iunlock>
      end_op();
80101019:	e8 32 1c 00 00       	call   80102c50 <end_op>
8010101e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101021:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101024:	39 d8                	cmp    %ebx,%eax
80101026:	0f 85 a1 00 00 00    	jne    801010cd <filewrite+0x10d>
        panic("short filewrite");
      i += r;
8010102c:	01 c7                	add    %eax,%edi
    while(i < n){
8010102e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101031:	7e 6d                	jle    801010a0 <filewrite+0xe0>
      int n1 = n - i;
80101033:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101036:	b8 00 1a 00 00       	mov    $0x1a00,%eax
8010103b:	29 fb                	sub    %edi,%ebx
8010103d:	81 fb 00 1a 00 00    	cmp    $0x1a00,%ebx
80101043:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101046:	e8 95 1b 00 00       	call   80102be0 <begin_op>
      ilock(f->ip);
8010104b:	83 ec 0c             	sub    $0xc,%esp
8010104e:	ff 76 10             	pushl  0x10(%esi)
80101051:	e8 0a 06 00 00       	call   80101660 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101056:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101059:	53                   	push   %ebx
8010105a:	ff 76 14             	pushl  0x14(%esi)
8010105d:	01 f8                	add    %edi,%eax
8010105f:	50                   	push   %eax
80101060:	ff 76 10             	pushl  0x10(%esi)
80101063:	e8 b8 09 00 00       	call   80101a20 <writei>
80101068:	83 c4 20             	add    $0x20,%esp
8010106b:	85 c0                	test   %eax,%eax
8010106d:	7f 99                	jg     80101008 <filewrite+0x48>
      iunlock(f->ip);
8010106f:	83 ec 0c             	sub    $0xc,%esp
80101072:	ff 76 10             	pushl  0x10(%esi)
80101075:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101078:	e8 c3 06 00 00       	call   80101740 <iunlock>
      end_op();
8010107d:	e8 ce 1b 00 00       	call   80102c50 <end_op>
      if(r < 0)
80101082:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101085:	83 c4 10             	add    $0x10,%esp
80101088:	85 c0                	test   %eax,%eax
8010108a:	74 98                	je     80101024 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
8010108c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010108f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101094:	5b                   	pop    %ebx
80101095:	5e                   	pop    %esi
80101096:	5f                   	pop    %edi
80101097:	5d                   	pop    %ebp
80101098:	c3                   	ret    
80101099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
801010a0:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
801010a3:	75 e7                	jne    8010108c <filewrite+0xcc>
}
801010a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010a8:	89 f8                	mov    %edi,%eax
801010aa:	5b                   	pop    %ebx
801010ab:	5e                   	pop    %esi
801010ac:	5f                   	pop    %edi
801010ad:	5d                   	pop    %ebp
801010ae:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
801010af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801010b2:	89 45 10             	mov    %eax,0x10(%ebp)
801010b5:	8b 45 dc             	mov    -0x24(%ebp),%eax
801010b8:	89 45 0c             	mov    %eax,0xc(%ebp)
801010bb:	8b 46 0c             	mov    0xc(%esi),%eax
801010be:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010c4:	5b                   	pop    %ebx
801010c5:	5e                   	pop    %esi
801010c6:	5f                   	pop    %edi
801010c7:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801010c8:	e9 43 24 00 00       	jmp    80103510 <pipewrite>
        panic("short filewrite");
801010cd:	83 ec 0c             	sub    $0xc,%esp
801010d0:	68 ab 74 10 80       	push   $0x801074ab
801010d5:	e8 96 f2 ff ff       	call   80100370 <panic>
  panic("filewrite");
801010da:	83 ec 0c             	sub    $0xc,%esp
801010dd:	68 b1 74 10 80       	push   $0x801074b1
801010e2:	e8 89 f2 ff ff       	call   80100370 <panic>
801010e7:	66 90                	xchg   %ax,%ax
801010e9:	66 90                	xchg   %ax,%ax
801010eb:	66 90                	xchg   %ax,%ax
801010ed:	66 90                	xchg   %ax,%ax
801010ef:	90                   	nop

801010f0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801010f0:	55                   	push   %ebp
801010f1:	89 e5                	mov    %esp,%ebp
801010f3:	57                   	push   %edi
801010f4:	56                   	push   %esi
801010f5:	53                   	push   %ebx
801010f6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801010f9:	8b 0d e0 09 11 80    	mov    0x801109e0,%ecx
{
801010ff:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101102:	85 c9                	test   %ecx,%ecx
80101104:	0f 84 87 00 00 00    	je     80101191 <balloc+0xa1>
8010110a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101111:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101114:	83 ec 08             	sub    $0x8,%esp
80101117:	89 f0                	mov    %esi,%eax
80101119:	c1 f8 0c             	sar    $0xc,%eax
8010111c:	03 05 f8 09 11 80    	add    0x801109f8,%eax
80101122:	50                   	push   %eax
80101123:	ff 75 d8             	pushl  -0x28(%ebp)
80101126:	e8 a5 ef ff ff       	call   801000d0 <bread>
8010112b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010112e:	a1 e0 09 11 80       	mov    0x801109e0,%eax
80101133:	83 c4 10             	add    $0x10,%esp
80101136:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101139:	31 c0                	xor    %eax,%eax
8010113b:	eb 2f                	jmp    8010116c <balloc+0x7c>
8010113d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101140:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101142:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101145:	bb 01 00 00 00       	mov    $0x1,%ebx
8010114a:	83 e1 07             	and    $0x7,%ecx
8010114d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010114f:	89 c1                	mov    %eax,%ecx
80101151:	c1 f9 03             	sar    $0x3,%ecx
80101154:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101159:	85 df                	test   %ebx,%edi
8010115b:	89 fa                	mov    %edi,%edx
8010115d:	74 41                	je     801011a0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010115f:	83 c0 01             	add    $0x1,%eax
80101162:	83 c6 01             	add    $0x1,%esi
80101165:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010116a:	74 05                	je     80101171 <balloc+0x81>
8010116c:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010116f:	72 cf                	jb     80101140 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101171:	83 ec 0c             	sub    $0xc,%esp
80101174:	ff 75 e4             	pushl  -0x1c(%ebp)
80101177:	e8 64 f0 ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010117c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101183:	83 c4 10             	add    $0x10,%esp
80101186:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101189:	39 05 e0 09 11 80    	cmp    %eax,0x801109e0
8010118f:	77 80                	ja     80101111 <balloc+0x21>
  }
  panic("balloc: out of blocks");
80101191:	83 ec 0c             	sub    $0xc,%esp
80101194:	68 bb 74 10 80       	push   $0x801074bb
80101199:	e8 d2 f1 ff ff       	call   80100370 <panic>
8010119e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801011a0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801011a3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801011a6:	09 da                	or     %ebx,%edx
801011a8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801011ac:	57                   	push   %edi
801011ad:	e8 0e 1c 00 00       	call   80102dc0 <log_write>
        brelse(bp);
801011b2:	89 3c 24             	mov    %edi,(%esp)
801011b5:	e8 26 f0 ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
801011ba:	58                   	pop    %eax
801011bb:	5a                   	pop    %edx
801011bc:	56                   	push   %esi
801011bd:	ff 75 d8             	pushl  -0x28(%ebp)
801011c0:	e8 0b ef ff ff       	call   801000d0 <bread>
801011c5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801011c7:	8d 40 5c             	lea    0x5c(%eax),%eax
801011ca:	83 c4 0c             	add    $0xc,%esp
801011cd:	68 00 02 00 00       	push   $0x200
801011d2:	6a 00                	push   $0x0
801011d4:	50                   	push   %eax
801011d5:	e8 86 34 00 00       	call   80104660 <memset>
  log_write(bp);
801011da:	89 1c 24             	mov    %ebx,(%esp)
801011dd:	e8 de 1b 00 00       	call   80102dc0 <log_write>
  brelse(bp);
801011e2:	89 1c 24             	mov    %ebx,(%esp)
801011e5:	e8 f6 ef ff ff       	call   801001e0 <brelse>
}
801011ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011ed:	89 f0                	mov    %esi,%eax
801011ef:	5b                   	pop    %ebx
801011f0:	5e                   	pop    %esi
801011f1:	5f                   	pop    %edi
801011f2:	5d                   	pop    %ebp
801011f3:	c3                   	ret    
801011f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801011fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101200 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101200:	55                   	push   %ebp
80101201:	89 e5                	mov    %esp,%ebp
80101203:	57                   	push   %edi
80101204:	56                   	push   %esi
80101205:	53                   	push   %ebx
80101206:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101208:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010120a:	bb 34 0a 11 80       	mov    $0x80110a34,%ebx
{
8010120f:	83 ec 28             	sub    $0x28,%esp
80101212:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101215:	68 00 0a 11 80       	push   $0x80110a00
8010121a:	e8 11 32 00 00       	call   80104430 <acquire>
8010121f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101222:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101225:	eb 1b                	jmp    80101242 <iget+0x42>
80101227:	89 f6                	mov    %esi,%esi
80101229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101230:	85 f6                	test   %esi,%esi
80101232:	74 44                	je     80101278 <iget+0x78>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101234:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010123a:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
80101240:	73 4e                	jae    80101290 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101242:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101245:	85 c9                	test   %ecx,%ecx
80101247:	7e e7                	jle    80101230 <iget+0x30>
80101249:	39 3b                	cmp    %edi,(%ebx)
8010124b:	75 e3                	jne    80101230 <iget+0x30>
8010124d:	39 53 04             	cmp    %edx,0x4(%ebx)
80101250:	75 de                	jne    80101230 <iget+0x30>
      release(&icache.lock);
80101252:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101255:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101258:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
8010125a:	68 00 0a 11 80       	push   $0x80110a00
      ip->ref++;
8010125f:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101262:	e8 a9 33 00 00       	call   80104610 <release>
      return ip;
80101267:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);

  return ip;
}
8010126a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010126d:	89 f0                	mov    %esi,%eax
8010126f:	5b                   	pop    %ebx
80101270:	5e                   	pop    %esi
80101271:	5f                   	pop    %edi
80101272:	5d                   	pop    %ebp
80101273:	c3                   	ret    
80101274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101278:	85 c9                	test   %ecx,%ecx
8010127a:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010127d:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101283:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
80101289:	72 b7                	jb     80101242 <iget+0x42>
8010128b:	90                   	nop
8010128c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(empty == 0)
80101290:	85 f6                	test   %esi,%esi
80101292:	74 2d                	je     801012c1 <iget+0xc1>
  release(&icache.lock);
80101294:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101297:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101299:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010129c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
801012a3:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801012aa:	68 00 0a 11 80       	push   $0x80110a00
801012af:	e8 5c 33 00 00       	call   80104610 <release>
  return ip;
801012b4:	83 c4 10             	add    $0x10,%esp
}
801012b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012ba:	89 f0                	mov    %esi,%eax
801012bc:	5b                   	pop    %ebx
801012bd:	5e                   	pop    %esi
801012be:	5f                   	pop    %edi
801012bf:	5d                   	pop    %ebp
801012c0:	c3                   	ret    
    panic("iget: no inodes");
801012c1:	83 ec 0c             	sub    $0xc,%esp
801012c4:	68 d1 74 10 80       	push   $0x801074d1
801012c9:	e8 a2 f0 ff ff       	call   80100370 <panic>
801012ce:	66 90                	xchg   %ax,%ax

801012d0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801012d0:	55                   	push   %ebp
801012d1:	89 e5                	mov    %esp,%ebp
801012d3:	57                   	push   %edi
801012d4:	56                   	push   %esi
801012d5:	53                   	push   %ebx
801012d6:	89 c6                	mov    %eax,%esi
801012d8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801012db:	83 fa 0b             	cmp    $0xb,%edx
801012de:	77 18                	ja     801012f8 <bmap+0x28>
801012e0:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
801012e3:	8b 5f 5c             	mov    0x5c(%edi),%ebx
801012e6:	85 db                	test   %ebx,%ebx
801012e8:	74 76                	je     80101360 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801012ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012ed:	89 d8                	mov    %ebx,%eax
801012ef:	5b                   	pop    %ebx
801012f0:	5e                   	pop    %esi
801012f1:	5f                   	pop    %edi
801012f2:	5d                   	pop    %ebp
801012f3:	c3                   	ret    
801012f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
801012f8:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
801012fb:	83 fb 7f             	cmp    $0x7f,%ebx
801012fe:	0f 87 8e 00 00 00    	ja     80101392 <bmap+0xc2>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101304:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
8010130a:	85 c0                	test   %eax,%eax
8010130c:	74 72                	je     80101380 <bmap+0xb0>
    bp = bread(ip->dev, addr);
8010130e:	83 ec 08             	sub    $0x8,%esp
80101311:	50                   	push   %eax
80101312:	ff 36                	pushl  (%esi)
80101314:	e8 b7 ed ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
80101319:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010131d:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
80101320:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
80101322:	8b 1a                	mov    (%edx),%ebx
80101324:	85 db                	test   %ebx,%ebx
80101326:	75 1d                	jne    80101345 <bmap+0x75>
      a[bn] = addr = balloc(ip->dev);
80101328:	8b 06                	mov    (%esi),%eax
8010132a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010132d:	e8 be fd ff ff       	call   801010f0 <balloc>
80101332:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101335:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101338:	89 c3                	mov    %eax,%ebx
8010133a:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010133c:	57                   	push   %edi
8010133d:	e8 7e 1a 00 00       	call   80102dc0 <log_write>
80101342:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101345:	83 ec 0c             	sub    $0xc,%esp
80101348:	57                   	push   %edi
80101349:	e8 92 ee ff ff       	call   801001e0 <brelse>
8010134e:	83 c4 10             	add    $0x10,%esp
}
80101351:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101354:	89 d8                	mov    %ebx,%eax
80101356:	5b                   	pop    %ebx
80101357:	5e                   	pop    %esi
80101358:	5f                   	pop    %edi
80101359:	5d                   	pop    %ebp
8010135a:	c3                   	ret    
8010135b:	90                   	nop
8010135c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101360:	8b 00                	mov    (%eax),%eax
80101362:	e8 89 fd ff ff       	call   801010f0 <balloc>
80101367:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010136a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010136d:	89 c3                	mov    %eax,%ebx
}
8010136f:	89 d8                	mov    %ebx,%eax
80101371:	5b                   	pop    %ebx
80101372:	5e                   	pop    %esi
80101373:	5f                   	pop    %edi
80101374:	5d                   	pop    %ebp
80101375:	c3                   	ret    
80101376:	8d 76 00             	lea    0x0(%esi),%esi
80101379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101380:	8b 06                	mov    (%esi),%eax
80101382:	e8 69 fd ff ff       	call   801010f0 <balloc>
80101387:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010138d:	e9 7c ff ff ff       	jmp    8010130e <bmap+0x3e>
  panic("bmap: out of range");
80101392:	83 ec 0c             	sub    $0xc,%esp
80101395:	68 e1 74 10 80       	push   $0x801074e1
8010139a:	e8 d1 ef ff ff       	call   80100370 <panic>
8010139f:	90                   	nop

801013a0 <readsb>:
{
801013a0:	55                   	push   %ebp
801013a1:	89 e5                	mov    %esp,%ebp
801013a3:	56                   	push   %esi
801013a4:	53                   	push   %ebx
801013a5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801013a8:	83 ec 08             	sub    $0x8,%esp
801013ab:	6a 01                	push   $0x1
801013ad:	ff 75 08             	pushl  0x8(%ebp)
801013b0:	e8 1b ed ff ff       	call   801000d0 <bread>
801013b5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801013b7:	8d 40 5c             	lea    0x5c(%eax),%eax
801013ba:	83 c4 0c             	add    $0xc,%esp
801013bd:	6a 1c                	push   $0x1c
801013bf:	50                   	push   %eax
801013c0:	56                   	push   %esi
801013c1:	e8 4a 33 00 00       	call   80104710 <memmove>
  brelse(bp);
801013c6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801013c9:	83 c4 10             	add    $0x10,%esp
}
801013cc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801013cf:	5b                   	pop    %ebx
801013d0:	5e                   	pop    %esi
801013d1:	5d                   	pop    %ebp
  brelse(bp);
801013d2:	e9 09 ee ff ff       	jmp    801001e0 <brelse>
801013d7:	89 f6                	mov    %esi,%esi
801013d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801013e0 <bfree>:
{
801013e0:	55                   	push   %ebp
801013e1:	89 e5                	mov    %esp,%ebp
801013e3:	56                   	push   %esi
801013e4:	53                   	push   %ebx
801013e5:	89 d3                	mov    %edx,%ebx
801013e7:	89 c6                	mov    %eax,%esi
  readsb(dev, &sb);
801013e9:	83 ec 08             	sub    $0x8,%esp
801013ec:	68 e0 09 11 80       	push   $0x801109e0
801013f1:	50                   	push   %eax
801013f2:	e8 a9 ff ff ff       	call   801013a0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801013f7:	58                   	pop    %eax
801013f8:	5a                   	pop    %edx
801013f9:	89 da                	mov    %ebx,%edx
801013fb:	c1 ea 0c             	shr    $0xc,%edx
801013fe:	03 15 f8 09 11 80    	add    0x801109f8,%edx
80101404:	52                   	push   %edx
80101405:	56                   	push   %esi
80101406:	e8 c5 ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010140b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010140d:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
80101410:	ba 01 00 00 00       	mov    $0x1,%edx
80101415:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101418:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010141e:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101421:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101423:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101428:	85 d1                	test   %edx,%ecx
8010142a:	74 25                	je     80101451 <bfree+0x71>
  bp->data[bi/8] &= ~m;
8010142c:	f7 d2                	not    %edx
8010142e:	89 c6                	mov    %eax,%esi
  log_write(bp);
80101430:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101433:	21 ca                	and    %ecx,%edx
80101435:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101439:	56                   	push   %esi
8010143a:	e8 81 19 00 00       	call   80102dc0 <log_write>
  brelse(bp);
8010143f:	89 34 24             	mov    %esi,(%esp)
80101442:	e8 99 ed ff ff       	call   801001e0 <brelse>
}
80101447:	83 c4 10             	add    $0x10,%esp
8010144a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010144d:	5b                   	pop    %ebx
8010144e:	5e                   	pop    %esi
8010144f:	5d                   	pop    %ebp
80101450:	c3                   	ret    
    panic("freeing free block");
80101451:	83 ec 0c             	sub    $0xc,%esp
80101454:	68 f4 74 10 80       	push   $0x801074f4
80101459:	e8 12 ef ff ff       	call   80100370 <panic>
8010145e:	66 90                	xchg   %ax,%ax

80101460 <iinit>:
{
80101460:	55                   	push   %ebp
80101461:	89 e5                	mov    %esp,%ebp
80101463:	53                   	push   %ebx
80101464:	bb 40 0a 11 80       	mov    $0x80110a40,%ebx
80101469:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010146c:	68 07 75 10 80       	push   $0x80107507
80101471:	68 00 0a 11 80       	push   $0x80110a00
80101476:	e8 95 2f 00 00       	call   80104410 <initlock>
8010147b:	83 c4 10             	add    $0x10,%esp
8010147e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101480:	83 ec 08             	sub    $0x8,%esp
80101483:	68 0e 75 10 80       	push   $0x8010750e
80101488:	53                   	push   %ebx
80101489:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010148f:	e8 6c 2e 00 00       	call   80104300 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101494:	83 c4 10             	add    $0x10,%esp
80101497:	81 fb 60 26 11 80    	cmp    $0x80112660,%ebx
8010149d:	75 e1                	jne    80101480 <iinit+0x20>
  readsb(dev, &sb);
8010149f:	83 ec 08             	sub    $0x8,%esp
801014a2:	68 e0 09 11 80       	push   $0x801109e0
801014a7:	ff 75 08             	pushl  0x8(%ebp)
801014aa:	e8 f1 fe ff ff       	call   801013a0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014af:	ff 35 f8 09 11 80    	pushl  0x801109f8
801014b5:	ff 35 f4 09 11 80    	pushl  0x801109f4
801014bb:	ff 35 f0 09 11 80    	pushl  0x801109f0
801014c1:	ff 35 ec 09 11 80    	pushl  0x801109ec
801014c7:	ff 35 e8 09 11 80    	pushl  0x801109e8
801014cd:	ff 35 e4 09 11 80    	pushl  0x801109e4
801014d3:	ff 35 e0 09 11 80    	pushl  0x801109e0
801014d9:	68 64 75 10 80       	push   $0x80107564
801014de:	e8 7d f1 ff ff       	call   80100660 <cprintf>
}
801014e3:	83 c4 30             	add    $0x30,%esp
801014e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801014e9:	c9                   	leave  
801014ea:	c3                   	ret    
801014eb:	90                   	nop
801014ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801014f0 <ialloc>:
{
801014f0:	55                   	push   %ebp
801014f1:	89 e5                	mov    %esp,%ebp
801014f3:	57                   	push   %edi
801014f4:	56                   	push   %esi
801014f5:	53                   	push   %ebx
801014f6:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801014f9:	83 3d e8 09 11 80 01 	cmpl   $0x1,0x801109e8
{
80101500:	8b 45 0c             	mov    0xc(%ebp),%eax
80101503:	8b 75 08             	mov    0x8(%ebp),%esi
80101506:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101509:	0f 86 91 00 00 00    	jbe    801015a0 <ialloc+0xb0>
8010150f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101514:	eb 21                	jmp    80101537 <ialloc+0x47>
80101516:	8d 76 00             	lea    0x0(%esi),%esi
80101519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101520:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101523:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101526:	57                   	push   %edi
80101527:	e8 b4 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010152c:	83 c4 10             	add    $0x10,%esp
8010152f:	39 1d e8 09 11 80    	cmp    %ebx,0x801109e8
80101535:	76 69                	jbe    801015a0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101537:	89 d8                	mov    %ebx,%eax
80101539:	83 ec 08             	sub    $0x8,%esp
8010153c:	c1 e8 03             	shr    $0x3,%eax
8010153f:	03 05 f4 09 11 80    	add    0x801109f4,%eax
80101545:	50                   	push   %eax
80101546:	56                   	push   %esi
80101547:	e8 84 eb ff ff       	call   801000d0 <bread>
8010154c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010154e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101550:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
80101553:	83 e0 07             	and    $0x7,%eax
80101556:	c1 e0 06             	shl    $0x6,%eax
80101559:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010155d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101561:	75 bd                	jne    80101520 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101563:	83 ec 04             	sub    $0x4,%esp
80101566:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101569:	6a 40                	push   $0x40
8010156b:	6a 00                	push   $0x0
8010156d:	51                   	push   %ecx
8010156e:	e8 ed 30 00 00       	call   80104660 <memset>
      dip->type = type;
80101573:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101577:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010157a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010157d:	89 3c 24             	mov    %edi,(%esp)
80101580:	e8 3b 18 00 00       	call   80102dc0 <log_write>
      brelse(bp);
80101585:	89 3c 24             	mov    %edi,(%esp)
80101588:	e8 53 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010158d:	83 c4 10             	add    $0x10,%esp
}
80101590:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101593:	89 da                	mov    %ebx,%edx
80101595:	89 f0                	mov    %esi,%eax
}
80101597:	5b                   	pop    %ebx
80101598:	5e                   	pop    %esi
80101599:	5f                   	pop    %edi
8010159a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010159b:	e9 60 fc ff ff       	jmp    80101200 <iget>
  panic("ialloc: no inodes");
801015a0:	83 ec 0c             	sub    $0xc,%esp
801015a3:	68 14 75 10 80       	push   $0x80107514
801015a8:	e8 c3 ed ff ff       	call   80100370 <panic>
801015ad:	8d 76 00             	lea    0x0(%esi),%esi

801015b0 <iupdate>:
{
801015b0:	55                   	push   %ebp
801015b1:	89 e5                	mov    %esp,%ebp
801015b3:	56                   	push   %esi
801015b4:	53                   	push   %ebx
801015b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015b8:	83 ec 08             	sub    $0x8,%esp
801015bb:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015be:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015c1:	c1 e8 03             	shr    $0x3,%eax
801015c4:	03 05 f4 09 11 80    	add    0x801109f4,%eax
801015ca:	50                   	push   %eax
801015cb:	ff 73 a4             	pushl  -0x5c(%ebx)
801015ce:	e8 fd ea ff ff       	call   801000d0 <bread>
801015d3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015d5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801015d8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015dc:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015df:	83 e0 07             	and    $0x7,%eax
801015e2:	c1 e0 06             	shl    $0x6,%eax
801015e5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801015e9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801015ec:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015f0:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
801015f3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801015f7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801015fb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801015ff:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101603:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101607:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010160a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010160d:	6a 34                	push   $0x34
8010160f:	53                   	push   %ebx
80101610:	50                   	push   %eax
80101611:	e8 fa 30 00 00       	call   80104710 <memmove>
  log_write(bp);
80101616:	89 34 24             	mov    %esi,(%esp)
80101619:	e8 a2 17 00 00       	call   80102dc0 <log_write>
  brelse(bp);
8010161e:	89 75 08             	mov    %esi,0x8(%ebp)
80101621:	83 c4 10             	add    $0x10,%esp
}
80101624:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101627:	5b                   	pop    %ebx
80101628:	5e                   	pop    %esi
80101629:	5d                   	pop    %ebp
  brelse(bp);
8010162a:	e9 b1 eb ff ff       	jmp    801001e0 <brelse>
8010162f:	90                   	nop

80101630 <idup>:
{
80101630:	55                   	push   %ebp
80101631:	89 e5                	mov    %esp,%ebp
80101633:	53                   	push   %ebx
80101634:	83 ec 10             	sub    $0x10,%esp
80101637:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010163a:	68 00 0a 11 80       	push   $0x80110a00
8010163f:	e8 ec 2d 00 00       	call   80104430 <acquire>
  ip->ref++;
80101644:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101648:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010164f:	e8 bc 2f 00 00       	call   80104610 <release>
}
80101654:	89 d8                	mov    %ebx,%eax
80101656:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101659:	c9                   	leave  
8010165a:	c3                   	ret    
8010165b:	90                   	nop
8010165c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101660 <ilock>:
{
80101660:	55                   	push   %ebp
80101661:	89 e5                	mov    %esp,%ebp
80101663:	56                   	push   %esi
80101664:	53                   	push   %ebx
80101665:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101668:	85 db                	test   %ebx,%ebx
8010166a:	0f 84 b4 00 00 00    	je     80101724 <ilock+0xc4>
80101670:	8b 43 08             	mov    0x8(%ebx),%eax
80101673:	85 c0                	test   %eax,%eax
80101675:	0f 8e a9 00 00 00    	jle    80101724 <ilock+0xc4>
  acquiresleep(&ip->lock);
8010167b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010167e:	83 ec 0c             	sub    $0xc,%esp
80101681:	50                   	push   %eax
80101682:	e8 b9 2c 00 00       	call   80104340 <acquiresleep>
  if(!(ip->flags & I_VALID)){
80101687:	83 c4 10             	add    $0x10,%esp
8010168a:	f6 43 4c 02          	testb  $0x2,0x4c(%ebx)
8010168e:	74 10                	je     801016a0 <ilock+0x40>
}
80101690:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101693:	5b                   	pop    %ebx
80101694:	5e                   	pop    %esi
80101695:	5d                   	pop    %ebp
80101696:	c3                   	ret    
80101697:	89 f6                	mov    %esi,%esi
80101699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016a0:	8b 43 04             	mov    0x4(%ebx),%eax
801016a3:	83 ec 08             	sub    $0x8,%esp
801016a6:	c1 e8 03             	shr    $0x3,%eax
801016a9:	03 05 f4 09 11 80    	add    0x801109f4,%eax
801016af:	50                   	push   %eax
801016b0:	ff 33                	pushl  (%ebx)
801016b2:	e8 19 ea ff ff       	call   801000d0 <bread>
801016b7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016b9:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016bc:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016bf:	83 e0 07             	and    $0x7,%eax
801016c2:	c1 e0 06             	shl    $0x6,%eax
801016c5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801016c9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016cc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801016cf:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801016d3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801016d7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801016db:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801016df:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801016e3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801016e7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801016eb:	8b 50 fc             	mov    -0x4(%eax),%edx
801016ee:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016f1:	6a 34                	push   $0x34
801016f3:	50                   	push   %eax
801016f4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801016f7:	50                   	push   %eax
801016f8:	e8 13 30 00 00       	call   80104710 <memmove>
    brelse(bp);
801016fd:	89 34 24             	mov    %esi,(%esp)
80101700:	e8 db ea ff ff       	call   801001e0 <brelse>
    ip->flags |= I_VALID;
80101705:	83 4b 4c 02          	orl    $0x2,0x4c(%ebx)
    if(ip->type == 0)
80101709:	83 c4 10             	add    $0x10,%esp
8010170c:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
80101711:	0f 85 79 ff ff ff    	jne    80101690 <ilock+0x30>
      panic("ilock: no type");
80101717:	83 ec 0c             	sub    $0xc,%esp
8010171a:	68 2c 75 10 80       	push   $0x8010752c
8010171f:	e8 4c ec ff ff       	call   80100370 <panic>
    panic("ilock");
80101724:	83 ec 0c             	sub    $0xc,%esp
80101727:	68 26 75 10 80       	push   $0x80107526
8010172c:	e8 3f ec ff ff       	call   80100370 <panic>
80101731:	eb 0d                	jmp    80101740 <iunlock>
80101733:	90                   	nop
80101734:	90                   	nop
80101735:	90                   	nop
80101736:	90                   	nop
80101737:	90                   	nop
80101738:	90                   	nop
80101739:	90                   	nop
8010173a:	90                   	nop
8010173b:	90                   	nop
8010173c:	90                   	nop
8010173d:	90                   	nop
8010173e:	90                   	nop
8010173f:	90                   	nop

80101740 <iunlock>:
{
80101740:	55                   	push   %ebp
80101741:	89 e5                	mov    %esp,%ebp
80101743:	56                   	push   %esi
80101744:	53                   	push   %ebx
80101745:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101748:	85 db                	test   %ebx,%ebx
8010174a:	74 28                	je     80101774 <iunlock+0x34>
8010174c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010174f:	83 ec 0c             	sub    $0xc,%esp
80101752:	56                   	push   %esi
80101753:	e8 88 2c 00 00       	call   801043e0 <holdingsleep>
80101758:	83 c4 10             	add    $0x10,%esp
8010175b:	85 c0                	test   %eax,%eax
8010175d:	74 15                	je     80101774 <iunlock+0x34>
8010175f:	8b 43 08             	mov    0x8(%ebx),%eax
80101762:	85 c0                	test   %eax,%eax
80101764:	7e 0e                	jle    80101774 <iunlock+0x34>
  releasesleep(&ip->lock);
80101766:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101769:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010176c:	5b                   	pop    %ebx
8010176d:	5e                   	pop    %esi
8010176e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010176f:	e9 2c 2c 00 00       	jmp    801043a0 <releasesleep>
    panic("iunlock");
80101774:	83 ec 0c             	sub    $0xc,%esp
80101777:	68 3b 75 10 80       	push   $0x8010753b
8010177c:	e8 ef eb ff ff       	call   80100370 <panic>
80101781:	eb 0d                	jmp    80101790 <iput>
80101783:	90                   	nop
80101784:	90                   	nop
80101785:	90                   	nop
80101786:	90                   	nop
80101787:	90                   	nop
80101788:	90                   	nop
80101789:	90                   	nop
8010178a:	90                   	nop
8010178b:	90                   	nop
8010178c:	90                   	nop
8010178d:	90                   	nop
8010178e:	90                   	nop
8010178f:	90                   	nop

80101790 <iput>:
{
80101790:	55                   	push   %ebp
80101791:	89 e5                	mov    %esp,%ebp
80101793:	57                   	push   %edi
80101794:	56                   	push   %esi
80101795:	53                   	push   %ebx
80101796:	83 ec 28             	sub    $0x28,%esp
80101799:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&icache.lock);
8010179c:	68 00 0a 11 80       	push   $0x80110a00
801017a1:	e8 8a 2c 00 00       	call   80104430 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
801017a6:	8b 46 08             	mov    0x8(%esi),%eax
801017a9:	83 c4 10             	add    $0x10,%esp
801017ac:	83 f8 01             	cmp    $0x1,%eax
801017af:	74 1f                	je     801017d0 <iput+0x40>
  ip->ref--;
801017b1:	83 e8 01             	sub    $0x1,%eax
801017b4:	89 46 08             	mov    %eax,0x8(%esi)
  release(&icache.lock);
801017b7:	c7 45 08 00 0a 11 80 	movl   $0x80110a00,0x8(%ebp)
}
801017be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017c1:	5b                   	pop    %ebx
801017c2:	5e                   	pop    %esi
801017c3:	5f                   	pop    %edi
801017c4:	5d                   	pop    %ebp
  release(&icache.lock);
801017c5:	e9 46 2e 00 00       	jmp    80104610 <release>
801017ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
801017d0:	f6 46 4c 02          	testb  $0x2,0x4c(%esi)
801017d4:	74 db                	je     801017b1 <iput+0x21>
801017d6:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
801017db:	75 d4                	jne    801017b1 <iput+0x21>
    release(&icache.lock);
801017dd:	83 ec 0c             	sub    $0xc,%esp
801017e0:	8d 5e 5c             	lea    0x5c(%esi),%ebx
801017e3:	8d be 8c 00 00 00    	lea    0x8c(%esi),%edi
801017e9:	68 00 0a 11 80       	push   $0x80110a00
801017ee:	e8 1d 2e 00 00       	call   80104610 <release>
801017f3:	83 c4 10             	add    $0x10,%esp
801017f6:	eb 0f                	jmp    80101807 <iput+0x77>
801017f8:	90                   	nop
801017f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101800:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101803:	39 fb                	cmp    %edi,%ebx
80101805:	74 19                	je     80101820 <iput+0x90>
    if(ip->addrs[i]){
80101807:	8b 13                	mov    (%ebx),%edx
80101809:	85 d2                	test   %edx,%edx
8010180b:	74 f3                	je     80101800 <iput+0x70>
      bfree(ip->dev, ip->addrs[i]);
8010180d:	8b 06                	mov    (%esi),%eax
8010180f:	e8 cc fb ff ff       	call   801013e0 <bfree>
      ip->addrs[i] = 0;
80101814:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010181a:	eb e4                	jmp    80101800 <iput+0x70>
8010181c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101820:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101826:	85 c0                	test   %eax,%eax
80101828:	75 46                	jne    80101870 <iput+0xe0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010182a:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
8010182d:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80101834:	56                   	push   %esi
80101835:	e8 76 fd ff ff       	call   801015b0 <iupdate>
    ip->type = 0;
8010183a:	31 c0                	xor    %eax,%eax
8010183c:	66 89 46 50          	mov    %ax,0x50(%esi)
    iupdate(ip);
80101840:	89 34 24             	mov    %esi,(%esp)
80101843:	e8 68 fd ff ff       	call   801015b0 <iupdate>
    acquire(&icache.lock);
80101848:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010184f:	e8 dc 2b 00 00       	call   80104430 <acquire>
    ip->flags = 0;
80101854:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
8010185b:	8b 46 08             	mov    0x8(%esi),%eax
8010185e:	83 c4 10             	add    $0x10,%esp
80101861:	e9 4b ff ff ff       	jmp    801017b1 <iput+0x21>
80101866:	8d 76 00             	lea    0x0(%esi),%esi
80101869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101870:	83 ec 08             	sub    $0x8,%esp
80101873:	50                   	push   %eax
80101874:	ff 36                	pushl  (%esi)
80101876:	e8 55 e8 ff ff       	call   801000d0 <bread>
8010187b:	83 c4 10             	add    $0x10,%esp
8010187e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101881:	8d 58 5c             	lea    0x5c(%eax),%ebx
80101884:	8d b8 5c 02 00 00    	lea    0x25c(%eax),%edi
8010188a:	eb 0b                	jmp    80101897 <iput+0x107>
8010188c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101890:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
80101893:	39 df                	cmp    %ebx,%edi
80101895:	74 0f                	je     801018a6 <iput+0x116>
      if(a[j])
80101897:	8b 13                	mov    (%ebx),%edx
80101899:	85 d2                	test   %edx,%edx
8010189b:	74 f3                	je     80101890 <iput+0x100>
        bfree(ip->dev, a[j]);
8010189d:	8b 06                	mov    (%esi),%eax
8010189f:	e8 3c fb ff ff       	call   801013e0 <bfree>
801018a4:	eb ea                	jmp    80101890 <iput+0x100>
    brelse(bp);
801018a6:	83 ec 0c             	sub    $0xc,%esp
801018a9:	ff 75 e4             	pushl  -0x1c(%ebp)
801018ac:	e8 2f e9 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801018b1:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
801018b7:	8b 06                	mov    (%esi),%eax
801018b9:	e8 22 fb ff ff       	call   801013e0 <bfree>
    ip->addrs[NDIRECT] = 0;
801018be:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
801018c5:	00 00 00 
801018c8:	83 c4 10             	add    $0x10,%esp
801018cb:	e9 5a ff ff ff       	jmp    8010182a <iput+0x9a>

801018d0 <iunlockput>:
{
801018d0:	55                   	push   %ebp
801018d1:	89 e5                	mov    %esp,%ebp
801018d3:	53                   	push   %ebx
801018d4:	83 ec 10             	sub    $0x10,%esp
801018d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801018da:	53                   	push   %ebx
801018db:	e8 60 fe ff ff       	call   80101740 <iunlock>
  iput(ip);
801018e0:	89 5d 08             	mov    %ebx,0x8(%ebp)
801018e3:	83 c4 10             	add    $0x10,%esp
}
801018e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801018e9:	c9                   	leave  
  iput(ip);
801018ea:	e9 a1 fe ff ff       	jmp    80101790 <iput>
801018ef:	90                   	nop

801018f0 <stati>:
}

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
801018f0:	55                   	push   %ebp
801018f1:	89 e5                	mov    %esp,%ebp
801018f3:	8b 55 08             	mov    0x8(%ebp),%edx
801018f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
801018f9:	8b 0a                	mov    (%edx),%ecx
801018fb:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
801018fe:	8b 4a 04             	mov    0x4(%edx),%ecx
80101901:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101904:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101908:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010190b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010190f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101913:	8b 52 58             	mov    0x58(%edx),%edx
80101916:	89 50 10             	mov    %edx,0x10(%eax)
}
80101919:	5d                   	pop    %ebp
8010191a:	c3                   	ret    
8010191b:	90                   	nop
8010191c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101920 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101920:	55                   	push   %ebp
80101921:	89 e5                	mov    %esp,%ebp
80101923:	57                   	push   %edi
80101924:	56                   	push   %esi
80101925:	53                   	push   %ebx
80101926:	83 ec 1c             	sub    $0x1c,%esp
80101929:	8b 45 08             	mov    0x8(%ebp),%eax
8010192c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010192f:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101932:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101937:	89 7d e0             	mov    %edi,-0x20(%ebp)
8010193a:	8b 7d 14             	mov    0x14(%ebp),%edi
8010193d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101940:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101943:	0f 84 a7 00 00 00    	je     801019f0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101949:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010194c:	8b 40 58             	mov    0x58(%eax),%eax
8010194f:	39 f0                	cmp    %esi,%eax
80101951:	0f 82 ba 00 00 00    	jb     80101a11 <readi+0xf1>
80101957:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010195a:	89 f9                	mov    %edi,%ecx
8010195c:	01 f1                	add    %esi,%ecx
8010195e:	0f 82 ad 00 00 00    	jb     80101a11 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101964:	89 c2                	mov    %eax,%edx
80101966:	29 f2                	sub    %esi,%edx
80101968:	39 c8                	cmp    %ecx,%eax
8010196a:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010196d:	31 ff                	xor    %edi,%edi
8010196f:	85 d2                	test   %edx,%edx
    n = ip->size - off;
80101971:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101974:	74 6c                	je     801019e2 <readi+0xc2>
80101976:	8d 76 00             	lea    0x0(%esi),%esi
80101979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101980:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101983:	89 f2                	mov    %esi,%edx
80101985:	c1 ea 09             	shr    $0x9,%edx
80101988:	89 d8                	mov    %ebx,%eax
8010198a:	e8 41 f9 ff ff       	call   801012d0 <bmap>
8010198f:	83 ec 08             	sub    $0x8,%esp
80101992:	50                   	push   %eax
80101993:	ff 33                	pushl  (%ebx)
80101995:	e8 36 e7 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
8010199a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010199d:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
8010199f:	89 f0                	mov    %esi,%eax
801019a1:	25 ff 01 00 00       	and    $0x1ff,%eax
801019a6:	b9 00 02 00 00       	mov    $0x200,%ecx
801019ab:	83 c4 0c             	add    $0xc,%esp
801019ae:	29 c1                	sub    %eax,%ecx
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
801019b0:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
801019b4:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
801019b7:	29 fb                	sub    %edi,%ebx
801019b9:	39 d9                	cmp    %ebx,%ecx
801019bb:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801019be:	53                   	push   %ebx
801019bf:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019c0:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
801019c2:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019c5:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
801019c7:	e8 44 2d 00 00       	call   80104710 <memmove>
    brelse(bp);
801019cc:	8b 55 dc             	mov    -0x24(%ebp),%edx
801019cf:	89 14 24             	mov    %edx,(%esp)
801019d2:	e8 09 e8 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019d7:	01 5d e0             	add    %ebx,-0x20(%ebp)
801019da:	83 c4 10             	add    $0x10,%esp
801019dd:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801019e0:	77 9e                	ja     80101980 <readi+0x60>
  }
  return n;
801019e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
801019e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019e8:	5b                   	pop    %ebx
801019e9:	5e                   	pop    %esi
801019ea:	5f                   	pop    %edi
801019eb:	5d                   	pop    %ebp
801019ec:	c3                   	ret    
801019ed:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
801019f0:	0f bf 40 52          	movswl 0x52(%eax),%eax
801019f4:	66 83 f8 09          	cmp    $0x9,%ax
801019f8:	77 17                	ja     80101a11 <readi+0xf1>
801019fa:	8b 04 c5 80 09 11 80 	mov    -0x7feef680(,%eax,8),%eax
80101a01:	85 c0                	test   %eax,%eax
80101a03:	74 0c                	je     80101a11 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101a05:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101a08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a0b:	5b                   	pop    %ebx
80101a0c:	5e                   	pop    %esi
80101a0d:	5f                   	pop    %edi
80101a0e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101a0f:	ff e0                	jmp    *%eax
      return -1;
80101a11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a16:	eb cd                	jmp    801019e5 <readi+0xc5>
80101a18:	90                   	nop
80101a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101a20 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a20:	55                   	push   %ebp
80101a21:	89 e5                	mov    %esp,%ebp
80101a23:	57                   	push   %edi
80101a24:	56                   	push   %esi
80101a25:	53                   	push   %ebx
80101a26:	83 ec 1c             	sub    $0x1c,%esp
80101a29:	8b 45 08             	mov    0x8(%ebp),%eax
80101a2c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a2f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a32:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a37:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a3a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a3d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a40:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  if(ip->type == T_DEV){
80101a43:	0f 84 b7 00 00 00    	je     80101b00 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a49:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a4c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a4f:	0f 82 eb 00 00 00    	jb     80101b40 <writei+0x120>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101a55:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101a58:	89 c8                	mov    %ecx,%eax
80101a5a:	01 f0                	add    %esi,%eax
80101a5c:	0f 82 de 00 00 00    	jb     80101b40 <writei+0x120>
80101a62:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101a67:	0f 87 d3 00 00 00    	ja     80101b40 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101a6d:	85 c9                	test   %ecx,%ecx
80101a6f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101a76:	74 79                	je     80101af1 <writei+0xd1>
80101a78:	90                   	nop
80101a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a80:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101a83:	89 f2                	mov    %esi,%edx
80101a85:	c1 ea 09             	shr    $0x9,%edx
80101a88:	89 f8                	mov    %edi,%eax
80101a8a:	e8 41 f8 ff ff       	call   801012d0 <bmap>
80101a8f:	83 ec 08             	sub    $0x8,%esp
80101a92:	50                   	push   %eax
80101a93:	ff 37                	pushl  (%edi)
80101a95:	e8 36 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101a9a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101a9d:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101aa0:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101aa2:	89 f0                	mov    %esi,%eax
80101aa4:	b9 00 02 00 00       	mov    $0x200,%ecx
80101aa9:	83 c4 0c             	add    $0xc,%esp
80101aac:	25 ff 01 00 00       	and    $0x1ff,%eax
80101ab1:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101ab3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101ab7:	39 d9                	cmp    %ebx,%ecx
80101ab9:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101abc:	53                   	push   %ebx
80101abd:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ac0:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101ac2:	50                   	push   %eax
80101ac3:	e8 48 2c 00 00       	call   80104710 <memmove>
    log_write(bp);
80101ac8:	89 3c 24             	mov    %edi,(%esp)
80101acb:	e8 f0 12 00 00       	call   80102dc0 <log_write>
    brelse(bp);
80101ad0:	89 3c 24             	mov    %edi,(%esp)
80101ad3:	e8 08 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ad8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101adb:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101ade:	83 c4 10             	add    $0x10,%esp
80101ae1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101ae4:	39 55 e0             	cmp    %edx,-0x20(%ebp)
80101ae7:	77 97                	ja     80101a80 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101ae9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101aec:	3b 70 58             	cmp    0x58(%eax),%esi
80101aef:	77 37                	ja     80101b28 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101af1:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101af4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101af7:	5b                   	pop    %ebx
80101af8:	5e                   	pop    %esi
80101af9:	5f                   	pop    %edi
80101afa:	5d                   	pop    %ebp
80101afb:	c3                   	ret    
80101afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b00:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b04:	66 83 f8 09          	cmp    $0x9,%ax
80101b08:	77 36                	ja     80101b40 <writei+0x120>
80101b0a:	8b 04 c5 84 09 11 80 	mov    -0x7feef67c(,%eax,8),%eax
80101b11:	85 c0                	test   %eax,%eax
80101b13:	74 2b                	je     80101b40 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101b15:	89 4d 10             	mov    %ecx,0x10(%ebp)
}
80101b18:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b1b:	5b                   	pop    %ebx
80101b1c:	5e                   	pop    %esi
80101b1d:	5f                   	pop    %edi
80101b1e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101b1f:	ff e0                	jmp    *%eax
80101b21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101b28:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101b2b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101b2e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b31:	50                   	push   %eax
80101b32:	e8 79 fa ff ff       	call   801015b0 <iupdate>
80101b37:	83 c4 10             	add    $0x10,%esp
80101b3a:	eb b5                	jmp    80101af1 <writei+0xd1>
80101b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101b40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b45:	eb ad                	jmp    80101af4 <writei+0xd4>
80101b47:	89 f6                	mov    %esi,%esi
80101b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b50 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101b50:	55                   	push   %ebp
80101b51:	89 e5                	mov    %esp,%ebp
80101b53:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101b56:	6a 0e                	push   $0xe
80101b58:	ff 75 0c             	pushl  0xc(%ebp)
80101b5b:	ff 75 08             	pushl  0x8(%ebp)
80101b5e:	e8 1d 2c 00 00       	call   80104780 <strncmp>
}
80101b63:	c9                   	leave  
80101b64:	c3                   	ret    
80101b65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b70 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101b70:	55                   	push   %ebp
80101b71:	89 e5                	mov    %esp,%ebp
80101b73:	57                   	push   %edi
80101b74:	56                   	push   %esi
80101b75:	53                   	push   %ebx
80101b76:	83 ec 1c             	sub    $0x1c,%esp
80101b79:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101b7c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101b81:	0f 85 80 00 00 00    	jne    80101c07 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101b87:	8b 53 58             	mov    0x58(%ebx),%edx
80101b8a:	31 ff                	xor    %edi,%edi
80101b8c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101b8f:	85 d2                	test   %edx,%edx
80101b91:	75 0d                	jne    80101ba0 <dirlookup+0x30>
80101b93:	eb 5b                	jmp    80101bf0 <dirlookup+0x80>
80101b95:	8d 76 00             	lea    0x0(%esi),%esi
80101b98:	83 c7 10             	add    $0x10,%edi
80101b9b:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101b9e:	76 50                	jbe    80101bf0 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ba0:	6a 10                	push   $0x10
80101ba2:	57                   	push   %edi
80101ba3:	56                   	push   %esi
80101ba4:	53                   	push   %ebx
80101ba5:	e8 76 fd ff ff       	call   80101920 <readi>
80101baa:	83 c4 10             	add    $0x10,%esp
80101bad:	83 f8 10             	cmp    $0x10,%eax
80101bb0:	75 48                	jne    80101bfa <dirlookup+0x8a>
      panic("dirlink read");
    if(de.inum == 0)
80101bb2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101bb7:	74 df                	je     80101b98 <dirlookup+0x28>
  return strncmp(s, t, DIRSIZ);
80101bb9:	8d 45 da             	lea    -0x26(%ebp),%eax
80101bbc:	83 ec 04             	sub    $0x4,%esp
80101bbf:	6a 0e                	push   $0xe
80101bc1:	50                   	push   %eax
80101bc2:	ff 75 0c             	pushl  0xc(%ebp)
80101bc5:	e8 b6 2b 00 00       	call   80104780 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101bca:	83 c4 10             	add    $0x10,%esp
80101bcd:	85 c0                	test   %eax,%eax
80101bcf:	75 c7                	jne    80101b98 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101bd1:	8b 45 10             	mov    0x10(%ebp),%eax
80101bd4:	85 c0                	test   %eax,%eax
80101bd6:	74 05                	je     80101bdd <dirlookup+0x6d>
        *poff = off;
80101bd8:	8b 45 10             	mov    0x10(%ebp),%eax
80101bdb:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101bdd:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101be1:	8b 03                	mov    (%ebx),%eax
80101be3:	e8 18 f6 ff ff       	call   80101200 <iget>
    }
  }

  return 0;
}
80101be8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101beb:	5b                   	pop    %ebx
80101bec:	5e                   	pop    %esi
80101bed:	5f                   	pop    %edi
80101bee:	5d                   	pop    %ebp
80101bef:	c3                   	ret    
80101bf0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101bf3:	31 c0                	xor    %eax,%eax
}
80101bf5:	5b                   	pop    %ebx
80101bf6:	5e                   	pop    %esi
80101bf7:	5f                   	pop    %edi
80101bf8:	5d                   	pop    %ebp
80101bf9:	c3                   	ret    
      panic("dirlink read");
80101bfa:	83 ec 0c             	sub    $0xc,%esp
80101bfd:	68 55 75 10 80       	push   $0x80107555
80101c02:	e8 69 e7 ff ff       	call   80100370 <panic>
    panic("dirlookup not DIR");
80101c07:	83 ec 0c             	sub    $0xc,%esp
80101c0a:	68 43 75 10 80       	push   $0x80107543
80101c0f:	e8 5c e7 ff ff       	call   80100370 <panic>
80101c14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101c20 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c20:	55                   	push   %ebp
80101c21:	89 e5                	mov    %esp,%ebp
80101c23:	57                   	push   %edi
80101c24:	56                   	push   %esi
80101c25:	53                   	push   %ebx
80101c26:	89 cf                	mov    %ecx,%edi
80101c28:	89 c3                	mov    %eax,%ebx
80101c2a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c2d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101c30:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101c33:	0f 84 55 01 00 00    	je     80101d8e <namex+0x16e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80101c39:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  acquire(&icache.lock);
80101c3f:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(proc->cwd);
80101c42:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101c45:	68 00 0a 11 80       	push   $0x80110a00
80101c4a:	e8 e1 27 00 00       	call   80104430 <acquire>
  ip->ref++;
80101c4f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101c53:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101c5a:	e8 b1 29 00 00       	call   80104610 <release>
80101c5f:	83 c4 10             	add    $0x10,%esp
80101c62:	eb 07                	jmp    80101c6b <namex+0x4b>
80101c64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101c68:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101c6b:	0f b6 03             	movzbl (%ebx),%eax
80101c6e:	3c 2f                	cmp    $0x2f,%al
80101c70:	74 f6                	je     80101c68 <namex+0x48>
  if(*path == 0)
80101c72:	84 c0                	test   %al,%al
80101c74:	0f 84 e3 00 00 00    	je     80101d5d <namex+0x13d>
  while(*path != '/' && *path != 0)
80101c7a:	0f b6 03             	movzbl (%ebx),%eax
80101c7d:	89 da                	mov    %ebx,%edx
80101c7f:	84 c0                	test   %al,%al
80101c81:	0f 84 ac 00 00 00    	je     80101d33 <namex+0x113>
80101c87:	3c 2f                	cmp    $0x2f,%al
80101c89:	75 09                	jne    80101c94 <namex+0x74>
80101c8b:	e9 a3 00 00 00       	jmp    80101d33 <namex+0x113>
80101c90:	84 c0                	test   %al,%al
80101c92:	74 0a                	je     80101c9e <namex+0x7e>
    path++;
80101c94:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101c97:	0f b6 02             	movzbl (%edx),%eax
80101c9a:	3c 2f                	cmp    $0x2f,%al
80101c9c:	75 f2                	jne    80101c90 <namex+0x70>
80101c9e:	89 d1                	mov    %edx,%ecx
80101ca0:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101ca2:	83 f9 0d             	cmp    $0xd,%ecx
80101ca5:	0f 8e 8d 00 00 00    	jle    80101d38 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101cab:	83 ec 04             	sub    $0x4,%esp
80101cae:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101cb1:	6a 0e                	push   $0xe
80101cb3:	53                   	push   %ebx
80101cb4:	57                   	push   %edi
80101cb5:	e8 56 2a 00 00       	call   80104710 <memmove>
    path++;
80101cba:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101cbd:	83 c4 10             	add    $0x10,%esp
    path++;
80101cc0:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101cc2:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101cc5:	75 11                	jne    80101cd8 <namex+0xb8>
80101cc7:	89 f6                	mov    %esi,%esi
80101cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101cd0:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101cd3:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101cd6:	74 f8                	je     80101cd0 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101cd8:	83 ec 0c             	sub    $0xc,%esp
80101cdb:	56                   	push   %esi
80101cdc:	e8 7f f9 ff ff       	call   80101660 <ilock>
    if(ip->type != T_DIR){
80101ce1:	83 c4 10             	add    $0x10,%esp
80101ce4:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101ce9:	0f 85 7f 00 00 00    	jne    80101d6e <namex+0x14e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101cef:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101cf2:	85 d2                	test   %edx,%edx
80101cf4:	74 09                	je     80101cff <namex+0xdf>
80101cf6:	80 3b 00             	cmpb   $0x0,(%ebx)
80101cf9:	0f 84 a5 00 00 00    	je     80101da4 <namex+0x184>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101cff:	83 ec 04             	sub    $0x4,%esp
80101d02:	6a 00                	push   $0x0
80101d04:	57                   	push   %edi
80101d05:	56                   	push   %esi
80101d06:	e8 65 fe ff ff       	call   80101b70 <dirlookup>
80101d0b:	83 c4 10             	add    $0x10,%esp
80101d0e:	85 c0                	test   %eax,%eax
80101d10:	74 5c                	je     80101d6e <namex+0x14e>
  iunlock(ip);
80101d12:	83 ec 0c             	sub    $0xc,%esp
80101d15:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d18:	56                   	push   %esi
80101d19:	e8 22 fa ff ff       	call   80101740 <iunlock>
  iput(ip);
80101d1e:	89 34 24             	mov    %esi,(%esp)
80101d21:	e8 6a fa ff ff       	call   80101790 <iput>
80101d26:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d29:	83 c4 10             	add    $0x10,%esp
80101d2c:	89 c6                	mov    %eax,%esi
80101d2e:	e9 38 ff ff ff       	jmp    80101c6b <namex+0x4b>
  while(*path != '/' && *path != 0)
80101d33:	31 c9                	xor    %ecx,%ecx
80101d35:	8d 76 00             	lea    0x0(%esi),%esi
    memmove(name, s, len);
80101d38:	83 ec 04             	sub    $0x4,%esp
80101d3b:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101d3e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101d41:	51                   	push   %ecx
80101d42:	53                   	push   %ebx
80101d43:	57                   	push   %edi
80101d44:	e8 c7 29 00 00       	call   80104710 <memmove>
    name[len] = 0;
80101d49:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101d4c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d4f:	83 c4 10             	add    $0x10,%esp
80101d52:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101d56:	89 d3                	mov    %edx,%ebx
80101d58:	e9 65 ff ff ff       	jmp    80101cc2 <namex+0xa2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101d5d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101d60:	85 c0                	test   %eax,%eax
80101d62:	75 56                	jne    80101dba <namex+0x19a>
    iput(ip);
    return 0;
  }
  return ip;
}
80101d64:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d67:	89 f0                	mov    %esi,%eax
80101d69:	5b                   	pop    %ebx
80101d6a:	5e                   	pop    %esi
80101d6b:	5f                   	pop    %edi
80101d6c:	5d                   	pop    %ebp
80101d6d:	c3                   	ret    
  iunlock(ip);
80101d6e:	83 ec 0c             	sub    $0xc,%esp
80101d71:	56                   	push   %esi
80101d72:	e8 c9 f9 ff ff       	call   80101740 <iunlock>
  iput(ip);
80101d77:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101d7a:	31 f6                	xor    %esi,%esi
  iput(ip);
80101d7c:	e8 0f fa ff ff       	call   80101790 <iput>
      return 0;
80101d81:	83 c4 10             	add    $0x10,%esp
}
80101d84:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d87:	89 f0                	mov    %esi,%eax
80101d89:	5b                   	pop    %ebx
80101d8a:	5e                   	pop    %esi
80101d8b:	5f                   	pop    %edi
80101d8c:	5d                   	pop    %ebp
80101d8d:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101d8e:	ba 01 00 00 00       	mov    $0x1,%edx
80101d93:	b8 01 00 00 00       	mov    $0x1,%eax
80101d98:	e8 63 f4 ff ff       	call   80101200 <iget>
80101d9d:	89 c6                	mov    %eax,%esi
80101d9f:	e9 c7 fe ff ff       	jmp    80101c6b <namex+0x4b>
      iunlock(ip);
80101da4:	83 ec 0c             	sub    $0xc,%esp
80101da7:	56                   	push   %esi
80101da8:	e8 93 f9 ff ff       	call   80101740 <iunlock>
      return ip;
80101dad:	83 c4 10             	add    $0x10,%esp
}
80101db0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101db3:	89 f0                	mov    %esi,%eax
80101db5:	5b                   	pop    %ebx
80101db6:	5e                   	pop    %esi
80101db7:	5f                   	pop    %edi
80101db8:	5d                   	pop    %ebp
80101db9:	c3                   	ret    
    iput(ip);
80101dba:	83 ec 0c             	sub    $0xc,%esp
80101dbd:	56                   	push   %esi
    return 0;
80101dbe:	31 f6                	xor    %esi,%esi
    iput(ip);
80101dc0:	e8 cb f9 ff ff       	call   80101790 <iput>
    return 0;
80101dc5:	83 c4 10             	add    $0x10,%esp
80101dc8:	eb 9a                	jmp    80101d64 <namex+0x144>
80101dca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101dd0 <dirlink>:
{
80101dd0:	55                   	push   %ebp
80101dd1:	89 e5                	mov    %esp,%ebp
80101dd3:	57                   	push   %edi
80101dd4:	56                   	push   %esi
80101dd5:	53                   	push   %ebx
80101dd6:	83 ec 20             	sub    $0x20,%esp
80101dd9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101ddc:	6a 00                	push   $0x0
80101dde:	ff 75 0c             	pushl  0xc(%ebp)
80101de1:	53                   	push   %ebx
80101de2:	e8 89 fd ff ff       	call   80101b70 <dirlookup>
80101de7:	83 c4 10             	add    $0x10,%esp
80101dea:	85 c0                	test   %eax,%eax
80101dec:	75 67                	jne    80101e55 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101dee:	8b 7b 58             	mov    0x58(%ebx),%edi
80101df1:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101df4:	85 ff                	test   %edi,%edi
80101df6:	74 29                	je     80101e21 <dirlink+0x51>
80101df8:	31 ff                	xor    %edi,%edi
80101dfa:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101dfd:	eb 09                	jmp    80101e08 <dirlink+0x38>
80101dff:	90                   	nop
80101e00:	83 c7 10             	add    $0x10,%edi
80101e03:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101e06:	76 19                	jbe    80101e21 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e08:	6a 10                	push   $0x10
80101e0a:	57                   	push   %edi
80101e0b:	56                   	push   %esi
80101e0c:	53                   	push   %ebx
80101e0d:	e8 0e fb ff ff       	call   80101920 <readi>
80101e12:	83 c4 10             	add    $0x10,%esp
80101e15:	83 f8 10             	cmp    $0x10,%eax
80101e18:	75 4e                	jne    80101e68 <dirlink+0x98>
    if(de.inum == 0)
80101e1a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e1f:	75 df                	jne    80101e00 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101e21:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e24:	83 ec 04             	sub    $0x4,%esp
80101e27:	6a 0e                	push   $0xe
80101e29:	ff 75 0c             	pushl  0xc(%ebp)
80101e2c:	50                   	push   %eax
80101e2d:	e8 ae 29 00 00       	call   801047e0 <strncpy>
  de.inum = inum;
80101e32:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e35:	6a 10                	push   $0x10
80101e37:	57                   	push   %edi
80101e38:	56                   	push   %esi
80101e39:	53                   	push   %ebx
  de.inum = inum;
80101e3a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e3e:	e8 dd fb ff ff       	call   80101a20 <writei>
80101e43:	83 c4 20             	add    $0x20,%esp
80101e46:	83 f8 10             	cmp    $0x10,%eax
80101e49:	75 2a                	jne    80101e75 <dirlink+0xa5>
  return 0;
80101e4b:	31 c0                	xor    %eax,%eax
}
80101e4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e50:	5b                   	pop    %ebx
80101e51:	5e                   	pop    %esi
80101e52:	5f                   	pop    %edi
80101e53:	5d                   	pop    %ebp
80101e54:	c3                   	ret    
    iput(ip);
80101e55:	83 ec 0c             	sub    $0xc,%esp
80101e58:	50                   	push   %eax
80101e59:	e8 32 f9 ff ff       	call   80101790 <iput>
    return -1;
80101e5e:	83 c4 10             	add    $0x10,%esp
80101e61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e66:	eb e5                	jmp    80101e4d <dirlink+0x7d>
      panic("dirlink read");
80101e68:	83 ec 0c             	sub    $0xc,%esp
80101e6b:	68 55 75 10 80       	push   $0x80107555
80101e70:	e8 fb e4 ff ff       	call   80100370 <panic>
    panic("dirlink");
80101e75:	83 ec 0c             	sub    $0xc,%esp
80101e78:	68 2a 7b 10 80       	push   $0x80107b2a
80101e7d:	e8 ee e4 ff ff       	call   80100370 <panic>
80101e82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101e90 <namei>:

struct inode*
namei(char *path)
{
80101e90:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101e91:	31 d2                	xor    %edx,%edx
{
80101e93:	89 e5                	mov    %esp,%ebp
80101e95:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101e98:	8b 45 08             	mov    0x8(%ebp),%eax
80101e9b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101e9e:	e8 7d fd ff ff       	call   80101c20 <namex>
}
80101ea3:	c9                   	leave  
80101ea4:	c3                   	ret    
80101ea5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101eb0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101eb0:	55                   	push   %ebp
  return namex(path, 1, name);
80101eb1:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101eb6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101eb8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101ebb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101ebe:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101ebf:	e9 5c fd ff ff       	jmp    80101c20 <namex>
80101ec4:	66 90                	xchg   %ax,%ax
80101ec6:	66 90                	xchg   %ax,%ax
80101ec8:	66 90                	xchg   %ax,%ax
80101eca:	66 90                	xchg   %ax,%ax
80101ecc:	66 90                	xchg   %ax,%ax
80101ece:	66 90                	xchg   %ax,%ax

80101ed0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101ed0:	55                   	push   %ebp
  if(b == 0)
80101ed1:	85 c0                	test   %eax,%eax
{
80101ed3:	89 e5                	mov    %esp,%ebp
80101ed5:	56                   	push   %esi
80101ed6:	53                   	push   %ebx
  if(b == 0)
80101ed7:	0f 84 ad 00 00 00    	je     80101f8a <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101edd:	8b 58 08             	mov    0x8(%eax),%ebx
80101ee0:	89 c1                	mov    %eax,%ecx
80101ee2:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101ee8:	0f 87 8f 00 00 00    	ja     80101f7d <idestart+0xad>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101eee:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101ef3:	90                   	nop
80101ef4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ef8:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101ef9:	83 e0 c0             	and    $0xffffffc0,%eax
80101efc:	3c 40                	cmp    $0x40,%al
80101efe:	75 f8                	jne    80101ef8 <idestart+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f00:	31 f6                	xor    %esi,%esi
80101f02:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f07:	89 f0                	mov    %esi,%eax
80101f09:	ee                   	out    %al,(%dx)
80101f0a:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f0f:	b8 01 00 00 00       	mov    $0x1,%eax
80101f14:	ee                   	out    %al,(%dx)
80101f15:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f1a:	89 d8                	mov    %ebx,%eax
80101f1c:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101f1d:	89 d8                	mov    %ebx,%eax
80101f1f:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101f24:	c1 f8 08             	sar    $0x8,%eax
80101f27:	ee                   	out    %al,(%dx)
80101f28:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101f2d:	89 f0                	mov    %esi,%eax
80101f2f:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101f30:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80101f34:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101f39:	c1 e0 04             	shl    $0x4,%eax
80101f3c:	83 e0 10             	and    $0x10,%eax
80101f3f:	83 c8 e0             	or     $0xffffffe0,%eax
80101f42:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101f43:	f6 01 04             	testb  $0x4,(%ecx)
80101f46:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f4b:	75 13                	jne    80101f60 <idestart+0x90>
80101f4d:	b8 20 00 00 00       	mov    $0x20,%eax
80101f52:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101f53:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f56:	5b                   	pop    %ebx
80101f57:	5e                   	pop    %esi
80101f58:	5d                   	pop    %ebp
80101f59:	c3                   	ret    
80101f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101f60:	b8 30 00 00 00       	mov    $0x30,%eax
80101f65:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80101f66:	ba f0 01 00 00       	mov    $0x1f0,%edx
    outsl(0x1f0, b->data, BSIZE/4);
80101f6b:	8d 71 5c             	lea    0x5c(%ecx),%esi
80101f6e:	b9 80 00 00 00       	mov    $0x80,%ecx
80101f73:	fc                   	cld    
80101f74:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80101f76:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f79:	5b                   	pop    %ebx
80101f7a:	5e                   	pop    %esi
80101f7b:	5d                   	pop    %ebp
80101f7c:	c3                   	ret    
    panic("incorrect blockno");
80101f7d:	83 ec 0c             	sub    $0xc,%esp
80101f80:	68 c0 75 10 80       	push   $0x801075c0
80101f85:	e8 e6 e3 ff ff       	call   80100370 <panic>
    panic("idestart");
80101f8a:	83 ec 0c             	sub    $0xc,%esp
80101f8d:	68 b7 75 10 80       	push   $0x801075b7
80101f92:	e8 d9 e3 ff ff       	call   80100370 <panic>
80101f97:	89 f6                	mov    %esi,%esi
80101f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fa0 <ideinit>:
{
80101fa0:	55                   	push   %ebp
80101fa1:	89 e5                	mov    %esp,%ebp
80101fa3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80101fa6:	68 d2 75 10 80       	push   $0x801075d2
80101fab:	68 80 a5 10 80       	push   $0x8010a580
80101fb0:	e8 5b 24 00 00       	call   80104410 <initlock>
  picenable(IRQ_IDE);
80101fb5:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80101fbc:	e8 df 12 00 00       	call   801032a0 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
80101fc1:	58                   	pop    %eax
80101fc2:	a1 80 2d 11 80       	mov    0x80112d80,%eax
80101fc7:	5a                   	pop    %edx
80101fc8:	83 e8 01             	sub    $0x1,%eax
80101fcb:	50                   	push   %eax
80101fcc:	6a 0e                	push   $0xe
80101fce:	e8 bd 02 00 00       	call   80102290 <ioapicenable>
80101fd3:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101fd6:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fdb:	90                   	nop
80101fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101fe0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101fe1:	83 e0 c0             	and    $0xffffffc0,%eax
80101fe4:	3c 40                	cmp    $0x40,%al
80101fe6:	75 f8                	jne    80101fe0 <ideinit+0x40>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101fe8:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101fed:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80101ff2:	ee                   	out    %al,(%dx)
80101ff3:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101ff8:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101ffd:	eb 06                	jmp    80102005 <ideinit+0x65>
80101fff:	90                   	nop
  for(i=0; i<1000; i++){
80102000:	83 e9 01             	sub    $0x1,%ecx
80102003:	74 0f                	je     80102014 <ideinit+0x74>
80102005:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102006:	84 c0                	test   %al,%al
80102008:	74 f6                	je     80102000 <ideinit+0x60>
      havedisk1 = 1;
8010200a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102011:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102014:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102019:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
8010201e:	ee                   	out    %al,(%dx)
}
8010201f:	c9                   	leave  
80102020:	c3                   	ret    
80102021:	eb 0d                	jmp    80102030 <ideintr>
80102023:	90                   	nop
80102024:	90                   	nop
80102025:	90                   	nop
80102026:	90                   	nop
80102027:	90                   	nop
80102028:	90                   	nop
80102029:	90                   	nop
8010202a:	90                   	nop
8010202b:	90                   	nop
8010202c:	90                   	nop
8010202d:	90                   	nop
8010202e:	90                   	nop
8010202f:	90                   	nop

80102030 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102030:	55                   	push   %ebp
80102031:	89 e5                	mov    %esp,%ebp
80102033:	57                   	push   %edi
80102034:	56                   	push   %esi
80102035:	53                   	push   %ebx
80102036:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102039:	68 80 a5 10 80       	push   $0x8010a580
8010203e:	e8 ed 23 00 00       	call   80104430 <acquire>
  if((b = idequeue) == 0){
80102043:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
80102049:	83 c4 10             	add    $0x10,%esp
8010204c:	85 db                	test   %ebx,%ebx
8010204e:	74 34                	je     80102084 <ideintr+0x54>
    release(&idelock);
    // cprintf("spurious IDE interrupt\n");
    return;
  }
  idequeue = b->qnext;
80102050:	8b 43 58             	mov    0x58(%ebx),%eax
80102053:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102058:	8b 33                	mov    (%ebx),%esi
8010205a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102060:	74 3e                	je     801020a0 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102062:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102065:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102068:	83 ce 02             	or     $0x2,%esi
8010206b:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010206d:	53                   	push   %ebx
8010206e:	e8 cd 20 00 00       	call   80104140 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102073:	a1 64 a5 10 80       	mov    0x8010a564,%eax
80102078:	83 c4 10             	add    $0x10,%esp
8010207b:	85 c0                	test   %eax,%eax
8010207d:	74 05                	je     80102084 <ideintr+0x54>
    idestart(idequeue);
8010207f:	e8 4c fe ff ff       	call   80101ed0 <idestart>
    release(&idelock);
80102084:	83 ec 0c             	sub    $0xc,%esp
80102087:	68 80 a5 10 80       	push   $0x8010a580
8010208c:	e8 7f 25 00 00       	call   80104610 <release>

  release(&idelock);
}
80102091:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102094:	5b                   	pop    %ebx
80102095:	5e                   	pop    %esi
80102096:	5f                   	pop    %edi
80102097:	5d                   	pop    %ebp
80102098:	c3                   	ret    
80102099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020a0:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020a5:	8d 76 00             	lea    0x0(%esi),%esi
801020a8:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020a9:	89 c1                	mov    %eax,%ecx
801020ab:	83 e1 c0             	and    $0xffffffc0,%ecx
801020ae:	80 f9 40             	cmp    $0x40,%cl
801020b1:	75 f5                	jne    801020a8 <ideintr+0x78>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020b3:	a8 21                	test   $0x21,%al
801020b5:	75 ab                	jne    80102062 <ideintr+0x32>
    insl(0x1f0, b->data, BSIZE/4);
801020b7:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801020ba:	b9 80 00 00 00       	mov    $0x80,%ecx
801020bf:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020c4:	fc                   	cld    
801020c5:	f3 6d                	rep insl (%dx),%es:(%edi)
801020c7:	8b 33                	mov    (%ebx),%esi
801020c9:	eb 97                	jmp    80102062 <ideintr+0x32>
801020cb:	90                   	nop
801020cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801020d0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801020d0:	55                   	push   %ebp
801020d1:	89 e5                	mov    %esp,%ebp
801020d3:	53                   	push   %ebx
801020d4:	83 ec 10             	sub    $0x10,%esp
801020d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801020da:	8d 43 0c             	lea    0xc(%ebx),%eax
801020dd:	50                   	push   %eax
801020de:	e8 fd 22 00 00       	call   801043e0 <holdingsleep>
801020e3:	83 c4 10             	add    $0x10,%esp
801020e6:	85 c0                	test   %eax,%eax
801020e8:	0f 84 ad 00 00 00    	je     8010219b <iderw+0xcb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801020ee:	8b 03                	mov    (%ebx),%eax
801020f0:	83 e0 06             	and    $0x6,%eax
801020f3:	83 f8 02             	cmp    $0x2,%eax
801020f6:	0f 84 b9 00 00 00    	je     801021b5 <iderw+0xe5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801020fc:	8b 53 04             	mov    0x4(%ebx),%edx
801020ff:	85 d2                	test   %edx,%edx
80102101:	74 0d                	je     80102110 <iderw+0x40>
80102103:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102108:	85 c0                	test   %eax,%eax
8010210a:	0f 84 98 00 00 00    	je     801021a8 <iderw+0xd8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102110:	83 ec 0c             	sub    $0xc,%esp
80102113:	68 80 a5 10 80       	push   $0x8010a580
80102118:	e8 13 23 00 00       	call   80104430 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010211d:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
80102123:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102126:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010212d:	85 d2                	test   %edx,%edx
8010212f:	75 09                	jne    8010213a <iderw+0x6a>
80102131:	eb 58                	jmp    8010218b <iderw+0xbb>
80102133:	90                   	nop
80102134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102138:	89 c2                	mov    %eax,%edx
8010213a:	8b 42 58             	mov    0x58(%edx),%eax
8010213d:	85 c0                	test   %eax,%eax
8010213f:	75 f7                	jne    80102138 <iderw+0x68>
80102141:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102144:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102146:	3b 1d 64 a5 10 80    	cmp    0x8010a564,%ebx
8010214c:	74 44                	je     80102192 <iderw+0xc2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010214e:	8b 03                	mov    (%ebx),%eax
80102150:	83 e0 06             	and    $0x6,%eax
80102153:	83 f8 02             	cmp    $0x2,%eax
80102156:	74 23                	je     8010217b <iderw+0xab>
80102158:	90                   	nop
80102159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102160:	83 ec 08             	sub    $0x8,%esp
80102163:	68 80 a5 10 80       	push   $0x8010a580
80102168:	53                   	push   %ebx
80102169:	e8 22 1e 00 00       	call   80103f90 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010216e:	8b 03                	mov    (%ebx),%eax
80102170:	83 c4 10             	add    $0x10,%esp
80102173:	83 e0 06             	and    $0x6,%eax
80102176:	83 f8 02             	cmp    $0x2,%eax
80102179:	75 e5                	jne    80102160 <iderw+0x90>
  }

  release(&idelock);
8010217b:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
80102182:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102185:	c9                   	leave  
  release(&idelock);
80102186:	e9 85 24 00 00       	jmp    80104610 <release>
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010218b:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
80102190:	eb b2                	jmp    80102144 <iderw+0x74>
    idestart(b);
80102192:	89 d8                	mov    %ebx,%eax
80102194:	e8 37 fd ff ff       	call   80101ed0 <idestart>
80102199:	eb b3                	jmp    8010214e <iderw+0x7e>
    panic("iderw: buf not locked");
8010219b:	83 ec 0c             	sub    $0xc,%esp
8010219e:	68 d6 75 10 80       	push   $0x801075d6
801021a3:	e8 c8 e1 ff ff       	call   80100370 <panic>
    panic("iderw: ide disk 1 not present");
801021a8:	83 ec 0c             	sub    $0xc,%esp
801021ab:	68 01 76 10 80       	push   $0x80107601
801021b0:	e8 bb e1 ff ff       	call   80100370 <panic>
    panic("iderw: nothing to do");
801021b5:	83 ec 0c             	sub    $0xc,%esp
801021b8:	68 ec 75 10 80       	push   $0x801075ec
801021bd:	e8 ae e1 ff ff       	call   80100370 <panic>
801021c2:	66 90                	xchg   %ax,%ax
801021c4:	66 90                	xchg   %ax,%ax
801021c6:	66 90                	xchg   %ax,%ax
801021c8:	66 90                	xchg   %ax,%ax
801021ca:	66 90                	xchg   %ax,%ax
801021cc:	66 90                	xchg   %ax,%ax
801021ce:	66 90                	xchg   %ax,%ax

801021d0 <ioapicinit>:
void
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
801021d0:	a1 84 27 11 80       	mov    0x80112784,%eax
801021d5:	85 c0                	test   %eax,%eax
801021d7:	0f 84 a8 00 00 00    	je     80102285 <ioapicinit+0xb5>
{
801021dd:	55                   	push   %ebp
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
801021de:	c7 05 54 26 11 80 00 	movl   $0xfec00000,0x80112654
801021e5:	00 c0 fe 
{
801021e8:	89 e5                	mov    %esp,%ebp
801021ea:	56                   	push   %esi
801021eb:	53                   	push   %ebx
  ioapic->reg = reg;
801021ec:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801021f3:	00 00 00 
  return ioapic->data;
801021f6:	8b 15 54 26 11 80    	mov    0x80112654,%edx
801021fc:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
801021ff:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102205:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010220b:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102212:	c1 ee 10             	shr    $0x10,%esi
80102215:	89 f0                	mov    %esi,%eax
80102217:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010221a:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
8010221d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102220:	39 d0                	cmp    %edx,%eax
80102222:	74 16                	je     8010223a <ioapicinit+0x6a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102224:	83 ec 0c             	sub    $0xc,%esp
80102227:	68 20 76 10 80       	push   $0x80107620
8010222c:	e8 2f e4 ff ff       	call   80100660 <cprintf>
80102231:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
80102237:	83 c4 10             	add    $0x10,%esp
8010223a:	83 c6 21             	add    $0x21,%esi
{
8010223d:	ba 10 00 00 00       	mov    $0x10,%edx
80102242:	b8 20 00 00 00       	mov    $0x20,%eax
80102247:	89 f6                	mov    %esi,%esi
80102249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
80102250:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102252:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102258:	89 c3                	mov    %eax,%ebx
8010225a:	81 cb 00 00 01 00    	or     $0x10000,%ebx
80102260:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102263:	89 59 10             	mov    %ebx,0x10(%ecx)
80102266:	8d 5a 01             	lea    0x1(%edx),%ebx
80102269:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
8010226c:	39 f0                	cmp    %esi,%eax
  ioapic->reg = reg;
8010226e:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80102270:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
80102276:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010227d:	75 d1                	jne    80102250 <ioapicinit+0x80>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010227f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102282:	5b                   	pop    %ebx
80102283:	5e                   	pop    %esi
80102284:	5d                   	pop    %ebp
80102285:	f3 c3                	repz ret 
80102287:	89 f6                	mov    %esi,%esi
80102289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102290 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
80102290:	8b 15 84 27 11 80    	mov    0x80112784,%edx
{
80102296:	55                   	push   %ebp
80102297:	89 e5                	mov    %esp,%ebp
  if(!ismp)
80102299:	85 d2                	test   %edx,%edx
{
8010229b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!ismp)
8010229e:	74 2b                	je     801022cb <ioapicenable+0x3b>
  ioapic->reg = reg;
801022a0:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801022a6:	8d 50 20             	lea    0x20(%eax),%edx
801022a9:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801022ad:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022af:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022b5:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022b8:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801022be:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022c0:	a1 54 26 11 80       	mov    0x80112654,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022c5:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801022c8:	89 50 10             	mov    %edx,0x10(%eax)
}
801022cb:	5d                   	pop    %ebp
801022cc:	c3                   	ret    
801022cd:	66 90                	xchg   %ax,%ax
801022cf:	90                   	nop

801022d0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801022d0:	55                   	push   %ebp
801022d1:	89 e5                	mov    %esp,%ebp
801022d3:	53                   	push   %ebx
801022d4:	83 ec 04             	sub    $0x4,%esp
801022d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801022da:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801022e0:	75 70                	jne    80102352 <kfree+0x82>
801022e2:	81 fb 28 57 11 80    	cmp    $0x80115728,%ebx
801022e8:	72 68                	jb     80102352 <kfree+0x82>
801022ea:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801022f0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801022f5:	77 5b                	ja     80102352 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801022f7:	83 ec 04             	sub    $0x4,%esp
801022fa:	68 00 10 00 00       	push   $0x1000
801022ff:	6a 01                	push   $0x1
80102301:	53                   	push   %ebx
80102302:	e8 59 23 00 00       	call   80104660 <memset>

  if(kmem.use_lock)
80102307:	8b 15 94 26 11 80    	mov    0x80112694,%edx
8010230d:	83 c4 10             	add    $0x10,%esp
80102310:	85 d2                	test   %edx,%edx
80102312:	75 2c                	jne    80102340 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102314:	a1 98 26 11 80       	mov    0x80112698,%eax
80102319:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010231b:	a1 94 26 11 80       	mov    0x80112694,%eax
  kmem.freelist = r;
80102320:	89 1d 98 26 11 80    	mov    %ebx,0x80112698
  if(kmem.use_lock)
80102326:	85 c0                	test   %eax,%eax
80102328:	75 06                	jne    80102330 <kfree+0x60>
    release(&kmem.lock);
}
8010232a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010232d:	c9                   	leave  
8010232e:	c3                   	ret    
8010232f:	90                   	nop
    release(&kmem.lock);
80102330:	c7 45 08 60 26 11 80 	movl   $0x80112660,0x8(%ebp)
}
80102337:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010233a:	c9                   	leave  
    release(&kmem.lock);
8010233b:	e9 d0 22 00 00       	jmp    80104610 <release>
    acquire(&kmem.lock);
80102340:	83 ec 0c             	sub    $0xc,%esp
80102343:	68 60 26 11 80       	push   $0x80112660
80102348:	e8 e3 20 00 00       	call   80104430 <acquire>
8010234d:	83 c4 10             	add    $0x10,%esp
80102350:	eb c2                	jmp    80102314 <kfree+0x44>
    panic("kfree");
80102352:	83 ec 0c             	sub    $0xc,%esp
80102355:	68 52 76 10 80       	push   $0x80107652
8010235a:	e8 11 e0 ff ff       	call   80100370 <panic>
8010235f:	90                   	nop

80102360 <freerange>:
{
80102360:	55                   	push   %ebp
80102361:	89 e5                	mov    %esp,%ebp
80102363:	56                   	push   %esi
80102364:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102365:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102368:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010236b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102371:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102377:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010237d:	39 de                	cmp    %ebx,%esi
8010237f:	72 23                	jb     801023a4 <freerange+0x44>
80102381:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102388:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010238e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102391:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102397:	50                   	push   %eax
80102398:	e8 33 ff ff ff       	call   801022d0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010239d:	83 c4 10             	add    $0x10,%esp
801023a0:	39 f3                	cmp    %esi,%ebx
801023a2:	76 e4                	jbe    80102388 <freerange+0x28>
}
801023a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023a7:	5b                   	pop    %ebx
801023a8:	5e                   	pop    %esi
801023a9:	5d                   	pop    %ebp
801023aa:	c3                   	ret    
801023ab:	90                   	nop
801023ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801023b0 <kinit1>:
{
801023b0:	55                   	push   %ebp
801023b1:	89 e5                	mov    %esp,%ebp
801023b3:	56                   	push   %esi
801023b4:	53                   	push   %ebx
801023b5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801023b8:	83 ec 08             	sub    $0x8,%esp
801023bb:	68 58 76 10 80       	push   $0x80107658
801023c0:	68 60 26 11 80       	push   $0x80112660
801023c5:	e8 46 20 00 00       	call   80104410 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801023ca:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023cd:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
801023d0:	c7 05 94 26 11 80 00 	movl   $0x0,0x80112694
801023d7:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
801023da:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023e0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023e6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023ec:	39 de                	cmp    %ebx,%esi
801023ee:	72 1c                	jb     8010240c <kinit1+0x5c>
    kfree(p);
801023f0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023f6:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023f9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023ff:	50                   	push   %eax
80102400:	e8 cb fe ff ff       	call   801022d0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102405:	83 c4 10             	add    $0x10,%esp
80102408:	39 de                	cmp    %ebx,%esi
8010240a:	73 e4                	jae    801023f0 <kinit1+0x40>
}
8010240c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010240f:	5b                   	pop    %ebx
80102410:	5e                   	pop    %esi
80102411:	5d                   	pop    %ebp
80102412:	c3                   	ret    
80102413:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102420 <kinit2>:
{
80102420:	55                   	push   %ebp
80102421:	89 e5                	mov    %esp,%ebp
80102423:	56                   	push   %esi
80102424:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102425:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102428:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010242b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102431:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102437:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010243d:	39 de                	cmp    %ebx,%esi
8010243f:	72 23                	jb     80102464 <kinit2+0x44>
80102441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102448:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010244e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102451:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102457:	50                   	push   %eax
80102458:	e8 73 fe ff ff       	call   801022d0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010245d:	83 c4 10             	add    $0x10,%esp
80102460:	39 de                	cmp    %ebx,%esi
80102462:	73 e4                	jae    80102448 <kinit2+0x28>
  kmem.use_lock = 1;
80102464:	c7 05 94 26 11 80 01 	movl   $0x1,0x80112694
8010246b:	00 00 00 
}
8010246e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102471:	5b                   	pop    %ebx
80102472:	5e                   	pop    %esi
80102473:	5d                   	pop    %ebp
80102474:	c3                   	ret    
80102475:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102480 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102480:	55                   	push   %ebp
80102481:	89 e5                	mov    %esp,%ebp
80102483:	53                   	push   %ebx
80102484:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102487:	a1 94 26 11 80       	mov    0x80112694,%eax
8010248c:	85 c0                	test   %eax,%eax
8010248e:	75 30                	jne    801024c0 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102490:	8b 1d 98 26 11 80    	mov    0x80112698,%ebx
  if(r)
80102496:	85 db                	test   %ebx,%ebx
80102498:	74 1c                	je     801024b6 <kalloc+0x36>
    kmem.freelist = r->next;
8010249a:	8b 13                	mov    (%ebx),%edx
8010249c:	89 15 98 26 11 80    	mov    %edx,0x80112698
  if(kmem.use_lock)
801024a2:	85 c0                	test   %eax,%eax
801024a4:	74 10                	je     801024b6 <kalloc+0x36>
    release(&kmem.lock);
801024a6:	83 ec 0c             	sub    $0xc,%esp
801024a9:	68 60 26 11 80       	push   $0x80112660
801024ae:	e8 5d 21 00 00       	call   80104610 <release>
801024b3:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
801024b6:	89 d8                	mov    %ebx,%eax
801024b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024bb:	c9                   	leave  
801024bc:	c3                   	ret    
801024bd:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
801024c0:	83 ec 0c             	sub    $0xc,%esp
801024c3:	68 60 26 11 80       	push   $0x80112660
801024c8:	e8 63 1f 00 00       	call   80104430 <acquire>
  r = kmem.freelist;
801024cd:	8b 1d 98 26 11 80    	mov    0x80112698,%ebx
  if(r)
801024d3:	83 c4 10             	add    $0x10,%esp
801024d6:	a1 94 26 11 80       	mov    0x80112694,%eax
801024db:	85 db                	test   %ebx,%ebx
801024dd:	75 bb                	jne    8010249a <kalloc+0x1a>
801024df:	eb c1                	jmp    801024a2 <kalloc+0x22>
801024e1:	66 90                	xchg   %ax,%ax
801024e3:	66 90                	xchg   %ax,%ax
801024e5:	66 90                	xchg   %ax,%ax
801024e7:	66 90                	xchg   %ax,%ax
801024e9:	66 90                	xchg   %ax,%ax
801024eb:	66 90                	xchg   %ax,%ax
801024ed:	66 90                	xchg   %ax,%ax
801024ef:	90                   	nop

801024f0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024f0:	ba 64 00 00 00       	mov    $0x64,%edx
801024f5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801024f6:	a8 01                	test   $0x1,%al
801024f8:	0f 84 c2 00 00 00    	je     801025c0 <kbdgetc+0xd0>
801024fe:	ba 60 00 00 00       	mov    $0x60,%edx
80102503:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102504:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
80102507:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
8010250d:	0f 84 9d 00 00 00    	je     801025b0 <kbdgetc+0xc0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102513:	84 c0                	test   %al,%al
80102515:	78 59                	js     80102570 <kbdgetc+0x80>
{
80102517:	55                   	push   %ebp
80102518:	89 e5                	mov    %esp,%ebp
8010251a:	53                   	push   %ebx
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
8010251b:	8b 1d b4 a5 10 80    	mov    0x8010a5b4,%ebx
80102521:	f6 c3 40             	test   $0x40,%bl
80102524:	74 09                	je     8010252f <kbdgetc+0x3f>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102526:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102529:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
8010252c:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
8010252f:	0f b6 8a 80 77 10 80 	movzbl -0x7fef8880(%edx),%ecx
  shift ^= togglecode[data];
80102536:	0f b6 82 80 76 10 80 	movzbl -0x7fef8980(%edx),%eax
  shift |= shiftcode[data];
8010253d:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
8010253f:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102541:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102543:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102549:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010254c:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
8010254f:	8b 04 85 60 76 10 80 	mov    -0x7fef89a0(,%eax,4),%eax
80102556:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010255a:	74 0b                	je     80102567 <kbdgetc+0x77>
    if('a' <= c && c <= 'z')
8010255c:	8d 50 9f             	lea    -0x61(%eax),%edx
8010255f:	83 fa 19             	cmp    $0x19,%edx
80102562:	77 3c                	ja     801025a0 <kbdgetc+0xb0>
      c += 'A' - 'a';
80102564:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102567:	5b                   	pop    %ebx
80102568:	5d                   	pop    %ebp
80102569:	c3                   	ret    
8010256a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    data = (shift & E0ESC ? data : data & 0x7F);
80102570:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx
80102576:	83 e0 7f             	and    $0x7f,%eax
80102579:	f6 c1 40             	test   $0x40,%cl
8010257c:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
8010257f:	0f b6 82 80 77 10 80 	movzbl -0x7fef8880(%edx),%eax
80102586:	83 c8 40             	or     $0x40,%eax
80102589:	0f b6 c0             	movzbl %al,%eax
8010258c:	f7 d0                	not    %eax
8010258e:	21 c8                	and    %ecx,%eax
80102590:	a3 b4 a5 10 80       	mov    %eax,0x8010a5b4
    return 0;
80102595:	31 c0                	xor    %eax,%eax
80102597:	c3                   	ret    
80102598:	90                   	nop
80102599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
801025a0:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801025a3:	8d 50 20             	lea    0x20(%eax),%edx
}
801025a6:	5b                   	pop    %ebx
      c += 'a' - 'A';
801025a7:	83 f9 19             	cmp    $0x19,%ecx
801025aa:	0f 46 c2             	cmovbe %edx,%eax
}
801025ad:	5d                   	pop    %ebp
801025ae:	c3                   	ret    
801025af:	90                   	nop
    shift |= E0ESC;
801025b0:	83 0d b4 a5 10 80 40 	orl    $0x40,0x8010a5b4
    return 0;
801025b7:	31 c0                	xor    %eax,%eax
801025b9:	c3                   	ret    
801025ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801025c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801025c5:	c3                   	ret    
801025c6:	8d 76 00             	lea    0x0(%esi),%esi
801025c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025d0 <kbdintr>:

void
kbdintr(void)
{
801025d0:	55                   	push   %ebp
801025d1:	89 e5                	mov    %esp,%ebp
801025d3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801025d6:	68 f0 24 10 80       	push   $0x801024f0
801025db:	e8 00 e2 ff ff       	call   801007e0 <consoleintr>
}
801025e0:	83 c4 10             	add    $0x10,%esp
801025e3:	c9                   	leave  
801025e4:	c3                   	ret    
801025e5:	66 90                	xchg   %ax,%ax
801025e7:	66 90                	xchg   %ax,%ax
801025e9:	66 90                	xchg   %ax,%ax
801025eb:	66 90                	xchg   %ax,%ax
801025ed:	66 90                	xchg   %ax,%ax
801025ef:	90                   	nop

801025f0 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
  if(!lapic)
801025f0:	a1 9c 26 11 80       	mov    0x8011269c,%eax
{
801025f5:	55                   	push   %ebp
801025f6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
801025f8:	85 c0                	test   %eax,%eax
801025fa:	0f 84 c8 00 00 00    	je     801026c8 <lapicinit+0xd8>
  lapic[index] = value;
80102600:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102607:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010260a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010260d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102614:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102617:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010261a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102621:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102624:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102627:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010262e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102631:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102634:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010263b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010263e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102641:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102648:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010264b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010264e:	8b 50 30             	mov    0x30(%eax),%edx
80102651:	c1 ea 10             	shr    $0x10,%edx
80102654:	80 fa 03             	cmp    $0x3,%dl
80102657:	77 77                	ja     801026d0 <lapicinit+0xe0>
  lapic[index] = value;
80102659:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102660:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102663:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102666:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010266d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102670:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102673:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010267a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010267d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102680:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102687:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010268a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010268d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102694:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102697:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010269a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801026a1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801026a4:	8b 50 20             	mov    0x20(%eax),%edx
801026a7:	89 f6                	mov    %esi,%esi
801026a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801026b0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801026b6:	80 e6 10             	and    $0x10,%dh
801026b9:	75 f5                	jne    801026b0 <lapicinit+0xc0>
  lapic[index] = value;
801026bb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801026c2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026c5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801026c8:	5d                   	pop    %ebp
801026c9:	c3                   	ret    
801026ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
801026d0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801026d7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026da:	8b 50 20             	mov    0x20(%eax),%edx
801026dd:	e9 77 ff ff ff       	jmp    80102659 <lapicinit+0x69>
801026e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026f0 <cpunum>:

int
cpunum(void)
{
801026f0:	55                   	push   %ebp
801026f1:	89 e5                	mov    %esp,%ebp
801026f3:	56                   	push   %esi
801026f4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801026f5:	9c                   	pushf  
801026f6:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
801026f7:	f6 c4 02             	test   $0x2,%ah
801026fa:	74 12                	je     8010270e <cpunum+0x1e>
    static int n;
    if(n++ == 0)
801026fc:	a1 b8 a5 10 80       	mov    0x8010a5b8,%eax
80102701:	8d 50 01             	lea    0x1(%eax),%edx
80102704:	85 c0                	test   %eax,%eax
80102706:	89 15 b8 a5 10 80    	mov    %edx,0x8010a5b8
8010270c:	74 4d                	je     8010275b <cpunum+0x6b>
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if (!lapic)
8010270e:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102713:	85 c0                	test   %eax,%eax
80102715:	74 60                	je     80102777 <cpunum+0x87>
    return 0;

  apicid = lapic[ID] >> 24;
80102717:	8b 58 20             	mov    0x20(%eax),%ebx
  for (i = 0; i < ncpu; ++i) {
8010271a:	8b 35 80 2d 11 80    	mov    0x80112d80,%esi
  apicid = lapic[ID] >> 24;
80102720:	c1 eb 18             	shr    $0x18,%ebx
  for (i = 0; i < ncpu; ++i) {
80102723:	85 f6                	test   %esi,%esi
80102725:	7e 59                	jle    80102780 <cpunum+0x90>
    if (cpus[i].apicid == apicid)
80102727:	0f b6 05 a0 27 11 80 	movzbl 0x801127a0,%eax
8010272e:	39 c3                	cmp    %eax,%ebx
80102730:	74 45                	je     80102777 <cpunum+0x87>
80102732:	ba 5c 28 11 80       	mov    $0x8011285c,%edx
80102737:	31 c0                	xor    %eax,%eax
80102739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for (i = 0; i < ncpu; ++i) {
80102740:	83 c0 01             	add    $0x1,%eax
80102743:	39 f0                	cmp    %esi,%eax
80102745:	74 39                	je     80102780 <cpunum+0x90>
    if (cpus[i].apicid == apicid)
80102747:	0f b6 0a             	movzbl (%edx),%ecx
8010274a:	81 c2 bc 00 00 00    	add    $0xbc,%edx
80102750:	39 cb                	cmp    %ecx,%ebx
80102752:	75 ec                	jne    80102740 <cpunum+0x50>
      return i;
  }
  panic("unknown apicid\n");
}
80102754:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102757:	5b                   	pop    %ebx
80102758:	5e                   	pop    %esi
80102759:	5d                   	pop    %ebp
8010275a:	c3                   	ret    
      cprintf("cpu called from %x with interrupts enabled\n",
8010275b:	83 ec 08             	sub    $0x8,%esp
8010275e:	ff 75 04             	pushl  0x4(%ebp)
80102761:	68 80 78 10 80       	push   $0x80107880
80102766:	e8 f5 de ff ff       	call   80100660 <cprintf>
  if (!lapic)
8010276b:	a1 9c 26 11 80       	mov    0x8011269c,%eax
      cprintf("cpu called from %x with interrupts enabled\n",
80102770:	83 c4 10             	add    $0x10,%esp
  if (!lapic)
80102773:	85 c0                	test   %eax,%eax
80102775:	75 a0                	jne    80102717 <cpunum+0x27>
}
80102777:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
8010277a:	31 c0                	xor    %eax,%eax
}
8010277c:	5b                   	pop    %ebx
8010277d:	5e                   	pop    %esi
8010277e:	5d                   	pop    %ebp
8010277f:	c3                   	ret    
  panic("unknown apicid\n");
80102780:	83 ec 0c             	sub    $0xc,%esp
80102783:	68 ac 78 10 80       	push   $0x801078ac
80102788:	e8 e3 db ff ff       	call   80100370 <panic>
8010278d:	8d 76 00             	lea    0x0(%esi),%esi

80102790 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102790:	a1 9c 26 11 80       	mov    0x8011269c,%eax
{
80102795:	55                   	push   %ebp
80102796:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102798:	85 c0                	test   %eax,%eax
8010279a:	74 0d                	je     801027a9 <lapiceoi+0x19>
  lapic[index] = value;
8010279c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801027a3:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027a6:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
801027a9:	5d                   	pop    %ebp
801027aa:	c3                   	ret    
801027ab:	90                   	nop
801027ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801027b0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
801027b0:	55                   	push   %ebp
801027b1:	89 e5                	mov    %esp,%ebp
}
801027b3:	5d                   	pop    %ebp
801027b4:	c3                   	ret    
801027b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027c0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801027c0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027c1:	ba 70 00 00 00       	mov    $0x70,%edx
801027c6:	b8 0f 00 00 00       	mov    $0xf,%eax
801027cb:	89 e5                	mov    %esp,%ebp
801027cd:	53                   	push   %ebx
801027ce:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801027d1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801027d4:	ee                   	out    %al,(%dx)
801027d5:	ba 71 00 00 00       	mov    $0x71,%edx
801027da:	b8 0a 00 00 00       	mov    $0xa,%eax
801027df:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801027e0:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801027e2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
801027e5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801027eb:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801027ed:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
801027f0:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
801027f3:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
801027f5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
801027f8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801027fe:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102803:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102809:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010280c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102813:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102816:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102819:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102820:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102823:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102826:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010282c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010282f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102835:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102838:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010283e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102841:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102847:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010284a:	5b                   	pop    %ebx
8010284b:	5d                   	pop    %ebp
8010284c:	c3                   	ret    
8010284d:	8d 76 00             	lea    0x0(%esi),%esi

80102850 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80102850:	55                   	push   %ebp
80102851:	ba 70 00 00 00       	mov    $0x70,%edx
80102856:	b8 0b 00 00 00       	mov    $0xb,%eax
8010285b:	89 e5                	mov    %esp,%ebp
8010285d:	57                   	push   %edi
8010285e:	56                   	push   %esi
8010285f:	53                   	push   %ebx
80102860:	83 ec 5c             	sub    $0x5c,%esp
80102863:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102864:	ba 71 00 00 00       	mov    $0x71,%edx
80102869:	ec                   	in     (%dx),%al
8010286a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010286d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102872:	88 45 a7             	mov    %al,-0x59(%ebp)
80102875:	8d 76 00             	lea    0x0(%esi),%esi
80102878:	31 c0                	xor    %eax,%eax
8010287a:	89 da                	mov    %ebx,%edx
8010287c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010287d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102882:	89 ca                	mov    %ecx,%edx
80102884:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
80102885:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102888:	89 da                	mov    %ebx,%edx
8010288a:	89 45 b4             	mov    %eax,-0x4c(%ebp)
8010288d:	b8 02 00 00 00       	mov    $0x2,%eax
80102892:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102893:	89 ca                	mov    %ecx,%edx
80102895:	ec                   	in     (%dx),%al
80102896:	0f b6 f0             	movzbl %al,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102899:	89 da                	mov    %ebx,%edx
8010289b:	b8 04 00 00 00       	mov    $0x4,%eax
801028a0:	89 75 b0             	mov    %esi,-0x50(%ebp)
801028a3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028a4:	89 ca                	mov    %ecx,%edx
801028a6:	ec                   	in     (%dx),%al
801028a7:	0f b6 f8             	movzbl %al,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028aa:	89 da                	mov    %ebx,%edx
801028ac:	b8 07 00 00 00       	mov    $0x7,%eax
801028b1:	89 7d ac             	mov    %edi,-0x54(%ebp)
801028b4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028b5:	89 ca                	mov    %ecx,%edx
801028b7:	ec                   	in     (%dx),%al
801028b8:	0f b6 d0             	movzbl %al,%edx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028bb:	b8 08 00 00 00       	mov    $0x8,%eax
801028c0:	89 55 a8             	mov    %edx,-0x58(%ebp)
801028c3:	89 da                	mov    %ebx,%edx
801028c5:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028c6:	89 ca                	mov    %ecx,%edx
801028c8:	ec                   	in     (%dx),%al
801028c9:	0f b6 f8             	movzbl %al,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028cc:	89 da                	mov    %ebx,%edx
801028ce:	b8 09 00 00 00       	mov    $0x9,%eax
801028d3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028d4:	89 ca                	mov    %ecx,%edx
801028d6:	ec                   	in     (%dx),%al
801028d7:	0f b6 f0             	movzbl %al,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028da:	89 da                	mov    %ebx,%edx
801028dc:	b8 0a 00 00 00       	mov    $0xa,%eax
801028e1:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028e2:	89 ca                	mov    %ecx,%edx
801028e4:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801028e5:	84 c0                	test   %al,%al
801028e7:	78 8f                	js     80102878 <cmostime+0x28>
801028e9:	8b 45 b4             	mov    -0x4c(%ebp),%eax
801028ec:	8b 55 a8             	mov    -0x58(%ebp),%edx
801028ef:	89 7d c8             	mov    %edi,-0x38(%ebp)
801028f2:	89 75 cc             	mov    %esi,-0x34(%ebp)
801028f5:	89 45 b8             	mov    %eax,-0x48(%ebp)
801028f8:	8b 45 b0             	mov    -0x50(%ebp),%eax
801028fb:	89 55 c4             	mov    %edx,-0x3c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028fe:	89 da                	mov    %ebx,%edx
80102900:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102903:	8b 45 ac             	mov    -0x54(%ebp),%eax
80102906:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102909:	31 c0                	xor    %eax,%eax
8010290b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010290c:	89 ca                	mov    %ecx,%edx
8010290e:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
8010290f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102912:	89 da                	mov    %ebx,%edx
80102914:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102917:	b8 02 00 00 00       	mov    $0x2,%eax
8010291c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010291d:	89 ca                	mov    %ecx,%edx
8010291f:	ec                   	in     (%dx),%al
80102920:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102923:	89 da                	mov    %ebx,%edx
80102925:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102928:	b8 04 00 00 00       	mov    $0x4,%eax
8010292d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010292e:	89 ca                	mov    %ecx,%edx
80102930:	ec                   	in     (%dx),%al
80102931:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102934:	89 da                	mov    %ebx,%edx
80102936:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102939:	b8 07 00 00 00       	mov    $0x7,%eax
8010293e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010293f:	89 ca                	mov    %ecx,%edx
80102941:	ec                   	in     (%dx),%al
80102942:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102945:	89 da                	mov    %ebx,%edx
80102947:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010294a:	b8 08 00 00 00       	mov    $0x8,%eax
8010294f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102950:	89 ca                	mov    %ecx,%edx
80102952:	ec                   	in     (%dx),%al
80102953:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102956:	89 da                	mov    %ebx,%edx
80102958:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010295b:	b8 09 00 00 00       	mov    $0x9,%eax
80102960:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102961:	89 ca                	mov    %ecx,%edx
80102963:	ec                   	in     (%dx),%al
80102964:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102967:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
8010296a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010296d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102970:	6a 18                	push   $0x18
80102972:	50                   	push   %eax
80102973:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102976:	50                   	push   %eax
80102977:	e8 34 1d 00 00       	call   801046b0 <memcmp>
8010297c:	83 c4 10             	add    $0x10,%esp
8010297f:	85 c0                	test   %eax,%eax
80102981:	0f 85 f1 fe ff ff    	jne    80102878 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102987:	80 7d a7 00          	cmpb   $0x0,-0x59(%ebp)
8010298b:	75 78                	jne    80102a05 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010298d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102990:	89 c2                	mov    %eax,%edx
80102992:	83 e0 0f             	and    $0xf,%eax
80102995:	c1 ea 04             	shr    $0x4,%edx
80102998:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010299b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010299e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
801029a1:	8b 45 bc             	mov    -0x44(%ebp),%eax
801029a4:	89 c2                	mov    %eax,%edx
801029a6:	83 e0 0f             	and    $0xf,%eax
801029a9:	c1 ea 04             	shr    $0x4,%edx
801029ac:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029af:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029b2:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
801029b5:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029b8:	89 c2                	mov    %eax,%edx
801029ba:	83 e0 0f             	and    $0xf,%eax
801029bd:	c1 ea 04             	shr    $0x4,%edx
801029c0:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029c3:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029c6:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
801029c9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029cc:	89 c2                	mov    %eax,%edx
801029ce:	83 e0 0f             	and    $0xf,%eax
801029d1:	c1 ea 04             	shr    $0x4,%edx
801029d4:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029d7:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029da:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
801029dd:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029e0:	89 c2                	mov    %eax,%edx
801029e2:	83 e0 0f             	and    $0xf,%eax
801029e5:	c1 ea 04             	shr    $0x4,%edx
801029e8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029eb:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029ee:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801029f1:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029f4:	89 c2                	mov    %eax,%edx
801029f6:	83 e0 0f             	and    $0xf,%eax
801029f9:	c1 ea 04             	shr    $0x4,%edx
801029fc:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029ff:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a02:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102a05:	8b 75 08             	mov    0x8(%ebp),%esi
80102a08:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a0b:	89 06                	mov    %eax,(%esi)
80102a0d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a10:	89 46 04             	mov    %eax,0x4(%esi)
80102a13:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a16:	89 46 08             	mov    %eax,0x8(%esi)
80102a19:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a1c:	89 46 0c             	mov    %eax,0xc(%esi)
80102a1f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a22:	89 46 10             	mov    %eax,0x10(%esi)
80102a25:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a28:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102a2b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102a32:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a35:	5b                   	pop    %ebx
80102a36:	5e                   	pop    %esi
80102a37:	5f                   	pop    %edi
80102a38:	5d                   	pop    %ebp
80102a39:	c3                   	ret    
80102a3a:	66 90                	xchg   %ax,%ax
80102a3c:	66 90                	xchg   %ax,%ax
80102a3e:	66 90                	xchg   %ax,%ax

80102a40 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a40:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102a46:	85 c9                	test   %ecx,%ecx
80102a48:	0f 8e 85 00 00 00    	jle    80102ad3 <install_trans+0x93>
{
80102a4e:	55                   	push   %ebp
80102a4f:	89 e5                	mov    %esp,%ebp
80102a51:	57                   	push   %edi
80102a52:	56                   	push   %esi
80102a53:	53                   	push   %ebx
80102a54:	31 db                	xor    %ebx,%ebx
80102a56:	83 ec 0c             	sub    $0xc,%esp
80102a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102a60:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102a65:	83 ec 08             	sub    $0x8,%esp
80102a68:	01 d8                	add    %ebx,%eax
80102a6a:	83 c0 01             	add    $0x1,%eax
80102a6d:	50                   	push   %eax
80102a6e:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102a74:	e8 57 d6 ff ff       	call   801000d0 <bread>
80102a79:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a7b:	58                   	pop    %eax
80102a7c:	5a                   	pop    %edx
80102a7d:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80102a84:	ff 35 e4 26 11 80    	pushl  0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102a8a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a8d:	e8 3e d6 ff ff       	call   801000d0 <bread>
80102a92:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a94:	8d 47 5c             	lea    0x5c(%edi),%eax
80102a97:	83 c4 0c             	add    $0xc,%esp
80102a9a:	68 00 02 00 00       	push   $0x200
80102a9f:	50                   	push   %eax
80102aa0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102aa3:	50                   	push   %eax
80102aa4:	e8 67 1c 00 00       	call   80104710 <memmove>
    bwrite(dbuf);  // write dst to disk
80102aa9:	89 34 24             	mov    %esi,(%esp)
80102aac:	e8 ef d6 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102ab1:	89 3c 24             	mov    %edi,(%esp)
80102ab4:	e8 27 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102ab9:	89 34 24             	mov    %esi,(%esp)
80102abc:	e8 1f d7 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102ac1:	83 c4 10             	add    $0x10,%esp
80102ac4:	39 1d e8 26 11 80    	cmp    %ebx,0x801126e8
80102aca:	7f 94                	jg     80102a60 <install_trans+0x20>
  }
}
80102acc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102acf:	5b                   	pop    %ebx
80102ad0:	5e                   	pop    %esi
80102ad1:	5f                   	pop    %edi
80102ad2:	5d                   	pop    %ebp
80102ad3:	f3 c3                	repz ret 
80102ad5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ae0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102ae0:	55                   	push   %ebp
80102ae1:	89 e5                	mov    %esp,%ebp
80102ae3:	53                   	push   %ebx
80102ae4:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ae7:	ff 35 d4 26 11 80    	pushl  0x801126d4
80102aed:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102af3:	e8 d8 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102af8:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102afe:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102b01:	89 c3                	mov    %eax,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b03:	85 c9                	test   %ecx,%ecx
  hb->n = log.lh.n;
80102b05:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102b08:	7e 1f                	jle    80102b29 <write_head+0x49>
80102b0a:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102b11:	31 d2                	xor    %edx,%edx
80102b13:	90                   	nop
80102b14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102b18:	8b 8a ec 26 11 80    	mov    -0x7feed914(%edx),%ecx
80102b1e:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102b22:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102b25:	39 c2                	cmp    %eax,%edx
80102b27:	75 ef                	jne    80102b18 <write_head+0x38>
  }
  bwrite(buf);
80102b29:	83 ec 0c             	sub    $0xc,%esp
80102b2c:	53                   	push   %ebx
80102b2d:	e8 6e d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102b32:	89 1c 24             	mov    %ebx,(%esp)
80102b35:	e8 a6 d6 ff ff       	call   801001e0 <brelse>
}
80102b3a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b3d:	c9                   	leave  
80102b3e:	c3                   	ret    
80102b3f:	90                   	nop

80102b40 <initlog>:
{
80102b40:	55                   	push   %ebp
80102b41:	89 e5                	mov    %esp,%ebp
80102b43:	53                   	push   %ebx
80102b44:	83 ec 2c             	sub    $0x2c,%esp
80102b47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102b4a:	68 bc 78 10 80       	push   $0x801078bc
80102b4f:	68 a0 26 11 80       	push   $0x801126a0
80102b54:	e8 b7 18 00 00       	call   80104410 <initlock>
  readsb(dev, &sb);
80102b59:	58                   	pop    %eax
80102b5a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102b5d:	5a                   	pop    %edx
80102b5e:	50                   	push   %eax
80102b5f:	53                   	push   %ebx
80102b60:	e8 3b e8 ff ff       	call   801013a0 <readsb>
  log.size = sb.nlog;
80102b65:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102b68:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102b6b:	59                   	pop    %ecx
  log.dev = dev;
80102b6c:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4
  log.size = sb.nlog;
80102b72:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
  log.start = sb.logstart;
80102b78:	a3 d4 26 11 80       	mov    %eax,0x801126d4
  struct buf *buf = bread(log.dev, log.start);
80102b7d:	5a                   	pop    %edx
80102b7e:	50                   	push   %eax
80102b7f:	53                   	push   %ebx
80102b80:	e8 4b d5 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102b85:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102b88:	83 c4 10             	add    $0x10,%esp
80102b8b:	85 c9                	test   %ecx,%ecx
  log.lh.n = lh->n;
80102b8d:	89 0d e8 26 11 80    	mov    %ecx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102b93:	7e 1c                	jle    80102bb1 <initlog+0x71>
80102b95:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102b9c:	31 d2                	xor    %edx,%edx
80102b9e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102ba0:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102ba4:	83 c2 04             	add    $0x4,%edx
80102ba7:	89 8a e8 26 11 80    	mov    %ecx,-0x7feed918(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102bad:	39 da                	cmp    %ebx,%edx
80102baf:	75 ef                	jne    80102ba0 <initlog+0x60>
  brelse(buf);
80102bb1:	83 ec 0c             	sub    $0xc,%esp
80102bb4:	50                   	push   %eax
80102bb5:	e8 26 d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102bba:	e8 81 fe ff ff       	call   80102a40 <install_trans>
  log.lh.n = 0;
80102bbf:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102bc6:	00 00 00 
  write_head(); // clear the log
80102bc9:	e8 12 ff ff ff       	call   80102ae0 <write_head>
}
80102bce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bd1:	c9                   	leave  
80102bd2:	c3                   	ret    
80102bd3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102be0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102be0:	55                   	push   %ebp
80102be1:	89 e5                	mov    %esp,%ebp
80102be3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102be6:	68 a0 26 11 80       	push   $0x801126a0
80102beb:	e8 40 18 00 00       	call   80104430 <acquire>
80102bf0:	83 c4 10             	add    $0x10,%esp
80102bf3:	eb 18                	jmp    80102c0d <begin_op+0x2d>
80102bf5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102bf8:	83 ec 08             	sub    $0x8,%esp
80102bfb:	68 a0 26 11 80       	push   $0x801126a0
80102c00:	68 a0 26 11 80       	push   $0x801126a0
80102c05:	e8 86 13 00 00       	call   80103f90 <sleep>
80102c0a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102c0d:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102c12:	85 c0                	test   %eax,%eax
80102c14:	75 e2                	jne    80102bf8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102c16:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102c1b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102c21:	83 c0 01             	add    $0x1,%eax
80102c24:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102c27:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102c2a:	83 fa 1e             	cmp    $0x1e,%edx
80102c2d:	7f c9                	jg     80102bf8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102c2f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102c32:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80102c37:	68 a0 26 11 80       	push   $0x801126a0
80102c3c:	e8 cf 19 00 00       	call   80104610 <release>
      break;
    }
  }
}
80102c41:	83 c4 10             	add    $0x10,%esp
80102c44:	c9                   	leave  
80102c45:	c3                   	ret    
80102c46:	8d 76 00             	lea    0x0(%esi),%esi
80102c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c50 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102c50:	55                   	push   %ebp
80102c51:	89 e5                	mov    %esp,%ebp
80102c53:	57                   	push   %edi
80102c54:	56                   	push   %esi
80102c55:	53                   	push   %ebx
80102c56:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102c59:	68 a0 26 11 80       	push   $0x801126a0
80102c5e:	e8 cd 17 00 00       	call   80104430 <acquire>
  log.outstanding -= 1;
80102c63:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102c68:	8b 35 e0 26 11 80    	mov    0x801126e0,%esi
80102c6e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102c71:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102c74:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102c76:	89 1d dc 26 11 80    	mov    %ebx,0x801126dc
  if(log.committing)
80102c7c:	0f 85 22 01 00 00    	jne    80102da4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102c82:	85 db                	test   %ebx,%ebx
80102c84:	0f 85 f6 00 00 00    	jne    80102d80 <end_op+0x130>
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
  }
  release(&log.lock);
80102c8a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102c8d:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102c94:	00 00 00 
  release(&log.lock);
80102c97:	68 a0 26 11 80       	push   $0x801126a0
80102c9c:	e8 6f 19 00 00       	call   80104610 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102ca1:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102ca7:	83 c4 10             	add    $0x10,%esp
80102caa:	85 c9                	test   %ecx,%ecx
80102cac:	0f 8e 8b 00 00 00    	jle    80102d3d <end_op+0xed>
80102cb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102cb8:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102cbd:	83 ec 08             	sub    $0x8,%esp
80102cc0:	01 d8                	add    %ebx,%eax
80102cc2:	83 c0 01             	add    $0x1,%eax
80102cc5:	50                   	push   %eax
80102cc6:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102ccc:	e8 ff d3 ff ff       	call   801000d0 <bread>
80102cd1:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102cd3:	58                   	pop    %eax
80102cd4:	5a                   	pop    %edx
80102cd5:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80102cdc:	ff 35 e4 26 11 80    	pushl  0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102ce2:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102ce5:	e8 e6 d3 ff ff       	call   801000d0 <bread>
80102cea:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102cec:	8d 40 5c             	lea    0x5c(%eax),%eax
80102cef:	83 c4 0c             	add    $0xc,%esp
80102cf2:	68 00 02 00 00       	push   $0x200
80102cf7:	50                   	push   %eax
80102cf8:	8d 46 5c             	lea    0x5c(%esi),%eax
80102cfb:	50                   	push   %eax
80102cfc:	e8 0f 1a 00 00       	call   80104710 <memmove>
    bwrite(to);  // write the log
80102d01:	89 34 24             	mov    %esi,(%esp)
80102d04:	e8 97 d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102d09:	89 3c 24             	mov    %edi,(%esp)
80102d0c:	e8 cf d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102d11:	89 34 24             	mov    %esi,(%esp)
80102d14:	e8 c7 d4 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102d19:	83 c4 10             	add    $0x10,%esp
80102d1c:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102d22:	7c 94                	jl     80102cb8 <end_op+0x68>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102d24:	e8 b7 fd ff ff       	call   80102ae0 <write_head>
    install_trans(); // Now install writes to home locations
80102d29:	e8 12 fd ff ff       	call   80102a40 <install_trans>
    log.lh.n = 0;
80102d2e:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102d35:	00 00 00 
    write_head();    // Erase the transaction from the log
80102d38:	e8 a3 fd ff ff       	call   80102ae0 <write_head>
    acquire(&log.lock);
80102d3d:	83 ec 0c             	sub    $0xc,%esp
80102d40:	68 a0 26 11 80       	push   $0x801126a0
80102d45:	e8 e6 16 00 00       	call   80104430 <acquire>
    wakeup(&log);
80102d4a:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
    log.committing = 0;
80102d51:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102d58:	00 00 00 
    wakeup(&log);
80102d5b:	e8 e0 13 00 00       	call   80104140 <wakeup>
    release(&log.lock);
80102d60:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102d67:	e8 a4 18 00 00       	call   80104610 <release>
80102d6c:	83 c4 10             	add    $0x10,%esp
}
80102d6f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d72:	5b                   	pop    %ebx
80102d73:	5e                   	pop    %esi
80102d74:	5f                   	pop    %edi
80102d75:	5d                   	pop    %ebp
80102d76:	c3                   	ret    
80102d77:	89 f6                	mov    %esi,%esi
80102d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    wakeup(&log);
80102d80:	83 ec 0c             	sub    $0xc,%esp
80102d83:	68 a0 26 11 80       	push   $0x801126a0
80102d88:	e8 b3 13 00 00       	call   80104140 <wakeup>
  release(&log.lock);
80102d8d:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102d94:	e8 77 18 00 00       	call   80104610 <release>
80102d99:	83 c4 10             	add    $0x10,%esp
}
80102d9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d9f:	5b                   	pop    %ebx
80102da0:	5e                   	pop    %esi
80102da1:	5f                   	pop    %edi
80102da2:	5d                   	pop    %ebp
80102da3:	c3                   	ret    
    panic("log.committing");
80102da4:	83 ec 0c             	sub    $0xc,%esp
80102da7:	68 c0 78 10 80       	push   $0x801078c0
80102dac:	e8 bf d5 ff ff       	call   80100370 <panic>
80102db1:	eb 0d                	jmp    80102dc0 <log_write>
80102db3:	90                   	nop
80102db4:	90                   	nop
80102db5:	90                   	nop
80102db6:	90                   	nop
80102db7:	90                   	nop
80102db8:	90                   	nop
80102db9:	90                   	nop
80102dba:	90                   	nop
80102dbb:	90                   	nop
80102dbc:	90                   	nop
80102dbd:	90                   	nop
80102dbe:	90                   	nop
80102dbf:	90                   	nop

80102dc0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102dc0:	55                   	push   %ebp
80102dc1:	89 e5                	mov    %esp,%ebp
80102dc3:	53                   	push   %ebx
80102dc4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102dc7:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
{
80102dcd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102dd0:	83 fa 1d             	cmp    $0x1d,%edx
80102dd3:	0f 8f 97 00 00 00    	jg     80102e70 <log_write+0xb0>
80102dd9:	a1 d8 26 11 80       	mov    0x801126d8,%eax
80102dde:	83 e8 01             	sub    $0x1,%eax
80102de1:	39 c2                	cmp    %eax,%edx
80102de3:	0f 8d 87 00 00 00    	jge    80102e70 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102de9:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102dee:	85 c0                	test   %eax,%eax
80102df0:	0f 8e 87 00 00 00    	jle    80102e7d <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102df6:	83 ec 0c             	sub    $0xc,%esp
80102df9:	68 a0 26 11 80       	push   $0x801126a0
80102dfe:	e8 2d 16 00 00       	call   80104430 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102e03:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102e09:	83 c4 10             	add    $0x10,%esp
80102e0c:	83 f9 00             	cmp    $0x0,%ecx
80102e0f:	7e 50                	jle    80102e61 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e11:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102e14:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e16:	3b 15 ec 26 11 80    	cmp    0x801126ec,%edx
80102e1c:	75 0b                	jne    80102e29 <log_write+0x69>
80102e1e:	eb 38                	jmp    80102e58 <log_write+0x98>
80102e20:	39 14 85 ec 26 11 80 	cmp    %edx,-0x7feed914(,%eax,4)
80102e27:	74 2f                	je     80102e58 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102e29:	83 c0 01             	add    $0x1,%eax
80102e2c:	39 c8                	cmp    %ecx,%eax
80102e2e:	75 f0                	jne    80102e20 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102e30:	89 14 85 ec 26 11 80 	mov    %edx,-0x7feed914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102e37:	83 c0 01             	add    $0x1,%eax
80102e3a:	a3 e8 26 11 80       	mov    %eax,0x801126e8
  b->flags |= B_DIRTY; // prevent eviction
80102e3f:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102e42:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80102e49:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e4c:	c9                   	leave  
  release(&log.lock);
80102e4d:	e9 be 17 00 00       	jmp    80104610 <release>
80102e52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102e58:	89 14 85 ec 26 11 80 	mov    %edx,-0x7feed914(,%eax,4)
80102e5f:	eb de                	jmp    80102e3f <log_write+0x7f>
80102e61:	8b 43 08             	mov    0x8(%ebx),%eax
80102e64:	a3 ec 26 11 80       	mov    %eax,0x801126ec
  if (i == log.lh.n)
80102e69:	75 d4                	jne    80102e3f <log_write+0x7f>
80102e6b:	31 c0                	xor    %eax,%eax
80102e6d:	eb c8                	jmp    80102e37 <log_write+0x77>
80102e6f:	90                   	nop
    panic("too big a transaction");
80102e70:	83 ec 0c             	sub    $0xc,%esp
80102e73:	68 cf 78 10 80       	push   $0x801078cf
80102e78:	e8 f3 d4 ff ff       	call   80100370 <panic>
    panic("log_write outside of trans");
80102e7d:	83 ec 0c             	sub    $0xc,%esp
80102e80:	68 e5 78 10 80       	push   $0x801078e5
80102e85:	e8 e6 d4 ff ff       	call   80100370 <panic>
80102e8a:	66 90                	xchg   %ax,%ax
80102e8c:	66 90                	xchg   %ax,%ax
80102e8e:	66 90                	xchg   %ax,%ax

80102e90 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102e90:	55                   	push   %ebp
80102e91:	89 e5                	mov    %esp,%ebp
80102e93:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpunum());
80102e96:	e8 55 f8 ff ff       	call   801026f0 <cpunum>
80102e9b:	83 ec 08             	sub    $0x8,%esp
80102e9e:	50                   	push   %eax
80102e9f:	68 00 79 10 80       	push   $0x80107900
80102ea4:	e8 b7 d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102ea9:	e8 b2 2d 00 00       	call   80105c60 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80102eae:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102eb5:	b8 01 00 00 00       	mov    $0x1,%eax
80102eba:	f0 87 82 a8 00 00 00 	lock xchg %eax,0xa8(%edx)
  scheduler();     // start running processes
80102ec1:	e8 7a 0d 00 00       	call   80103c40 <scheduler>
80102ec6:	8d 76 00             	lea    0x0(%esi),%esi
80102ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ed0 <mpenter>:
{
80102ed0:	55                   	push   %ebp
80102ed1:	89 e5                	mov    %esp,%ebp
80102ed3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102ed6:	e8 95 3f 00 00       	call   80106e70 <switchkvm>
  seginit();
80102edb:	e8 b0 3d 00 00       	call   80106c90 <seginit>
  lapicinit();
80102ee0:	e8 0b f7 ff ff       	call   801025f0 <lapicinit>
  mpmain();
80102ee5:	e8 a6 ff ff ff       	call   80102e90 <mpmain>
80102eea:	66 90                	xchg   %ax,%ax
80102eec:	66 90                	xchg   %ax,%ax
80102eee:	66 90                	xchg   %ax,%ax

80102ef0 <main>:
{
80102ef0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102ef4:	83 e4 f0             	and    $0xfffffff0,%esp
80102ef7:	ff 71 fc             	pushl  -0x4(%ecx)
80102efa:	55                   	push   %ebp
80102efb:	89 e5                	mov    %esp,%ebp
80102efd:	53                   	push   %ebx
80102efe:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102eff:	83 ec 08             	sub    $0x8,%esp
80102f02:	68 00 00 40 80       	push   $0x80400000
80102f07:	68 28 57 11 80       	push   $0x80115728
80102f0c:	e8 9f f4 ff ff       	call   801023b0 <kinit1>
  kvmalloc();      // kernel page table
80102f11:	e8 3a 3f 00 00       	call   80106e50 <kvmalloc>
  mpinit();        // detect other processors
80102f16:	e8 a5 01 00 00       	call   801030c0 <mpinit>
  lapicinit();     // interrupt controller
80102f1b:	e8 d0 f6 ff ff       	call   801025f0 <lapicinit>
  seginit();       // segment descriptors
80102f20:	e8 6b 3d 00 00       	call   80106c90 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpunum());
80102f25:	e8 c6 f7 ff ff       	call   801026f0 <cpunum>
80102f2a:	5a                   	pop    %edx
80102f2b:	59                   	pop    %ecx
80102f2c:	50                   	push   %eax
80102f2d:	68 11 79 10 80       	push   $0x80107911
80102f32:	e8 29 d7 ff ff       	call   80100660 <cprintf>
  picinit();       // another interrupt controller
80102f37:	e8 94 03 00 00       	call   801032d0 <picinit>
  ioapicinit();    // another interrupt controller
80102f3c:	e8 8f f2 ff ff       	call   801021d0 <ioapicinit>
  consoleinit();   // console hardware
80102f41:	e8 4a da ff ff       	call   80100990 <consoleinit>
  uartinit();      // serial port
80102f46:	e8 15 30 00 00       	call   80105f60 <uartinit>
  pinit();         // process table
80102f4b:	e8 30 09 00 00       	call   80103880 <pinit>
  tvinit();        // trap vectors
80102f50:	e8 6b 2c 00 00       	call   80105bc0 <tvinit>
  binit();         // buffer cache
80102f55:	e8 e6 d0 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102f5a:	e8 d1 dd ff ff       	call   80100d30 <fileinit>
  ideinit();       // disk
80102f5f:	e8 3c f0 ff ff       	call   80101fa0 <ideinit>
  if(!ismp)
80102f64:	8b 1d 84 27 11 80    	mov    0x80112784,%ebx
80102f6a:	83 c4 10             	add    $0x10,%esp
80102f6d:	85 db                	test   %ebx,%ebx
80102f6f:	0f 84 ca 00 00 00    	je     8010303f <main+0x14f>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f75:	83 ec 04             	sub    $0x4,%esp

  for(c = cpus; c < cpus+ncpu; c++){
80102f78:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f7d:	68 8a 00 00 00       	push   $0x8a
80102f82:	68 8c a4 10 80       	push   $0x8010a48c
80102f87:	68 00 70 00 80       	push   $0x80007000
80102f8c:	e8 7f 17 00 00       	call   80104710 <memmove>
  for(c = cpus; c < cpus+ncpu; c++){
80102f91:	69 05 80 2d 11 80 bc 	imul   $0xbc,0x80112d80,%eax
80102f98:	00 00 00 
80102f9b:	83 c4 10             	add    $0x10,%esp
80102f9e:	05 a0 27 11 80       	add    $0x801127a0,%eax
80102fa3:	39 d8                	cmp    %ebx,%eax
80102fa5:	76 7c                	jbe    80103023 <main+0x133>
80102fa7:	89 f6                	mov    %esi,%esi
80102fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == cpus+cpunum())  // We've started already.
80102fb0:	e8 3b f7 ff ff       	call   801026f0 <cpunum>
80102fb5:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80102fbb:	05 a0 27 11 80       	add    $0x801127a0,%eax
80102fc0:	39 c3                	cmp    %eax,%ebx
80102fc2:	74 46                	je     8010300a <main+0x11a>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102fc4:	e8 b7 f4 ff ff       	call   80102480 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80102fc9:	83 ec 08             	sub    $0x8,%esp
    *(void**)(code-4) = stack + KSTACKSIZE;
80102fcc:	05 00 10 00 00       	add    $0x1000,%eax
    *(void**)(code-8) = mpenter;
80102fd1:	c7 05 f8 6f 00 80 d0 	movl   $0x80102ed0,0x80006ff8
80102fd8:	2e 10 80 
    *(void**)(code-4) = stack + KSTACKSIZE;
80102fdb:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102fe0:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102fe7:	90 10 00 
    lapicstartap(c->apicid, V2P(code));
80102fea:	68 00 70 00 00       	push   $0x7000
80102fef:	0f b6 03             	movzbl (%ebx),%eax
80102ff2:	50                   	push   %eax
80102ff3:	e8 c8 f7 ff ff       	call   801027c0 <lapicstartap>
80102ff8:	83 c4 10             	add    $0x10,%esp
80102ffb:	90                   	nop
80102ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103000:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
80103006:	85 c0                	test   %eax,%eax
80103008:	74 f6                	je     80103000 <main+0x110>
  for(c = cpus; c < cpus+ncpu; c++){
8010300a:	69 05 80 2d 11 80 bc 	imul   $0xbc,0x80112d80,%eax
80103011:	00 00 00 
80103014:	81 c3 bc 00 00 00    	add    $0xbc,%ebx
8010301a:	05 a0 27 11 80       	add    $0x801127a0,%eax
8010301f:	39 c3                	cmp    %eax,%ebx
80103021:	72 8d                	jb     80102fb0 <main+0xc0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103023:	83 ec 08             	sub    $0x8,%esp
80103026:	68 00 00 00 8e       	push   $0x8e000000
8010302b:	68 00 00 40 80       	push   $0x80400000
80103030:	e8 eb f3 ff ff       	call   80102420 <kinit2>
  userinit();      // first user process
80103035:	e8 66 08 00 00       	call   801038a0 <userinit>
  mpmain();        // finish this processor's setup
8010303a:	e8 51 fe ff ff       	call   80102e90 <mpmain>
    timerinit();   // uniprocessor timer
8010303f:	e8 1c 2b 00 00       	call   80105b60 <timerinit>
80103044:	e9 2c ff ff ff       	jmp    80102f75 <main+0x85>
80103049:	66 90                	xchg   %ax,%ax
8010304b:	66 90                	xchg   %ax,%ax
8010304d:	66 90                	xchg   %ax,%ax
8010304f:	90                   	nop

80103050 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103050:	55                   	push   %ebp
80103051:	89 e5                	mov    %esp,%ebp
80103053:	57                   	push   %edi
80103054:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103055:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010305b:	53                   	push   %ebx
  e = addr+len;
8010305c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010305f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103062:	39 de                	cmp    %ebx,%esi
80103064:	73 40                	jae    801030a6 <mpsearch1+0x56>
80103066:	8d 76 00             	lea    0x0(%esi),%esi
80103069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103070:	83 ec 04             	sub    $0x4,%esp
80103073:	8d 7e 10             	lea    0x10(%esi),%edi
80103076:	6a 04                	push   $0x4
80103078:	68 28 79 10 80       	push   $0x80107928
8010307d:	56                   	push   %esi
8010307e:	e8 2d 16 00 00       	call   801046b0 <memcmp>
80103083:	83 c4 10             	add    $0x10,%esp
80103086:	85 c0                	test   %eax,%eax
80103088:	75 16                	jne    801030a0 <mpsearch1+0x50>
8010308a:	8d 7e 10             	lea    0x10(%esi),%edi
8010308d:	89 f2                	mov    %esi,%edx
8010308f:	90                   	nop
    sum += addr[i];
80103090:	0f b6 0a             	movzbl (%edx),%ecx
80103093:	83 c2 01             	add    $0x1,%edx
80103096:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103098:	39 fa                	cmp    %edi,%edx
8010309a:	75 f4                	jne    80103090 <mpsearch1+0x40>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010309c:	84 c0                	test   %al,%al
8010309e:	74 10                	je     801030b0 <mpsearch1+0x60>
  for(p = addr; p < e; p += sizeof(struct mp))
801030a0:	39 fb                	cmp    %edi,%ebx
801030a2:	89 fe                	mov    %edi,%esi
801030a4:	77 ca                	ja     80103070 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801030a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801030a9:	31 c0                	xor    %eax,%eax
}
801030ab:	5b                   	pop    %ebx
801030ac:	5e                   	pop    %esi
801030ad:	5f                   	pop    %edi
801030ae:	5d                   	pop    %ebp
801030af:	c3                   	ret    
801030b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030b3:	89 f0                	mov    %esi,%eax
801030b5:	5b                   	pop    %ebx
801030b6:	5e                   	pop    %esi
801030b7:	5f                   	pop    %edi
801030b8:	5d                   	pop    %ebp
801030b9:	c3                   	ret    
801030ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801030c0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801030c0:	55                   	push   %ebp
801030c1:	89 e5                	mov    %esp,%ebp
801030c3:	57                   	push   %edi
801030c4:	56                   	push   %esi
801030c5:	53                   	push   %ebx
801030c6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801030c9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801030d0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801030d7:	c1 e0 08             	shl    $0x8,%eax
801030da:	09 d0                	or     %edx,%eax
801030dc:	c1 e0 04             	shl    $0x4,%eax
801030df:	85 c0                	test   %eax,%eax
801030e1:	75 1b                	jne    801030fe <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801030e3:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801030ea:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801030f1:	c1 e0 08             	shl    $0x8,%eax
801030f4:	09 d0                	or     %edx,%eax
801030f6:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801030f9:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801030fe:	ba 00 04 00 00       	mov    $0x400,%edx
80103103:	e8 48 ff ff ff       	call   80103050 <mpsearch1>
80103108:	85 c0                	test   %eax,%eax
8010310a:	89 c6                	mov    %eax,%esi
8010310c:	0f 84 66 01 00 00    	je     80103278 <mpinit+0x1b8>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103112:	8b 5e 04             	mov    0x4(%esi),%ebx
80103115:	85 db                	test   %ebx,%ebx
80103117:	0f 84 d6 00 00 00    	je     801031f3 <mpinit+0x133>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010311d:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103123:	83 ec 04             	sub    $0x4,%esp
80103126:	6a 04                	push   $0x4
80103128:	68 2d 79 10 80       	push   $0x8010792d
8010312d:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010312e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103131:	e8 7a 15 00 00       	call   801046b0 <memcmp>
80103136:	83 c4 10             	add    $0x10,%esp
80103139:	85 c0                	test   %eax,%eax
8010313b:	0f 85 b2 00 00 00    	jne    801031f3 <mpinit+0x133>
  if(conf->version != 1 && conf->version != 4)
80103141:	0f b6 93 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%edx
80103148:	80 fa 01             	cmp    $0x1,%dl
8010314b:	74 09                	je     80103156 <mpinit+0x96>
8010314d:	80 fa 04             	cmp    $0x4,%dl
80103150:	0f 85 9d 00 00 00    	jne    801031f3 <mpinit+0x133>
  if(sum((uchar*)conf, conf->length) != 0)
80103156:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
8010315d:	85 ff                	test   %edi,%edi
8010315f:	74 1c                	je     8010317d <mpinit+0xbd>
80103161:	31 d2                	xor    %edx,%edx
80103163:	90                   	nop
80103164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103168:	0f b6 8c 13 00 00 00 	movzbl -0x80000000(%ebx,%edx,1),%ecx
8010316f:	80 
  for(i=0; i<len; i++)
80103170:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103173:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103175:	39 d7                	cmp    %edx,%edi
80103177:	75 ef                	jne    80103168 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103179:	84 c0                	test   %al,%al
8010317b:	75 76                	jne    801031f3 <mpinit+0x133>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
8010317d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103180:	85 ff                	test   %edi,%edi
80103182:	74 6f                	je     801031f3 <mpinit+0x133>
    return;
  ismp = 1;
80103184:	c7 05 84 27 11 80 01 	movl   $0x1,0x80112784
8010318b:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
8010318e:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103194:	a3 9c 26 11 80       	mov    %eax,0x8011269c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103199:	0f b7 8b 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%ecx
801031a0:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
801031a6:	01 f9                	add    %edi,%ecx
801031a8:	39 c8                	cmp    %ecx,%eax
801031aa:	0f 83 a0 00 00 00    	jae    80103250 <mpinit+0x190>
    switch(*p){
801031b0:	80 38 04             	cmpb   $0x4,(%eax)
801031b3:	0f 87 87 00 00 00    	ja     80103240 <mpinit+0x180>
801031b9:	0f b6 10             	movzbl (%eax),%edx
801031bc:	ff 24 95 34 79 10 80 	jmp    *-0x7fef86cc(,%edx,4)
801031c3:	90                   	nop
801031c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801031c8:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031cb:	39 c1                	cmp    %eax,%ecx
801031cd:	77 e1                	ja     801031b0 <mpinit+0xf0>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp){
801031cf:	a1 84 27 11 80       	mov    0x80112784,%eax
801031d4:	85 c0                	test   %eax,%eax
801031d6:	75 78                	jne    80103250 <mpinit+0x190>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
801031d8:	c7 05 80 2d 11 80 01 	movl   $0x1,0x80112d80
801031df:	00 00 00 
    lapic = 0;
801031e2:	c7 05 9c 26 11 80 00 	movl   $0x0,0x8011269c
801031e9:	00 00 00 
    ioapicid = 0;
801031ec:	c6 05 80 27 11 80 00 	movb   $0x0,0x80112780
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
801031f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031f6:	5b                   	pop    %ebx
801031f7:	5e                   	pop    %esi
801031f8:	5f                   	pop    %edi
801031f9:	5d                   	pop    %ebp
801031fa:	c3                   	ret    
801031fb:	90                   	nop
801031fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
80103200:	8b 15 80 2d 11 80    	mov    0x80112d80,%edx
80103206:	83 fa 07             	cmp    $0x7,%edx
80103209:	7f 19                	jg     80103224 <mpinit+0x164>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010320b:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
8010320f:	69 fa bc 00 00 00    	imul   $0xbc,%edx,%edi
        ncpu++;
80103215:	83 c2 01             	add    $0x1,%edx
80103218:	89 15 80 2d 11 80    	mov    %edx,0x80112d80
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010321e:	88 9f a0 27 11 80    	mov    %bl,-0x7feed860(%edi)
      p += sizeof(struct mpproc);
80103224:	83 c0 14             	add    $0x14,%eax
      continue;
80103227:	eb a2                	jmp    801031cb <mpinit+0x10b>
80103229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103230:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
80103234:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103237:	88 15 80 27 11 80    	mov    %dl,0x80112780
      continue;
8010323d:	eb 8c                	jmp    801031cb <mpinit+0x10b>
8010323f:	90                   	nop
      ismp = 0;
80103240:	c7 05 84 27 11 80 00 	movl   $0x0,0x80112784
80103247:	00 00 00 
      break;
8010324a:	e9 7c ff ff ff       	jmp    801031cb <mpinit+0x10b>
8010324f:	90                   	nop
  if(mp->imcrp){
80103250:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
80103254:	74 9d                	je     801031f3 <mpinit+0x133>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103256:	ba 22 00 00 00       	mov    $0x22,%edx
8010325b:	b8 70 00 00 00       	mov    $0x70,%eax
80103260:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103261:	ba 23 00 00 00       	mov    $0x23,%edx
80103266:	ec                   	in     (%dx),%al
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103267:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010326a:	ee                   	out    %al,(%dx)
}
8010326b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010326e:	5b                   	pop    %ebx
8010326f:	5e                   	pop    %esi
80103270:	5f                   	pop    %edi
80103271:	5d                   	pop    %ebp
80103272:	c3                   	ret    
80103273:	90                   	nop
80103274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return mpsearch1(0xF0000, 0x10000);
80103278:	ba 00 00 01 00       	mov    $0x10000,%edx
8010327d:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80103282:	e8 c9 fd ff ff       	call   80103050 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103287:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
80103289:	89 c6                	mov    %eax,%esi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010328b:	0f 85 81 fe ff ff    	jne    80103112 <mpinit+0x52>
80103291:	e9 5d ff ff ff       	jmp    801031f3 <mpinit+0x133>
80103296:	66 90                	xchg   %ax,%ax
80103298:	66 90                	xchg   %ax,%ax
8010329a:	66 90                	xchg   %ax,%ax
8010329c:	66 90                	xchg   %ax,%ax
8010329e:	66 90                	xchg   %ax,%ax

801032a0 <picenable>:
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
801032a0:	55                   	push   %ebp
  picsetmask(irqmask & ~(1<<irq));
801032a1:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
801032a6:	ba 21 00 00 00       	mov    $0x21,%edx
{
801032ab:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
801032ad:	8b 4d 08             	mov    0x8(%ebp),%ecx
801032b0:	d3 c0                	rol    %cl,%eax
801032b2:	66 23 05 00 a0 10 80 	and    0x8010a000,%ax
  irqmask = mask;
801032b9:	66 a3 00 a0 10 80    	mov    %ax,0x8010a000
801032bf:	ee                   	out    %al,(%dx)
801032c0:	ba a1 00 00 00       	mov    $0xa1,%edx
  outb(IO_PIC2+1, mask >> 8);
801032c5:	66 c1 e8 08          	shr    $0x8,%ax
801032c9:	ee                   	out    %al,(%dx)
}
801032ca:	5d                   	pop    %ebp
801032cb:	c3                   	ret    
801032cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801032d0 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
801032d0:	55                   	push   %ebp
801032d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801032d6:	89 e5                	mov    %esp,%ebp
801032d8:	57                   	push   %edi
801032d9:	56                   	push   %esi
801032da:	53                   	push   %ebx
801032db:	bb 21 00 00 00       	mov    $0x21,%ebx
801032e0:	89 da                	mov    %ebx,%edx
801032e2:	ee                   	out    %al,(%dx)
801032e3:	b9 a1 00 00 00       	mov    $0xa1,%ecx
801032e8:	89 ca                	mov    %ecx,%edx
801032ea:	ee                   	out    %al,(%dx)
801032eb:	bf 11 00 00 00       	mov    $0x11,%edi
801032f0:	be 20 00 00 00       	mov    $0x20,%esi
801032f5:	89 f8                	mov    %edi,%eax
801032f7:	89 f2                	mov    %esi,%edx
801032f9:	ee                   	out    %al,(%dx)
801032fa:	b8 20 00 00 00       	mov    $0x20,%eax
801032ff:	89 da                	mov    %ebx,%edx
80103301:	ee                   	out    %al,(%dx)
80103302:	b8 04 00 00 00       	mov    $0x4,%eax
80103307:	ee                   	out    %al,(%dx)
80103308:	b8 03 00 00 00       	mov    $0x3,%eax
8010330d:	ee                   	out    %al,(%dx)
8010330e:	bb a0 00 00 00       	mov    $0xa0,%ebx
80103313:	89 f8                	mov    %edi,%eax
80103315:	89 da                	mov    %ebx,%edx
80103317:	ee                   	out    %al,(%dx)
80103318:	b8 28 00 00 00       	mov    $0x28,%eax
8010331d:	89 ca                	mov    %ecx,%edx
8010331f:	ee                   	out    %al,(%dx)
80103320:	b8 02 00 00 00       	mov    $0x2,%eax
80103325:	ee                   	out    %al,(%dx)
80103326:	b8 03 00 00 00       	mov    $0x3,%eax
8010332b:	ee                   	out    %al,(%dx)
8010332c:	bf 68 00 00 00       	mov    $0x68,%edi
80103331:	89 f2                	mov    %esi,%edx
80103333:	89 f8                	mov    %edi,%eax
80103335:	ee                   	out    %al,(%dx)
80103336:	b9 0a 00 00 00       	mov    $0xa,%ecx
8010333b:	89 c8                	mov    %ecx,%eax
8010333d:	ee                   	out    %al,(%dx)
8010333e:	89 f8                	mov    %edi,%eax
80103340:	89 da                	mov    %ebx,%edx
80103342:	ee                   	out    %al,(%dx)
80103343:	89 c8                	mov    %ecx,%eax
80103345:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
80103346:	0f b7 05 00 a0 10 80 	movzwl 0x8010a000,%eax
8010334d:	66 83 f8 ff          	cmp    $0xffff,%ax
80103351:	74 10                	je     80103363 <picinit+0x93>
80103353:	ba 21 00 00 00       	mov    $0x21,%edx
80103358:	ee                   	out    %al,(%dx)
80103359:	ba a1 00 00 00       	mov    $0xa1,%edx
  outb(IO_PIC2+1, mask >> 8);
8010335e:	66 c1 e8 08          	shr    $0x8,%ax
80103362:	ee                   	out    %al,(%dx)
    picsetmask(irqmask);
}
80103363:	5b                   	pop    %ebx
80103364:	5e                   	pop    %esi
80103365:	5f                   	pop    %edi
80103366:	5d                   	pop    %ebp
80103367:	c3                   	ret    
80103368:	66 90                	xchg   %ax,%ax
8010336a:	66 90                	xchg   %ax,%ax
8010336c:	66 90                	xchg   %ax,%ax
8010336e:	66 90                	xchg   %ax,%ax

80103370 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103370:	55                   	push   %ebp
80103371:	89 e5                	mov    %esp,%ebp
80103373:	57                   	push   %edi
80103374:	56                   	push   %esi
80103375:	53                   	push   %ebx
80103376:	83 ec 0c             	sub    $0xc,%esp
80103379:	8b 75 08             	mov    0x8(%ebp),%esi
8010337c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010337f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103385:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010338b:	e8 c0 d9 ff ff       	call   80100d50 <filealloc>
80103390:	85 c0                	test   %eax,%eax
80103392:	89 06                	mov    %eax,(%esi)
80103394:	0f 84 a8 00 00 00    	je     80103442 <pipealloc+0xd2>
8010339a:	e8 b1 d9 ff ff       	call   80100d50 <filealloc>
8010339f:	85 c0                	test   %eax,%eax
801033a1:	89 03                	mov    %eax,(%ebx)
801033a3:	0f 84 87 00 00 00    	je     80103430 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801033a9:	e8 d2 f0 ff ff       	call   80102480 <kalloc>
801033ae:	85 c0                	test   %eax,%eax
801033b0:	89 c7                	mov    %eax,%edi
801033b2:	0f 84 b0 00 00 00    	je     80103468 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
801033b8:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
801033bb:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801033c2:	00 00 00 
  p->writeopen = 1;
801033c5:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801033cc:	00 00 00 
  p->nwrite = 0;
801033cf:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801033d6:	00 00 00 
  p->nread = 0;
801033d9:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801033e0:	00 00 00 
  initlock(&p->lock, "pipe");
801033e3:	68 48 79 10 80       	push   $0x80107948
801033e8:	50                   	push   %eax
801033e9:	e8 22 10 00 00       	call   80104410 <initlock>
  (*f0)->type = FD_PIPE;
801033ee:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801033f0:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801033f3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801033f9:	8b 06                	mov    (%esi),%eax
801033fb:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801033ff:	8b 06                	mov    (%esi),%eax
80103401:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103405:	8b 06                	mov    (%esi),%eax
80103407:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010340a:	8b 03                	mov    (%ebx),%eax
8010340c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103412:	8b 03                	mov    (%ebx),%eax
80103414:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103418:	8b 03                	mov    (%ebx),%eax
8010341a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010341e:	8b 03                	mov    (%ebx),%eax
80103420:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103423:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103426:	31 c0                	xor    %eax,%eax
}
80103428:	5b                   	pop    %ebx
80103429:	5e                   	pop    %esi
8010342a:	5f                   	pop    %edi
8010342b:	5d                   	pop    %ebp
8010342c:	c3                   	ret    
8010342d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
80103430:	8b 06                	mov    (%esi),%eax
80103432:	85 c0                	test   %eax,%eax
80103434:	74 1e                	je     80103454 <pipealloc+0xe4>
    fileclose(*f0);
80103436:	83 ec 0c             	sub    $0xc,%esp
80103439:	50                   	push   %eax
8010343a:	e8 d1 d9 ff ff       	call   80100e10 <fileclose>
8010343f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103442:	8b 03                	mov    (%ebx),%eax
80103444:	85 c0                	test   %eax,%eax
80103446:	74 0c                	je     80103454 <pipealloc+0xe4>
    fileclose(*f1);
80103448:	83 ec 0c             	sub    $0xc,%esp
8010344b:	50                   	push   %eax
8010344c:	e8 bf d9 ff ff       	call   80100e10 <fileclose>
80103451:	83 c4 10             	add    $0x10,%esp
}
80103454:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80103457:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010345c:	5b                   	pop    %ebx
8010345d:	5e                   	pop    %esi
8010345e:	5f                   	pop    %edi
8010345f:	5d                   	pop    %ebp
80103460:	c3                   	ret    
80103461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103468:	8b 06                	mov    (%esi),%eax
8010346a:	85 c0                	test   %eax,%eax
8010346c:	75 c8                	jne    80103436 <pipealloc+0xc6>
8010346e:	eb d2                	jmp    80103442 <pipealloc+0xd2>

80103470 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103470:	55                   	push   %ebp
80103471:	89 e5                	mov    %esp,%ebp
80103473:	56                   	push   %esi
80103474:	53                   	push   %ebx
80103475:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103478:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010347b:	83 ec 0c             	sub    $0xc,%esp
8010347e:	53                   	push   %ebx
8010347f:	e8 ac 0f 00 00       	call   80104430 <acquire>
  if(writable){
80103484:	83 c4 10             	add    $0x10,%esp
80103487:	85 f6                	test   %esi,%esi
80103489:	74 45                	je     801034d0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010348b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103491:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103494:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010349b:	00 00 00 
    wakeup(&p->nread);
8010349e:	50                   	push   %eax
8010349f:	e8 9c 0c 00 00       	call   80104140 <wakeup>
801034a4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801034a7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801034ad:	85 d2                	test   %edx,%edx
801034af:	75 0a                	jne    801034bb <pipeclose+0x4b>
801034b1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801034b7:	85 c0                	test   %eax,%eax
801034b9:	74 35                	je     801034f0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801034bb:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801034be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801034c1:	5b                   	pop    %ebx
801034c2:	5e                   	pop    %esi
801034c3:	5d                   	pop    %ebp
    release(&p->lock);
801034c4:	e9 47 11 00 00       	jmp    80104610 <release>
801034c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801034d0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801034d6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
801034d9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801034e0:	00 00 00 
    wakeup(&p->nwrite);
801034e3:	50                   	push   %eax
801034e4:	e8 57 0c 00 00       	call   80104140 <wakeup>
801034e9:	83 c4 10             	add    $0x10,%esp
801034ec:	eb b9                	jmp    801034a7 <pipeclose+0x37>
801034ee:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801034f0:	83 ec 0c             	sub    $0xc,%esp
801034f3:	53                   	push   %ebx
801034f4:	e8 17 11 00 00       	call   80104610 <release>
    kfree((char*)p);
801034f9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801034fc:	83 c4 10             	add    $0x10,%esp
}
801034ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103502:	5b                   	pop    %ebx
80103503:	5e                   	pop    %esi
80103504:	5d                   	pop    %ebp
    kfree((char*)p);
80103505:	e9 c6 ed ff ff       	jmp    801022d0 <kfree>
8010350a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103510 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103510:	55                   	push   %ebp
80103511:	89 e5                	mov    %esp,%ebp
80103513:	57                   	push   %edi
80103514:	56                   	push   %esi
80103515:	53                   	push   %ebx
80103516:	83 ec 28             	sub    $0x28,%esp
80103519:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;

  acquire(&p->lock);
8010351c:	57                   	push   %edi
8010351d:	e8 0e 0f 00 00       	call   80104430 <acquire>
  for(i = 0; i < n; i++){
80103522:	8b 45 10             	mov    0x10(%ebp),%eax
80103525:	83 c4 10             	add    $0x10,%esp
80103528:	85 c0                	test   %eax,%eax
8010352a:	0f 8e c6 00 00 00    	jle    801035f6 <pipewrite+0xe6>
80103530:	8b 45 0c             	mov    0xc(%ebp),%eax
80103533:	8b 8f 38 02 00 00    	mov    0x238(%edi),%ecx
80103539:	8d b7 34 02 00 00    	lea    0x234(%edi),%esi
8010353f:	8d 9f 38 02 00 00    	lea    0x238(%edi),%ebx
80103545:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103548:	03 45 10             	add    0x10(%ebp),%eax
8010354b:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010354e:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
80103554:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
8010355a:	39 d1                	cmp    %edx,%ecx
8010355c:	0f 85 cf 00 00 00    	jne    80103631 <pipewrite+0x121>
      if(p->readopen == 0 || proc->killed){
80103562:	8b 97 3c 02 00 00    	mov    0x23c(%edi),%edx
80103568:	85 d2                	test   %edx,%edx
8010356a:	0f 84 a8 00 00 00    	je     80103618 <pipewrite+0x108>
80103570:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103577:	8b 42 24             	mov    0x24(%edx),%eax
8010357a:	85 c0                	test   %eax,%eax
8010357c:	74 25                	je     801035a3 <pipewrite+0x93>
8010357e:	e9 95 00 00 00       	jmp    80103618 <pipewrite+0x108>
80103583:	90                   	nop
80103584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103588:	8b 87 3c 02 00 00    	mov    0x23c(%edi),%eax
8010358e:	85 c0                	test   %eax,%eax
80103590:	0f 84 82 00 00 00    	je     80103618 <pipewrite+0x108>
80103596:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010359c:	8b 40 24             	mov    0x24(%eax),%eax
8010359f:	85 c0                	test   %eax,%eax
801035a1:	75 75                	jne    80103618 <pipewrite+0x108>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801035a3:	83 ec 0c             	sub    $0xc,%esp
801035a6:	56                   	push   %esi
801035a7:	e8 94 0b 00 00       	call   80104140 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035ac:	59                   	pop    %ecx
801035ad:	58                   	pop    %eax
801035ae:	57                   	push   %edi
801035af:	53                   	push   %ebx
801035b0:	e8 db 09 00 00       	call   80103f90 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035b5:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
801035bb:	8b 97 38 02 00 00    	mov    0x238(%edi),%edx
801035c1:	83 c4 10             	add    $0x10,%esp
801035c4:	05 00 02 00 00       	add    $0x200,%eax
801035c9:	39 c2                	cmp    %eax,%edx
801035cb:	74 bb                	je     80103588 <pipewrite+0x78>
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801035cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801035d0:	8d 4a 01             	lea    0x1(%edx),%ecx
801035d3:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801035d7:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801035dd:	89 8f 38 02 00 00    	mov    %ecx,0x238(%edi)
801035e3:	0f b6 00             	movzbl (%eax),%eax
801035e6:	88 44 17 34          	mov    %al,0x34(%edi,%edx,1)
801035ea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(i = 0; i < n; i++){
801035ed:	39 45 e0             	cmp    %eax,-0x20(%ebp)
801035f0:	0f 85 58 ff ff ff    	jne    8010354e <pipewrite+0x3e>
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801035f6:	8d 97 34 02 00 00    	lea    0x234(%edi),%edx
801035fc:	83 ec 0c             	sub    $0xc,%esp
801035ff:	52                   	push   %edx
80103600:	e8 3b 0b 00 00       	call   80104140 <wakeup>
  release(&p->lock);
80103605:	89 3c 24             	mov    %edi,(%esp)
80103608:	e8 03 10 00 00       	call   80104610 <release>
  return n;
8010360d:	83 c4 10             	add    $0x10,%esp
80103610:	8b 45 10             	mov    0x10(%ebp),%eax
80103613:	eb 14                	jmp    80103629 <pipewrite+0x119>
80103615:	8d 76 00             	lea    0x0(%esi),%esi
        release(&p->lock);
80103618:	83 ec 0c             	sub    $0xc,%esp
8010361b:	57                   	push   %edi
8010361c:	e8 ef 0f 00 00       	call   80104610 <release>
        return -1;
80103621:	83 c4 10             	add    $0x10,%esp
80103624:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103629:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010362c:	5b                   	pop    %ebx
8010362d:	5e                   	pop    %esi
8010362e:	5f                   	pop    %edi
8010362f:	5d                   	pop    %ebp
80103630:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103631:	89 ca                	mov    %ecx,%edx
80103633:	eb 98                	jmp    801035cd <pipewrite+0xbd>
80103635:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103640 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103640:	55                   	push   %ebp
80103641:	89 e5                	mov    %esp,%ebp
80103643:	57                   	push   %edi
80103644:	56                   	push   %esi
80103645:	53                   	push   %ebx
80103646:	83 ec 18             	sub    $0x18,%esp
80103649:	8b 75 08             	mov    0x8(%ebp),%esi
8010364c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010364f:	56                   	push   %esi
80103650:	e8 db 0d 00 00       	call   80104430 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103655:	83 c4 10             	add    $0x10,%esp
80103658:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010365e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103664:	75 72                	jne    801036d8 <piperead+0x98>
80103666:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010366c:	85 db                	test   %ebx,%ebx
8010366e:	0f 84 cc 00 00 00    	je     80103740 <piperead+0x100>
80103674:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010367a:	eb 2d                	jmp    801036a9 <piperead+0x69>
8010367c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103680:	83 ec 08             	sub    $0x8,%esp
80103683:	56                   	push   %esi
80103684:	53                   	push   %ebx
80103685:	e8 06 09 00 00       	call   80103f90 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010368a:	83 c4 10             	add    $0x10,%esp
8010368d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103693:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103699:	75 3d                	jne    801036d8 <piperead+0x98>
8010369b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801036a1:	85 d2                	test   %edx,%edx
801036a3:	0f 84 97 00 00 00    	je     80103740 <piperead+0x100>
    if(proc->killed){
801036a9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801036af:	8b 48 24             	mov    0x24(%eax),%ecx
801036b2:	85 c9                	test   %ecx,%ecx
801036b4:	74 ca                	je     80103680 <piperead+0x40>
      release(&p->lock);
801036b6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801036b9:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801036be:	56                   	push   %esi
801036bf:	e8 4c 0f 00 00       	call   80104610 <release>
      return -1;
801036c4:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801036c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036ca:	89 d8                	mov    %ebx,%eax
801036cc:	5b                   	pop    %ebx
801036cd:	5e                   	pop    %esi
801036ce:	5f                   	pop    %edi
801036cf:	5d                   	pop    %ebp
801036d0:	c3                   	ret    
801036d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801036d8:	8b 45 10             	mov    0x10(%ebp),%eax
801036db:	85 c0                	test   %eax,%eax
801036dd:	7e 61                	jle    80103740 <piperead+0x100>
    if(p->nread == p->nwrite)
801036df:	31 db                	xor    %ebx,%ebx
801036e1:	eb 13                	jmp    801036f6 <piperead+0xb6>
801036e3:	90                   	nop
801036e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036e8:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801036ee:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801036f4:	74 1f                	je     80103715 <piperead+0xd5>
    addr[i] = p->data[p->nread++ % PIPESIZE];
801036f6:	8d 41 01             	lea    0x1(%ecx),%eax
801036f9:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801036ff:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
80103705:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
8010370a:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010370d:	83 c3 01             	add    $0x1,%ebx
80103710:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103713:	75 d3                	jne    801036e8 <piperead+0xa8>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103715:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
8010371b:	83 ec 0c             	sub    $0xc,%esp
8010371e:	50                   	push   %eax
8010371f:	e8 1c 0a 00 00       	call   80104140 <wakeup>
  release(&p->lock);
80103724:	89 34 24             	mov    %esi,(%esp)
80103727:	e8 e4 0e 00 00       	call   80104610 <release>
  return i;
8010372c:	83 c4 10             	add    $0x10,%esp
}
8010372f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103732:	89 d8                	mov    %ebx,%eax
80103734:	5b                   	pop    %ebx
80103735:	5e                   	pop    %esi
80103736:	5f                   	pop    %edi
80103737:	5d                   	pop    %ebp
80103738:	c3                   	ret    
80103739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p->nread == p->nwrite)
80103740:	31 db                	xor    %ebx,%ebx
80103742:	eb d1                	jmp    80103715 <piperead+0xd5>
80103744:	66 90                	xchg   %ax,%ax
80103746:	66 90                	xchg   %ax,%ax
80103748:	66 90                	xchg   %ax,%ax
8010374a:	66 90                	xchg   %ax,%ax
8010374c:	66 90                	xchg   %ax,%ax
8010374e:	66 90                	xchg   %ax,%ax

80103750 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103750:	55                   	push   %ebp
80103751:	89 e5                	mov    %esp,%ebp
80103753:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103754:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
{
80103759:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010375c:	68 a0 2d 11 80       	push   $0x80112da0
80103761:	e8 ca 0c 00 00       	call   80104430 <acquire>
80103766:	83 c4 10             	add    $0x10,%esp
80103769:	eb 17                	jmp    80103782 <allocproc+0x32>
8010376b:	90                   	nop
8010376c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103770:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103776:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
8010377c:	0f 83 7e 00 00 00    	jae    80103800 <allocproc+0xb0>
    if(p->state == UNUSED)
80103782:	8b 43 0c             	mov    0xc(%ebx),%eax
80103785:	85 c0                	test   %eax,%eax
80103787:	75 e7                	jne    80103770 <allocproc+0x20>
  return 0;

found:
  p->type = 0;
  p->state = EMBRYO;
  p->pid = nextpid++;
80103789:	a1 08 a0 10 80       	mov    0x8010a008,%eax

  release(&ptable.lock);
8010378e:	83 ec 0c             	sub    $0xc,%esp
  p->type = 0;
80103791:	c7 43 7c 00 00 00 00 	movl   $0x0,0x7c(%ebx)
  p->state = EMBRYO;
80103798:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
8010379f:	8d 50 01             	lea    0x1(%eax),%edx
801037a2:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
801037a5:	68 a0 2d 11 80       	push   $0x80112da0
  p->pid = nextpid++;
801037aa:	89 15 08 a0 10 80    	mov    %edx,0x8010a008
  release(&ptable.lock);
801037b0:	e8 5b 0e 00 00       	call   80104610 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801037b5:	e8 c6 ec ff ff       	call   80102480 <kalloc>
801037ba:	83 c4 10             	add    $0x10,%esp
801037bd:	85 c0                	test   %eax,%eax
801037bf:	89 43 08             	mov    %eax,0x8(%ebx)
801037c2:	74 55                	je     80103819 <allocproc+0xc9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801037c4:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801037ca:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
801037cd:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
801037d2:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
801037d5:	c7 40 14 ae 5b 10 80 	movl   $0x80105bae,0x14(%eax)
  p->context = (struct context*)sp;
801037dc:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801037df:	6a 14                	push   $0x14
801037e1:	6a 00                	push   $0x0
801037e3:	50                   	push   %eax
801037e4:	e8 77 0e 00 00       	call   80104660 <memset>
  p->context->eip = (uint)forkret;
801037e9:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
801037ec:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
801037ef:	c7 40 10 30 38 10 80 	movl   $0x80103830,0x10(%eax)
}
801037f6:	89 d8                	mov    %ebx,%eax
801037f8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037fb:	c9                   	leave  
801037fc:	c3                   	ret    
801037fd:	8d 76 00             	lea    0x0(%esi),%esi
  release(&ptable.lock);
80103800:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103803:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103805:	68 a0 2d 11 80       	push   $0x80112da0
8010380a:	e8 01 0e 00 00       	call   80104610 <release>
}
8010380f:	89 d8                	mov    %ebx,%eax
  return 0;
80103811:	83 c4 10             	add    $0x10,%esp
}
80103814:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103817:	c9                   	leave  
80103818:	c3                   	ret    
    p->state = UNUSED;
80103819:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103820:	31 db                	xor    %ebx,%ebx
80103822:	eb d2                	jmp    801037f6 <allocproc+0xa6>
80103824:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010382a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103830 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103830:	55                   	push   %ebp
80103831:	89 e5                	mov    %esp,%ebp
80103833:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103836:	68 a0 2d 11 80       	push   $0x80112da0
8010383b:	e8 d0 0d 00 00       	call   80104610 <release>

  if (first) {
80103840:	a1 04 a0 10 80       	mov    0x8010a004,%eax
80103845:	83 c4 10             	add    $0x10,%esp
80103848:	85 c0                	test   %eax,%eax
8010384a:	75 04                	jne    80103850 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010384c:	c9                   	leave  
8010384d:	c3                   	ret    
8010384e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103850:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103853:	c7 05 04 a0 10 80 00 	movl   $0x0,0x8010a004
8010385a:	00 00 00 
    iinit(ROOTDEV);
8010385d:	6a 01                	push   $0x1
8010385f:	e8 fc db ff ff       	call   80101460 <iinit>
    initlog(ROOTDEV);
80103864:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010386b:	e8 d0 f2 ff ff       	call   80102b40 <initlog>
80103870:	83 c4 10             	add    $0x10,%esp
}
80103873:	c9                   	leave  
80103874:	c3                   	ret    
80103875:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103880 <pinit>:
{
80103880:	55                   	push   %ebp
80103881:	89 e5                	mov    %esp,%ebp
80103883:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103886:	68 4d 79 10 80       	push   $0x8010794d
8010388b:	68 a0 2d 11 80       	push   $0x80112da0
80103890:	e8 7b 0b 00 00       	call   80104410 <initlock>
}
80103895:	83 c4 10             	add    $0x10,%esp
80103898:	c9                   	leave  
80103899:	c3                   	ret    
8010389a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801038a0 <userinit>:
{
801038a0:	55                   	push   %ebp
801038a1:	89 e5                	mov    %esp,%ebp
801038a3:	53                   	push   %ebx
801038a4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
801038a7:	e8 a4 fe ff ff       	call   80103750 <allocproc>
801038ac:	89 c3                	mov    %eax,%ebx
  initproc = p;
801038ae:	a3 bc a5 10 80       	mov    %eax,0x8010a5bc
  if((p->pgdir = setupkvm()) == 0)
801038b3:	e8 28 35 00 00       	call   80106de0 <setupkvm>
801038b8:	85 c0                	test   %eax,%eax
801038ba:	89 43 04             	mov    %eax,0x4(%ebx)
801038bd:	0f 84 bd 00 00 00    	je     80103980 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801038c3:	83 ec 04             	sub    $0x4,%esp
801038c6:	68 2c 00 00 00       	push   $0x2c
801038cb:	68 60 a4 10 80       	push   $0x8010a460
801038d0:	50                   	push   %eax
801038d1:	e8 5a 36 00 00       	call   80106f30 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801038d6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801038d9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801038df:	6a 4c                	push   $0x4c
801038e1:	6a 00                	push   $0x0
801038e3:	ff 73 18             	pushl  0x18(%ebx)
801038e6:	e8 75 0d 00 00       	call   80104660 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801038eb:	8b 43 18             	mov    0x18(%ebx),%eax
801038ee:	ba 23 00 00 00       	mov    $0x23,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801038f3:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
801038f8:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801038fb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801038ff:	8b 43 18             	mov    0x18(%ebx),%eax
80103902:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103906:	8b 43 18             	mov    0x18(%ebx),%eax
80103909:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010390d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103911:	8b 43 18             	mov    0x18(%ebx),%eax
80103914:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103918:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010391c:	8b 43 18             	mov    0x18(%ebx),%eax
8010391f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103926:	8b 43 18             	mov    0x18(%ebx),%eax
80103929:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103930:	8b 43 18             	mov    0x18(%ebx),%eax
80103933:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010393a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010393d:	6a 10                	push   $0x10
8010393f:	68 6d 79 10 80       	push   $0x8010796d
80103944:	50                   	push   %eax
80103945:	e8 f6 0e 00 00       	call   80104840 <safestrcpy>
  p->cwd = namei("/");
8010394a:	c7 04 24 76 79 10 80 	movl   $0x80107976,(%esp)
80103951:	e8 3a e5 ff ff       	call   80101e90 <namei>
80103956:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103959:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103960:	e8 cb 0a 00 00       	call   80104430 <acquire>
  p->state = RUNNABLE;
80103965:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
8010396c:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103973:	e8 98 0c 00 00       	call   80104610 <release>
}
80103978:	83 c4 10             	add    $0x10,%esp
8010397b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010397e:	c9                   	leave  
8010397f:	c3                   	ret    
    panic("userinit: out of memory?");
80103980:	83 ec 0c             	sub    $0xc,%esp
80103983:	68 54 79 10 80       	push   $0x80107954
80103988:	e8 e3 c9 ff ff       	call   80100370 <panic>
8010398d:	8d 76 00             	lea    0x0(%esi),%esi

80103990 <growproc>:
{
80103990:	55                   	push   %ebp
80103991:	89 e5                	mov    %esp,%ebp
80103993:	83 ec 08             	sub    $0x8,%esp
  sz = proc->sz;
80103996:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
{
8010399d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  sz = proc->sz;
801039a0:	8b 02                	mov    (%edx),%eax
  if(n > 0){
801039a2:	83 f9 00             	cmp    $0x0,%ecx
801039a5:	7e 39                	jle    801039e0 <growproc+0x50>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
801039a7:	83 ec 04             	sub    $0x4,%esp
801039aa:	01 c1                	add    %eax,%ecx
801039ac:	51                   	push   %ecx
801039ad:	50                   	push   %eax
801039ae:	ff 72 04             	pushl  0x4(%edx)
801039b1:	e8 ba 36 00 00       	call   80107070 <allocuvm>
801039b6:	83 c4 10             	add    $0x10,%esp
801039b9:	85 c0                	test   %eax,%eax
801039bb:	74 3b                	je     801039f8 <growproc+0x68>
801039bd:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  proc->sz = sz;
801039c4:	89 02                	mov    %eax,(%edx)
  switchuvm(proc);
801039c6:	83 ec 0c             	sub    $0xc,%esp
801039c9:	65 ff 35 04 00 00 00 	pushl  %gs:0x4
801039d0:	e8 bb 34 00 00       	call   80106e90 <switchuvm>
  return 0;
801039d5:	83 c4 10             	add    $0x10,%esp
801039d8:	31 c0                	xor    %eax,%eax
}
801039da:	c9                   	leave  
801039db:	c3                   	ret    
801039dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  } else if(n < 0){
801039e0:	74 e2                	je     801039c4 <growproc+0x34>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
801039e2:	83 ec 04             	sub    $0x4,%esp
801039e5:	01 c1                	add    %eax,%ecx
801039e7:	51                   	push   %ecx
801039e8:	50                   	push   %eax
801039e9:	ff 72 04             	pushl  0x4(%edx)
801039ec:	e8 6f 37 00 00       	call   80107160 <deallocuvm>
801039f1:	83 c4 10             	add    $0x10,%esp
801039f4:	85 c0                	test   %eax,%eax
801039f6:	75 c5                	jne    801039bd <growproc+0x2d>
      return -1;
801039f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801039fd:	c9                   	leave  
801039fe:	c3                   	ret    
801039ff:	90                   	nop

80103a00 <clone_jared>:
int clone_jared(void(*worker)(void*), void *arg, void *stack){
80103a00:	55                   	push   %ebp
80103a01:	89 e5                	mov    %esp,%ebp
80103a03:	57                   	push   %edi
80103a04:	56                   	push   %esi
80103a05:	53                   	push   %ebx
80103a06:	83 ec 0c             	sub    $0xc,%esp
  if((np = allocproc()) == 0){
80103a09:	e8 42 fd ff ff       	call   80103750 <allocproc>
80103a0e:	85 c0                	test   %eax,%eax
80103a10:	0f 84 f6 00 00 00    	je     80103b0c <clone_jared+0x10c>
80103a16:	89 c3                	mov    %eax,%ebx
  np->pgdir = proc->pgdir;
80103a18:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  *np->tf = *proc->tf;
80103a1e:	b9 13 00 00 00       	mov    $0x13,%ecx
80103a23:	8b 7b 18             	mov    0x18(%ebx),%edi
  np->pgdir = proc->pgdir;
80103a26:	8b 50 04             	mov    0x4(%eax),%edx
80103a29:	89 53 04             	mov    %edx,0x4(%ebx)
  np->sz = proc->sz;
80103a2c:	8b 00                	mov    (%eax),%eax
  np->type = 1;
80103a2e:	c7 43 7c 01 00 00 00 	movl   $0x1,0x7c(%ebx)
  np->sz = proc->sz;
80103a35:	89 03                	mov    %eax,(%ebx)
  np->parent = proc;
80103a37:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103a3d:	89 43 14             	mov    %eax,0x14(%ebx)
  *np->tf = *proc->tf;
80103a40:	8b 70 18             	mov    0x18(%eax),%esi
  *argPtr = (int)arg;
80103a43:	8b 45 0c             	mov    0xc(%ebp),%eax
  *np->tf = *proc->tf;
80103a46:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  *argPtr = (int)arg;
80103a48:	8b 4d 10             	mov    0x10(%ebp),%ecx
  for(i = 0; i < NOFILE; i++)
80103a4b:	31 f6                	xor    %esi,%esi
  *argPtr = (int)arg;
80103a4d:	89 81 fc 0f 00 00    	mov    %eax,0xffc(%ecx)
  *stackPtr = 0xffffffff;
80103a53:	c7 81 f8 0f 00 00 ff 	movl   $0xffffffff,0xff8(%ecx)
80103a5a:	ff ff ff 
  np->tf->eax = 0;
80103a5d:	8b 43 18             	mov    0x18(%ebx),%eax
80103a60:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  np->tf->esp = (int)stackPtr; 
80103a67:	8b 53 18             	mov    0x18(%ebx),%edx
  int* stackPtr = stack + PGSIZE - 2*sizeof(int*);
80103a6a:	89 c8                	mov    %ecx,%eax
80103a6c:	05 f8 0f 00 00       	add    $0xff8,%eax
  np->tf->esp = (int)stackPtr; 
80103a71:	89 42 44             	mov    %eax,0x44(%edx)
  np->tf->ebp = (int)stackPtr;
80103a74:	8b 53 18             	mov    0x18(%ebx),%edx
80103a77:	89 42 08             	mov    %eax,0x8(%edx)
  np->tf->eip = (int)worker;
80103a7a:	8b 55 08             	mov    0x8(%ebp),%edx
80103a7d:	8b 43 18             	mov    0x18(%ebx),%eax
80103a80:	89 50 38             	mov    %edx,0x38(%eax)
80103a83:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(proc->ofile[i])
80103a90:	8b 44 b2 28          	mov    0x28(%edx,%esi,4),%eax
80103a94:	85 c0                	test   %eax,%eax
80103a96:	74 17                	je     80103aaf <clone_jared+0xaf>
      np->ofile[i] = filedup(proc->ofile[i]);
80103a98:	83 ec 0c             	sub    $0xc,%esp
80103a9b:	50                   	push   %eax
80103a9c:	e8 1f d3 ff ff       	call   80100dc0 <filedup>
80103aa1:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
80103aa5:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103aac:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NOFILE; i++)
80103aaf:	83 c6 01             	add    $0x1,%esi
80103ab2:	83 fe 10             	cmp    $0x10,%esi
80103ab5:	75 d9                	jne    80103a90 <clone_jared+0x90>
  np->cwd = idup(proc->cwd);
80103ab7:	83 ec 0c             	sub    $0xc,%esp
80103aba:	ff 72 68             	pushl  0x68(%edx)
80103abd:	e8 6e db ff ff       	call   80101630 <idup>
80103ac2:	89 43 68             	mov    %eax,0x68(%ebx)
  safestrcpy(np->name, proc->name, sizeof(proc->name));
80103ac5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103acb:	83 c4 0c             	add    $0xc,%esp
80103ace:	6a 10                	push   $0x10
80103ad0:	83 c0 6c             	add    $0x6c,%eax
80103ad3:	50                   	push   %eax
80103ad4:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103ad7:	50                   	push   %eax
80103ad8:	e8 63 0d 00 00       	call   80104840 <safestrcpy>
  pid = np->pid;
80103add:	8b 73 10             	mov    0x10(%ebx),%esi
  acquire(&ptable.lock);
80103ae0:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103ae7:	e8 44 09 00 00       	call   80104430 <acquire>
  np->state = RUNNABLE;
80103aec:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103af3:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103afa:	e8 11 0b 00 00       	call   80104610 <release>
  return pid;
80103aff:	83 c4 10             	add    $0x10,%esp
}
80103b02:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b05:	89 f0                	mov    %esi,%eax
80103b07:	5b                   	pop    %ebx
80103b08:	5e                   	pop    %esi
80103b09:	5f                   	pop    %edi
80103b0a:	5d                   	pop    %ebp
80103b0b:	c3                   	ret    
    return -1;
80103b0c:	be ff ff ff ff       	mov    $0xffffffff,%esi
80103b11:	eb ef                	jmp    80103b02 <clone_jared+0x102>
80103b13:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b20 <fork>:
{
80103b20:	55                   	push   %ebp
80103b21:	89 e5                	mov    %esp,%ebp
80103b23:	57                   	push   %edi
80103b24:	56                   	push   %esi
80103b25:	53                   	push   %ebx
80103b26:	83 ec 0c             	sub    $0xc,%esp
  if((np = allocproc()) == 0){
80103b29:	e8 22 fc ff ff       	call   80103750 <allocproc>
80103b2e:	85 c0                	test   %eax,%eax
80103b30:	0f 84 d6 00 00 00    	je     80103c0c <fork+0xec>
80103b36:	89 c3                	mov    %eax,%ebx
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80103b38:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103b3e:	83 ec 08             	sub    $0x8,%esp
80103b41:	ff 30                	pushl  (%eax)
80103b43:	ff 70 04             	pushl  0x4(%eax)
80103b46:	e8 f5 36 00 00       	call   80107240 <copyuvm>
80103b4b:	83 c4 10             	add    $0x10,%esp
80103b4e:	85 c0                	test   %eax,%eax
80103b50:	89 43 04             	mov    %eax,0x4(%ebx)
80103b53:	0f 84 ba 00 00 00    	je     80103c13 <fork+0xf3>
  np->sz = proc->sz;
80103b59:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  *np->tf = *proc->tf;
80103b5f:	8b 7b 18             	mov    0x18(%ebx),%edi
80103b62:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = proc->sz;
80103b67:	8b 00                	mov    (%eax),%eax
80103b69:	89 03                	mov    %eax,(%ebx)
  np->parent = proc;
80103b6b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103b71:	89 43 14             	mov    %eax,0x14(%ebx)
  *np->tf = *proc->tf;
80103b74:	8b 70 18             	mov    0x18(%eax),%esi
80103b77:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103b79:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103b7b:	8b 43 18             	mov    0x18(%ebx),%eax
80103b7e:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103b85:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->ofile[i])
80103b90:	8b 44 b2 28          	mov    0x28(%edx,%esi,4),%eax
80103b94:	85 c0                	test   %eax,%eax
80103b96:	74 17                	je     80103baf <fork+0x8f>
      np->ofile[i] = filedup(proc->ofile[i]);
80103b98:	83 ec 0c             	sub    $0xc,%esp
80103b9b:	50                   	push   %eax
80103b9c:	e8 1f d2 ff ff       	call   80100dc0 <filedup>
80103ba1:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
80103ba5:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103bac:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NOFILE; i++)
80103baf:	83 c6 01             	add    $0x1,%esi
80103bb2:	83 fe 10             	cmp    $0x10,%esi
80103bb5:	75 d9                	jne    80103b90 <fork+0x70>
  np->cwd = idup(proc->cwd);
80103bb7:	83 ec 0c             	sub    $0xc,%esp
80103bba:	ff 72 68             	pushl  0x68(%edx)
80103bbd:	e8 6e da ff ff       	call   80101630 <idup>
80103bc2:	89 43 68             	mov    %eax,0x68(%ebx)
  safestrcpy(np->name, proc->name, sizeof(proc->name));
80103bc5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103bcb:	83 c4 0c             	add    $0xc,%esp
80103bce:	6a 10                	push   $0x10
80103bd0:	83 c0 6c             	add    $0x6c,%eax
80103bd3:	50                   	push   %eax
80103bd4:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103bd7:	50                   	push   %eax
80103bd8:	e8 63 0c 00 00       	call   80104840 <safestrcpy>
  pid = np->pid;
80103bdd:	8b 73 10             	mov    0x10(%ebx),%esi
  acquire(&ptable.lock);
80103be0:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103be7:	e8 44 08 00 00       	call   80104430 <acquire>
  np->state = RUNNABLE;
80103bec:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103bf3:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103bfa:	e8 11 0a 00 00       	call   80104610 <release>
  return pid;
80103bff:	83 c4 10             	add    $0x10,%esp
}
80103c02:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c05:	89 f0                	mov    %esi,%eax
80103c07:	5b                   	pop    %ebx
80103c08:	5e                   	pop    %esi
80103c09:	5f                   	pop    %edi
80103c0a:	5d                   	pop    %ebp
80103c0b:	c3                   	ret    
    return -1;
80103c0c:	be ff ff ff ff       	mov    $0xffffffff,%esi
80103c11:	eb ef                	jmp    80103c02 <fork+0xe2>
    kfree(np->kstack);
80103c13:	83 ec 0c             	sub    $0xc,%esp
80103c16:	ff 73 08             	pushl  0x8(%ebx)
    return -1;
80103c19:	be ff ff ff ff       	mov    $0xffffffff,%esi
    kfree(np->kstack);
80103c1e:	e8 ad e6 ff ff       	call   801022d0 <kfree>
    np->kstack = 0;
80103c23:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103c2a:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103c31:	83 c4 10             	add    $0x10,%esp
80103c34:	eb cc                	jmp    80103c02 <fork+0xe2>
80103c36:	8d 76 00             	lea    0x0(%esi),%esi
80103c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c40 <scheduler>:
{
80103c40:	55                   	push   %ebp
80103c41:	89 e5                	mov    %esp,%ebp
80103c43:	53                   	push   %ebx
80103c44:	83 ec 04             	sub    $0x4,%esp
80103c47:	89 f6                	mov    %esi,%esi
80103c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  asm volatile("sti");
80103c50:	fb                   	sti    
    acquire(&ptable.lock);
80103c51:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c54:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
    acquire(&ptable.lock);
80103c59:	68 a0 2d 11 80       	push   $0x80112da0
80103c5e:	e8 cd 07 00 00       	call   80104430 <acquire>
80103c63:	83 c4 10             	add    $0x10,%esp
80103c66:	eb 16                	jmp    80103c7e <scheduler+0x3e>
80103c68:	90                   	nop
80103c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c70:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103c76:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
80103c7c:	73 52                	jae    80103cd0 <scheduler+0x90>
      if(p->state != RUNNABLE)
80103c7e:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103c82:	75 ec                	jne    80103c70 <scheduler+0x30>
      switchuvm(p);
80103c84:	83 ec 0c             	sub    $0xc,%esp
      proc = p;
80103c87:	65 89 1d 04 00 00 00 	mov    %ebx,%gs:0x4
      switchuvm(p);
80103c8e:	53                   	push   %ebx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c8f:	81 c3 84 00 00 00    	add    $0x84,%ebx
      switchuvm(p);
80103c95:	e8 f6 31 00 00       	call   80106e90 <switchuvm>
      swtch(&cpu->scheduler, p->context);
80103c9a:	58                   	pop    %eax
80103c9b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
      p->state = RUNNING;
80103ca1:	c7 43 88 04 00 00 00 	movl   $0x4,-0x78(%ebx)
      swtch(&cpu->scheduler, p->context);
80103ca8:	5a                   	pop    %edx
80103ca9:	ff 73 98             	pushl  -0x68(%ebx)
80103cac:	83 c0 04             	add    $0x4,%eax
80103caf:	50                   	push   %eax
80103cb0:	e8 e6 0b 00 00       	call   8010489b <swtch>
      switchkvm();
80103cb5:	e8 b6 31 00 00       	call   80106e70 <switchkvm>
      proc = 0;
80103cba:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cbd:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
      proc = 0;
80103cc3:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80103cca:	00 00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cce:	72 ae                	jb     80103c7e <scheduler+0x3e>
    release(&ptable.lock);
80103cd0:	83 ec 0c             	sub    $0xc,%esp
80103cd3:	68 a0 2d 11 80       	push   $0x80112da0
80103cd8:	e8 33 09 00 00       	call   80104610 <release>
    sti();
80103cdd:	83 c4 10             	add    $0x10,%esp
80103ce0:	e9 6b ff ff ff       	jmp    80103c50 <scheduler+0x10>
80103ce5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103cf0 <sched>:
{
80103cf0:	55                   	push   %ebp
80103cf1:	89 e5                	mov    %esp,%ebp
80103cf3:	53                   	push   %ebx
80103cf4:	83 ec 10             	sub    $0x10,%esp
  if(!holding(&ptable.lock))
80103cf7:	68 a0 2d 11 80       	push   $0x80112da0
80103cfc:	e8 5f 08 00 00       	call   80104560 <holding>
80103d01:	83 c4 10             	add    $0x10,%esp
80103d04:	85 c0                	test   %eax,%eax
80103d06:	74 4c                	je     80103d54 <sched+0x64>
  if(cpu->ncli != 1)
80103d08:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80103d0f:	83 ba ac 00 00 00 01 	cmpl   $0x1,0xac(%edx)
80103d16:	75 63                	jne    80103d7b <sched+0x8b>
  if(proc->state == RUNNING)
80103d18:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103d1e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80103d22:	74 4a                	je     80103d6e <sched+0x7e>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103d24:	9c                   	pushf  
80103d25:	59                   	pop    %ecx
  if(readeflags()&FL_IF)
80103d26:	80 e5 02             	and    $0x2,%ch
80103d29:	75 36                	jne    80103d61 <sched+0x71>
  swtch(&proc->context, cpu->scheduler);
80103d2b:	83 ec 08             	sub    $0x8,%esp
80103d2e:	83 c0 1c             	add    $0x1c,%eax
  intena = cpu->intena;
80103d31:	8b 9a b0 00 00 00    	mov    0xb0(%edx),%ebx
  swtch(&proc->context, cpu->scheduler);
80103d37:	ff 72 04             	pushl  0x4(%edx)
80103d3a:	50                   	push   %eax
80103d3b:	e8 5b 0b 00 00       	call   8010489b <swtch>
  cpu->intena = intena;
80103d40:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
}
80103d46:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
80103d49:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
}
80103d4f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d52:	c9                   	leave  
80103d53:	c3                   	ret    
    panic("sched ptable.lock");
80103d54:	83 ec 0c             	sub    $0xc,%esp
80103d57:	68 78 79 10 80       	push   $0x80107978
80103d5c:	e8 0f c6 ff ff       	call   80100370 <panic>
    panic("sched interruptible");
80103d61:	83 ec 0c             	sub    $0xc,%esp
80103d64:	68 a4 79 10 80       	push   $0x801079a4
80103d69:	e8 02 c6 ff ff       	call   80100370 <panic>
    panic("sched running");
80103d6e:	83 ec 0c             	sub    $0xc,%esp
80103d71:	68 96 79 10 80       	push   $0x80107996
80103d76:	e8 f5 c5 ff ff       	call   80100370 <panic>
    panic("sched locks");
80103d7b:	83 ec 0c             	sub    $0xc,%esp
80103d7e:	68 8a 79 10 80       	push   $0x8010798a
80103d83:	e8 e8 c5 ff ff       	call   80100370 <panic>
80103d88:	90                   	nop
80103d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103d90 <exit>:
  if(proc == initproc)
80103d90:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103d97:	3b 15 bc a5 10 80    	cmp    0x8010a5bc,%edx
{
80103d9d:	55                   	push   %ebp
80103d9e:	89 e5                	mov    %esp,%ebp
80103da0:	56                   	push   %esi
80103da1:	53                   	push   %ebx
  if(proc == initproc)
80103da2:	0f 84 90 01 00 00    	je     80103f38 <exit+0x1a8>
80103da8:	31 db                	xor    %ebx,%ebx
80103daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(proc->ofile[fd]){
80103db0:	8d 73 08             	lea    0x8(%ebx),%esi
80103db3:	8b 44 b2 08          	mov    0x8(%edx,%esi,4),%eax
80103db7:	85 c0                	test   %eax,%eax
80103db9:	74 1b                	je     80103dd6 <exit+0x46>
      fileclose(proc->ofile[fd]);
80103dbb:	83 ec 0c             	sub    $0xc,%esp
80103dbe:	50                   	push   %eax
80103dbf:	e8 4c d0 ff ff       	call   80100e10 <fileclose>
      proc->ofile[fd] = 0;
80103dc4:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103dcb:	83 c4 10             	add    $0x10,%esp
80103dce:	c7 44 b2 08 00 00 00 	movl   $0x0,0x8(%edx,%esi,4)
80103dd5:	00 
  for(fd = 0; fd < NOFILE; fd++){
80103dd6:	83 c3 01             	add    $0x1,%ebx
80103dd9:	83 fb 10             	cmp    $0x10,%ebx
80103ddc:	75 d2                	jne    80103db0 <exit+0x20>
  begin_op();
80103dde:	e8 fd ed ff ff       	call   80102be0 <begin_op>
  iput(proc->cwd);
80103de3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103de9:	83 ec 0c             	sub    $0xc,%esp
80103dec:	ff 70 68             	pushl  0x68(%eax)
80103def:	e8 9c d9 ff ff       	call   80101790 <iput>
  end_op();
80103df4:	e8 57 ee ff ff       	call   80102c50 <end_op>
  proc->cwd = 0;
80103df9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103dff:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
  acquire(&ptable.lock);
80103e06:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103e0d:	e8 1e 06 00 00       	call   80104430 <acquire>
  wakeup1(proc->parent);
80103e12:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
80103e19:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e1c:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
  wakeup1(proc->parent);
80103e21:	8b 51 14             	mov    0x14(%ecx),%edx
80103e24:	eb 16                	jmp    80103e3c <exit+0xac>
80103e26:	8d 76 00             	lea    0x0(%esi),%esi
80103e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e30:	05 84 00 00 00       	add    $0x84,%eax
80103e35:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
80103e3a:	73 24                	jae    80103e60 <exit+0xd0>
    if(p->state == SLEEPING && p->chan == chan)
80103e3c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e40:	75 ee                	jne    80103e30 <exit+0xa0>
80103e42:	3b 50 20             	cmp    0x20(%eax),%edx
80103e45:	75 e9                	jne    80103e30 <exit+0xa0>
      p->state = RUNNABLE;
80103e47:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e4e:	05 84 00 00 00       	add    $0x84,%eax
80103e53:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
80103e58:	72 e2                	jb     80103e3c <exit+0xac>
80103e5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e60:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
80103e65:	eb 17                	jmp    80103e7e <exit+0xee>
80103e67:	89 f6                	mov    %esi,%esi
80103e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e70:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103e76:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
80103e7c:	73 72                	jae    80103ef0 <exit+0x160>
    if(p->parent == proc && p->type == 1){
80103e7e:	8b 53 14             	mov    0x14(%ebx),%edx
80103e81:	39 ca                	cmp    %ecx,%edx
80103e83:	75 eb                	jne    80103e70 <exit+0xe0>
80103e85:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103e88:	83 f8 01             	cmp    $0x1,%eax
80103e8b:	0f 84 7f 00 00 00    	je     80103f10 <exit+0x180>
    else if(p->parent == proc && p->type == 0){
80103e91:	85 c0                	test   %eax,%eax
80103e93:	75 db                	jne    80103e70 <exit+0xe0>
      if(p->state == ZOMBIE)
80103e95:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
      p->parent = initproc;
80103e99:	8b 35 bc a5 10 80    	mov    0x8010a5bc,%esi
80103e9f:	89 73 14             	mov    %esi,0x14(%ebx)
      if(p->state == ZOMBIE)
80103ea2:	75 cc                	jne    80103e70 <exit+0xe0>
80103ea4:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
80103ea9:	eb 11                	jmp    80103ebc <exit+0x12c>
80103eab:	90                   	nop
80103eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103eb0:	05 84 00 00 00       	add    $0x84,%eax
80103eb5:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
80103eba:	73 24                	jae    80103ee0 <exit+0x150>
    if(p->state == SLEEPING && p->chan == chan)
80103ebc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103ec0:	75 ee                	jne    80103eb0 <exit+0x120>
80103ec2:	3b 70 20             	cmp    0x20(%eax),%esi
80103ec5:	75 e9                	jne    80103eb0 <exit+0x120>
      p->state = RUNNABLE;
80103ec7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ece:	05 84 00 00 00       	add    $0x84,%eax
80103ed3:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
80103ed8:	72 e2                	jb     80103ebc <exit+0x12c>
80103eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ee0:	81 c3 84 00 00 00    	add    $0x84,%ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ee6:	89 d1                	mov    %edx,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ee8:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
80103eee:	72 8e                	jb     80103e7e <exit+0xee>
  proc->state = ZOMBIE;
80103ef0:	c7 41 0c 05 00 00 00 	movl   $0x5,0xc(%ecx)
  sched();
80103ef7:	e8 f4 fd ff ff       	call   80103cf0 <sched>
  panic("zombie exit");
80103efc:	83 ec 0c             	sub    $0xc,%esp
80103eff:	68 c5 79 10 80       	push   $0x801079c5
80103f04:	e8 67 c4 ff ff       	call   80100370 <panic>
80103f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80103f10:	83 ec 0c             	sub    $0xc,%esp
80103f13:	ff 73 08             	pushl  0x8(%ebx)
80103f16:	e8 b5 e3 ff ff       	call   801022d0 <kfree>
	p->kstack=0;
80103f1b:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        p->state = UNUSED;
80103f22:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80103f29:	83 c4 10             	add    $0x10,%esp
80103f2c:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
80103f33:	e9 38 ff ff ff       	jmp    80103e70 <exit+0xe0>
    panic("init exiting");
80103f38:	83 ec 0c             	sub    $0xc,%esp
80103f3b:	68 b8 79 10 80       	push   $0x801079b8
80103f40:	e8 2b c4 ff ff       	call   80100370 <panic>
80103f45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f50 <yield>:
{
80103f50:	55                   	push   %ebp
80103f51:	89 e5                	mov    %esp,%ebp
80103f53:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103f56:	68 a0 2d 11 80       	push   $0x80112da0
80103f5b:	e8 d0 04 00 00       	call   80104430 <acquire>
  proc->state = RUNNABLE;
80103f60:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103f66:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80103f6d:	e8 7e fd ff ff       	call   80103cf0 <sched>
  release(&ptable.lock);
80103f72:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103f79:	e8 92 06 00 00       	call   80104610 <release>
}
80103f7e:	83 c4 10             	add    $0x10,%esp
80103f81:	c9                   	leave  
80103f82:	c3                   	ret    
80103f83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f90 <sleep>:
  if(proc == 0)
80103f90:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
80103f96:	55                   	push   %ebp
80103f97:	89 e5                	mov    %esp,%ebp
80103f99:	56                   	push   %esi
80103f9a:	53                   	push   %ebx
  if(proc == 0)
80103f9b:	85 c0                	test   %eax,%eax
{
80103f9d:	8b 75 08             	mov    0x8(%ebp),%esi
80103fa0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(proc == 0)
80103fa3:	0f 84 97 00 00 00    	je     80104040 <sleep+0xb0>
  if(lk == 0)
80103fa9:	85 db                	test   %ebx,%ebx
80103fab:	0f 84 82 00 00 00    	je     80104033 <sleep+0xa3>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103fb1:	81 fb a0 2d 11 80    	cmp    $0x80112da0,%ebx
80103fb7:	74 57                	je     80104010 <sleep+0x80>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103fb9:	83 ec 0c             	sub    $0xc,%esp
80103fbc:	68 a0 2d 11 80       	push   $0x80112da0
80103fc1:	e8 6a 04 00 00       	call   80104430 <acquire>
    release(lk);
80103fc6:	89 1c 24             	mov    %ebx,(%esp)
80103fc9:	e8 42 06 00 00       	call   80104610 <release>
  proc->chan = chan;
80103fce:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103fd4:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80103fd7:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103fde:	e8 0d fd ff ff       	call   80103cf0 <sched>
  proc->chan = 0;
80103fe3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103fe9:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
    release(&ptable.lock);
80103ff0:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103ff7:	e8 14 06 00 00       	call   80104610 <release>
    acquire(lk);
80103ffc:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103fff:	83 c4 10             	add    $0x10,%esp
}
80104002:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104005:	5b                   	pop    %ebx
80104006:	5e                   	pop    %esi
80104007:	5d                   	pop    %ebp
    acquire(lk);
80104008:	e9 23 04 00 00       	jmp    80104430 <acquire>
8010400d:	8d 76 00             	lea    0x0(%esi),%esi
  proc->chan = chan;
80104010:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80104013:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
8010401a:	e8 d1 fc ff ff       	call   80103cf0 <sched>
  proc->chan = 0;
8010401f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104025:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
}
8010402c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010402f:	5b                   	pop    %ebx
80104030:	5e                   	pop    %esi
80104031:	5d                   	pop    %ebp
80104032:	c3                   	ret    
    panic("sleep without lk");
80104033:	83 ec 0c             	sub    $0xc,%esp
80104036:	68 d7 79 10 80       	push   $0x801079d7
8010403b:	e8 30 c3 ff ff       	call   80100370 <panic>
    panic("sleep");
80104040:	83 ec 0c             	sub    $0xc,%esp
80104043:	68 d1 79 10 80       	push   $0x801079d1
80104048:	e8 23 c3 ff ff       	call   80100370 <panic>
8010404d:	8d 76 00             	lea    0x0(%esi),%esi

80104050 <wait>:
{
80104050:	55                   	push   %ebp
80104051:	89 e5                	mov    %esp,%ebp
80104053:	56                   	push   %esi
80104054:	53                   	push   %ebx
  acquire(&ptable.lock);
80104055:	83 ec 0c             	sub    $0xc,%esp
80104058:	68 a0 2d 11 80       	push   $0x80112da0
8010405d:	e8 ce 03 00 00       	call   80104430 <acquire>
80104062:	83 c4 10             	add    $0x10,%esp
80104065:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    havekids = 0;
8010406b:	31 d2                	xor    %edx,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010406d:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
80104072:	eb 12                	jmp    80104086 <wait+0x36>
80104074:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104078:	81 c3 84 00 00 00    	add    $0x84,%ebx
8010407e:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
80104084:	73 22                	jae    801040a8 <wait+0x58>
      if(p->parent != proc)
80104086:	3b 43 14             	cmp    0x14(%ebx),%eax
80104089:	75 ed                	jne    80104078 <wait+0x28>
      if(p->state == ZOMBIE){
8010408b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010408f:	74 35                	je     801040c6 <wait+0x76>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104091:	81 c3 84 00 00 00    	add    $0x84,%ebx
      havekids = 1;
80104097:	ba 01 00 00 00       	mov    $0x1,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010409c:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
801040a2:	72 e2                	jb     80104086 <wait+0x36>
801040a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(!havekids || proc->killed){
801040a8:	85 d2                	test   %edx,%edx
801040aa:	74 70                	je     8010411c <wait+0xcc>
801040ac:	8b 50 24             	mov    0x24(%eax),%edx
801040af:	85 d2                	test   %edx,%edx
801040b1:	75 69                	jne    8010411c <wait+0xcc>
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
801040b3:	83 ec 08             	sub    $0x8,%esp
801040b6:	68 a0 2d 11 80       	push   $0x80112da0
801040bb:	50                   	push   %eax
801040bc:	e8 cf fe ff ff       	call   80103f90 <sleep>
    havekids = 0;
801040c1:	83 c4 10             	add    $0x10,%esp
801040c4:	eb 9f                	jmp    80104065 <wait+0x15>
        kfree(p->kstack);
801040c6:	83 ec 0c             	sub    $0xc,%esp
801040c9:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
801040cc:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801040cf:	e8 fc e1 ff ff       	call   801022d0 <kfree>
        freevm(p->pgdir);
801040d4:	59                   	pop    %ecx
801040d5:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
801040d8:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801040df:	e8 ac 30 00 00       	call   80107190 <freevm>
        p->pid = 0;
801040e4:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801040eb:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801040f2:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801040f6:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801040fd:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104104:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
8010410b:	e8 00 05 00 00       	call   80104610 <release>
        return pid;
80104110:	83 c4 10             	add    $0x10,%esp
}
80104113:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104116:	89 f0                	mov    %esi,%eax
80104118:	5b                   	pop    %ebx
80104119:	5e                   	pop    %esi
8010411a:	5d                   	pop    %ebp
8010411b:	c3                   	ret    
      release(&ptable.lock);
8010411c:	83 ec 0c             	sub    $0xc,%esp
      return -1;
8010411f:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104124:	68 a0 2d 11 80       	push   $0x80112da0
80104129:	e8 e2 04 00 00       	call   80104610 <release>
      return -1;
8010412e:	83 c4 10             	add    $0x10,%esp
}
80104131:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104134:	89 f0                	mov    %esi,%eax
80104136:	5b                   	pop    %ebx
80104137:	5e                   	pop    %esi
80104138:	5d                   	pop    %ebp
80104139:	c3                   	ret    
8010413a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104140 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104140:	55                   	push   %ebp
80104141:	89 e5                	mov    %esp,%ebp
80104143:	53                   	push   %ebx
80104144:	83 ec 10             	sub    $0x10,%esp
80104147:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010414a:	68 a0 2d 11 80       	push   $0x80112da0
8010414f:	e8 dc 02 00 00       	call   80104430 <acquire>
80104154:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104157:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
8010415c:	eb 0e                	jmp    8010416c <wakeup+0x2c>
8010415e:	66 90                	xchg   %ax,%ax
80104160:	05 84 00 00 00       	add    $0x84,%eax
80104165:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
8010416a:	73 1e                	jae    8010418a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010416c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104170:	75 ee                	jne    80104160 <wakeup+0x20>
80104172:	3b 58 20             	cmp    0x20(%eax),%ebx
80104175:	75 e9                	jne    80104160 <wakeup+0x20>
      p->state = RUNNABLE;
80104177:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010417e:	05 84 00 00 00       	add    $0x84,%eax
80104183:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
80104188:	72 e2                	jb     8010416c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010418a:	c7 45 08 a0 2d 11 80 	movl   $0x80112da0,0x8(%ebp)
}
80104191:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104194:	c9                   	leave  
  release(&ptable.lock);
80104195:	e9 76 04 00 00       	jmp    80104610 <release>
8010419a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801041a0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801041a0:	55                   	push   %ebp
801041a1:	89 e5                	mov    %esp,%ebp
801041a3:	53                   	push   %ebx
801041a4:	83 ec 10             	sub    $0x10,%esp
801041a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801041aa:	68 a0 2d 11 80       	push   $0x80112da0
801041af:	e8 7c 02 00 00       	call   80104430 <acquire>
801041b4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041b7:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
801041bc:	eb 0e                	jmp    801041cc <kill+0x2c>
801041be:	66 90                	xchg   %ax,%ax
801041c0:	05 84 00 00 00       	add    $0x84,%eax
801041c5:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
801041ca:	73 3c                	jae    80104208 <kill+0x68>
    if(p->pid == pid){
801041cc:	39 58 10             	cmp    %ebx,0x10(%eax)
801041cf:	75 ef                	jne    801041c0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801041d1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801041d5:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801041dc:	74 1a                	je     801041f8 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
801041de:	83 ec 0c             	sub    $0xc,%esp
801041e1:	68 a0 2d 11 80       	push   $0x80112da0
801041e6:	e8 25 04 00 00       	call   80104610 <release>
      return 0;
801041eb:	83 c4 10             	add    $0x10,%esp
801041ee:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801041f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041f3:	c9                   	leave  
801041f4:	c3                   	ret    
801041f5:	8d 76 00             	lea    0x0(%esi),%esi
        p->state = RUNNABLE;
801041f8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801041ff:	eb dd                	jmp    801041de <kill+0x3e>
80104201:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104208:	83 ec 0c             	sub    $0xc,%esp
8010420b:	68 a0 2d 11 80       	push   $0x80112da0
80104210:	e8 fb 03 00 00       	call   80104610 <release>
  return -1;
80104215:	83 c4 10             	add    $0x10,%esp
80104218:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010421d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104220:	c9                   	leave  
80104221:	c3                   	ret    
80104222:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104230 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104230:	55                   	push   %ebp
80104231:	89 e5                	mov    %esp,%ebp
80104233:	57                   	push   %edi
80104234:	56                   	push   %esi
80104235:	53                   	push   %ebx
80104236:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104239:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
{
8010423e:	83 ec 3c             	sub    $0x3c,%esp
80104241:	eb 27                	jmp    8010426a <procdump+0x3a>
80104243:	90                   	nop
80104244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104248:	83 ec 0c             	sub    $0xc,%esp
8010424b:	68 26 79 10 80       	push   $0x80107926
80104250:	e8 0b c4 ff ff       	call   80100660 <cprintf>
80104255:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104258:	81 c3 84 00 00 00    	add    $0x84,%ebx
8010425e:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
80104264:	0f 83 86 00 00 00    	jae    801042f0 <procdump+0xc0>
    if(p->state == UNUSED)
8010426a:	8b 43 0c             	mov    0xc(%ebx),%eax
8010426d:	85 c0                	test   %eax,%eax
8010426f:	74 e7                	je     80104258 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104271:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104274:	ba e8 79 10 80       	mov    $0x801079e8,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104279:	77 11                	ja     8010428c <procdump+0x5c>
8010427b:	8b 14 85 20 7a 10 80 	mov    -0x7fef85e0(,%eax,4),%edx
      state = "???";
80104282:	b8 e8 79 10 80       	mov    $0x801079e8,%eax
80104287:	85 d2                	test   %edx,%edx
80104289:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010428c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010428f:	50                   	push   %eax
80104290:	52                   	push   %edx
80104291:	ff 73 10             	pushl  0x10(%ebx)
80104294:	68 ec 79 10 80       	push   $0x801079ec
80104299:	e8 c2 c3 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
8010429e:	83 c4 10             	add    $0x10,%esp
801042a1:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
801042a5:	75 a1                	jne    80104248 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801042a7:	8d 45 c0             	lea    -0x40(%ebp),%eax
801042aa:	83 ec 08             	sub    $0x8,%esp
801042ad:	8d 7d c0             	lea    -0x40(%ebp),%edi
801042b0:	50                   	push   %eax
801042b1:	8b 43 1c             	mov    0x1c(%ebx),%eax
801042b4:	8b 40 0c             	mov    0xc(%eax),%eax
801042b7:	83 c0 08             	add    $0x8,%eax
801042ba:	50                   	push   %eax
801042bb:	e8 40 02 00 00       	call   80104500 <getcallerpcs>
801042c0:	83 c4 10             	add    $0x10,%esp
801042c3:	90                   	nop
801042c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
801042c8:	8b 17                	mov    (%edi),%edx
801042ca:	85 d2                	test   %edx,%edx
801042cc:	0f 84 76 ff ff ff    	je     80104248 <procdump+0x18>
        cprintf(" %p", pc[i]);
801042d2:	83 ec 08             	sub    $0x8,%esp
801042d5:	83 c7 04             	add    $0x4,%edi
801042d8:	52                   	push   %edx
801042d9:	68 49 74 10 80       	push   $0x80107449
801042de:	e8 7d c3 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801042e3:	83 c4 10             	add    $0x10,%esp
801042e6:	39 fe                	cmp    %edi,%esi
801042e8:	75 de                	jne    801042c8 <procdump+0x98>
801042ea:	e9 59 ff ff ff       	jmp    80104248 <procdump+0x18>
801042ef:	90                   	nop
  }
}
801042f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801042f3:	5b                   	pop    %ebx
801042f4:	5e                   	pop    %esi
801042f5:	5f                   	pop    %edi
801042f6:	5d                   	pop    %ebp
801042f7:	c3                   	ret    
801042f8:	66 90                	xchg   %ax,%ax
801042fa:	66 90                	xchg   %ax,%ax
801042fc:	66 90                	xchg   %ax,%ax
801042fe:	66 90                	xchg   %ax,%ax

80104300 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104300:	55                   	push   %ebp
80104301:	89 e5                	mov    %esp,%ebp
80104303:	53                   	push   %ebx
80104304:	83 ec 0c             	sub    $0xc,%esp
80104307:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010430a:	68 38 7a 10 80       	push   $0x80107a38
8010430f:	8d 43 04             	lea    0x4(%ebx),%eax
80104312:	50                   	push   %eax
80104313:	e8 f8 00 00 00       	call   80104410 <initlock>
  lk->name = name;
80104318:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010431b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104321:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104324:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010432b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010432e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104331:	c9                   	leave  
80104332:	c3                   	ret    
80104333:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104340 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104340:	55                   	push   %ebp
80104341:	89 e5                	mov    %esp,%ebp
80104343:	56                   	push   %esi
80104344:	53                   	push   %ebx
80104345:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104348:	83 ec 0c             	sub    $0xc,%esp
8010434b:	8d 73 04             	lea    0x4(%ebx),%esi
8010434e:	56                   	push   %esi
8010434f:	e8 dc 00 00 00       	call   80104430 <acquire>
  while (lk->locked) {
80104354:	8b 13                	mov    (%ebx),%edx
80104356:	83 c4 10             	add    $0x10,%esp
80104359:	85 d2                	test   %edx,%edx
8010435b:	74 16                	je     80104373 <acquiresleep+0x33>
8010435d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104360:	83 ec 08             	sub    $0x8,%esp
80104363:	56                   	push   %esi
80104364:	53                   	push   %ebx
80104365:	e8 26 fc ff ff       	call   80103f90 <sleep>
  while (lk->locked) {
8010436a:	8b 03                	mov    (%ebx),%eax
8010436c:	83 c4 10             	add    $0x10,%esp
8010436f:	85 c0                	test   %eax,%eax
80104371:	75 ed                	jne    80104360 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104373:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = proc->pid;
80104379:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010437f:	8b 40 10             	mov    0x10(%eax),%eax
80104382:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104385:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104388:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010438b:	5b                   	pop    %ebx
8010438c:	5e                   	pop    %esi
8010438d:	5d                   	pop    %ebp
  release(&lk->lk);
8010438e:	e9 7d 02 00 00       	jmp    80104610 <release>
80104393:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801043a0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	56                   	push   %esi
801043a4:	53                   	push   %ebx
801043a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801043a8:	83 ec 0c             	sub    $0xc,%esp
801043ab:	8d 73 04             	lea    0x4(%ebx),%esi
801043ae:	56                   	push   %esi
801043af:	e8 7c 00 00 00       	call   80104430 <acquire>
  lk->locked = 0;
801043b4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801043ba:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801043c1:	89 1c 24             	mov    %ebx,(%esp)
801043c4:	e8 77 fd ff ff       	call   80104140 <wakeup>
  release(&lk->lk);
801043c9:	89 75 08             	mov    %esi,0x8(%ebp)
801043cc:	83 c4 10             	add    $0x10,%esp
}
801043cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043d2:	5b                   	pop    %ebx
801043d3:	5e                   	pop    %esi
801043d4:	5d                   	pop    %ebp
  release(&lk->lk);
801043d5:	e9 36 02 00 00       	jmp    80104610 <release>
801043da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801043e0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	56                   	push   %esi
801043e4:	53                   	push   %ebx
801043e5:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
801043e8:	83 ec 0c             	sub    $0xc,%esp
801043eb:	8d 5e 04             	lea    0x4(%esi),%ebx
801043ee:	53                   	push   %ebx
801043ef:	e8 3c 00 00 00       	call   80104430 <acquire>
  r = lk->locked;
801043f4:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
801043f6:	89 1c 24             	mov    %ebx,(%esp)
801043f9:	e8 12 02 00 00       	call   80104610 <release>
  return r;
}
801043fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104401:	89 f0                	mov    %esi,%eax
80104403:	5b                   	pop    %ebx
80104404:	5e                   	pop    %esi
80104405:	5d                   	pop    %ebp
80104406:	c3                   	ret    
80104407:	66 90                	xchg   %ax,%ax
80104409:	66 90                	xchg   %ax,%ax
8010440b:	66 90                	xchg   %ax,%ax
8010440d:	66 90                	xchg   %ax,%ax
8010440f:	90                   	nop

80104410 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104410:	55                   	push   %ebp
80104411:	89 e5                	mov    %esp,%ebp
80104413:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104416:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104419:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010441f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104422:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104429:	5d                   	pop    %ebp
8010442a:	c3                   	ret    
8010442b:	90                   	nop
8010442c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104430 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104430:	55                   	push   %ebp
80104431:	89 e5                	mov    %esp,%ebp
80104433:	53                   	push   %ebx
80104434:	83 ec 04             	sub    $0x4,%esp
80104437:	9c                   	pushf  
80104438:	5a                   	pop    %edx
  asm volatile("cli");
80104439:	fa                   	cli    
{
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
8010443a:	65 8b 0d 00 00 00 00 	mov    %gs:0x0,%ecx
80104441:	8b 81 ac 00 00 00    	mov    0xac(%ecx),%eax
80104447:	85 c0                	test   %eax,%eax
80104449:	75 0c                	jne    80104457 <acquire+0x27>
    cpu->intena = eflags & FL_IF;
8010444b:	81 e2 00 02 00 00    	and    $0x200,%edx
80104451:	89 91 b0 00 00 00    	mov    %edx,0xb0(%ecx)
  if(holding(lk))
80104457:	8b 55 08             	mov    0x8(%ebp),%edx
  cpu->ncli += 1;
8010445a:	83 c0 01             	add    $0x1,%eax
8010445d:	89 81 ac 00 00 00    	mov    %eax,0xac(%ecx)
  return lock->locked && lock->cpu == cpu;
80104463:	8b 02                	mov    (%edx),%eax
80104465:	85 c0                	test   %eax,%eax
80104467:	74 05                	je     8010446e <acquire+0x3e>
80104469:	39 4a 08             	cmp    %ecx,0x8(%edx)
8010446c:	74 7a                	je     801044e8 <acquire+0xb8>
  asm volatile("lock; xchgl %0, %1" :
8010446e:	b9 01 00 00 00       	mov    $0x1,%ecx
80104473:	90                   	nop
80104474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104478:	89 c8                	mov    %ecx,%eax
8010447a:	f0 87 02             	lock xchg %eax,(%edx)
  while(xchg(&lk->locked, 1) != 0)
8010447d:	85 c0                	test   %eax,%eax
8010447f:	75 f7                	jne    80104478 <acquire+0x48>
  __sync_synchronize();
80104481:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = cpu;
80104486:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104489:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  ebp = (uint*)v - 2;
8010448f:	89 ea                	mov    %ebp,%edx
  lk->cpu = cpu;
80104491:	89 41 08             	mov    %eax,0x8(%ecx)
  getcallerpcs(&lk, lk->pcs);
80104494:	83 c1 0c             	add    $0xc,%ecx
  for(i = 0; i < 10; i++){
80104497:	31 c0                	xor    %eax,%eax
80104499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801044a0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801044a6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801044ac:	77 1a                	ja     801044c8 <acquire+0x98>
    pcs[i] = ebp[1];     // saved %eip
801044ae:	8b 5a 04             	mov    0x4(%edx),%ebx
801044b1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
801044b4:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
801044b7:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
801044b9:	83 f8 0a             	cmp    $0xa,%eax
801044bc:	75 e2                	jne    801044a0 <acquire+0x70>
}
801044be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044c1:	c9                   	leave  
801044c2:	c3                   	ret    
801044c3:	90                   	nop
801044c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
801044c8:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
801044cf:	83 c0 01             	add    $0x1,%eax
801044d2:	83 f8 0a             	cmp    $0xa,%eax
801044d5:	74 e7                	je     801044be <acquire+0x8e>
    pcs[i] = 0;
801044d7:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
801044de:	83 c0 01             	add    $0x1,%eax
801044e1:	83 f8 0a             	cmp    $0xa,%eax
801044e4:	75 e2                	jne    801044c8 <acquire+0x98>
801044e6:	eb d6                	jmp    801044be <acquire+0x8e>
    panic("acquire");
801044e8:	83 ec 0c             	sub    $0xc,%esp
801044eb:	68 43 7a 10 80       	push   $0x80107a43
801044f0:	e8 7b be ff ff       	call   80100370 <panic>
801044f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104500 <getcallerpcs>:
{
80104500:	55                   	push   %ebp
80104501:	89 e5                	mov    %esp,%ebp
80104503:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104504:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104507:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010450a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
8010450d:	31 c0                	xor    %eax,%eax
8010450f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104510:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104516:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010451c:	77 1a                	ja     80104538 <getcallerpcs+0x38>
    pcs[i] = ebp[1];     // saved %eip
8010451e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104521:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104524:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104527:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104529:	83 f8 0a             	cmp    $0xa,%eax
8010452c:	75 e2                	jne    80104510 <getcallerpcs+0x10>
}
8010452e:	5b                   	pop    %ebx
8010452f:	5d                   	pop    %ebp
80104530:	c3                   	ret    
80104531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
80104538:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
8010453f:	83 c0 01             	add    $0x1,%eax
80104542:	83 f8 0a             	cmp    $0xa,%eax
80104545:	74 e7                	je     8010452e <getcallerpcs+0x2e>
    pcs[i] = 0;
80104547:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
8010454e:	83 c0 01             	add    $0x1,%eax
80104551:	83 f8 0a             	cmp    $0xa,%eax
80104554:	75 e2                	jne    80104538 <getcallerpcs+0x38>
80104556:	eb d6                	jmp    8010452e <getcallerpcs+0x2e>
80104558:	90                   	nop
80104559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104560 <holding>:
{
80104560:	55                   	push   %ebp
80104561:	89 e5                	mov    %esp,%ebp
80104563:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu;
80104566:	8b 02                	mov    (%edx),%eax
80104568:	85 c0                	test   %eax,%eax
8010456a:	74 14                	je     80104580 <holding+0x20>
8010456c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104572:	39 42 08             	cmp    %eax,0x8(%edx)
}
80104575:	5d                   	pop    %ebp
  return lock->locked && lock->cpu == cpu;
80104576:	0f 94 c0             	sete   %al
80104579:	0f b6 c0             	movzbl %al,%eax
}
8010457c:	c3                   	ret    
8010457d:	8d 76 00             	lea    0x0(%esi),%esi
80104580:	31 c0                	xor    %eax,%eax
  return lock->locked && lock->cpu == cpu;
80104582:	0f b6 c0             	movzbl %al,%eax
}
80104585:	5d                   	pop    %ebp
80104586:	c3                   	ret    
80104587:	89 f6                	mov    %esi,%esi
80104589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104590 <pushcli>:
{
80104590:	55                   	push   %ebp
80104591:	89 e5                	mov    %esp,%ebp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104593:	9c                   	pushf  
80104594:	59                   	pop    %ecx
  asm volatile("cli");
80104595:	fa                   	cli    
  if(cpu->ncli == 0)
80104596:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010459d:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
801045a3:	85 c0                	test   %eax,%eax
801045a5:	75 0c                	jne    801045b3 <pushcli+0x23>
    cpu->intena = eflags & FL_IF;
801045a7:	81 e1 00 02 00 00    	and    $0x200,%ecx
801045ad:	89 8a b0 00 00 00    	mov    %ecx,0xb0(%edx)
  cpu->ncli += 1;
801045b3:	83 c0 01             	add    $0x1,%eax
801045b6:	89 82 ac 00 00 00    	mov    %eax,0xac(%edx)
}
801045bc:	5d                   	pop    %ebp
801045bd:	c3                   	ret    
801045be:	66 90                	xchg   %ax,%ax

801045c0 <popcli>:

void
popcli(void)
{
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801045c6:	9c                   	pushf  
801045c7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801045c8:	f6 c4 02             	test   $0x2,%ah
801045cb:	75 2c                	jne    801045f9 <popcli+0x39>
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
801045cd:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801045d4:	83 aa ac 00 00 00 01 	subl   $0x1,0xac(%edx)
801045db:	78 0f                	js     801045ec <popcli+0x2c>
    panic("popcli");
  if(cpu->ncli == 0 && cpu->intena)
801045dd:	75 0b                	jne    801045ea <popcli+0x2a>
801045df:	8b 82 b0 00 00 00    	mov    0xb0(%edx),%eax
801045e5:	85 c0                	test   %eax,%eax
801045e7:	74 01                	je     801045ea <popcli+0x2a>
  asm volatile("sti");
801045e9:	fb                   	sti    
    sti();
}
801045ea:	c9                   	leave  
801045eb:	c3                   	ret    
    panic("popcli");
801045ec:	83 ec 0c             	sub    $0xc,%esp
801045ef:	68 62 7a 10 80       	push   $0x80107a62
801045f4:	e8 77 bd ff ff       	call   80100370 <panic>
    panic("popcli - interruptible");
801045f9:	83 ec 0c             	sub    $0xc,%esp
801045fc:	68 4b 7a 10 80       	push   $0x80107a4b
80104601:	e8 6a bd ff ff       	call   80100370 <panic>
80104606:	8d 76 00             	lea    0x0(%esi),%esi
80104609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104610 <release>:
{
80104610:	55                   	push   %ebp
80104611:	89 e5                	mov    %esp,%ebp
80104613:	83 ec 08             	sub    $0x8,%esp
80104616:	8b 45 08             	mov    0x8(%ebp),%eax
  return lock->locked && lock->cpu == cpu;
80104619:	8b 10                	mov    (%eax),%edx
8010461b:	85 d2                	test   %edx,%edx
8010461d:	74 0c                	je     8010462b <release+0x1b>
8010461f:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104626:	39 50 08             	cmp    %edx,0x8(%eax)
80104629:	74 15                	je     80104640 <release+0x30>
    panic("release");
8010462b:	83 ec 0c             	sub    $0xc,%esp
8010462e:	68 69 7a 10 80       	push   $0x80107a69
80104633:	e8 38 bd ff ff       	call   80100370 <panic>
80104638:	90                   	nop
80104639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lk->pcs[0] = 0;
80104640:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104647:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  __sync_synchronize();
8010464e:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104653:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
80104659:	c9                   	leave  
  popcli();
8010465a:	e9 61 ff ff ff       	jmp    801045c0 <popcli>
8010465f:	90                   	nop

80104660 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104660:	55                   	push   %ebp
80104661:	89 e5                	mov    %esp,%ebp
80104663:	57                   	push   %edi
80104664:	53                   	push   %ebx
80104665:	8b 55 08             	mov    0x8(%ebp),%edx
80104668:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010466b:	f6 c2 03             	test   $0x3,%dl
8010466e:	75 05                	jne    80104675 <memset+0x15>
80104670:	f6 c1 03             	test   $0x3,%cl
80104673:	74 13                	je     80104688 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104675:	89 d7                	mov    %edx,%edi
80104677:	8b 45 0c             	mov    0xc(%ebp),%eax
8010467a:	fc                   	cld    
8010467b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010467d:	5b                   	pop    %ebx
8010467e:	89 d0                	mov    %edx,%eax
80104680:	5f                   	pop    %edi
80104681:	5d                   	pop    %ebp
80104682:	c3                   	ret    
80104683:	90                   	nop
80104684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104688:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010468c:	c1 e9 02             	shr    $0x2,%ecx
8010468f:	89 f8                	mov    %edi,%eax
80104691:	89 fb                	mov    %edi,%ebx
80104693:	c1 e0 18             	shl    $0x18,%eax
80104696:	c1 e3 10             	shl    $0x10,%ebx
80104699:	09 d8                	or     %ebx,%eax
8010469b:	09 f8                	or     %edi,%eax
8010469d:	c1 e7 08             	shl    $0x8,%edi
801046a0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
801046a2:	89 d7                	mov    %edx,%edi
801046a4:	fc                   	cld    
801046a5:	f3 ab                	rep stos %eax,%es:(%edi)
}
801046a7:	5b                   	pop    %ebx
801046a8:	89 d0                	mov    %edx,%eax
801046aa:	5f                   	pop    %edi
801046ab:	5d                   	pop    %ebp
801046ac:	c3                   	ret    
801046ad:	8d 76 00             	lea    0x0(%esi),%esi

801046b0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801046b0:	55                   	push   %ebp
801046b1:	89 e5                	mov    %esp,%ebp
801046b3:	57                   	push   %edi
801046b4:	56                   	push   %esi
801046b5:	53                   	push   %ebx
801046b6:	8b 5d 10             	mov    0x10(%ebp),%ebx
801046b9:	8b 75 08             	mov    0x8(%ebp),%esi
801046bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801046bf:	85 db                	test   %ebx,%ebx
801046c1:	74 29                	je     801046ec <memcmp+0x3c>
    if(*s1 != *s2)
801046c3:	0f b6 16             	movzbl (%esi),%edx
801046c6:	0f b6 0f             	movzbl (%edi),%ecx
801046c9:	38 d1                	cmp    %dl,%cl
801046cb:	75 2b                	jne    801046f8 <memcmp+0x48>
801046cd:	b8 01 00 00 00       	mov    $0x1,%eax
801046d2:	eb 14                	jmp    801046e8 <memcmp+0x38>
801046d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046d8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
801046dc:	83 c0 01             	add    $0x1,%eax
801046df:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
801046e4:	38 ca                	cmp    %cl,%dl
801046e6:	75 10                	jne    801046f8 <memcmp+0x48>
  while(n-- > 0){
801046e8:	39 d8                	cmp    %ebx,%eax
801046ea:	75 ec                	jne    801046d8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
801046ec:	5b                   	pop    %ebx
  return 0;
801046ed:	31 c0                	xor    %eax,%eax
}
801046ef:	5e                   	pop    %esi
801046f0:	5f                   	pop    %edi
801046f1:	5d                   	pop    %ebp
801046f2:	c3                   	ret    
801046f3:	90                   	nop
801046f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
801046f8:	0f b6 c2             	movzbl %dl,%eax
}
801046fb:	5b                   	pop    %ebx
      return *s1 - *s2;
801046fc:	29 c8                	sub    %ecx,%eax
}
801046fe:	5e                   	pop    %esi
801046ff:	5f                   	pop    %edi
80104700:	5d                   	pop    %ebp
80104701:	c3                   	ret    
80104702:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104710 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104710:	55                   	push   %ebp
80104711:	89 e5                	mov    %esp,%ebp
80104713:	56                   	push   %esi
80104714:	53                   	push   %ebx
80104715:	8b 45 08             	mov    0x8(%ebp),%eax
80104718:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010471b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010471e:	39 c3                	cmp    %eax,%ebx
80104720:	73 26                	jae    80104748 <memmove+0x38>
80104722:	8d 14 33             	lea    (%ebx,%esi,1),%edx
80104725:	39 d0                	cmp    %edx,%eax
80104727:	73 1f                	jae    80104748 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104729:	85 f6                	test   %esi,%esi
8010472b:	8d 56 ff             	lea    -0x1(%esi),%edx
8010472e:	74 0f                	je     8010473f <memmove+0x2f>
      *--d = *--s;
80104730:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104734:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104737:	83 ea 01             	sub    $0x1,%edx
8010473a:	83 fa ff             	cmp    $0xffffffff,%edx
8010473d:	75 f1                	jne    80104730 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010473f:	5b                   	pop    %ebx
80104740:	5e                   	pop    %esi
80104741:	5d                   	pop    %ebp
80104742:	c3                   	ret    
80104743:	90                   	nop
80104744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104748:	31 d2                	xor    %edx,%edx
8010474a:	85 f6                	test   %esi,%esi
8010474c:	74 f1                	je     8010473f <memmove+0x2f>
8010474e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104750:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104754:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104757:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
8010475a:	39 f2                	cmp    %esi,%edx
8010475c:	75 f2                	jne    80104750 <memmove+0x40>
}
8010475e:	5b                   	pop    %ebx
8010475f:	5e                   	pop    %esi
80104760:	5d                   	pop    %ebp
80104761:	c3                   	ret    
80104762:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104770 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104773:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104774:	eb 9a                	jmp    80104710 <memmove>
80104776:	8d 76 00             	lea    0x0(%esi),%esi
80104779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104780 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	57                   	push   %edi
80104784:	56                   	push   %esi
80104785:	8b 7d 10             	mov    0x10(%ebp),%edi
80104788:	53                   	push   %ebx
80104789:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010478c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010478f:	85 ff                	test   %edi,%edi
80104791:	74 2f                	je     801047c2 <strncmp+0x42>
80104793:	0f b6 11             	movzbl (%ecx),%edx
80104796:	0f b6 1e             	movzbl (%esi),%ebx
80104799:	84 d2                	test   %dl,%dl
8010479b:	74 37                	je     801047d4 <strncmp+0x54>
8010479d:	38 d3                	cmp    %dl,%bl
8010479f:	75 33                	jne    801047d4 <strncmp+0x54>
801047a1:	01 f7                	add    %esi,%edi
801047a3:	eb 13                	jmp    801047b8 <strncmp+0x38>
801047a5:	8d 76 00             	lea    0x0(%esi),%esi
801047a8:	0f b6 11             	movzbl (%ecx),%edx
801047ab:	84 d2                	test   %dl,%dl
801047ad:	74 21                	je     801047d0 <strncmp+0x50>
801047af:	0f b6 18             	movzbl (%eax),%ebx
801047b2:	89 c6                	mov    %eax,%esi
801047b4:	38 da                	cmp    %bl,%dl
801047b6:	75 1c                	jne    801047d4 <strncmp+0x54>
    n--, p++, q++;
801047b8:	8d 46 01             	lea    0x1(%esi),%eax
801047bb:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801047be:	39 f8                	cmp    %edi,%eax
801047c0:	75 e6                	jne    801047a8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
801047c2:	5b                   	pop    %ebx
    return 0;
801047c3:	31 c0                	xor    %eax,%eax
}
801047c5:	5e                   	pop    %esi
801047c6:	5f                   	pop    %edi
801047c7:	5d                   	pop    %ebp
801047c8:	c3                   	ret    
801047c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047d0:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
801047d4:	0f b6 c2             	movzbl %dl,%eax
801047d7:	29 d8                	sub    %ebx,%eax
}
801047d9:	5b                   	pop    %ebx
801047da:	5e                   	pop    %esi
801047db:	5f                   	pop    %edi
801047dc:	5d                   	pop    %ebp
801047dd:	c3                   	ret    
801047de:	66 90                	xchg   %ax,%ax

801047e0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	56                   	push   %esi
801047e4:	53                   	push   %ebx
801047e5:	8b 45 08             	mov    0x8(%ebp),%eax
801047e8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801047eb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801047ee:	89 c2                	mov    %eax,%edx
801047f0:	eb 19                	jmp    8010480b <strncpy+0x2b>
801047f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801047f8:	83 c3 01             	add    $0x1,%ebx
801047fb:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
801047ff:	83 c2 01             	add    $0x1,%edx
80104802:	84 c9                	test   %cl,%cl
80104804:	88 4a ff             	mov    %cl,-0x1(%edx)
80104807:	74 09                	je     80104812 <strncpy+0x32>
80104809:	89 f1                	mov    %esi,%ecx
8010480b:	85 c9                	test   %ecx,%ecx
8010480d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104810:	7f e6                	jg     801047f8 <strncpy+0x18>
    ;
  while(n-- > 0)
80104812:	31 c9                	xor    %ecx,%ecx
80104814:	85 f6                	test   %esi,%esi
80104816:	7e 17                	jle    8010482f <strncpy+0x4f>
80104818:	90                   	nop
80104819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104820:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104824:	89 f3                	mov    %esi,%ebx
80104826:	83 c1 01             	add    $0x1,%ecx
80104829:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
8010482b:	85 db                	test   %ebx,%ebx
8010482d:	7f f1                	jg     80104820 <strncpy+0x40>
  return os;
}
8010482f:	5b                   	pop    %ebx
80104830:	5e                   	pop    %esi
80104831:	5d                   	pop    %ebp
80104832:	c3                   	ret    
80104833:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104840 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104840:	55                   	push   %ebp
80104841:	89 e5                	mov    %esp,%ebp
80104843:	56                   	push   %esi
80104844:	53                   	push   %ebx
80104845:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104848:	8b 45 08             	mov    0x8(%ebp),%eax
8010484b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010484e:	85 c9                	test   %ecx,%ecx
80104850:	7e 26                	jle    80104878 <safestrcpy+0x38>
80104852:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104856:	89 c1                	mov    %eax,%ecx
80104858:	eb 17                	jmp    80104871 <safestrcpy+0x31>
8010485a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104860:	83 c2 01             	add    $0x1,%edx
80104863:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104867:	83 c1 01             	add    $0x1,%ecx
8010486a:	84 db                	test   %bl,%bl
8010486c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010486f:	74 04                	je     80104875 <safestrcpy+0x35>
80104871:	39 f2                	cmp    %esi,%edx
80104873:	75 eb                	jne    80104860 <safestrcpy+0x20>
    ;
  *s = 0;
80104875:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104878:	5b                   	pop    %ebx
80104879:	5e                   	pop    %esi
8010487a:	5d                   	pop    %ebp
8010487b:	c3                   	ret    
8010487c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104880 <strlen>:

int
strlen(const char *s)
{
80104880:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104881:	31 c0                	xor    %eax,%eax
{
80104883:	89 e5                	mov    %esp,%ebp
80104885:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104888:	80 3a 00             	cmpb   $0x0,(%edx)
8010488b:	74 0c                	je     80104899 <strlen+0x19>
8010488d:	8d 76 00             	lea    0x0(%esi),%esi
80104890:	83 c0 01             	add    $0x1,%eax
80104893:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104897:	75 f7                	jne    80104890 <strlen+0x10>
    ;
  return n;
}
80104899:	5d                   	pop    %ebp
8010489a:	c3                   	ret    

8010489b <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010489b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010489f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
801048a3:	55                   	push   %ebp
  pushl %ebx
801048a4:	53                   	push   %ebx
  pushl %esi
801048a5:	56                   	push   %esi
  pushl %edi
801048a6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801048a7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801048a9:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
801048ab:	5f                   	pop    %edi
  popl %esi
801048ac:	5e                   	pop    %esi
  popl %ebx
801048ad:	5b                   	pop    %ebx
  popl %ebp
801048ae:	5d                   	pop    %ebp
  ret
801048af:	c3                   	ret    

801048b0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801048b0:	55                   	push   %ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
801048b1:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
{
801048b8:	89 e5                	mov    %esp,%ebp
801048ba:	8b 45 08             	mov    0x8(%ebp),%eax
  if(addr >= proc->sz || addr+4 > proc->sz)
801048bd:	8b 12                	mov    (%edx),%edx
801048bf:	39 c2                	cmp    %eax,%edx
801048c1:	76 15                	jbe    801048d8 <fetchint+0x28>
801048c3:	8d 48 04             	lea    0x4(%eax),%ecx
801048c6:	39 ca                	cmp    %ecx,%edx
801048c8:	72 0e                	jb     801048d8 <fetchint+0x28>
    return -1;
  *ip = *(int*)(addr);
801048ca:	8b 10                	mov    (%eax),%edx
801048cc:	8b 45 0c             	mov    0xc(%ebp),%eax
801048cf:	89 10                	mov    %edx,(%eax)
  return 0;
801048d1:	31 c0                	xor    %eax,%eax
}
801048d3:	5d                   	pop    %ebp
801048d4:	c3                   	ret    
801048d5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801048d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801048dd:	5d                   	pop    %ebp
801048de:	c3                   	ret    
801048df:	90                   	nop

801048e0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801048e0:	55                   	push   %ebp
  char *s, *ep;

  if(addr >= proc->sz)
801048e1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
801048e7:	89 e5                	mov    %esp,%ebp
801048e9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if(addr >= proc->sz)
801048ec:	39 08                	cmp    %ecx,(%eax)
801048ee:	76 2c                	jbe    8010491c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
801048f0:	8b 55 0c             	mov    0xc(%ebp),%edx
801048f3:	89 c8                	mov    %ecx,%eax
801048f5:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
801048f7:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801048fe:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
80104900:	39 d1                	cmp    %edx,%ecx
80104902:	73 18                	jae    8010491c <fetchstr+0x3c>
    if(*s == 0)
80104904:	80 39 00             	cmpb   $0x0,(%ecx)
80104907:	75 0c                	jne    80104915 <fetchstr+0x35>
80104909:	eb 1d                	jmp    80104928 <fetchstr+0x48>
8010490b:	90                   	nop
8010490c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104910:	80 38 00             	cmpb   $0x0,(%eax)
80104913:	74 13                	je     80104928 <fetchstr+0x48>
  for(s = *pp; s < ep; s++)
80104915:	83 c0 01             	add    $0x1,%eax
80104918:	39 c2                	cmp    %eax,%edx
8010491a:	77 f4                	ja     80104910 <fetchstr+0x30>
    return -1;
8010491c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  return -1;
}
80104921:	5d                   	pop    %ebp
80104922:	c3                   	ret    
80104923:	90                   	nop
80104924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return s - *pp;
80104928:	29 c8                	sub    %ecx,%eax
}
8010492a:	5d                   	pop    %ebp
8010492b:	c3                   	ret    
8010492c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104930 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104930:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
{
80104937:	55                   	push   %ebp
80104938:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
8010493a:	8b 42 18             	mov    0x18(%edx),%eax
8010493d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104940:	8b 12                	mov    (%edx),%edx
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104942:	8b 40 44             	mov    0x44(%eax),%eax
80104945:	8d 04 88             	lea    (%eax,%ecx,4),%eax
80104948:	8d 48 04             	lea    0x4(%eax),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
8010494b:	39 d1                	cmp    %edx,%ecx
8010494d:	73 19                	jae    80104968 <argint+0x38>
8010494f:	8d 48 08             	lea    0x8(%eax),%ecx
80104952:	39 ca                	cmp    %ecx,%edx
80104954:	72 12                	jb     80104968 <argint+0x38>
  *ip = *(int*)(addr);
80104956:	8b 50 04             	mov    0x4(%eax),%edx
80104959:	8b 45 0c             	mov    0xc(%ebp),%eax
8010495c:	89 10                	mov    %edx,(%eax)
  return 0;
8010495e:	31 c0                	xor    %eax,%eax
}
80104960:	5d                   	pop    %ebp
80104961:	c3                   	ret    
80104962:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104968:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010496d:	5d                   	pop    %ebp
8010496e:	c3                   	ret    
8010496f:	90                   	nop

80104970 <argptr>:
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104970:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104976:	55                   	push   %ebp
80104977:	89 e5                	mov    %esp,%ebp
80104979:	56                   	push   %esi
8010497a:	53                   	push   %ebx
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
8010497b:	8b 48 18             	mov    0x18(%eax),%ecx
8010497e:	8b 5d 08             	mov    0x8(%ebp),%ebx
{
80104981:	8b 55 10             	mov    0x10(%ebp),%edx
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104984:	8b 49 44             	mov    0x44(%ecx),%ecx
80104987:	8d 1c 99             	lea    (%ecx,%ebx,4),%ebx
  if(addr >= proc->sz || addr+4 > proc->sz)
8010498a:	8b 08                	mov    (%eax),%ecx
  int i;

  if(argint(n, &i) < 0)
    return -1;
8010498c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104991:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= proc->sz || addr+4 > proc->sz)
80104994:	39 ce                	cmp    %ecx,%esi
80104996:	73 1f                	jae    801049b7 <argptr+0x47>
80104998:	8d 73 08             	lea    0x8(%ebx),%esi
8010499b:	39 f1                	cmp    %esi,%ecx
8010499d:	72 18                	jb     801049b7 <argptr+0x47>
  if(size < 0 || (uint)i >= proc->sz || (uint)i+size > proc->sz)
8010499f:	85 d2                	test   %edx,%edx
  *ip = *(int*)(addr);
801049a1:	8b 5b 04             	mov    0x4(%ebx),%ebx
  if(size < 0 || (uint)i >= proc->sz || (uint)i+size > proc->sz)
801049a4:	78 11                	js     801049b7 <argptr+0x47>
801049a6:	39 cb                	cmp    %ecx,%ebx
801049a8:	73 0d                	jae    801049b7 <argptr+0x47>
801049aa:	01 da                	add    %ebx,%edx
801049ac:	39 ca                	cmp    %ecx,%edx
801049ae:	77 07                	ja     801049b7 <argptr+0x47>
    return -1;
  *pp = (char*)i;
801049b0:	8b 45 0c             	mov    0xc(%ebp),%eax
801049b3:	89 18                	mov    %ebx,(%eax)
  return 0;
801049b5:	31 c0                	xor    %eax,%eax
}
801049b7:	5b                   	pop    %ebx
801049b8:	5e                   	pop    %esi
801049b9:	5d                   	pop    %ebp
801049ba:	c3                   	ret    
801049bb:	90                   	nop
801049bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801049c0 <argstr>:
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801049c0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801049c6:	55                   	push   %ebp
801049c7:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801049c9:	8b 50 18             	mov    0x18(%eax),%edx
801049cc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
801049cf:	8b 00                	mov    (%eax),%eax
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801049d1:	8b 52 44             	mov    0x44(%edx),%edx
801049d4:	8d 14 8a             	lea    (%edx,%ecx,4),%edx
801049d7:	8d 4a 04             	lea    0x4(%edx),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
801049da:	39 c1                	cmp    %eax,%ecx
801049dc:	73 3e                	jae    80104a1c <argstr+0x5c>
801049de:	8d 4a 08             	lea    0x8(%edx),%ecx
801049e1:	39 c8                	cmp    %ecx,%eax
801049e3:	72 37                	jb     80104a1c <argstr+0x5c>
  *ip = *(int*)(addr);
801049e5:	8b 4a 04             	mov    0x4(%edx),%ecx
  if(addr >= proc->sz)
801049e8:	39 c1                	cmp    %eax,%ecx
801049ea:	73 30                	jae    80104a1c <argstr+0x5c>
  *pp = (char*)addr;
801049ec:	8b 55 0c             	mov    0xc(%ebp),%edx
801049ef:	89 c8                	mov    %ecx,%eax
801049f1:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
801049f3:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801049fa:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
801049fc:	39 d1                	cmp    %edx,%ecx
801049fe:	73 1c                	jae    80104a1c <argstr+0x5c>
    if(*s == 0)
80104a00:	80 39 00             	cmpb   $0x0,(%ecx)
80104a03:	75 10                	jne    80104a15 <argstr+0x55>
80104a05:	eb 21                	jmp    80104a28 <argstr+0x68>
80104a07:	89 f6                	mov    %esi,%esi
80104a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104a10:	80 38 00             	cmpb   $0x0,(%eax)
80104a13:	74 13                	je     80104a28 <argstr+0x68>
  for(s = *pp; s < ep; s++)
80104a15:	83 c0 01             	add    $0x1,%eax
80104a18:	39 c2                	cmp    %eax,%edx
80104a1a:	77 f4                	ja     80104a10 <argstr+0x50>
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104a1c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80104a21:	5d                   	pop    %ebp
80104a22:	c3                   	ret    
80104a23:	90                   	nop
80104a24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return s - *pp;
80104a28:	29 c8                	sub    %ecx,%eax
}
80104a2a:	5d                   	pop    %ebp
80104a2b:	c3                   	ret    
80104a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104a30 <syscall>:
[SYS_clone_jared]   sys_clone_jared,
};

void
syscall(void)
{
80104a30:	55                   	push   %ebp
80104a31:	89 e5                	mov    %esp,%ebp
80104a33:	53                   	push   %ebx
80104a34:	83 ec 04             	sub    $0x4,%esp
  int num;

  num = proc->tf->eax;
80104a37:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104a3e:	8b 5a 18             	mov    0x18(%edx),%ebx
80104a41:	8b 43 1c             	mov    0x1c(%ebx),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104a44:	8d 48 ff             	lea    -0x1(%eax),%ecx
80104a47:	83 f9 17             	cmp    $0x17,%ecx
80104a4a:	77 1c                	ja     80104a68 <syscall+0x38>
80104a4c:	8b 0c 85 a0 7a 10 80 	mov    -0x7fef8560(,%eax,4),%ecx
80104a53:	85 c9                	test   %ecx,%ecx
80104a55:	74 11                	je     80104a68 <syscall+0x38>
    proc->tf->eax = syscalls[num]();
80104a57:	ff d1                	call   *%ecx
80104a59:	89 43 1c             	mov    %eax,0x1c(%ebx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  }
}
80104a5c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a5f:	c9                   	leave  
80104a60:	c3                   	ret    
80104a61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104a68:	50                   	push   %eax
            proc->pid, proc->name, num);
80104a69:	8d 42 6c             	lea    0x6c(%edx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104a6c:	50                   	push   %eax
80104a6d:	ff 72 10             	pushl  0x10(%edx)
80104a70:	68 71 7a 10 80       	push   $0x80107a71
80104a75:	e8 e6 bb ff ff       	call   80100660 <cprintf>
    proc->tf->eax = -1;
80104a7a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a80:	83 c4 10             	add    $0x10,%esp
80104a83:	8b 40 18             	mov    0x18(%eax),%eax
80104a86:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104a8d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a90:	c9                   	leave  
80104a91:	c3                   	ret    
80104a92:	66 90                	xchg   %ax,%ax
80104a94:	66 90                	xchg   %ax,%ax
80104a96:	66 90                	xchg   %ax,%ax
80104a98:	66 90                	xchg   %ax,%ax
80104a9a:	66 90                	xchg   %ax,%ax
80104a9c:	66 90                	xchg   %ax,%ax
80104a9e:	66 90                	xchg   %ax,%ax

80104aa0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104aa0:	55                   	push   %ebp
80104aa1:	89 e5                	mov    %esp,%ebp
80104aa3:	57                   	push   %edi
80104aa4:	56                   	push   %esi
80104aa5:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104aa6:	8d 5d da             	lea    -0x26(%ebp),%ebx
{
80104aa9:	83 ec 44             	sub    $0x44,%esp
80104aac:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104aaf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104ab2:	53                   	push   %ebx
80104ab3:	50                   	push   %eax
{
80104ab4:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104ab7:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104aba:	e8 f1 d3 ff ff       	call   80101eb0 <nameiparent>
80104abf:	83 c4 10             	add    $0x10,%esp
80104ac2:	85 c0                	test   %eax,%eax
80104ac4:	0f 84 f6 00 00 00    	je     80104bc0 <create+0x120>
    return 0;
  ilock(dp);
80104aca:	83 ec 0c             	sub    $0xc,%esp
80104acd:	89 c6                	mov    %eax,%esi
80104acf:	50                   	push   %eax
80104ad0:	e8 8b cb ff ff       	call   80101660 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104ad5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104ad8:	83 c4 0c             	add    $0xc,%esp
80104adb:	50                   	push   %eax
80104adc:	53                   	push   %ebx
80104add:	56                   	push   %esi
80104ade:	e8 8d d0 ff ff       	call   80101b70 <dirlookup>
80104ae3:	83 c4 10             	add    $0x10,%esp
80104ae6:	85 c0                	test   %eax,%eax
80104ae8:	89 c7                	mov    %eax,%edi
80104aea:	74 54                	je     80104b40 <create+0xa0>
    iunlockput(dp);
80104aec:	83 ec 0c             	sub    $0xc,%esp
80104aef:	56                   	push   %esi
80104af0:	e8 db cd ff ff       	call   801018d0 <iunlockput>
    ilock(ip);
80104af5:	89 3c 24             	mov    %edi,(%esp)
80104af8:	e8 63 cb ff ff       	call   80101660 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104afd:	83 c4 10             	add    $0x10,%esp
80104b00:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104b05:	75 19                	jne    80104b20 <create+0x80>
80104b07:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104b0c:	75 12                	jne    80104b20 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104b0e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b11:	89 f8                	mov    %edi,%eax
80104b13:	5b                   	pop    %ebx
80104b14:	5e                   	pop    %esi
80104b15:	5f                   	pop    %edi
80104b16:	5d                   	pop    %ebp
80104b17:	c3                   	ret    
80104b18:	90                   	nop
80104b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80104b20:	83 ec 0c             	sub    $0xc,%esp
80104b23:	57                   	push   %edi
    return 0;
80104b24:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104b26:	e8 a5 cd ff ff       	call   801018d0 <iunlockput>
    return 0;
80104b2b:	83 c4 10             	add    $0x10,%esp
}
80104b2e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b31:	89 f8                	mov    %edi,%eax
80104b33:	5b                   	pop    %ebx
80104b34:	5e                   	pop    %esi
80104b35:	5f                   	pop    %edi
80104b36:	5d                   	pop    %ebp
80104b37:	c3                   	ret    
80104b38:	90                   	nop
80104b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = ialloc(dp->dev, type)) == 0)
80104b40:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104b44:	83 ec 08             	sub    $0x8,%esp
80104b47:	50                   	push   %eax
80104b48:	ff 36                	pushl  (%esi)
80104b4a:	e8 a1 c9 ff ff       	call   801014f0 <ialloc>
80104b4f:	83 c4 10             	add    $0x10,%esp
80104b52:	85 c0                	test   %eax,%eax
80104b54:	89 c7                	mov    %eax,%edi
80104b56:	0f 84 cc 00 00 00    	je     80104c28 <create+0x188>
  ilock(ip);
80104b5c:	83 ec 0c             	sub    $0xc,%esp
80104b5f:	50                   	push   %eax
80104b60:	e8 fb ca ff ff       	call   80101660 <ilock>
  ip->major = major;
80104b65:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104b69:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104b6d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104b71:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104b75:	b8 01 00 00 00       	mov    $0x1,%eax
80104b7a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104b7e:	89 3c 24             	mov    %edi,(%esp)
80104b81:	e8 2a ca ff ff       	call   801015b0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104b86:	83 c4 10             	add    $0x10,%esp
80104b89:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104b8e:	74 40                	je     80104bd0 <create+0x130>
  if(dirlink(dp, name, ip->inum) < 0)
80104b90:	83 ec 04             	sub    $0x4,%esp
80104b93:	ff 77 04             	pushl  0x4(%edi)
80104b96:	53                   	push   %ebx
80104b97:	56                   	push   %esi
80104b98:	e8 33 d2 ff ff       	call   80101dd0 <dirlink>
80104b9d:	83 c4 10             	add    $0x10,%esp
80104ba0:	85 c0                	test   %eax,%eax
80104ba2:	78 77                	js     80104c1b <create+0x17b>
  iunlockput(dp);
80104ba4:	83 ec 0c             	sub    $0xc,%esp
80104ba7:	56                   	push   %esi
80104ba8:	e8 23 cd ff ff       	call   801018d0 <iunlockput>
  return ip;
80104bad:	83 c4 10             	add    $0x10,%esp
}
80104bb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bb3:	89 f8                	mov    %edi,%eax
80104bb5:	5b                   	pop    %ebx
80104bb6:	5e                   	pop    %esi
80104bb7:	5f                   	pop    %edi
80104bb8:	5d                   	pop    %ebp
80104bb9:	c3                   	ret    
80104bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return 0;
80104bc0:	31 ff                	xor    %edi,%edi
80104bc2:	e9 47 ff ff ff       	jmp    80104b0e <create+0x6e>
80104bc7:	89 f6                	mov    %esi,%esi
80104bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    dp->nlink++;  // for ".."
80104bd0:	66 83 46 56 01       	addw   $0x1,0x56(%esi)
    iupdate(dp);
80104bd5:	83 ec 0c             	sub    $0xc,%esp
80104bd8:	56                   	push   %esi
80104bd9:	e8 d2 c9 ff ff       	call   801015b0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104bde:	83 c4 0c             	add    $0xc,%esp
80104be1:	ff 77 04             	pushl  0x4(%edi)
80104be4:	68 20 7b 10 80       	push   $0x80107b20
80104be9:	57                   	push   %edi
80104bea:	e8 e1 d1 ff ff       	call   80101dd0 <dirlink>
80104bef:	83 c4 10             	add    $0x10,%esp
80104bf2:	85 c0                	test   %eax,%eax
80104bf4:	78 18                	js     80104c0e <create+0x16e>
80104bf6:	83 ec 04             	sub    $0x4,%esp
80104bf9:	ff 76 04             	pushl  0x4(%esi)
80104bfc:	68 1f 7b 10 80       	push   $0x80107b1f
80104c01:	57                   	push   %edi
80104c02:	e8 c9 d1 ff ff       	call   80101dd0 <dirlink>
80104c07:	83 c4 10             	add    $0x10,%esp
80104c0a:	85 c0                	test   %eax,%eax
80104c0c:	79 82                	jns    80104b90 <create+0xf0>
      panic("create dots");
80104c0e:	83 ec 0c             	sub    $0xc,%esp
80104c11:	68 13 7b 10 80       	push   $0x80107b13
80104c16:	e8 55 b7 ff ff       	call   80100370 <panic>
    panic("create: dirlink");
80104c1b:	83 ec 0c             	sub    $0xc,%esp
80104c1e:	68 22 7b 10 80       	push   $0x80107b22
80104c23:	e8 48 b7 ff ff       	call   80100370 <panic>
    panic("create: ialloc");
80104c28:	83 ec 0c             	sub    $0xc,%esp
80104c2b:	68 04 7b 10 80       	push   $0x80107b04
80104c30:	e8 3b b7 ff ff       	call   80100370 <panic>
80104c35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c40 <argfd.constprop.1>:
argfd(int n, int *pfd, struct file **pf)
80104c40:	55                   	push   %ebp
80104c41:	89 e5                	mov    %esp,%ebp
80104c43:	56                   	push   %esi
80104c44:	53                   	push   %ebx
80104c45:	89 c6                	mov    %eax,%esi
  if(argint(n, &fd) < 0)
80104c47:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104c4a:	89 d3                	mov    %edx,%ebx
80104c4c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104c4f:	50                   	push   %eax
80104c50:	6a 00                	push   $0x0
80104c52:	e8 d9 fc ff ff       	call   80104930 <argint>
80104c57:	83 c4 10             	add    $0x10,%esp
80104c5a:	85 c0                	test   %eax,%eax
80104c5c:	78 3a                	js     80104c98 <argfd.constprop.1+0x58>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80104c5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c61:	83 f8 0f             	cmp    $0xf,%eax
80104c64:	77 32                	ja     80104c98 <argfd.constprop.1+0x58>
80104c66:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104c6d:	8b 54 82 28          	mov    0x28(%edx,%eax,4),%edx
80104c71:	85 d2                	test   %edx,%edx
80104c73:	74 23                	je     80104c98 <argfd.constprop.1+0x58>
  if(pfd)
80104c75:	85 f6                	test   %esi,%esi
80104c77:	74 02                	je     80104c7b <argfd.constprop.1+0x3b>
    *pfd = fd;
80104c79:	89 06                	mov    %eax,(%esi)
  if(pf)
80104c7b:	85 db                	test   %ebx,%ebx
80104c7d:	74 11                	je     80104c90 <argfd.constprop.1+0x50>
    *pf = f;
80104c7f:	89 13                	mov    %edx,(%ebx)
  return 0;
80104c81:	31 c0                	xor    %eax,%eax
}
80104c83:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c86:	5b                   	pop    %ebx
80104c87:	5e                   	pop    %esi
80104c88:	5d                   	pop    %ebp
80104c89:	c3                   	ret    
80104c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return 0;
80104c90:	31 c0                	xor    %eax,%eax
80104c92:	eb ef                	jmp    80104c83 <argfd.constprop.1+0x43>
80104c94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104c98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c9d:	eb e4                	jmp    80104c83 <argfd.constprop.1+0x43>
80104c9f:	90                   	nop

80104ca0 <sys_dup>:
{
80104ca0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104ca1:	31 c0                	xor    %eax,%eax
{
80104ca3:	89 e5                	mov    %esp,%ebp
80104ca5:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104ca6:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104ca9:	83 ec 14             	sub    $0x14,%esp
  if(argfd(0, 0, &f) < 0)
80104cac:	e8 8f ff ff ff       	call   80104c40 <argfd.constprop.1>
80104cb1:	85 c0                	test   %eax,%eax
80104cb3:	78 1b                	js     80104cd0 <sys_dup+0x30>
  if((fd=fdalloc(f)) < 0)
80104cb5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104cb8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  for(fd = 0; fd < NOFILE; fd++){
80104cbe:	31 db                	xor    %ebx,%ebx
    if(proc->ofile[fd] == 0){
80104cc0:	8b 4c 98 28          	mov    0x28(%eax,%ebx,4),%ecx
80104cc4:	85 c9                	test   %ecx,%ecx
80104cc6:	74 18                	je     80104ce0 <sys_dup+0x40>
  for(fd = 0; fd < NOFILE; fd++){
80104cc8:	83 c3 01             	add    $0x1,%ebx
80104ccb:	83 fb 10             	cmp    $0x10,%ebx
80104cce:	75 f0                	jne    80104cc0 <sys_dup+0x20>
    return -1;
80104cd0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104cd5:	89 d8                	mov    %ebx,%eax
80104cd7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104cda:	c9                   	leave  
80104cdb:	c3                   	ret    
80104cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  filedup(f);
80104ce0:	83 ec 0c             	sub    $0xc,%esp
      proc->ofile[fd] = f;
80104ce3:	89 54 98 28          	mov    %edx,0x28(%eax,%ebx,4)
  filedup(f);
80104ce7:	52                   	push   %edx
80104ce8:	e8 d3 c0 ff ff       	call   80100dc0 <filedup>
}
80104ced:	89 d8                	mov    %ebx,%eax
  return fd;
80104cef:	83 c4 10             	add    $0x10,%esp
}
80104cf2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104cf5:	c9                   	leave  
80104cf6:	c3                   	ret    
80104cf7:	89 f6                	mov    %esi,%esi
80104cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d00 <sys_dup2>:
sys_dup2(void) {
80104d00:	55                   	push   %ebp
	if(argfd(0, 0, &f) < 0)
80104d01:	31 c0                	xor    %eax,%eax
sys_dup2(void) {
80104d03:	89 e5                	mov    %esp,%ebp
80104d05:	83 ec 18             	sub    $0x18,%esp
	if(argfd(0, 0, &f) < 0)
80104d08:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104d0b:	e8 30 ff ff ff       	call   80104c40 <argfd.constprop.1>
80104d10:	85 c0                	test   %eax,%eax
80104d12:	78 5c                	js     80104d70 <sys_dup2+0x70>
	if(argint(1, &fd) < 0)
80104d14:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d17:	83 ec 08             	sub    $0x8,%esp
80104d1a:	50                   	push   %eax
80104d1b:	6a 01                	push   $0x1
80104d1d:	e8 0e fc ff ff       	call   80104930 <argint>
80104d22:	83 c4 10             	add    $0x10,%esp
80104d25:	85 c0                	test   %eax,%eax
80104d27:	78 47                	js     80104d70 <sys_dup2+0x70>
	if(fd < 0 || fd >= NOFILE)
80104d29:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d2c:	83 f8 0f             	cmp    $0xf,%eax
80104d2f:	77 3f                	ja     80104d70 <sys_dup2+0x70>
	if(proc->ofile[fd])
80104d31:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104d38:	8b 44 82 28          	mov    0x28(%edx,%eax,4),%eax
80104d3c:	85 c0                	test   %eax,%eax
80104d3e:	74 0c                	je     80104d4c <sys_dup2+0x4c>
		fileclose(proc->ofile[fd]);
80104d40:	83 ec 0c             	sub    $0xc,%esp
80104d43:	50                   	push   %eax
80104d44:	e8 c7 c0 ff ff       	call   80100e10 <fileclose>
80104d49:	83 c4 10             	add    $0x10,%esp
	filedup(f);
80104d4c:	83 ec 0c             	sub    $0xc,%esp
80104d4f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d52:	e8 69 c0 ff ff       	call   80100dc0 <filedup>
	proc->ofile[fd] = f;
80104d57:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d5d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
	return 0;
80104d60:	83 c4 10             	add    $0x10,%esp
	proc->ofile[fd] = f;
80104d63:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104d66:	89 4c 90 28          	mov    %ecx,0x28(%eax,%edx,4)
	return 0;
80104d6a:	31 c0                	xor    %eax,%eax
}
80104d6c:	c9                   	leave  
80104d6d:	c3                   	ret    
80104d6e:	66 90                	xchg   %ax,%ax
		return -1;
80104d70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d75:	c9                   	leave  
80104d76:	c3                   	ret    
80104d77:	89 f6                	mov    %esi,%esi
80104d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d80 <sys_read>:
{
80104d80:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d81:	31 c0                	xor    %eax,%eax
{
80104d83:	89 e5                	mov    %esp,%ebp
80104d85:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d88:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d8b:	e8 b0 fe ff ff       	call   80104c40 <argfd.constprop.1>
80104d90:	85 c0                	test   %eax,%eax
80104d92:	78 4c                	js     80104de0 <sys_read+0x60>
80104d94:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d97:	83 ec 08             	sub    $0x8,%esp
80104d9a:	50                   	push   %eax
80104d9b:	6a 02                	push   $0x2
80104d9d:	e8 8e fb ff ff       	call   80104930 <argint>
80104da2:	83 c4 10             	add    $0x10,%esp
80104da5:	85 c0                	test   %eax,%eax
80104da7:	78 37                	js     80104de0 <sys_read+0x60>
80104da9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104dac:	83 ec 04             	sub    $0x4,%esp
80104daf:	ff 75 f0             	pushl  -0x10(%ebp)
80104db2:	50                   	push   %eax
80104db3:	6a 01                	push   $0x1
80104db5:	e8 b6 fb ff ff       	call   80104970 <argptr>
80104dba:	83 c4 10             	add    $0x10,%esp
80104dbd:	85 c0                	test   %eax,%eax
80104dbf:	78 1f                	js     80104de0 <sys_read+0x60>
  return fileread(f, p, n);
80104dc1:	83 ec 04             	sub    $0x4,%esp
80104dc4:	ff 75 f0             	pushl  -0x10(%ebp)
80104dc7:	ff 75 f4             	pushl  -0xc(%ebp)
80104dca:	ff 75 ec             	pushl  -0x14(%ebp)
80104dcd:	e8 5e c1 ff ff       	call   80100f30 <fileread>
80104dd2:	83 c4 10             	add    $0x10,%esp
}
80104dd5:	c9                   	leave  
80104dd6:	c3                   	ret    
80104dd7:	89 f6                	mov    %esi,%esi
80104dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104de0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104de5:	c9                   	leave  
80104de6:	c3                   	ret    
80104de7:	89 f6                	mov    %esi,%esi
80104de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104df0 <sys_write>:
{
80104df0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104df1:	31 c0                	xor    %eax,%eax
{
80104df3:	89 e5                	mov    %esp,%ebp
80104df5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104df8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104dfb:	e8 40 fe ff ff       	call   80104c40 <argfd.constprop.1>
80104e00:	85 c0                	test   %eax,%eax
80104e02:	78 4c                	js     80104e50 <sys_write+0x60>
80104e04:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e07:	83 ec 08             	sub    $0x8,%esp
80104e0a:	50                   	push   %eax
80104e0b:	6a 02                	push   $0x2
80104e0d:	e8 1e fb ff ff       	call   80104930 <argint>
80104e12:	83 c4 10             	add    $0x10,%esp
80104e15:	85 c0                	test   %eax,%eax
80104e17:	78 37                	js     80104e50 <sys_write+0x60>
80104e19:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e1c:	83 ec 04             	sub    $0x4,%esp
80104e1f:	ff 75 f0             	pushl  -0x10(%ebp)
80104e22:	50                   	push   %eax
80104e23:	6a 01                	push   $0x1
80104e25:	e8 46 fb ff ff       	call   80104970 <argptr>
80104e2a:	83 c4 10             	add    $0x10,%esp
80104e2d:	85 c0                	test   %eax,%eax
80104e2f:	78 1f                	js     80104e50 <sys_write+0x60>
  return filewrite(f, p, n);
80104e31:	83 ec 04             	sub    $0x4,%esp
80104e34:	ff 75 f0             	pushl  -0x10(%ebp)
80104e37:	ff 75 f4             	pushl  -0xc(%ebp)
80104e3a:	ff 75 ec             	pushl  -0x14(%ebp)
80104e3d:	e8 7e c1 ff ff       	call   80100fc0 <filewrite>
80104e42:	83 c4 10             	add    $0x10,%esp
}
80104e45:	c9                   	leave  
80104e46:	c3                   	ret    
80104e47:	89 f6                	mov    %esi,%esi
80104e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104e50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e55:	c9                   	leave  
80104e56:	c3                   	ret    
80104e57:	89 f6                	mov    %esi,%esi
80104e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e60 <sys_close>:
{
80104e60:	55                   	push   %ebp
80104e61:	89 e5                	mov    %esp,%ebp
80104e63:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104e66:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104e69:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e6c:	e8 cf fd ff ff       	call   80104c40 <argfd.constprop.1>
80104e71:	85 c0                	test   %eax,%eax
80104e73:	78 2b                	js     80104ea0 <sys_close+0x40>
  proc->ofile[fd] = 0;
80104e75:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104e78:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  fileclose(f);
80104e7e:	83 ec 0c             	sub    $0xc,%esp
  proc->ofile[fd] = 0;
80104e81:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104e88:	00 
  fileclose(f);
80104e89:	ff 75 f4             	pushl  -0xc(%ebp)
80104e8c:	e8 7f bf ff ff       	call   80100e10 <fileclose>
  return 0;
80104e91:	83 c4 10             	add    $0x10,%esp
80104e94:	31 c0                	xor    %eax,%eax
}
80104e96:	c9                   	leave  
80104e97:	c3                   	ret    
80104e98:	90                   	nop
80104e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104ea0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ea5:	c9                   	leave  
80104ea6:	c3                   	ret    
80104ea7:	89 f6                	mov    %esi,%esi
80104ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104eb0 <sys_fstat>:
{
80104eb0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104eb1:	31 c0                	xor    %eax,%eax
{
80104eb3:	89 e5                	mov    %esp,%ebp
80104eb5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104eb8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104ebb:	e8 80 fd ff ff       	call   80104c40 <argfd.constprop.1>
80104ec0:	85 c0                	test   %eax,%eax
80104ec2:	78 2c                	js     80104ef0 <sys_fstat+0x40>
80104ec4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ec7:	83 ec 04             	sub    $0x4,%esp
80104eca:	6a 14                	push   $0x14
80104ecc:	50                   	push   %eax
80104ecd:	6a 01                	push   $0x1
80104ecf:	e8 9c fa ff ff       	call   80104970 <argptr>
80104ed4:	83 c4 10             	add    $0x10,%esp
80104ed7:	85 c0                	test   %eax,%eax
80104ed9:	78 15                	js     80104ef0 <sys_fstat+0x40>
  return filestat(f, st);
80104edb:	83 ec 08             	sub    $0x8,%esp
80104ede:	ff 75 f4             	pushl  -0xc(%ebp)
80104ee1:	ff 75 f0             	pushl  -0x10(%ebp)
80104ee4:	e8 f7 bf ff ff       	call   80100ee0 <filestat>
80104ee9:	83 c4 10             	add    $0x10,%esp
}
80104eec:	c9                   	leave  
80104eed:	c3                   	ret    
80104eee:	66 90                	xchg   %ax,%ax
    return -1;
80104ef0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ef5:	c9                   	leave  
80104ef6:	c3                   	ret    
80104ef7:	89 f6                	mov    %esi,%esi
80104ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f00 <sys_link>:
{
80104f00:	55                   	push   %ebp
80104f01:	89 e5                	mov    %esp,%ebp
80104f03:	57                   	push   %edi
80104f04:	56                   	push   %esi
80104f05:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104f06:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104f09:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104f0c:	50                   	push   %eax
80104f0d:	6a 00                	push   $0x0
80104f0f:	e8 ac fa ff ff       	call   801049c0 <argstr>
80104f14:	83 c4 10             	add    $0x10,%esp
80104f17:	85 c0                	test   %eax,%eax
80104f19:	0f 88 fb 00 00 00    	js     8010501a <sys_link+0x11a>
80104f1f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104f22:	83 ec 08             	sub    $0x8,%esp
80104f25:	50                   	push   %eax
80104f26:	6a 01                	push   $0x1
80104f28:	e8 93 fa ff ff       	call   801049c0 <argstr>
80104f2d:	83 c4 10             	add    $0x10,%esp
80104f30:	85 c0                	test   %eax,%eax
80104f32:	0f 88 e2 00 00 00    	js     8010501a <sys_link+0x11a>
  begin_op();
80104f38:	e8 a3 dc ff ff       	call   80102be0 <begin_op>
  if((ip = namei(old)) == 0){
80104f3d:	83 ec 0c             	sub    $0xc,%esp
80104f40:	ff 75 d4             	pushl  -0x2c(%ebp)
80104f43:	e8 48 cf ff ff       	call   80101e90 <namei>
80104f48:	83 c4 10             	add    $0x10,%esp
80104f4b:	85 c0                	test   %eax,%eax
80104f4d:	89 c3                	mov    %eax,%ebx
80104f4f:	0f 84 f3 00 00 00    	je     80105048 <sys_link+0x148>
  ilock(ip);
80104f55:	83 ec 0c             	sub    $0xc,%esp
80104f58:	50                   	push   %eax
80104f59:	e8 02 c7 ff ff       	call   80101660 <ilock>
  if(ip->type == T_DIR){
80104f5e:	83 c4 10             	add    $0x10,%esp
80104f61:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f66:	0f 84 c4 00 00 00    	je     80105030 <sys_link+0x130>
  ip->nlink++;
80104f6c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f71:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80104f74:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104f77:	53                   	push   %ebx
80104f78:	e8 33 c6 ff ff       	call   801015b0 <iupdate>
  iunlock(ip);
80104f7d:	89 1c 24             	mov    %ebx,(%esp)
80104f80:	e8 bb c7 ff ff       	call   80101740 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104f85:	58                   	pop    %eax
80104f86:	5a                   	pop    %edx
80104f87:	57                   	push   %edi
80104f88:	ff 75 d0             	pushl  -0x30(%ebp)
80104f8b:	e8 20 cf ff ff       	call   80101eb0 <nameiparent>
80104f90:	83 c4 10             	add    $0x10,%esp
80104f93:	85 c0                	test   %eax,%eax
80104f95:	89 c6                	mov    %eax,%esi
80104f97:	74 5b                	je     80104ff4 <sys_link+0xf4>
  ilock(dp);
80104f99:	83 ec 0c             	sub    $0xc,%esp
80104f9c:	50                   	push   %eax
80104f9d:	e8 be c6 ff ff       	call   80101660 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104fa2:	83 c4 10             	add    $0x10,%esp
80104fa5:	8b 03                	mov    (%ebx),%eax
80104fa7:	39 06                	cmp    %eax,(%esi)
80104fa9:	75 3d                	jne    80104fe8 <sys_link+0xe8>
80104fab:	83 ec 04             	sub    $0x4,%esp
80104fae:	ff 73 04             	pushl  0x4(%ebx)
80104fb1:	57                   	push   %edi
80104fb2:	56                   	push   %esi
80104fb3:	e8 18 ce ff ff       	call   80101dd0 <dirlink>
80104fb8:	83 c4 10             	add    $0x10,%esp
80104fbb:	85 c0                	test   %eax,%eax
80104fbd:	78 29                	js     80104fe8 <sys_link+0xe8>
  iunlockput(dp);
80104fbf:	83 ec 0c             	sub    $0xc,%esp
80104fc2:	56                   	push   %esi
80104fc3:	e8 08 c9 ff ff       	call   801018d0 <iunlockput>
  iput(ip);
80104fc8:	89 1c 24             	mov    %ebx,(%esp)
80104fcb:	e8 c0 c7 ff ff       	call   80101790 <iput>
  end_op();
80104fd0:	e8 7b dc ff ff       	call   80102c50 <end_op>
  return 0;
80104fd5:	83 c4 10             	add    $0x10,%esp
80104fd8:	31 c0                	xor    %eax,%eax
}
80104fda:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104fdd:	5b                   	pop    %ebx
80104fde:	5e                   	pop    %esi
80104fdf:	5f                   	pop    %edi
80104fe0:	5d                   	pop    %ebp
80104fe1:	c3                   	ret    
80104fe2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80104fe8:	83 ec 0c             	sub    $0xc,%esp
80104feb:	56                   	push   %esi
80104fec:	e8 df c8 ff ff       	call   801018d0 <iunlockput>
    goto bad;
80104ff1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80104ff4:	83 ec 0c             	sub    $0xc,%esp
80104ff7:	53                   	push   %ebx
80104ff8:	e8 63 c6 ff ff       	call   80101660 <ilock>
  ip->nlink--;
80104ffd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105002:	89 1c 24             	mov    %ebx,(%esp)
80105005:	e8 a6 c5 ff ff       	call   801015b0 <iupdate>
  iunlockput(ip);
8010500a:	89 1c 24             	mov    %ebx,(%esp)
8010500d:	e8 be c8 ff ff       	call   801018d0 <iunlockput>
  end_op();
80105012:	e8 39 dc ff ff       	call   80102c50 <end_op>
  return -1;
80105017:	83 c4 10             	add    $0x10,%esp
}
8010501a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010501d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105022:	5b                   	pop    %ebx
80105023:	5e                   	pop    %esi
80105024:	5f                   	pop    %edi
80105025:	5d                   	pop    %ebp
80105026:	c3                   	ret    
80105027:	89 f6                	mov    %esi,%esi
80105029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105030:	83 ec 0c             	sub    $0xc,%esp
80105033:	53                   	push   %ebx
80105034:	e8 97 c8 ff ff       	call   801018d0 <iunlockput>
    end_op();
80105039:	e8 12 dc ff ff       	call   80102c50 <end_op>
    return -1;
8010503e:	83 c4 10             	add    $0x10,%esp
80105041:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105046:	eb 92                	jmp    80104fda <sys_link+0xda>
    end_op();
80105048:	e8 03 dc ff ff       	call   80102c50 <end_op>
    return -1;
8010504d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105052:	eb 86                	jmp    80104fda <sys_link+0xda>
80105054:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010505a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105060 <sys_unlink>:
{
80105060:	55                   	push   %ebp
80105061:	89 e5                	mov    %esp,%ebp
80105063:	57                   	push   %edi
80105064:	56                   	push   %esi
80105065:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80105066:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105069:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
8010506c:	50                   	push   %eax
8010506d:	6a 00                	push   $0x0
8010506f:	e8 4c f9 ff ff       	call   801049c0 <argstr>
80105074:	83 c4 10             	add    $0x10,%esp
80105077:	85 c0                	test   %eax,%eax
80105079:	0f 88 82 01 00 00    	js     80105201 <sys_unlink+0x1a1>
  if((dp = nameiparent(path, name)) == 0){
8010507f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105082:	e8 59 db ff ff       	call   80102be0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105087:	83 ec 08             	sub    $0x8,%esp
8010508a:	53                   	push   %ebx
8010508b:	ff 75 c0             	pushl  -0x40(%ebp)
8010508e:	e8 1d ce ff ff       	call   80101eb0 <nameiparent>
80105093:	83 c4 10             	add    $0x10,%esp
80105096:	85 c0                	test   %eax,%eax
80105098:	89 45 b4             	mov    %eax,-0x4c(%ebp)
8010509b:	0f 84 6a 01 00 00    	je     8010520b <sys_unlink+0x1ab>
  ilock(dp);
801050a1:	8b 75 b4             	mov    -0x4c(%ebp),%esi
801050a4:	83 ec 0c             	sub    $0xc,%esp
801050a7:	56                   	push   %esi
801050a8:	e8 b3 c5 ff ff       	call   80101660 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801050ad:	58                   	pop    %eax
801050ae:	5a                   	pop    %edx
801050af:	68 20 7b 10 80       	push   $0x80107b20
801050b4:	53                   	push   %ebx
801050b5:	e8 96 ca ff ff       	call   80101b50 <namecmp>
801050ba:	83 c4 10             	add    $0x10,%esp
801050bd:	85 c0                	test   %eax,%eax
801050bf:	0f 84 fc 00 00 00    	je     801051c1 <sys_unlink+0x161>
801050c5:	83 ec 08             	sub    $0x8,%esp
801050c8:	68 1f 7b 10 80       	push   $0x80107b1f
801050cd:	53                   	push   %ebx
801050ce:	e8 7d ca ff ff       	call   80101b50 <namecmp>
801050d3:	83 c4 10             	add    $0x10,%esp
801050d6:	85 c0                	test   %eax,%eax
801050d8:	0f 84 e3 00 00 00    	je     801051c1 <sys_unlink+0x161>
  if((ip = dirlookup(dp, name, &off)) == 0)
801050de:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801050e1:	83 ec 04             	sub    $0x4,%esp
801050e4:	50                   	push   %eax
801050e5:	53                   	push   %ebx
801050e6:	56                   	push   %esi
801050e7:	e8 84 ca ff ff       	call   80101b70 <dirlookup>
801050ec:	83 c4 10             	add    $0x10,%esp
801050ef:	85 c0                	test   %eax,%eax
801050f1:	89 c3                	mov    %eax,%ebx
801050f3:	0f 84 c8 00 00 00    	je     801051c1 <sys_unlink+0x161>
  ilock(ip);
801050f9:	83 ec 0c             	sub    $0xc,%esp
801050fc:	50                   	push   %eax
801050fd:	e8 5e c5 ff ff       	call   80101660 <ilock>
  if(ip->nlink < 1)
80105102:	83 c4 10             	add    $0x10,%esp
80105105:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010510a:	0f 8e 24 01 00 00    	jle    80105234 <sys_unlink+0x1d4>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105110:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105115:	8d 75 d8             	lea    -0x28(%ebp),%esi
80105118:	74 66                	je     80105180 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010511a:	83 ec 04             	sub    $0x4,%esp
8010511d:	6a 10                	push   $0x10
8010511f:	6a 00                	push   $0x0
80105121:	56                   	push   %esi
80105122:	e8 39 f5 ff ff       	call   80104660 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105127:	6a 10                	push   $0x10
80105129:	ff 75 c4             	pushl  -0x3c(%ebp)
8010512c:	56                   	push   %esi
8010512d:	ff 75 b4             	pushl  -0x4c(%ebp)
80105130:	e8 eb c8 ff ff       	call   80101a20 <writei>
80105135:	83 c4 20             	add    $0x20,%esp
80105138:	83 f8 10             	cmp    $0x10,%eax
8010513b:	0f 85 e6 00 00 00    	jne    80105227 <sys_unlink+0x1c7>
  if(ip->type == T_DIR){
80105141:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105146:	0f 84 9c 00 00 00    	je     801051e8 <sys_unlink+0x188>
  iunlockput(dp);
8010514c:	83 ec 0c             	sub    $0xc,%esp
8010514f:	ff 75 b4             	pushl  -0x4c(%ebp)
80105152:	e8 79 c7 ff ff       	call   801018d0 <iunlockput>
  ip->nlink--;
80105157:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010515c:	89 1c 24             	mov    %ebx,(%esp)
8010515f:	e8 4c c4 ff ff       	call   801015b0 <iupdate>
  iunlockput(ip);
80105164:	89 1c 24             	mov    %ebx,(%esp)
80105167:	e8 64 c7 ff ff       	call   801018d0 <iunlockput>
  end_op();
8010516c:	e8 df da ff ff       	call   80102c50 <end_op>
  return 0;
80105171:	83 c4 10             	add    $0x10,%esp
80105174:	31 c0                	xor    %eax,%eax
}
80105176:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105179:	5b                   	pop    %ebx
8010517a:	5e                   	pop    %esi
8010517b:	5f                   	pop    %edi
8010517c:	5d                   	pop    %ebp
8010517d:	c3                   	ret    
8010517e:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105180:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105184:	76 94                	jbe    8010511a <sys_unlink+0xba>
80105186:	bf 20 00 00 00       	mov    $0x20,%edi
8010518b:	eb 0f                	jmp    8010519c <sys_unlink+0x13c>
8010518d:	8d 76 00             	lea    0x0(%esi),%esi
80105190:	83 c7 10             	add    $0x10,%edi
80105193:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105196:	0f 83 7e ff ff ff    	jae    8010511a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010519c:	6a 10                	push   $0x10
8010519e:	57                   	push   %edi
8010519f:	56                   	push   %esi
801051a0:	53                   	push   %ebx
801051a1:	e8 7a c7 ff ff       	call   80101920 <readi>
801051a6:	83 c4 10             	add    $0x10,%esp
801051a9:	83 f8 10             	cmp    $0x10,%eax
801051ac:	75 6c                	jne    8010521a <sys_unlink+0x1ba>
    if(de.inum != 0)
801051ae:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801051b3:	74 db                	je     80105190 <sys_unlink+0x130>
    iunlockput(ip);
801051b5:	83 ec 0c             	sub    $0xc,%esp
801051b8:	53                   	push   %ebx
801051b9:	e8 12 c7 ff ff       	call   801018d0 <iunlockput>
    goto bad;
801051be:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
801051c1:	83 ec 0c             	sub    $0xc,%esp
801051c4:	ff 75 b4             	pushl  -0x4c(%ebp)
801051c7:	e8 04 c7 ff ff       	call   801018d0 <iunlockput>
  end_op();
801051cc:	e8 7f da ff ff       	call   80102c50 <end_op>
  return -1;
801051d1:	83 c4 10             	add    $0x10,%esp
}
801051d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801051d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801051dc:	5b                   	pop    %ebx
801051dd:	5e                   	pop    %esi
801051de:	5f                   	pop    %edi
801051df:	5d                   	pop    %ebp
801051e0:	c3                   	ret    
801051e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
801051e8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
801051eb:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
801051ee:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
801051f3:	50                   	push   %eax
801051f4:	e8 b7 c3 ff ff       	call   801015b0 <iupdate>
801051f9:	83 c4 10             	add    $0x10,%esp
801051fc:	e9 4b ff ff ff       	jmp    8010514c <sys_unlink+0xec>
    return -1;
80105201:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105206:	e9 6b ff ff ff       	jmp    80105176 <sys_unlink+0x116>
    end_op();
8010520b:	e8 40 da ff ff       	call   80102c50 <end_op>
    return -1;
80105210:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105215:	e9 5c ff ff ff       	jmp    80105176 <sys_unlink+0x116>
      panic("isdirempty: readi");
8010521a:	83 ec 0c             	sub    $0xc,%esp
8010521d:	68 44 7b 10 80       	push   $0x80107b44
80105222:	e8 49 b1 ff ff       	call   80100370 <panic>
    panic("unlink: writei");
80105227:	83 ec 0c             	sub    $0xc,%esp
8010522a:	68 56 7b 10 80       	push   $0x80107b56
8010522f:	e8 3c b1 ff ff       	call   80100370 <panic>
    panic("unlink: nlink < 1");
80105234:	83 ec 0c             	sub    $0xc,%esp
80105237:	68 32 7b 10 80       	push   $0x80107b32
8010523c:	e8 2f b1 ff ff       	call   80100370 <panic>
80105241:	eb 0d                	jmp    80105250 <sys_open>
80105243:	90                   	nop
80105244:	90                   	nop
80105245:	90                   	nop
80105246:	90                   	nop
80105247:	90                   	nop
80105248:	90                   	nop
80105249:	90                   	nop
8010524a:	90                   	nop
8010524b:	90                   	nop
8010524c:	90                   	nop
8010524d:	90                   	nop
8010524e:	90                   	nop
8010524f:	90                   	nop

80105250 <sys_open>:

int
sys_open(void)
{
80105250:	55                   	push   %ebp
80105251:	89 e5                	mov    %esp,%ebp
80105253:	57                   	push   %edi
80105254:	56                   	push   %esi
80105255:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105256:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105259:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010525c:	50                   	push   %eax
8010525d:	6a 00                	push   $0x0
8010525f:	e8 5c f7 ff ff       	call   801049c0 <argstr>
80105264:	83 c4 10             	add    $0x10,%esp
80105267:	85 c0                	test   %eax,%eax
80105269:	0f 88 9e 00 00 00    	js     8010530d <sys_open+0xbd>
8010526f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105272:	83 ec 08             	sub    $0x8,%esp
80105275:	50                   	push   %eax
80105276:	6a 01                	push   $0x1
80105278:	e8 b3 f6 ff ff       	call   80104930 <argint>
8010527d:	83 c4 10             	add    $0x10,%esp
80105280:	85 c0                	test   %eax,%eax
80105282:	0f 88 85 00 00 00    	js     8010530d <sys_open+0xbd>
    return -1;

  begin_op();
80105288:	e8 53 d9 ff ff       	call   80102be0 <begin_op>

  if(omode & O_CREATE){
8010528d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105291:	0f 85 89 00 00 00    	jne    80105320 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105297:	83 ec 0c             	sub    $0xc,%esp
8010529a:	ff 75 e0             	pushl  -0x20(%ebp)
8010529d:	e8 ee cb ff ff       	call   80101e90 <namei>
801052a2:	83 c4 10             	add    $0x10,%esp
801052a5:	85 c0                	test   %eax,%eax
801052a7:	89 c7                	mov    %eax,%edi
801052a9:	0f 84 8e 00 00 00    	je     8010533d <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
801052af:	83 ec 0c             	sub    $0xc,%esp
801052b2:	50                   	push   %eax
801052b3:	e8 a8 c3 ff ff       	call   80101660 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801052b8:	83 c4 10             	add    $0x10,%esp
801052bb:	66 83 7f 50 01       	cmpw   $0x1,0x50(%edi)
801052c0:	0f 84 d2 00 00 00    	je     80105398 <sys_open+0x148>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801052c6:	e8 85 ba ff ff       	call   80100d50 <filealloc>
801052cb:	85 c0                	test   %eax,%eax
801052cd:	89 c6                	mov    %eax,%esi
801052cf:	74 2b                	je     801052fc <sys_open+0xac>
801052d1:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801052d8:	31 db                	xor    %ebx,%ebx
801052da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(proc->ofile[fd] == 0){
801052e0:	8b 44 9a 28          	mov    0x28(%edx,%ebx,4),%eax
801052e4:	85 c0                	test   %eax,%eax
801052e6:	74 68                	je     80105350 <sys_open+0x100>
  for(fd = 0; fd < NOFILE; fd++){
801052e8:	83 c3 01             	add    $0x1,%ebx
801052eb:	83 fb 10             	cmp    $0x10,%ebx
801052ee:	75 f0                	jne    801052e0 <sys_open+0x90>
    if(f)
      fileclose(f);
801052f0:	83 ec 0c             	sub    $0xc,%esp
801052f3:	56                   	push   %esi
801052f4:	e8 17 bb ff ff       	call   80100e10 <fileclose>
801052f9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801052fc:	83 ec 0c             	sub    $0xc,%esp
801052ff:	57                   	push   %edi
80105300:	e8 cb c5 ff ff       	call   801018d0 <iunlockput>
    end_op();
80105305:	e8 46 d9 ff ff       	call   80102c50 <end_op>
    return -1;
8010530a:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
8010530d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105310:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105315:	89 d8                	mov    %ebx,%eax
80105317:	5b                   	pop    %ebx
80105318:	5e                   	pop    %esi
80105319:	5f                   	pop    %edi
8010531a:	5d                   	pop    %ebp
8010531b:	c3                   	ret    
8010531c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105320:	83 ec 0c             	sub    $0xc,%esp
80105323:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105326:	31 c9                	xor    %ecx,%ecx
80105328:	6a 00                	push   $0x0
8010532a:	ba 02 00 00 00       	mov    $0x2,%edx
8010532f:	e8 6c f7 ff ff       	call   80104aa0 <create>
    if(ip == 0){
80105334:	83 c4 10             	add    $0x10,%esp
80105337:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105339:	89 c7                	mov    %eax,%edi
    if(ip == 0){
8010533b:	75 89                	jne    801052c6 <sys_open+0x76>
      end_op();
8010533d:	e8 0e d9 ff ff       	call   80102c50 <end_op>
      return -1;
80105342:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105347:	eb 40                	jmp    80105389 <sys_open+0x139>
80105349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80105350:	83 ec 0c             	sub    $0xc,%esp
      proc->ofile[fd] = f;
80105353:	89 74 9a 28          	mov    %esi,0x28(%edx,%ebx,4)
  iunlock(ip);
80105357:	57                   	push   %edi
80105358:	e8 e3 c3 ff ff       	call   80101740 <iunlock>
  end_op();
8010535d:	e8 ee d8 ff ff       	call   80102c50 <end_op>
  f->type = FD_INODE;
80105362:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f->readable = !(omode & O_WRONLY);
80105368:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010536b:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
8010536e:	89 7e 10             	mov    %edi,0x10(%esi)
  f->off = 0;
80105371:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
80105378:	89 c2                	mov    %eax,%edx
8010537a:	f7 d2                	not    %edx
8010537c:	88 56 08             	mov    %dl,0x8(%esi)
8010537f:	80 66 08 01          	andb   $0x1,0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105383:	a8 03                	test   $0x3,%al
80105385:	0f 95 46 09          	setne  0x9(%esi)
}
80105389:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010538c:	89 d8                	mov    %ebx,%eax
8010538e:	5b                   	pop    %ebx
8010538f:	5e                   	pop    %esi
80105390:	5f                   	pop    %edi
80105391:	5d                   	pop    %ebp
80105392:	c3                   	ret    
80105393:	90                   	nop
80105394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105398:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010539b:	85 d2                	test   %edx,%edx
8010539d:	0f 84 23 ff ff ff    	je     801052c6 <sys_open+0x76>
801053a3:	e9 54 ff ff ff       	jmp    801052fc <sys_open+0xac>
801053a8:	90                   	nop
801053a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801053b0 <sys_mkdir>:

int
sys_mkdir(void)
{
801053b0:	55                   	push   %ebp
801053b1:	89 e5                	mov    %esp,%ebp
801053b3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801053b6:	e8 25 d8 ff ff       	call   80102be0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801053bb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053be:	83 ec 08             	sub    $0x8,%esp
801053c1:	50                   	push   %eax
801053c2:	6a 00                	push   $0x0
801053c4:	e8 f7 f5 ff ff       	call   801049c0 <argstr>
801053c9:	83 c4 10             	add    $0x10,%esp
801053cc:	85 c0                	test   %eax,%eax
801053ce:	78 30                	js     80105400 <sys_mkdir+0x50>
801053d0:	83 ec 0c             	sub    $0xc,%esp
801053d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053d6:	31 c9                	xor    %ecx,%ecx
801053d8:	6a 00                	push   $0x0
801053da:	ba 01 00 00 00       	mov    $0x1,%edx
801053df:	e8 bc f6 ff ff       	call   80104aa0 <create>
801053e4:	83 c4 10             	add    $0x10,%esp
801053e7:	85 c0                	test   %eax,%eax
801053e9:	74 15                	je     80105400 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801053eb:	83 ec 0c             	sub    $0xc,%esp
801053ee:	50                   	push   %eax
801053ef:	e8 dc c4 ff ff       	call   801018d0 <iunlockput>
  end_op();
801053f4:	e8 57 d8 ff ff       	call   80102c50 <end_op>
  return 0;
801053f9:	83 c4 10             	add    $0x10,%esp
801053fc:	31 c0                	xor    %eax,%eax
}
801053fe:	c9                   	leave  
801053ff:	c3                   	ret    
    end_op();
80105400:	e8 4b d8 ff ff       	call   80102c50 <end_op>
    return -1;
80105405:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010540a:	c9                   	leave  
8010540b:	c3                   	ret    
8010540c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105410 <sys_mknod>:

int
sys_mknod(void)
{
80105410:	55                   	push   %ebp
80105411:	89 e5                	mov    %esp,%ebp
80105413:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105416:	e8 c5 d7 ff ff       	call   80102be0 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010541b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010541e:	83 ec 08             	sub    $0x8,%esp
80105421:	50                   	push   %eax
80105422:	6a 00                	push   $0x0
80105424:	e8 97 f5 ff ff       	call   801049c0 <argstr>
80105429:	83 c4 10             	add    $0x10,%esp
8010542c:	85 c0                	test   %eax,%eax
8010542e:	78 60                	js     80105490 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105430:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105433:	83 ec 08             	sub    $0x8,%esp
80105436:	50                   	push   %eax
80105437:	6a 01                	push   $0x1
80105439:	e8 f2 f4 ff ff       	call   80104930 <argint>
  if((argstr(0, &path)) < 0 ||
8010543e:	83 c4 10             	add    $0x10,%esp
80105441:	85 c0                	test   %eax,%eax
80105443:	78 4b                	js     80105490 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105445:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105448:	83 ec 08             	sub    $0x8,%esp
8010544b:	50                   	push   %eax
8010544c:	6a 02                	push   $0x2
8010544e:	e8 dd f4 ff ff       	call   80104930 <argint>
     argint(1, &major) < 0 ||
80105453:	83 c4 10             	add    $0x10,%esp
80105456:	85 c0                	test   %eax,%eax
80105458:	78 36                	js     80105490 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010545a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
8010545e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105461:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105465:	ba 03 00 00 00       	mov    $0x3,%edx
8010546a:	50                   	push   %eax
8010546b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010546e:	e8 2d f6 ff ff       	call   80104aa0 <create>
80105473:	83 c4 10             	add    $0x10,%esp
80105476:	85 c0                	test   %eax,%eax
80105478:	74 16                	je     80105490 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010547a:	83 ec 0c             	sub    $0xc,%esp
8010547d:	50                   	push   %eax
8010547e:	e8 4d c4 ff ff       	call   801018d0 <iunlockput>
  end_op();
80105483:	e8 c8 d7 ff ff       	call   80102c50 <end_op>
  return 0;
80105488:	83 c4 10             	add    $0x10,%esp
8010548b:	31 c0                	xor    %eax,%eax
}
8010548d:	c9                   	leave  
8010548e:	c3                   	ret    
8010548f:	90                   	nop
    end_op();
80105490:	e8 bb d7 ff ff       	call   80102c50 <end_op>
    return -1;
80105495:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010549a:	c9                   	leave  
8010549b:	c3                   	ret    
8010549c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054a0 <sys_chdir>:

int
sys_chdir(void)
{
801054a0:	55                   	push   %ebp
801054a1:	89 e5                	mov    %esp,%ebp
801054a3:	53                   	push   %ebx
801054a4:	83 ec 14             	sub    $0x14,%esp
  char *path;
  struct inode *ip;

  begin_op();
801054a7:	e8 34 d7 ff ff       	call   80102be0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801054ac:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054af:	83 ec 08             	sub    $0x8,%esp
801054b2:	50                   	push   %eax
801054b3:	6a 00                	push   $0x0
801054b5:	e8 06 f5 ff ff       	call   801049c0 <argstr>
801054ba:	83 c4 10             	add    $0x10,%esp
801054bd:	85 c0                	test   %eax,%eax
801054bf:	78 7f                	js     80105540 <sys_chdir+0xa0>
801054c1:	83 ec 0c             	sub    $0xc,%esp
801054c4:	ff 75 f4             	pushl  -0xc(%ebp)
801054c7:	e8 c4 c9 ff ff       	call   80101e90 <namei>
801054cc:	83 c4 10             	add    $0x10,%esp
801054cf:	85 c0                	test   %eax,%eax
801054d1:	89 c3                	mov    %eax,%ebx
801054d3:	74 6b                	je     80105540 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801054d5:	83 ec 0c             	sub    $0xc,%esp
801054d8:	50                   	push   %eax
801054d9:	e8 82 c1 ff ff       	call   80101660 <ilock>
  if(ip->type != T_DIR){
801054de:	83 c4 10             	add    $0x10,%esp
801054e1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801054e6:	75 38                	jne    80105520 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801054e8:	83 ec 0c             	sub    $0xc,%esp
801054eb:	53                   	push   %ebx
801054ec:	e8 4f c2 ff ff       	call   80101740 <iunlock>
  iput(proc->cwd);
801054f1:	58                   	pop    %eax
801054f2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054f8:	ff 70 68             	pushl  0x68(%eax)
801054fb:	e8 90 c2 ff ff       	call   80101790 <iput>
  end_op();
80105500:	e8 4b d7 ff ff       	call   80102c50 <end_op>
  proc->cwd = ip;
80105505:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return 0;
8010550b:	83 c4 10             	add    $0x10,%esp
  proc->cwd = ip;
8010550e:	89 58 68             	mov    %ebx,0x68(%eax)
  return 0;
80105511:	31 c0                	xor    %eax,%eax
}
80105513:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105516:	c9                   	leave  
80105517:	c3                   	ret    
80105518:	90                   	nop
80105519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80105520:	83 ec 0c             	sub    $0xc,%esp
80105523:	53                   	push   %ebx
80105524:	e8 a7 c3 ff ff       	call   801018d0 <iunlockput>
    end_op();
80105529:	e8 22 d7 ff ff       	call   80102c50 <end_op>
    return -1;
8010552e:	83 c4 10             	add    $0x10,%esp
80105531:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105536:	eb db                	jmp    80105513 <sys_chdir+0x73>
80105538:	90                   	nop
80105539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105540:	e8 0b d7 ff ff       	call   80102c50 <end_op>
    return -1;
80105545:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010554a:	eb c7                	jmp    80105513 <sys_chdir+0x73>
8010554c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105550 <sys_exec>:

int
sys_exec(void)
{
80105550:	55                   	push   %ebp
80105551:	89 e5                	mov    %esp,%ebp
80105553:	57                   	push   %edi
80105554:	56                   	push   %esi
80105555:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105556:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010555c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105562:	50                   	push   %eax
80105563:	6a 00                	push   $0x0
80105565:	e8 56 f4 ff ff       	call   801049c0 <argstr>
8010556a:	83 c4 10             	add    $0x10,%esp
8010556d:	85 c0                	test   %eax,%eax
8010556f:	78 7f                	js     801055f0 <sys_exec+0xa0>
80105571:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105577:	83 ec 08             	sub    $0x8,%esp
8010557a:	50                   	push   %eax
8010557b:	6a 01                	push   $0x1
8010557d:	e8 ae f3 ff ff       	call   80104930 <argint>
80105582:	83 c4 10             	add    $0x10,%esp
80105585:	85 c0                	test   %eax,%eax
80105587:	78 67                	js     801055f0 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105589:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010558f:	83 ec 04             	sub    $0x4,%esp
80105592:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105598:	68 80 00 00 00       	push   $0x80
8010559d:	6a 00                	push   $0x0
8010559f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801055a5:	50                   	push   %eax
801055a6:	31 db                	xor    %ebx,%ebx
801055a8:	e8 b3 f0 ff ff       	call   80104660 <memset>
801055ad:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801055b0:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801055b6:	83 ec 08             	sub    $0x8,%esp
801055b9:	57                   	push   %edi
801055ba:	8d 04 98             	lea    (%eax,%ebx,4),%eax
801055bd:	50                   	push   %eax
801055be:	e8 ed f2 ff ff       	call   801048b0 <fetchint>
801055c3:	83 c4 10             	add    $0x10,%esp
801055c6:	85 c0                	test   %eax,%eax
801055c8:	78 26                	js     801055f0 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
801055ca:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801055d0:	85 c0                	test   %eax,%eax
801055d2:	74 2c                	je     80105600 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801055d4:	83 ec 08             	sub    $0x8,%esp
801055d7:	56                   	push   %esi
801055d8:	50                   	push   %eax
801055d9:	e8 02 f3 ff ff       	call   801048e0 <fetchstr>
801055de:	83 c4 10             	add    $0x10,%esp
801055e1:	85 c0                	test   %eax,%eax
801055e3:	78 0b                	js     801055f0 <sys_exec+0xa0>
  for(i=0;; i++){
801055e5:	83 c3 01             	add    $0x1,%ebx
801055e8:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
801055eb:	83 fb 20             	cmp    $0x20,%ebx
801055ee:	75 c0                	jne    801055b0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
801055f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801055f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055f8:	5b                   	pop    %ebx
801055f9:	5e                   	pop    %esi
801055fa:	5f                   	pop    %edi
801055fb:	5d                   	pop    %ebp
801055fc:	c3                   	ret    
801055fd:	8d 76 00             	lea    0x0(%esi),%esi
  return exec(path, argv);
80105600:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105606:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105609:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105610:	00 00 00 00 
  return exec(path, argv);
80105614:	50                   	push   %eax
80105615:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010561b:	e8 c0 b3 ff ff       	call   801009e0 <exec>
80105620:	83 c4 10             	add    $0x10,%esp
}
80105623:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105626:	5b                   	pop    %ebx
80105627:	5e                   	pop    %esi
80105628:	5f                   	pop    %edi
80105629:	5d                   	pop    %ebp
8010562a:	c3                   	ret    
8010562b:	90                   	nop
8010562c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105630 <sys_pipe>:

int
sys_pipe(void)
{
80105630:	55                   	push   %ebp
80105631:	89 e5                	mov    %esp,%ebp
80105633:	57                   	push   %edi
80105634:	56                   	push   %esi
80105635:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105636:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105639:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010563c:	6a 08                	push   $0x8
8010563e:	50                   	push   %eax
8010563f:	6a 00                	push   $0x0
80105641:	e8 2a f3 ff ff       	call   80104970 <argptr>
80105646:	83 c4 10             	add    $0x10,%esp
80105649:	85 c0                	test   %eax,%eax
8010564b:	78 48                	js     80105695 <sys_pipe+0x65>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010564d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105650:	83 ec 08             	sub    $0x8,%esp
80105653:	50                   	push   %eax
80105654:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105657:	50                   	push   %eax
80105658:	e8 13 dd ff ff       	call   80103370 <pipealloc>
8010565d:	83 c4 10             	add    $0x10,%esp
80105660:	85 c0                	test   %eax,%eax
80105662:	78 31                	js     80105695 <sys_pipe+0x65>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105664:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80105667:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
  for(fd = 0; fd < NOFILE; fd++){
8010566e:	31 c0                	xor    %eax,%eax
    if(proc->ofile[fd] == 0){
80105670:	8b 54 81 28          	mov    0x28(%ecx,%eax,4),%edx
80105674:	85 d2                	test   %edx,%edx
80105676:	74 28                	je     801056a0 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
80105678:	83 c0 01             	add    $0x1,%eax
8010567b:	83 f8 10             	cmp    $0x10,%eax
8010567e:	75 f0                	jne    80105670 <sys_pipe+0x40>
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
    fileclose(rf);
80105680:	83 ec 0c             	sub    $0xc,%esp
80105683:	53                   	push   %ebx
80105684:	e8 87 b7 ff ff       	call   80100e10 <fileclose>
    fileclose(wf);
80105689:	58                   	pop    %eax
8010568a:	ff 75 e4             	pushl  -0x1c(%ebp)
8010568d:	e8 7e b7 ff ff       	call   80100e10 <fileclose>
    return -1;
80105692:	83 c4 10             	add    $0x10,%esp
80105695:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010569a:	eb 45                	jmp    801056e1 <sys_pipe+0xb1>
8010569c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801056a0:	8d 34 81             	lea    (%ecx,%eax,4),%esi
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801056a3:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801056a6:	31 d2                	xor    %edx,%edx
      proc->ofile[fd] = f;
801056a8:	89 5e 28             	mov    %ebx,0x28(%esi)
801056ab:	90                   	nop
801056ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->ofile[fd] == 0){
801056b0:	83 7c 91 28 00       	cmpl   $0x0,0x28(%ecx,%edx,4)
801056b5:	74 19                	je     801056d0 <sys_pipe+0xa0>
  for(fd = 0; fd < NOFILE; fd++){
801056b7:	83 c2 01             	add    $0x1,%edx
801056ba:	83 fa 10             	cmp    $0x10,%edx
801056bd:	75 f1                	jne    801056b0 <sys_pipe+0x80>
      proc->ofile[fd0] = 0;
801056bf:	c7 46 28 00 00 00 00 	movl   $0x0,0x28(%esi)
801056c6:	eb b8                	jmp    80105680 <sys_pipe+0x50>
801056c8:	90                   	nop
801056c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      proc->ofile[fd] = f;
801056d0:	89 7c 91 28          	mov    %edi,0x28(%ecx,%edx,4)
  }
  fd[0] = fd0;
801056d4:	8b 4d dc             	mov    -0x24(%ebp),%ecx
801056d7:	89 01                	mov    %eax,(%ecx)
  fd[1] = fd1;
801056d9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801056dc:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801056df:	31 c0                	xor    %eax,%eax
}
801056e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056e4:	5b                   	pop    %ebx
801056e5:	5e                   	pop    %esi
801056e6:	5f                   	pop    %edi
801056e7:	5d                   	pop    %ebp
801056e8:	c3                   	ret    
801056e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801056f0 <name_of_inode>:

// Must be inside a transaction, as it calls readi.
int
name_of_inode(struct inode *ip, struct inode *parent, char buf[DIRSIZ]) {
801056f0:	55                   	push   %ebp
801056f1:	89 e5                	mov    %esp,%ebp
801056f3:	57                   	push   %edi
801056f4:	56                   	push   %esi
801056f5:	53                   	push   %ebx
801056f6:	31 ff                	xor    %edi,%edi
801056f8:	8d 75 d8             	lea    -0x28(%ebp),%esi
801056fb:	83 ec 1c             	sub    $0x1c,%esp
801056fe:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  uint off;
  struct dirent de;
  for (off = 0; off < parent->size; off += sizeof(de)) {
80105701:	8b 43 58             	mov    0x58(%ebx),%eax
80105704:	85 c0                	test   %eax,%eax
80105706:	75 10                	jne    80105718 <name_of_inode+0x28>
80105708:	eb 4e                	jmp    80105758 <name_of_inode+0x68>
8010570a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105710:	83 c7 10             	add    $0x10,%edi
80105713:	39 7b 58             	cmp    %edi,0x58(%ebx)
80105716:	76 40                	jbe    80105758 <name_of_inode+0x68>
    if (readi(parent, (char*)&de, off, sizeof(de)) != sizeof(de))
80105718:	6a 10                	push   $0x10
8010571a:	57                   	push   %edi
8010571b:	56                   	push   %esi
8010571c:	53                   	push   %ebx
8010571d:	e8 fe c1 ff ff       	call   80101920 <readi>
80105722:	83 c4 10             	add    $0x10,%esp
80105725:	83 f8 10             	cmp    $0x10,%eax
80105728:	75 3b                	jne    80105765 <name_of_inode+0x75>
      panic("couldn't read dir entry");
    if (de.inum == ip->inum) {
8010572a:	8b 55 08             	mov    0x8(%ebp),%edx
8010572d:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
80105731:	3b 42 04             	cmp    0x4(%edx),%eax
80105734:	75 da                	jne    80105710 <name_of_inode+0x20>
      safestrcpy(buf, de.name, DIRSIZ);
80105736:	8d 45 da             	lea    -0x26(%ebp),%eax
80105739:	83 ec 04             	sub    $0x4,%esp
8010573c:	6a 0e                	push   $0xe
8010573e:	50                   	push   %eax
8010573f:	ff 75 10             	pushl  0x10(%ebp)
80105742:	e8 f9 f0 ff ff       	call   80104840 <safestrcpy>
      return 0;
80105747:	83 c4 10             	add    $0x10,%esp
    }
  }
  return -1;
}
8010574a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
8010574d:	31 c0                	xor    %eax,%eax
}
8010574f:	5b                   	pop    %ebx
80105750:	5e                   	pop    %esi
80105751:	5f                   	pop    %edi
80105752:	5d                   	pop    %ebp
80105753:	c3                   	ret    
80105754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105758:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010575b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105760:	5b                   	pop    %ebx
80105761:	5e                   	pop    %esi
80105762:	5f                   	pop    %edi
80105763:	5d                   	pop    %ebp
80105764:	c3                   	ret    
      panic("couldn't read dir entry");
80105765:	83 ec 0c             	sub    $0xc,%esp
80105768:	68 65 7b 10 80       	push   $0x80107b65
8010576d:	e8 fe ab ff ff       	call   80100370 <panic>
80105772:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105780 <name_for_inode>:

int
name_for_inode(char* buf, int n, struct inode *ip) {
80105780:	55                   	push   %ebp
80105781:	89 e5                	mov    %esp,%ebp
80105783:	57                   	push   %edi
80105784:	56                   	push   %esi
80105785:	53                   	push   %ebx
80105786:	83 ec 2c             	sub    $0x2c,%esp
80105789:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int path_offset;
  struct inode *parent;
  char node_name[DIRSIZ];

  begin_op();
8010578c:	e8 4f d4 ff ff       	call   80102be0 <begin_op>

  if (ip->inum == namei("/")->inum) {
80105791:	83 ec 0c             	sub    $0xc,%esp
80105794:	8b 73 04             	mov    0x4(%ebx),%esi
80105797:	68 76 79 10 80       	push   $0x80107976
8010579c:	e8 ef c6 ff ff       	call   80101e90 <namei>
801057a1:	83 c4 10             	add    $0x10,%esp
801057a4:	3b 70 04             	cmp    0x4(%eax),%esi
801057a7:	0f 84 e3 00 00 00    	je     80105890 <name_for_inode+0x110>
	buf[0] = '/';
    buf[1] = '\0';
    end_op();
	return 1;
  } else if (ip->type == T_DIR) {
801057ad:	0f b7 43 50          	movzwl 0x50(%ebx),%eax
801057b1:	66 83 f8 01          	cmp    $0x1,%ax
801057b5:	74 39                	je     801057f0 <name_for_inode+0x70>
	  buf[path_offset++] = '/';
	}
	iunlockput(parent);
    end_op();
	return path_offset;
  } else if (ip->type == T_DEV || ip->type == T_FILE) {
801057b7:	83 e8 02             	sub    $0x2,%eax
801057ba:	66 83 f8 01          	cmp    $0x1,%ax
801057be:	76 18                	jbe    801057d8 <name_for_inode+0x58>
    end_op();
	panic("process cwd is a device node / file, not a directory!");
  } else {
    end_op();
801057c0:	e8 8b d4 ff ff       	call   80102c50 <end_op>
	panic("unknown inode type");
801057c5:	83 ec 0c             	sub    $0xc,%esp
801057c8:	68 7d 7b 10 80       	push   $0x80107b7d
801057cd:	e8 9e ab ff ff       	call   80100370 <panic>
801057d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    end_op();
801057d8:	e8 73 d4 ff ff       	call   80102c50 <end_op>
	panic("process cwd is a device node / file, not a directory!");
801057dd:	83 ec 0c             	sub    $0xc,%esp
801057e0:	68 b8 7b 10 80       	push   $0x80107bb8
801057e5:	e8 86 ab ff ff       	call   80100370 <panic>
801057ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	parent = dirlookup(ip, "..", 0);
801057f0:	83 ec 04             	sub    $0x4,%esp
	if (name_of_inode(ip, parent, node_name)) {
801057f3:	8d 7d da             	lea    -0x26(%ebp),%edi
	parent = dirlookup(ip, "..", 0);
801057f6:	6a 00                	push   $0x0
801057f8:	68 1f 7b 10 80       	push   $0x80107b1f
801057fd:	53                   	push   %ebx
801057fe:	e8 6d c3 ff ff       	call   80101b70 <dirlookup>
80105803:	89 c6                	mov    %eax,%esi
	ilock(parent);
80105805:	89 04 24             	mov    %eax,(%esp)
80105808:	e8 53 be ff ff       	call   80101660 <ilock>
	if (name_of_inode(ip, parent, node_name)) {
8010580d:	83 c4 0c             	add    $0xc,%esp
80105810:	57                   	push   %edi
80105811:	56                   	push   %esi
80105812:	53                   	push   %ebx
80105813:	e8 d8 fe ff ff       	call   801056f0 <name_of_inode>
80105818:	83 c4 10             	add    $0x10,%esp
8010581b:	85 c0                	test   %eax,%eax
8010581d:	0f 85 aa 00 00 00    	jne    801058cd <name_for_inode+0x14d>
	path_offset = name_for_inode(buf, n, parent);
80105823:	83 ec 04             	sub    $0x4,%esp
80105826:	56                   	push   %esi
80105827:	ff 75 0c             	pushl  0xc(%ebp)
8010582a:	ff 75 08             	pushl  0x8(%ebp)
8010582d:	e8 4e ff ff ff       	call   80105780 <name_for_inode>
80105832:	89 c3                	mov    %eax,%ebx
	safestrcpy(buf + path_offset, node_name, n - path_offset);
80105834:	8b 45 0c             	mov    0xc(%ebp),%eax
80105837:	83 c4 0c             	add    $0xc,%esp
8010583a:	29 d8                	sub    %ebx,%eax
8010583c:	50                   	push   %eax
8010583d:	8b 45 08             	mov    0x8(%ebp),%eax
80105840:	57                   	push   %edi
80105841:	01 d8                	add    %ebx,%eax
80105843:	50                   	push   %eax
80105844:	e8 f7 ef ff ff       	call   80104840 <safestrcpy>
	path_offset += strlen(node_name);
80105849:	89 3c 24             	mov    %edi,(%esp)
8010584c:	e8 2f f0 ff ff       	call   80104880 <strlen>
80105851:	01 c3                	add    %eax,%ebx
	if (path_offset == n - 1) {
80105853:	8b 45 0c             	mov    0xc(%ebp),%eax
80105856:	83 c4 10             	add    $0x10,%esp
80105859:	83 e8 01             	sub    $0x1,%eax
8010585c:	39 c3                	cmp    %eax,%ebx
8010585e:	74 50                	je     801058b0 <name_for_inode+0x130>
	  buf[path_offset++] = '/';
80105860:	8d 43 01             	lea    0x1(%ebx),%eax
	iunlockput(parent);
80105863:	83 ec 0c             	sub    $0xc,%esp
	  buf[path_offset++] = '/';
80105866:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80105869:	8b 45 08             	mov    0x8(%ebp),%eax
8010586c:	c6 04 18 2f          	movb   $0x2f,(%eax,%ebx,1)
	iunlockput(parent);
80105870:	56                   	push   %esi
80105871:	e8 5a c0 ff ff       	call   801018d0 <iunlockput>
    end_op();
80105876:	e8 d5 d3 ff ff       	call   80102c50 <end_op>
8010587b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010587e:	83 c4 10             	add    $0x10,%esp
  }
}
80105881:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105884:	5b                   	pop    %ebx
80105885:	5e                   	pop    %esi
80105886:	5f                   	pop    %edi
80105887:	5d                   	pop    %ebp
80105888:	c3                   	ret    
80105889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	buf[0] = '/';
80105890:	8b 45 08             	mov    0x8(%ebp),%eax
80105893:	c6 00 2f             	movb   $0x2f,(%eax)
    buf[1] = '\0';
80105896:	c6 40 01 00          	movb   $0x0,0x1(%eax)
    end_op();
8010589a:	e8 b1 d3 ff ff       	call   80102c50 <end_op>
	return 1;
8010589f:	b8 01 00 00 00       	mov    $0x1,%eax
801058a4:	eb db                	jmp    80105881 <name_for_inode+0x101>
801058a6:	8d 76 00             	lea    0x0(%esi),%esi
801058a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	  buf[path_offset] = '\0';
801058b0:	8b 45 08             	mov    0x8(%ebp),%eax
      iunlockput(parent);
801058b3:	83 ec 0c             	sub    $0xc,%esp
	  buf[path_offset] = '\0';
801058b6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
      iunlockput(parent);
801058ba:	56                   	push   %esi
801058bb:	e8 10 c0 ff ff       	call   801018d0 <iunlockput>
      end_op();
801058c0:	e8 8b d3 ff ff       	call   80102c50 <end_op>
801058c5:	83 c4 10             	add    $0x10,%esp
	  return n;
801058c8:	8b 45 0c             	mov    0xc(%ebp),%eax
801058cb:	eb b4                	jmp    80105881 <name_for_inode+0x101>
      end_op();
801058cd:	e8 7e d3 ff ff       	call   80102c50 <end_op>
	  panic("could not find name of inode in parent!");
801058d2:	83 ec 0c             	sub    $0xc,%esp
801058d5:	68 90 7b 10 80       	push   $0x80107b90
801058da:	e8 91 aa ff ff       	call   80100370 <panic>
801058df:	90                   	nop

801058e0 <sys_getcwd>:

/* NB: Return from here is cast to char*, thus 0 == NULL */
int
sys_getcwd(void)
{
801058e0:	55                   	push   %ebp
801058e1:	89 e5                	mov    %esp,%ebp
801058e3:	83 ec 20             	sub    $0x20,%esp
  char *p;
  int n;
  if (argint(1, &n) < 0)
801058e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058e9:	50                   	push   %eax
801058ea:	6a 01                	push   $0x1
801058ec:	e8 3f f0 ff ff       	call   80104930 <argint>
801058f1:	83 c4 10             	add    $0x10,%esp
801058f4:	85 c0                	test   %eax,%eax
801058f6:	78 38                	js     80105930 <sys_getcwd+0x50>
    return 0;
  if(argptr(0, &p, n) < 0)
801058f8:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058fb:	83 ec 04             	sub    $0x4,%esp
801058fe:	ff 75 f4             	pushl  -0xc(%ebp)
80105901:	50                   	push   %eax
80105902:	6a 00                	push   $0x0
80105904:	e8 67 f0 ff ff       	call   80104970 <argptr>
80105909:	83 c4 10             	add    $0x10,%esp
8010590c:	85 c0                	test   %eax,%eax
8010590e:	78 20                	js     80105930 <sys_getcwd+0x50>
	return 0;
  name_for_inode(p, n, proc->cwd);
80105910:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105916:	83 ec 04             	sub    $0x4,%esp
80105919:	ff 70 68             	pushl  0x68(%eax)
8010591c:	ff 75 f4             	pushl  -0xc(%ebp)
8010591f:	ff 75 f0             	pushl  -0x10(%ebp)
80105922:	e8 59 fe ff ff       	call   80105780 <name_for_inode>
  return (int) p;
80105927:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010592a:	83 c4 10             	add    $0x10,%esp
}
8010592d:	c9                   	leave  
8010592e:	c3                   	ret    
8010592f:	90                   	nop
    return 0;
80105930:	31 c0                	xor    %eax,%eax
}
80105932:	c9                   	leave  
80105933:	c3                   	ret    
80105934:	66 90                	xchg   %ax,%ax
80105936:	66 90                	xchg   %ax,%ax
80105938:	66 90                	xchg   %ax,%ax
8010593a:	66 90                	xchg   %ax,%ax
8010593c:	66 90                	xchg   %ax,%ax
8010593e:	66 90                	xchg   %ax,%ax

80105940 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105940:	55                   	push   %ebp
80105941:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105943:	5d                   	pop    %ebp
  return fork();
80105944:	e9 d7 e1 ff ff       	jmp    80103b20 <fork>
80105949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105950 <sys_clone_jared>:

int sys_clone_jared(void){
80105950:	55                   	push   %ebp
80105951:	89 e5                	mov    %esp,%ebp
80105953:	83 ec 20             	sub    $0x20,%esp
	int function;
	int arg;
	int stack;
	if(argint(0, &function) < 0)
80105956:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105959:	50                   	push   %eax
8010595a:	6a 00                	push   $0x0
8010595c:	e8 cf ef ff ff       	call   80104930 <argint>
80105961:	83 c4 10             	add    $0x10,%esp
80105964:	85 c0                	test   %eax,%eax
80105966:	78 48                	js     801059b0 <sys_clone_jared+0x60>
    		return -1;
 	if(argint(1, &arg) < 0)
80105968:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010596b:	83 ec 08             	sub    $0x8,%esp
8010596e:	50                   	push   %eax
8010596f:	6a 01                	push   $0x1
80105971:	e8 ba ef ff ff       	call   80104930 <argint>
80105976:	83 c4 10             	add    $0x10,%esp
80105979:	85 c0                	test   %eax,%eax
8010597b:	78 33                	js     801059b0 <sys_clone_jared+0x60>
    		return -1;
	if(argint(2, &stack) < 0)
8010597d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105980:	83 ec 08             	sub    $0x8,%esp
80105983:	50                   	push   %eax
80105984:	6a 02                	push   $0x2
80105986:	e8 a5 ef ff ff       	call   80104930 <argint>
8010598b:	83 c4 10             	add    $0x10,%esp
8010598e:	85 c0                	test   %eax,%eax
80105990:	78 1e                	js     801059b0 <sys_clone_jared+0x60>
    		return -1;
	return clone_jared( (void*)function, (void*)arg, (void*)stack );
80105992:	83 ec 04             	sub    $0x4,%esp
80105995:	ff 75 f4             	pushl  -0xc(%ebp)
80105998:	ff 75 f0             	pushl  -0x10(%ebp)
8010599b:	ff 75 ec             	pushl  -0x14(%ebp)
8010599e:	e8 5d e0 ff ff       	call   80103a00 <clone_jared>
801059a3:	83 c4 10             	add    $0x10,%esp
}
801059a6:	c9                   	leave  
801059a7:	c3                   	ret    
801059a8:	90                   	nop
801059a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    		return -1;
801059b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059b5:	c9                   	leave  
801059b6:	c3                   	ret    
801059b7:	89 f6                	mov    %esi,%esi
801059b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801059c0 <sys_exit>:

int
sys_exit(void)
{
801059c0:	55                   	push   %ebp
801059c1:	89 e5                	mov    %esp,%ebp
801059c3:	83 ec 08             	sub    $0x8,%esp
  exit();
801059c6:	e8 c5 e3 ff ff       	call   80103d90 <exit>
  return 0;  // not reached
}
801059cb:	31 c0                	xor    %eax,%eax
801059cd:	c9                   	leave  
801059ce:	c3                   	ret    
801059cf:	90                   	nop

801059d0 <sys_wait>:

int
sys_wait(void)
{
801059d0:	55                   	push   %ebp
801059d1:	89 e5                	mov    %esp,%ebp
  return wait();
}
801059d3:	5d                   	pop    %ebp
  return wait();
801059d4:	e9 77 e6 ff ff       	jmp    80104050 <wait>
801059d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801059e0 <sys_kill>:

int
sys_kill(void)
{
801059e0:	55                   	push   %ebp
801059e1:	89 e5                	mov    %esp,%ebp
801059e3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801059e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059e9:	50                   	push   %eax
801059ea:	6a 00                	push   $0x0
801059ec:	e8 3f ef ff ff       	call   80104930 <argint>
801059f1:	83 c4 10             	add    $0x10,%esp
801059f4:	85 c0                	test   %eax,%eax
801059f6:	78 18                	js     80105a10 <sys_kill+0x30>
    return -1;
  return kill(pid);
801059f8:	83 ec 0c             	sub    $0xc,%esp
801059fb:	ff 75 f4             	pushl  -0xc(%ebp)
801059fe:	e8 9d e7 ff ff       	call   801041a0 <kill>
80105a03:	83 c4 10             	add    $0x10,%esp
}
80105a06:	c9                   	leave  
80105a07:	c3                   	ret    
80105a08:	90                   	nop
80105a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105a10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a15:	c9                   	leave  
80105a16:	c3                   	ret    
80105a17:	89 f6                	mov    %esi,%esi
80105a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a20 <sys_getpid>:

int
sys_getpid(void)
{
  return proc->pid;
80105a20:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
80105a26:	55                   	push   %ebp
80105a27:	89 e5                	mov    %esp,%ebp
  return proc->pid;
80105a29:	8b 40 10             	mov    0x10(%eax),%eax
}
80105a2c:	5d                   	pop    %ebp
80105a2d:	c3                   	ret    
80105a2e:	66 90                	xchg   %ax,%ax

80105a30 <sys_sbrk>:

int
sys_sbrk(void)
{
80105a30:	55                   	push   %ebp
80105a31:	89 e5                	mov    %esp,%ebp
80105a33:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105a34:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105a37:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105a3a:	50                   	push   %eax
80105a3b:	6a 00                	push   $0x0
80105a3d:	e8 ee ee ff ff       	call   80104930 <argint>
80105a42:	83 c4 10             	add    $0x10,%esp
80105a45:	85 c0                	test   %eax,%eax
80105a47:	78 27                	js     80105a70 <sys_sbrk+0x40>
    return -1;
  addr = proc->sz;
80105a49:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(growproc(n) < 0)
80105a4f:	83 ec 0c             	sub    $0xc,%esp
  addr = proc->sz;
80105a52:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105a54:	ff 75 f4             	pushl  -0xc(%ebp)
80105a57:	e8 34 df ff ff       	call   80103990 <growproc>
80105a5c:	83 c4 10             	add    $0x10,%esp
80105a5f:	85 c0                	test   %eax,%eax
80105a61:	78 0d                	js     80105a70 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105a63:	89 d8                	mov    %ebx,%eax
80105a65:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a68:	c9                   	leave  
80105a69:	c3                   	ret    
80105a6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105a70:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105a75:	eb ec                	jmp    80105a63 <sys_sbrk+0x33>
80105a77:	89 f6                	mov    %esi,%esi
80105a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a80 <sys_sleep>:

int
sys_sleep(void)
{
80105a80:	55                   	push   %ebp
80105a81:	89 e5                	mov    %esp,%ebp
80105a83:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105a84:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105a87:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105a8a:	50                   	push   %eax
80105a8b:	6a 00                	push   $0x0
80105a8d:	e8 9e ee ff ff       	call   80104930 <argint>
80105a92:	83 c4 10             	add    $0x10,%esp
80105a95:	85 c0                	test   %eax,%eax
80105a97:	0f 88 8a 00 00 00    	js     80105b27 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105a9d:	83 ec 0c             	sub    $0xc,%esp
80105aa0:	68 e0 4e 11 80       	push   $0x80114ee0
80105aa5:	e8 86 e9 ff ff       	call   80104430 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105aaa:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105aad:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105ab0:	8b 1d 20 57 11 80    	mov    0x80115720,%ebx
  while(ticks - ticks0 < n){
80105ab6:	85 d2                	test   %edx,%edx
80105ab8:	75 27                	jne    80105ae1 <sys_sleep+0x61>
80105aba:	eb 54                	jmp    80105b10 <sys_sleep+0x90>
80105abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105ac0:	83 ec 08             	sub    $0x8,%esp
80105ac3:	68 e0 4e 11 80       	push   $0x80114ee0
80105ac8:	68 20 57 11 80       	push   $0x80115720
80105acd:	e8 be e4 ff ff       	call   80103f90 <sleep>
  while(ticks - ticks0 < n){
80105ad2:	a1 20 57 11 80       	mov    0x80115720,%eax
80105ad7:	83 c4 10             	add    $0x10,%esp
80105ada:	29 d8                	sub    %ebx,%eax
80105adc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105adf:	73 2f                	jae    80105b10 <sys_sleep+0x90>
    if(proc->killed){
80105ae1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105ae7:	8b 40 24             	mov    0x24(%eax),%eax
80105aea:	85 c0                	test   %eax,%eax
80105aec:	74 d2                	je     80105ac0 <sys_sleep+0x40>
      release(&tickslock);
80105aee:	83 ec 0c             	sub    $0xc,%esp
80105af1:	68 e0 4e 11 80       	push   $0x80114ee0
80105af6:	e8 15 eb ff ff       	call   80104610 <release>
      return -1;
80105afb:	83 c4 10             	add    $0x10,%esp
80105afe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105b03:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b06:	c9                   	leave  
80105b07:	c3                   	ret    
80105b08:	90                   	nop
80105b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&tickslock);
80105b10:	83 ec 0c             	sub    $0xc,%esp
80105b13:	68 e0 4e 11 80       	push   $0x80114ee0
80105b18:	e8 f3 ea ff ff       	call   80104610 <release>
  return 0;
80105b1d:	83 c4 10             	add    $0x10,%esp
80105b20:	31 c0                	xor    %eax,%eax
}
80105b22:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b25:	c9                   	leave  
80105b26:	c3                   	ret    
    return -1;
80105b27:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b2c:	eb d5                	jmp    80105b03 <sys_sleep+0x83>
80105b2e:	66 90                	xchg   %ax,%ax

80105b30 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105b30:	55                   	push   %ebp
80105b31:	89 e5                	mov    %esp,%ebp
80105b33:	53                   	push   %ebx
80105b34:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105b37:	68 e0 4e 11 80       	push   $0x80114ee0
80105b3c:	e8 ef e8 ff ff       	call   80104430 <acquire>
  xticks = ticks;
80105b41:	8b 1d 20 57 11 80    	mov    0x80115720,%ebx
  release(&tickslock);
80105b47:	c7 04 24 e0 4e 11 80 	movl   $0x80114ee0,(%esp)
80105b4e:	e8 bd ea ff ff       	call   80104610 <release>
  return xticks;
}
80105b53:	89 d8                	mov    %ebx,%eax
80105b55:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b58:	c9                   	leave  
80105b59:	c3                   	ret    
80105b5a:	66 90                	xchg   %ax,%ax
80105b5c:	66 90                	xchg   %ax,%ax
80105b5e:	66 90                	xchg   %ax,%ax

80105b60 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
80105b60:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105b61:	ba 43 00 00 00       	mov    $0x43,%edx
80105b66:	b8 34 00 00 00       	mov    $0x34,%eax
80105b6b:	89 e5                	mov    %esp,%ebp
80105b6d:	83 ec 14             	sub    $0x14,%esp
80105b70:	ee                   	out    %al,(%dx)
80105b71:	ba 40 00 00 00       	mov    $0x40,%edx
80105b76:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
80105b7b:	ee                   	out    %al,(%dx)
80105b7c:	b8 2e 00 00 00       	mov    $0x2e,%eax
80105b81:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  picenable(IRQ_TIMER);
80105b82:	6a 00                	push   $0x0
80105b84:	e8 17 d7 ff ff       	call   801032a0 <picenable>
}
80105b89:	83 c4 10             	add    $0x10,%esp
80105b8c:	c9                   	leave  
80105b8d:	c3                   	ret    

80105b8e <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105b8e:	1e                   	push   %ds
  pushl %es
80105b8f:	06                   	push   %es
  pushl %fs
80105b90:	0f a0                	push   %fs
  pushl %gs
80105b92:	0f a8                	push   %gs
  pushal
80105b94:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
80105b95:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105b99:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105b9b:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
80105b9d:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
80105ba1:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
80105ba3:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
80105ba5:	54                   	push   %esp
  call trap
80105ba6:	e8 e5 00 00 00       	call   80105c90 <trap>
  addl $4, %esp
80105bab:	83 c4 04             	add    $0x4,%esp

80105bae <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105bae:	61                   	popa   
  popl %gs
80105baf:	0f a9                	pop    %gs
  popl %fs
80105bb1:	0f a1                	pop    %fs
  popl %es
80105bb3:	07                   	pop    %es
  popl %ds
80105bb4:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105bb5:	83 c4 08             	add    $0x8,%esp
  iret
80105bb8:	cf                   	iret   
80105bb9:	66 90                	xchg   %ax,%ax
80105bbb:	66 90                	xchg   %ax,%ax
80105bbd:	66 90                	xchg   %ax,%ax
80105bbf:	90                   	nop

80105bc0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105bc0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105bc1:	31 c0                	xor    %eax,%eax
{
80105bc3:	89 e5                	mov    %esp,%ebp
80105bc5:	83 ec 08             	sub    $0x8,%esp
80105bc8:	90                   	nop
80105bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105bd0:	8b 14 85 0c a0 10 80 	mov    -0x7fef5ff4(,%eax,4),%edx
80105bd7:	b9 08 00 00 00       	mov    $0x8,%ecx
80105bdc:	c6 04 c5 24 4f 11 80 	movb   $0x0,-0x7feeb0dc(,%eax,8)
80105be3:	00 
80105be4:	66 89 0c c5 22 4f 11 	mov    %cx,-0x7feeb0de(,%eax,8)
80105beb:	80 
80105bec:	c6 04 c5 25 4f 11 80 	movb   $0x8e,-0x7feeb0db(,%eax,8)
80105bf3:	8e 
80105bf4:	66 89 14 c5 20 4f 11 	mov    %dx,-0x7feeb0e0(,%eax,8)
80105bfb:	80 
80105bfc:	c1 ea 10             	shr    $0x10,%edx
80105bff:	66 89 14 c5 26 4f 11 	mov    %dx,-0x7feeb0da(,%eax,8)
80105c06:	80 
  for(i = 0; i < 256; i++)
80105c07:	83 c0 01             	add    $0x1,%eax
80105c0a:	3d 00 01 00 00       	cmp    $0x100,%eax
80105c0f:	75 bf                	jne    80105bd0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105c11:	a1 0c a1 10 80       	mov    0x8010a10c,%eax

  initlock(&tickslock, "time");
80105c16:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105c19:	ba 08 00 00 00       	mov    $0x8,%edx
  initlock(&tickslock, "time");
80105c1e:	68 ee 7b 10 80       	push   $0x80107bee
80105c23:	68 e0 4e 11 80       	push   $0x80114ee0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105c28:	66 89 15 22 51 11 80 	mov    %dx,0x80115122
80105c2f:	c6 05 24 51 11 80 00 	movb   $0x0,0x80115124
80105c36:	66 a3 20 51 11 80    	mov    %ax,0x80115120
80105c3c:	c1 e8 10             	shr    $0x10,%eax
80105c3f:	c6 05 25 51 11 80 ef 	movb   $0xef,0x80115125
80105c46:	66 a3 26 51 11 80    	mov    %ax,0x80115126
  initlock(&tickslock, "time");
80105c4c:	e8 bf e7 ff ff       	call   80104410 <initlock>
}
80105c51:	83 c4 10             	add    $0x10,%esp
80105c54:	c9                   	leave  
80105c55:	c3                   	ret    
80105c56:	8d 76 00             	lea    0x0(%esi),%esi
80105c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105c60 <idtinit>:

void
idtinit(void)
{
80105c60:	55                   	push   %ebp
  pd[0] = size-1;
80105c61:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105c66:	89 e5                	mov    %esp,%ebp
80105c68:	83 ec 10             	sub    $0x10,%esp
80105c6b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105c6f:	b8 20 4f 11 80       	mov    $0x80114f20,%eax
80105c74:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105c78:	c1 e8 10             	shr    $0x10,%eax
80105c7b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105c7f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105c82:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105c85:	c9                   	leave  
80105c86:	c3                   	ret    
80105c87:	89 f6                	mov    %esi,%esi
80105c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105c90 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105c90:	55                   	push   %ebp
80105c91:	89 e5                	mov    %esp,%ebp
80105c93:	57                   	push   %edi
80105c94:	56                   	push   %esi
80105c95:	53                   	push   %ebx
80105c96:	83 ec 0c             	sub    $0xc,%esp
80105c99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105c9c:	8b 43 30             	mov    0x30(%ebx),%eax
80105c9f:	83 f8 40             	cmp    $0x40,%eax
80105ca2:	0f 84 f8 00 00 00    	je     80105da0 <trap+0x110>
    if(proc->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105ca8:	83 e8 20             	sub    $0x20,%eax
80105cab:	83 f8 1f             	cmp    $0x1f,%eax
80105cae:	77 68                	ja     80105d18 <trap+0x88>
80105cb0:	ff 24 85 94 7c 10 80 	jmp    *-0x7fef836c(,%eax,4)
80105cb7:	89 f6                	mov    %esi,%esi
80105cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
80105cc0:	e8 2b ca ff ff       	call   801026f0 <cpunum>
80105cc5:	85 c0                	test   %eax,%eax
80105cc7:	0f 84 b3 01 00 00    	je     80105e80 <trap+0x1f0>
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
    lapiceoi();
80105ccd:	e8 be ca ff ff       	call   80102790 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105cd2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105cd8:	85 c0                	test   %eax,%eax
80105cda:	74 2d                	je     80105d09 <trap+0x79>
80105cdc:	8b 50 24             	mov    0x24(%eax),%edx
80105cdf:	85 d2                	test   %edx,%edx
80105ce1:	0f 85 86 00 00 00    	jne    80105d6d <trap+0xdd>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105ce7:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105ceb:	0f 84 ef 00 00 00    	je     80105de0 <trap+0x150>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105cf1:	8b 40 24             	mov    0x24(%eax),%eax
80105cf4:	85 c0                	test   %eax,%eax
80105cf6:	74 11                	je     80105d09 <trap+0x79>
80105cf8:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105cfc:	83 e0 03             	and    $0x3,%eax
80105cff:	66 83 f8 03          	cmp    $0x3,%ax
80105d03:	0f 84 c1 00 00 00    	je     80105dca <trap+0x13a>
    exit();
}
80105d09:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d0c:	5b                   	pop    %ebx
80105d0d:	5e                   	pop    %esi
80105d0e:	5f                   	pop    %edi
80105d0f:	5d                   	pop    %ebp
80105d10:	c3                   	ret    
80105d11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(proc == 0 || (tf->cs&3) == 0){
80105d18:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
80105d1f:	85 c9                	test   %ecx,%ecx
80105d21:	0f 84 8d 01 00 00    	je     80105eb4 <trap+0x224>
80105d27:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105d2b:	0f 84 83 01 00 00    	je     80105eb4 <trap+0x224>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105d31:	0f 20 d7             	mov    %cr2,%edi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105d34:	8b 73 38             	mov    0x38(%ebx),%esi
80105d37:	e8 b4 c9 ff ff       	call   801026f0 <cpunum>
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80105d3c:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105d43:	57                   	push   %edi
80105d44:	56                   	push   %esi
80105d45:	50                   	push   %eax
80105d46:	ff 73 34             	pushl  0x34(%ebx)
80105d49:	ff 73 30             	pushl  0x30(%ebx)
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80105d4c:	8d 42 6c             	lea    0x6c(%edx),%eax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105d4f:	50                   	push   %eax
80105d50:	ff 72 10             	pushl  0x10(%edx)
80105d53:	68 50 7c 10 80       	push   $0x80107c50
80105d58:	e8 03 a9 ff ff       	call   80100660 <cprintf>
    proc->killed = 1;
80105d5d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105d63:	83 c4 20             	add    $0x20,%esp
80105d66:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105d6d:	0f b7 53 3c          	movzwl 0x3c(%ebx),%edx
80105d71:	83 e2 03             	and    $0x3,%edx
80105d74:	66 83 fa 03          	cmp    $0x3,%dx
80105d78:	0f 85 69 ff ff ff    	jne    80105ce7 <trap+0x57>
    exit();
80105d7e:	e8 0d e0 ff ff       	call   80103d90 <exit>
80105d83:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105d89:	85 c0                	test   %eax,%eax
80105d8b:	0f 85 56 ff ff ff    	jne    80105ce7 <trap+0x57>
80105d91:	e9 73 ff ff ff       	jmp    80105d09 <trap+0x79>
80105d96:	8d 76 00             	lea    0x0(%esi),%esi
80105d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(proc->killed)
80105da0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105da6:	8b 70 24             	mov    0x24(%eax),%esi
80105da9:	85 f6                	test   %esi,%esi
80105dab:	0f 85 bf 00 00 00    	jne    80105e70 <trap+0x1e0>
    proc->tf = tf;
80105db1:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105db4:	e8 77 ec ff ff       	call   80104a30 <syscall>
    if(proc->killed)
80105db9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105dbf:	8b 58 24             	mov    0x24(%eax),%ebx
80105dc2:	85 db                	test   %ebx,%ebx
80105dc4:	0f 84 3f ff ff ff    	je     80105d09 <trap+0x79>
}
80105dca:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105dcd:	5b                   	pop    %ebx
80105dce:	5e                   	pop    %esi
80105dcf:	5f                   	pop    %edi
80105dd0:	5d                   	pop    %ebp
      exit();
80105dd1:	e9 ba df ff ff       	jmp    80103d90 <exit>
80105dd6:	8d 76 00             	lea    0x0(%esi),%esi
80105dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105de0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105de4:	0f 85 07 ff ff ff    	jne    80105cf1 <trap+0x61>
    yield();
80105dea:	e8 61 e1 ff ff       	call   80103f50 <yield>
80105def:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105df5:	85 c0                	test   %eax,%eax
80105df7:	0f 85 f4 fe ff ff    	jne    80105cf1 <trap+0x61>
80105dfd:	e9 07 ff ff ff       	jmp    80105d09 <trap+0x79>
80105e02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    kbdintr();
80105e08:	e8 c3 c7 ff ff       	call   801025d0 <kbdintr>
    lapiceoi();
80105e0d:	e8 7e c9 ff ff       	call   80102790 <lapiceoi>
    break;
80105e12:	e9 bb fe ff ff       	jmp    80105cd2 <trap+0x42>
80105e17:	89 f6                	mov    %esi,%esi
80105e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    uartintr();
80105e20:	e8 2b 02 00 00       	call   80106050 <uartintr>
80105e25:	e9 a3 fe ff ff       	jmp    80105ccd <trap+0x3d>
80105e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105e30:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105e34:	8b 7b 38             	mov    0x38(%ebx),%edi
80105e37:	e8 b4 c8 ff ff       	call   801026f0 <cpunum>
80105e3c:	57                   	push   %edi
80105e3d:	56                   	push   %esi
80105e3e:	50                   	push   %eax
80105e3f:	68 f8 7b 10 80       	push   $0x80107bf8
80105e44:	e8 17 a8 ff ff       	call   80100660 <cprintf>
    lapiceoi();
80105e49:	e8 42 c9 ff ff       	call   80102790 <lapiceoi>
    break;
80105e4e:	83 c4 10             	add    $0x10,%esp
80105e51:	e9 7c fe ff ff       	jmp    80105cd2 <trap+0x42>
80105e56:	8d 76 00             	lea    0x0(%esi),%esi
80105e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ideintr();
80105e60:	e8 cb c1 ff ff       	call   80102030 <ideintr>
    lapiceoi();
80105e65:	e8 26 c9 ff ff       	call   80102790 <lapiceoi>
    break;
80105e6a:	e9 63 fe ff ff       	jmp    80105cd2 <trap+0x42>
80105e6f:	90                   	nop
      exit();
80105e70:	e8 1b df ff ff       	call   80103d90 <exit>
80105e75:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105e7b:	e9 31 ff ff ff       	jmp    80105db1 <trap+0x121>
      acquire(&tickslock);
80105e80:	83 ec 0c             	sub    $0xc,%esp
80105e83:	68 e0 4e 11 80       	push   $0x80114ee0
80105e88:	e8 a3 e5 ff ff       	call   80104430 <acquire>
      wakeup(&ticks);
80105e8d:	c7 04 24 20 57 11 80 	movl   $0x80115720,(%esp)
      ticks++;
80105e94:	83 05 20 57 11 80 01 	addl   $0x1,0x80115720
      wakeup(&ticks);
80105e9b:	e8 a0 e2 ff ff       	call   80104140 <wakeup>
      release(&tickslock);
80105ea0:	c7 04 24 e0 4e 11 80 	movl   $0x80114ee0,(%esp)
80105ea7:	e8 64 e7 ff ff       	call   80104610 <release>
80105eac:	83 c4 10             	add    $0x10,%esp
80105eaf:	e9 19 fe ff ff       	jmp    80105ccd <trap+0x3d>
80105eb4:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105eb7:	8b 73 38             	mov    0x38(%ebx),%esi
80105eba:	e8 31 c8 ff ff       	call   801026f0 <cpunum>
80105ebf:	83 ec 0c             	sub    $0xc,%esp
80105ec2:	57                   	push   %edi
80105ec3:	56                   	push   %esi
80105ec4:	50                   	push   %eax
80105ec5:	ff 73 30             	pushl  0x30(%ebx)
80105ec8:	68 1c 7c 10 80       	push   $0x80107c1c
80105ecd:	e8 8e a7 ff ff       	call   80100660 <cprintf>
      panic("trap");
80105ed2:	83 c4 14             	add    $0x14,%esp
80105ed5:	68 f3 7b 10 80       	push   $0x80107bf3
80105eda:	e8 91 a4 ff ff       	call   80100370 <panic>
80105edf:	90                   	nop

80105ee0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105ee0:	a1 c0 a5 10 80       	mov    0x8010a5c0,%eax
{
80105ee5:	55                   	push   %ebp
80105ee6:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105ee8:	85 c0                	test   %eax,%eax
80105eea:	74 1c                	je     80105f08 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105eec:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105ef1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105ef2:	a8 01                	test   $0x1,%al
80105ef4:	74 12                	je     80105f08 <uartgetc+0x28>
80105ef6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105efb:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105efc:	0f b6 c0             	movzbl %al,%eax
}
80105eff:	5d                   	pop    %ebp
80105f00:	c3                   	ret    
80105f01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105f08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f0d:	5d                   	pop    %ebp
80105f0e:	c3                   	ret    
80105f0f:	90                   	nop

80105f10 <uartputc.part.0>:
uartputc(int c)
80105f10:	55                   	push   %ebp
80105f11:	89 e5                	mov    %esp,%ebp
80105f13:	57                   	push   %edi
80105f14:	56                   	push   %esi
80105f15:	53                   	push   %ebx
80105f16:	89 c7                	mov    %eax,%edi
80105f18:	bb 80 00 00 00       	mov    $0x80,%ebx
80105f1d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105f22:	83 ec 0c             	sub    $0xc,%esp
80105f25:	eb 1b                	jmp    80105f42 <uartputc.part.0+0x32>
80105f27:	89 f6                	mov    %esi,%esi
80105f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80105f30:	83 ec 0c             	sub    $0xc,%esp
80105f33:	6a 0a                	push   $0xa
80105f35:	e8 76 c8 ff ff       	call   801027b0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105f3a:	83 c4 10             	add    $0x10,%esp
80105f3d:	83 eb 01             	sub    $0x1,%ebx
80105f40:	74 07                	je     80105f49 <uartputc.part.0+0x39>
80105f42:	89 f2                	mov    %esi,%edx
80105f44:	ec                   	in     (%dx),%al
80105f45:	a8 20                	test   $0x20,%al
80105f47:	74 e7                	je     80105f30 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105f49:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105f4e:	89 f8                	mov    %edi,%eax
80105f50:	ee                   	out    %al,(%dx)
}
80105f51:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f54:	5b                   	pop    %ebx
80105f55:	5e                   	pop    %esi
80105f56:	5f                   	pop    %edi
80105f57:	5d                   	pop    %ebp
80105f58:	c3                   	ret    
80105f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105f60 <uartinit>:
{
80105f60:	55                   	push   %ebp
80105f61:	31 c9                	xor    %ecx,%ecx
80105f63:	89 c8                	mov    %ecx,%eax
80105f65:	89 e5                	mov    %esp,%ebp
80105f67:	57                   	push   %edi
80105f68:	56                   	push   %esi
80105f69:	53                   	push   %ebx
80105f6a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105f6f:	89 da                	mov    %ebx,%edx
80105f71:	83 ec 0c             	sub    $0xc,%esp
80105f74:	ee                   	out    %al,(%dx)
80105f75:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105f7a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105f7f:	89 fa                	mov    %edi,%edx
80105f81:	ee                   	out    %al,(%dx)
80105f82:	b8 0c 00 00 00       	mov    $0xc,%eax
80105f87:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105f8c:	ee                   	out    %al,(%dx)
80105f8d:	be f9 03 00 00       	mov    $0x3f9,%esi
80105f92:	89 c8                	mov    %ecx,%eax
80105f94:	89 f2                	mov    %esi,%edx
80105f96:	ee                   	out    %al,(%dx)
80105f97:	b8 03 00 00 00       	mov    $0x3,%eax
80105f9c:	89 fa                	mov    %edi,%edx
80105f9e:	ee                   	out    %al,(%dx)
80105f9f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105fa4:	89 c8                	mov    %ecx,%eax
80105fa6:	ee                   	out    %al,(%dx)
80105fa7:	b8 01 00 00 00       	mov    $0x1,%eax
80105fac:	89 f2                	mov    %esi,%edx
80105fae:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105faf:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105fb4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105fb5:	3c ff                	cmp    $0xff,%al
80105fb7:	74 5a                	je     80106013 <uartinit+0xb3>
  uart = 1;
80105fb9:	c7 05 c0 a5 10 80 01 	movl   $0x1,0x8010a5c0
80105fc0:	00 00 00 
80105fc3:	89 da                	mov    %ebx,%edx
80105fc5:	ec                   	in     (%dx),%al
80105fc6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105fcb:	ec                   	in     (%dx),%al
  picenable(IRQ_COM1);
80105fcc:	83 ec 0c             	sub    $0xc,%esp
80105fcf:	6a 04                	push   $0x4
80105fd1:	e8 ca d2 ff ff       	call   801032a0 <picenable>
  ioapicenable(IRQ_COM1, 0);
80105fd6:	59                   	pop    %ecx
80105fd7:	5b                   	pop    %ebx
80105fd8:	6a 00                	push   $0x0
80105fda:	6a 04                	push   $0x4
80105fdc:	bb 14 7d 10 80       	mov    $0x80107d14,%ebx
80105fe1:	e8 aa c2 ff ff       	call   80102290 <ioapicenable>
80105fe6:	83 c4 10             	add    $0x10,%esp
80105fe9:	b8 78 00 00 00       	mov    $0x78,%eax
80105fee:	eb 0a                	jmp    80105ffa <uartinit+0x9a>
  for(p="xv6...\n"; *p; p++)
80105ff0:	83 c3 01             	add    $0x1,%ebx
80105ff3:	0f be 03             	movsbl (%ebx),%eax
80105ff6:	84 c0                	test   %al,%al
80105ff8:	74 19                	je     80106013 <uartinit+0xb3>
  if(!uart)
80105ffa:	8b 15 c0 a5 10 80    	mov    0x8010a5c0,%edx
80106000:	85 d2                	test   %edx,%edx
80106002:	74 ec                	je     80105ff0 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80106004:	83 c3 01             	add    $0x1,%ebx
80106007:	e8 04 ff ff ff       	call   80105f10 <uartputc.part.0>
8010600c:	0f be 03             	movsbl (%ebx),%eax
8010600f:	84 c0                	test   %al,%al
80106011:	75 e7                	jne    80105ffa <uartinit+0x9a>
}
80106013:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106016:	5b                   	pop    %ebx
80106017:	5e                   	pop    %esi
80106018:	5f                   	pop    %edi
80106019:	5d                   	pop    %ebp
8010601a:	c3                   	ret    
8010601b:	90                   	nop
8010601c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106020 <uartputc>:
  if(!uart)
80106020:	8b 15 c0 a5 10 80    	mov    0x8010a5c0,%edx
{
80106026:	55                   	push   %ebp
80106027:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106029:	85 d2                	test   %edx,%edx
{
8010602b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
8010602e:	74 10                	je     80106040 <uartputc+0x20>
}
80106030:	5d                   	pop    %ebp
80106031:	e9 da fe ff ff       	jmp    80105f10 <uartputc.part.0>
80106036:	8d 76 00             	lea    0x0(%esi),%esi
80106039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106040:	5d                   	pop    %ebp
80106041:	c3                   	ret    
80106042:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106050 <uartintr>:

void
uartintr(void)
{
80106050:	55                   	push   %ebp
80106051:	89 e5                	mov    %esp,%ebp
80106053:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106056:	68 e0 5e 10 80       	push   $0x80105ee0
8010605b:	e8 80 a7 ff ff       	call   801007e0 <consoleintr>
}
80106060:	83 c4 10             	add    $0x10,%esp
80106063:	c9                   	leave  
80106064:	c3                   	ret    

80106065 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106065:	6a 00                	push   $0x0
  pushl $0
80106067:	6a 00                	push   $0x0
  jmp alltraps
80106069:	e9 20 fb ff ff       	jmp    80105b8e <alltraps>

8010606e <vector1>:
.globl vector1
vector1:
  pushl $0
8010606e:	6a 00                	push   $0x0
  pushl $1
80106070:	6a 01                	push   $0x1
  jmp alltraps
80106072:	e9 17 fb ff ff       	jmp    80105b8e <alltraps>

80106077 <vector2>:
.globl vector2
vector2:
  pushl $0
80106077:	6a 00                	push   $0x0
  pushl $2
80106079:	6a 02                	push   $0x2
  jmp alltraps
8010607b:	e9 0e fb ff ff       	jmp    80105b8e <alltraps>

80106080 <vector3>:
.globl vector3
vector3:
  pushl $0
80106080:	6a 00                	push   $0x0
  pushl $3
80106082:	6a 03                	push   $0x3
  jmp alltraps
80106084:	e9 05 fb ff ff       	jmp    80105b8e <alltraps>

80106089 <vector4>:
.globl vector4
vector4:
  pushl $0
80106089:	6a 00                	push   $0x0
  pushl $4
8010608b:	6a 04                	push   $0x4
  jmp alltraps
8010608d:	e9 fc fa ff ff       	jmp    80105b8e <alltraps>

80106092 <vector5>:
.globl vector5
vector5:
  pushl $0
80106092:	6a 00                	push   $0x0
  pushl $5
80106094:	6a 05                	push   $0x5
  jmp alltraps
80106096:	e9 f3 fa ff ff       	jmp    80105b8e <alltraps>

8010609b <vector6>:
.globl vector6
vector6:
  pushl $0
8010609b:	6a 00                	push   $0x0
  pushl $6
8010609d:	6a 06                	push   $0x6
  jmp alltraps
8010609f:	e9 ea fa ff ff       	jmp    80105b8e <alltraps>

801060a4 <vector7>:
.globl vector7
vector7:
  pushl $0
801060a4:	6a 00                	push   $0x0
  pushl $7
801060a6:	6a 07                	push   $0x7
  jmp alltraps
801060a8:	e9 e1 fa ff ff       	jmp    80105b8e <alltraps>

801060ad <vector8>:
.globl vector8
vector8:
  pushl $8
801060ad:	6a 08                	push   $0x8
  jmp alltraps
801060af:	e9 da fa ff ff       	jmp    80105b8e <alltraps>

801060b4 <vector9>:
.globl vector9
vector9:
  pushl $0
801060b4:	6a 00                	push   $0x0
  pushl $9
801060b6:	6a 09                	push   $0x9
  jmp alltraps
801060b8:	e9 d1 fa ff ff       	jmp    80105b8e <alltraps>

801060bd <vector10>:
.globl vector10
vector10:
  pushl $10
801060bd:	6a 0a                	push   $0xa
  jmp alltraps
801060bf:	e9 ca fa ff ff       	jmp    80105b8e <alltraps>

801060c4 <vector11>:
.globl vector11
vector11:
  pushl $11
801060c4:	6a 0b                	push   $0xb
  jmp alltraps
801060c6:	e9 c3 fa ff ff       	jmp    80105b8e <alltraps>

801060cb <vector12>:
.globl vector12
vector12:
  pushl $12
801060cb:	6a 0c                	push   $0xc
  jmp alltraps
801060cd:	e9 bc fa ff ff       	jmp    80105b8e <alltraps>

801060d2 <vector13>:
.globl vector13
vector13:
  pushl $13
801060d2:	6a 0d                	push   $0xd
  jmp alltraps
801060d4:	e9 b5 fa ff ff       	jmp    80105b8e <alltraps>

801060d9 <vector14>:
.globl vector14
vector14:
  pushl $14
801060d9:	6a 0e                	push   $0xe
  jmp alltraps
801060db:	e9 ae fa ff ff       	jmp    80105b8e <alltraps>

801060e0 <vector15>:
.globl vector15
vector15:
  pushl $0
801060e0:	6a 00                	push   $0x0
  pushl $15
801060e2:	6a 0f                	push   $0xf
  jmp alltraps
801060e4:	e9 a5 fa ff ff       	jmp    80105b8e <alltraps>

801060e9 <vector16>:
.globl vector16
vector16:
  pushl $0
801060e9:	6a 00                	push   $0x0
  pushl $16
801060eb:	6a 10                	push   $0x10
  jmp alltraps
801060ed:	e9 9c fa ff ff       	jmp    80105b8e <alltraps>

801060f2 <vector17>:
.globl vector17
vector17:
  pushl $17
801060f2:	6a 11                	push   $0x11
  jmp alltraps
801060f4:	e9 95 fa ff ff       	jmp    80105b8e <alltraps>

801060f9 <vector18>:
.globl vector18
vector18:
  pushl $0
801060f9:	6a 00                	push   $0x0
  pushl $18
801060fb:	6a 12                	push   $0x12
  jmp alltraps
801060fd:	e9 8c fa ff ff       	jmp    80105b8e <alltraps>

80106102 <vector19>:
.globl vector19
vector19:
  pushl $0
80106102:	6a 00                	push   $0x0
  pushl $19
80106104:	6a 13                	push   $0x13
  jmp alltraps
80106106:	e9 83 fa ff ff       	jmp    80105b8e <alltraps>

8010610b <vector20>:
.globl vector20
vector20:
  pushl $0
8010610b:	6a 00                	push   $0x0
  pushl $20
8010610d:	6a 14                	push   $0x14
  jmp alltraps
8010610f:	e9 7a fa ff ff       	jmp    80105b8e <alltraps>

80106114 <vector21>:
.globl vector21
vector21:
  pushl $0
80106114:	6a 00                	push   $0x0
  pushl $21
80106116:	6a 15                	push   $0x15
  jmp alltraps
80106118:	e9 71 fa ff ff       	jmp    80105b8e <alltraps>

8010611d <vector22>:
.globl vector22
vector22:
  pushl $0
8010611d:	6a 00                	push   $0x0
  pushl $22
8010611f:	6a 16                	push   $0x16
  jmp alltraps
80106121:	e9 68 fa ff ff       	jmp    80105b8e <alltraps>

80106126 <vector23>:
.globl vector23
vector23:
  pushl $0
80106126:	6a 00                	push   $0x0
  pushl $23
80106128:	6a 17                	push   $0x17
  jmp alltraps
8010612a:	e9 5f fa ff ff       	jmp    80105b8e <alltraps>

8010612f <vector24>:
.globl vector24
vector24:
  pushl $0
8010612f:	6a 00                	push   $0x0
  pushl $24
80106131:	6a 18                	push   $0x18
  jmp alltraps
80106133:	e9 56 fa ff ff       	jmp    80105b8e <alltraps>

80106138 <vector25>:
.globl vector25
vector25:
  pushl $0
80106138:	6a 00                	push   $0x0
  pushl $25
8010613a:	6a 19                	push   $0x19
  jmp alltraps
8010613c:	e9 4d fa ff ff       	jmp    80105b8e <alltraps>

80106141 <vector26>:
.globl vector26
vector26:
  pushl $0
80106141:	6a 00                	push   $0x0
  pushl $26
80106143:	6a 1a                	push   $0x1a
  jmp alltraps
80106145:	e9 44 fa ff ff       	jmp    80105b8e <alltraps>

8010614a <vector27>:
.globl vector27
vector27:
  pushl $0
8010614a:	6a 00                	push   $0x0
  pushl $27
8010614c:	6a 1b                	push   $0x1b
  jmp alltraps
8010614e:	e9 3b fa ff ff       	jmp    80105b8e <alltraps>

80106153 <vector28>:
.globl vector28
vector28:
  pushl $0
80106153:	6a 00                	push   $0x0
  pushl $28
80106155:	6a 1c                	push   $0x1c
  jmp alltraps
80106157:	e9 32 fa ff ff       	jmp    80105b8e <alltraps>

8010615c <vector29>:
.globl vector29
vector29:
  pushl $0
8010615c:	6a 00                	push   $0x0
  pushl $29
8010615e:	6a 1d                	push   $0x1d
  jmp alltraps
80106160:	e9 29 fa ff ff       	jmp    80105b8e <alltraps>

80106165 <vector30>:
.globl vector30
vector30:
  pushl $0
80106165:	6a 00                	push   $0x0
  pushl $30
80106167:	6a 1e                	push   $0x1e
  jmp alltraps
80106169:	e9 20 fa ff ff       	jmp    80105b8e <alltraps>

8010616e <vector31>:
.globl vector31
vector31:
  pushl $0
8010616e:	6a 00                	push   $0x0
  pushl $31
80106170:	6a 1f                	push   $0x1f
  jmp alltraps
80106172:	e9 17 fa ff ff       	jmp    80105b8e <alltraps>

80106177 <vector32>:
.globl vector32
vector32:
  pushl $0
80106177:	6a 00                	push   $0x0
  pushl $32
80106179:	6a 20                	push   $0x20
  jmp alltraps
8010617b:	e9 0e fa ff ff       	jmp    80105b8e <alltraps>

80106180 <vector33>:
.globl vector33
vector33:
  pushl $0
80106180:	6a 00                	push   $0x0
  pushl $33
80106182:	6a 21                	push   $0x21
  jmp alltraps
80106184:	e9 05 fa ff ff       	jmp    80105b8e <alltraps>

80106189 <vector34>:
.globl vector34
vector34:
  pushl $0
80106189:	6a 00                	push   $0x0
  pushl $34
8010618b:	6a 22                	push   $0x22
  jmp alltraps
8010618d:	e9 fc f9 ff ff       	jmp    80105b8e <alltraps>

80106192 <vector35>:
.globl vector35
vector35:
  pushl $0
80106192:	6a 00                	push   $0x0
  pushl $35
80106194:	6a 23                	push   $0x23
  jmp alltraps
80106196:	e9 f3 f9 ff ff       	jmp    80105b8e <alltraps>

8010619b <vector36>:
.globl vector36
vector36:
  pushl $0
8010619b:	6a 00                	push   $0x0
  pushl $36
8010619d:	6a 24                	push   $0x24
  jmp alltraps
8010619f:	e9 ea f9 ff ff       	jmp    80105b8e <alltraps>

801061a4 <vector37>:
.globl vector37
vector37:
  pushl $0
801061a4:	6a 00                	push   $0x0
  pushl $37
801061a6:	6a 25                	push   $0x25
  jmp alltraps
801061a8:	e9 e1 f9 ff ff       	jmp    80105b8e <alltraps>

801061ad <vector38>:
.globl vector38
vector38:
  pushl $0
801061ad:	6a 00                	push   $0x0
  pushl $38
801061af:	6a 26                	push   $0x26
  jmp alltraps
801061b1:	e9 d8 f9 ff ff       	jmp    80105b8e <alltraps>

801061b6 <vector39>:
.globl vector39
vector39:
  pushl $0
801061b6:	6a 00                	push   $0x0
  pushl $39
801061b8:	6a 27                	push   $0x27
  jmp alltraps
801061ba:	e9 cf f9 ff ff       	jmp    80105b8e <alltraps>

801061bf <vector40>:
.globl vector40
vector40:
  pushl $0
801061bf:	6a 00                	push   $0x0
  pushl $40
801061c1:	6a 28                	push   $0x28
  jmp alltraps
801061c3:	e9 c6 f9 ff ff       	jmp    80105b8e <alltraps>

801061c8 <vector41>:
.globl vector41
vector41:
  pushl $0
801061c8:	6a 00                	push   $0x0
  pushl $41
801061ca:	6a 29                	push   $0x29
  jmp alltraps
801061cc:	e9 bd f9 ff ff       	jmp    80105b8e <alltraps>

801061d1 <vector42>:
.globl vector42
vector42:
  pushl $0
801061d1:	6a 00                	push   $0x0
  pushl $42
801061d3:	6a 2a                	push   $0x2a
  jmp alltraps
801061d5:	e9 b4 f9 ff ff       	jmp    80105b8e <alltraps>

801061da <vector43>:
.globl vector43
vector43:
  pushl $0
801061da:	6a 00                	push   $0x0
  pushl $43
801061dc:	6a 2b                	push   $0x2b
  jmp alltraps
801061de:	e9 ab f9 ff ff       	jmp    80105b8e <alltraps>

801061e3 <vector44>:
.globl vector44
vector44:
  pushl $0
801061e3:	6a 00                	push   $0x0
  pushl $44
801061e5:	6a 2c                	push   $0x2c
  jmp alltraps
801061e7:	e9 a2 f9 ff ff       	jmp    80105b8e <alltraps>

801061ec <vector45>:
.globl vector45
vector45:
  pushl $0
801061ec:	6a 00                	push   $0x0
  pushl $45
801061ee:	6a 2d                	push   $0x2d
  jmp alltraps
801061f0:	e9 99 f9 ff ff       	jmp    80105b8e <alltraps>

801061f5 <vector46>:
.globl vector46
vector46:
  pushl $0
801061f5:	6a 00                	push   $0x0
  pushl $46
801061f7:	6a 2e                	push   $0x2e
  jmp alltraps
801061f9:	e9 90 f9 ff ff       	jmp    80105b8e <alltraps>

801061fe <vector47>:
.globl vector47
vector47:
  pushl $0
801061fe:	6a 00                	push   $0x0
  pushl $47
80106200:	6a 2f                	push   $0x2f
  jmp alltraps
80106202:	e9 87 f9 ff ff       	jmp    80105b8e <alltraps>

80106207 <vector48>:
.globl vector48
vector48:
  pushl $0
80106207:	6a 00                	push   $0x0
  pushl $48
80106209:	6a 30                	push   $0x30
  jmp alltraps
8010620b:	e9 7e f9 ff ff       	jmp    80105b8e <alltraps>

80106210 <vector49>:
.globl vector49
vector49:
  pushl $0
80106210:	6a 00                	push   $0x0
  pushl $49
80106212:	6a 31                	push   $0x31
  jmp alltraps
80106214:	e9 75 f9 ff ff       	jmp    80105b8e <alltraps>

80106219 <vector50>:
.globl vector50
vector50:
  pushl $0
80106219:	6a 00                	push   $0x0
  pushl $50
8010621b:	6a 32                	push   $0x32
  jmp alltraps
8010621d:	e9 6c f9 ff ff       	jmp    80105b8e <alltraps>

80106222 <vector51>:
.globl vector51
vector51:
  pushl $0
80106222:	6a 00                	push   $0x0
  pushl $51
80106224:	6a 33                	push   $0x33
  jmp alltraps
80106226:	e9 63 f9 ff ff       	jmp    80105b8e <alltraps>

8010622b <vector52>:
.globl vector52
vector52:
  pushl $0
8010622b:	6a 00                	push   $0x0
  pushl $52
8010622d:	6a 34                	push   $0x34
  jmp alltraps
8010622f:	e9 5a f9 ff ff       	jmp    80105b8e <alltraps>

80106234 <vector53>:
.globl vector53
vector53:
  pushl $0
80106234:	6a 00                	push   $0x0
  pushl $53
80106236:	6a 35                	push   $0x35
  jmp alltraps
80106238:	e9 51 f9 ff ff       	jmp    80105b8e <alltraps>

8010623d <vector54>:
.globl vector54
vector54:
  pushl $0
8010623d:	6a 00                	push   $0x0
  pushl $54
8010623f:	6a 36                	push   $0x36
  jmp alltraps
80106241:	e9 48 f9 ff ff       	jmp    80105b8e <alltraps>

80106246 <vector55>:
.globl vector55
vector55:
  pushl $0
80106246:	6a 00                	push   $0x0
  pushl $55
80106248:	6a 37                	push   $0x37
  jmp alltraps
8010624a:	e9 3f f9 ff ff       	jmp    80105b8e <alltraps>

8010624f <vector56>:
.globl vector56
vector56:
  pushl $0
8010624f:	6a 00                	push   $0x0
  pushl $56
80106251:	6a 38                	push   $0x38
  jmp alltraps
80106253:	e9 36 f9 ff ff       	jmp    80105b8e <alltraps>

80106258 <vector57>:
.globl vector57
vector57:
  pushl $0
80106258:	6a 00                	push   $0x0
  pushl $57
8010625a:	6a 39                	push   $0x39
  jmp alltraps
8010625c:	e9 2d f9 ff ff       	jmp    80105b8e <alltraps>

80106261 <vector58>:
.globl vector58
vector58:
  pushl $0
80106261:	6a 00                	push   $0x0
  pushl $58
80106263:	6a 3a                	push   $0x3a
  jmp alltraps
80106265:	e9 24 f9 ff ff       	jmp    80105b8e <alltraps>

8010626a <vector59>:
.globl vector59
vector59:
  pushl $0
8010626a:	6a 00                	push   $0x0
  pushl $59
8010626c:	6a 3b                	push   $0x3b
  jmp alltraps
8010626e:	e9 1b f9 ff ff       	jmp    80105b8e <alltraps>

80106273 <vector60>:
.globl vector60
vector60:
  pushl $0
80106273:	6a 00                	push   $0x0
  pushl $60
80106275:	6a 3c                	push   $0x3c
  jmp alltraps
80106277:	e9 12 f9 ff ff       	jmp    80105b8e <alltraps>

8010627c <vector61>:
.globl vector61
vector61:
  pushl $0
8010627c:	6a 00                	push   $0x0
  pushl $61
8010627e:	6a 3d                	push   $0x3d
  jmp alltraps
80106280:	e9 09 f9 ff ff       	jmp    80105b8e <alltraps>

80106285 <vector62>:
.globl vector62
vector62:
  pushl $0
80106285:	6a 00                	push   $0x0
  pushl $62
80106287:	6a 3e                	push   $0x3e
  jmp alltraps
80106289:	e9 00 f9 ff ff       	jmp    80105b8e <alltraps>

8010628e <vector63>:
.globl vector63
vector63:
  pushl $0
8010628e:	6a 00                	push   $0x0
  pushl $63
80106290:	6a 3f                	push   $0x3f
  jmp alltraps
80106292:	e9 f7 f8 ff ff       	jmp    80105b8e <alltraps>

80106297 <vector64>:
.globl vector64
vector64:
  pushl $0
80106297:	6a 00                	push   $0x0
  pushl $64
80106299:	6a 40                	push   $0x40
  jmp alltraps
8010629b:	e9 ee f8 ff ff       	jmp    80105b8e <alltraps>

801062a0 <vector65>:
.globl vector65
vector65:
  pushl $0
801062a0:	6a 00                	push   $0x0
  pushl $65
801062a2:	6a 41                	push   $0x41
  jmp alltraps
801062a4:	e9 e5 f8 ff ff       	jmp    80105b8e <alltraps>

801062a9 <vector66>:
.globl vector66
vector66:
  pushl $0
801062a9:	6a 00                	push   $0x0
  pushl $66
801062ab:	6a 42                	push   $0x42
  jmp alltraps
801062ad:	e9 dc f8 ff ff       	jmp    80105b8e <alltraps>

801062b2 <vector67>:
.globl vector67
vector67:
  pushl $0
801062b2:	6a 00                	push   $0x0
  pushl $67
801062b4:	6a 43                	push   $0x43
  jmp alltraps
801062b6:	e9 d3 f8 ff ff       	jmp    80105b8e <alltraps>

801062bb <vector68>:
.globl vector68
vector68:
  pushl $0
801062bb:	6a 00                	push   $0x0
  pushl $68
801062bd:	6a 44                	push   $0x44
  jmp alltraps
801062bf:	e9 ca f8 ff ff       	jmp    80105b8e <alltraps>

801062c4 <vector69>:
.globl vector69
vector69:
  pushl $0
801062c4:	6a 00                	push   $0x0
  pushl $69
801062c6:	6a 45                	push   $0x45
  jmp alltraps
801062c8:	e9 c1 f8 ff ff       	jmp    80105b8e <alltraps>

801062cd <vector70>:
.globl vector70
vector70:
  pushl $0
801062cd:	6a 00                	push   $0x0
  pushl $70
801062cf:	6a 46                	push   $0x46
  jmp alltraps
801062d1:	e9 b8 f8 ff ff       	jmp    80105b8e <alltraps>

801062d6 <vector71>:
.globl vector71
vector71:
  pushl $0
801062d6:	6a 00                	push   $0x0
  pushl $71
801062d8:	6a 47                	push   $0x47
  jmp alltraps
801062da:	e9 af f8 ff ff       	jmp    80105b8e <alltraps>

801062df <vector72>:
.globl vector72
vector72:
  pushl $0
801062df:	6a 00                	push   $0x0
  pushl $72
801062e1:	6a 48                	push   $0x48
  jmp alltraps
801062e3:	e9 a6 f8 ff ff       	jmp    80105b8e <alltraps>

801062e8 <vector73>:
.globl vector73
vector73:
  pushl $0
801062e8:	6a 00                	push   $0x0
  pushl $73
801062ea:	6a 49                	push   $0x49
  jmp alltraps
801062ec:	e9 9d f8 ff ff       	jmp    80105b8e <alltraps>

801062f1 <vector74>:
.globl vector74
vector74:
  pushl $0
801062f1:	6a 00                	push   $0x0
  pushl $74
801062f3:	6a 4a                	push   $0x4a
  jmp alltraps
801062f5:	e9 94 f8 ff ff       	jmp    80105b8e <alltraps>

801062fa <vector75>:
.globl vector75
vector75:
  pushl $0
801062fa:	6a 00                	push   $0x0
  pushl $75
801062fc:	6a 4b                	push   $0x4b
  jmp alltraps
801062fe:	e9 8b f8 ff ff       	jmp    80105b8e <alltraps>

80106303 <vector76>:
.globl vector76
vector76:
  pushl $0
80106303:	6a 00                	push   $0x0
  pushl $76
80106305:	6a 4c                	push   $0x4c
  jmp alltraps
80106307:	e9 82 f8 ff ff       	jmp    80105b8e <alltraps>

8010630c <vector77>:
.globl vector77
vector77:
  pushl $0
8010630c:	6a 00                	push   $0x0
  pushl $77
8010630e:	6a 4d                	push   $0x4d
  jmp alltraps
80106310:	e9 79 f8 ff ff       	jmp    80105b8e <alltraps>

80106315 <vector78>:
.globl vector78
vector78:
  pushl $0
80106315:	6a 00                	push   $0x0
  pushl $78
80106317:	6a 4e                	push   $0x4e
  jmp alltraps
80106319:	e9 70 f8 ff ff       	jmp    80105b8e <alltraps>

8010631e <vector79>:
.globl vector79
vector79:
  pushl $0
8010631e:	6a 00                	push   $0x0
  pushl $79
80106320:	6a 4f                	push   $0x4f
  jmp alltraps
80106322:	e9 67 f8 ff ff       	jmp    80105b8e <alltraps>

80106327 <vector80>:
.globl vector80
vector80:
  pushl $0
80106327:	6a 00                	push   $0x0
  pushl $80
80106329:	6a 50                	push   $0x50
  jmp alltraps
8010632b:	e9 5e f8 ff ff       	jmp    80105b8e <alltraps>

80106330 <vector81>:
.globl vector81
vector81:
  pushl $0
80106330:	6a 00                	push   $0x0
  pushl $81
80106332:	6a 51                	push   $0x51
  jmp alltraps
80106334:	e9 55 f8 ff ff       	jmp    80105b8e <alltraps>

80106339 <vector82>:
.globl vector82
vector82:
  pushl $0
80106339:	6a 00                	push   $0x0
  pushl $82
8010633b:	6a 52                	push   $0x52
  jmp alltraps
8010633d:	e9 4c f8 ff ff       	jmp    80105b8e <alltraps>

80106342 <vector83>:
.globl vector83
vector83:
  pushl $0
80106342:	6a 00                	push   $0x0
  pushl $83
80106344:	6a 53                	push   $0x53
  jmp alltraps
80106346:	e9 43 f8 ff ff       	jmp    80105b8e <alltraps>

8010634b <vector84>:
.globl vector84
vector84:
  pushl $0
8010634b:	6a 00                	push   $0x0
  pushl $84
8010634d:	6a 54                	push   $0x54
  jmp alltraps
8010634f:	e9 3a f8 ff ff       	jmp    80105b8e <alltraps>

80106354 <vector85>:
.globl vector85
vector85:
  pushl $0
80106354:	6a 00                	push   $0x0
  pushl $85
80106356:	6a 55                	push   $0x55
  jmp alltraps
80106358:	e9 31 f8 ff ff       	jmp    80105b8e <alltraps>

8010635d <vector86>:
.globl vector86
vector86:
  pushl $0
8010635d:	6a 00                	push   $0x0
  pushl $86
8010635f:	6a 56                	push   $0x56
  jmp alltraps
80106361:	e9 28 f8 ff ff       	jmp    80105b8e <alltraps>

80106366 <vector87>:
.globl vector87
vector87:
  pushl $0
80106366:	6a 00                	push   $0x0
  pushl $87
80106368:	6a 57                	push   $0x57
  jmp alltraps
8010636a:	e9 1f f8 ff ff       	jmp    80105b8e <alltraps>

8010636f <vector88>:
.globl vector88
vector88:
  pushl $0
8010636f:	6a 00                	push   $0x0
  pushl $88
80106371:	6a 58                	push   $0x58
  jmp alltraps
80106373:	e9 16 f8 ff ff       	jmp    80105b8e <alltraps>

80106378 <vector89>:
.globl vector89
vector89:
  pushl $0
80106378:	6a 00                	push   $0x0
  pushl $89
8010637a:	6a 59                	push   $0x59
  jmp alltraps
8010637c:	e9 0d f8 ff ff       	jmp    80105b8e <alltraps>

80106381 <vector90>:
.globl vector90
vector90:
  pushl $0
80106381:	6a 00                	push   $0x0
  pushl $90
80106383:	6a 5a                	push   $0x5a
  jmp alltraps
80106385:	e9 04 f8 ff ff       	jmp    80105b8e <alltraps>

8010638a <vector91>:
.globl vector91
vector91:
  pushl $0
8010638a:	6a 00                	push   $0x0
  pushl $91
8010638c:	6a 5b                	push   $0x5b
  jmp alltraps
8010638e:	e9 fb f7 ff ff       	jmp    80105b8e <alltraps>

80106393 <vector92>:
.globl vector92
vector92:
  pushl $0
80106393:	6a 00                	push   $0x0
  pushl $92
80106395:	6a 5c                	push   $0x5c
  jmp alltraps
80106397:	e9 f2 f7 ff ff       	jmp    80105b8e <alltraps>

8010639c <vector93>:
.globl vector93
vector93:
  pushl $0
8010639c:	6a 00                	push   $0x0
  pushl $93
8010639e:	6a 5d                	push   $0x5d
  jmp alltraps
801063a0:	e9 e9 f7 ff ff       	jmp    80105b8e <alltraps>

801063a5 <vector94>:
.globl vector94
vector94:
  pushl $0
801063a5:	6a 00                	push   $0x0
  pushl $94
801063a7:	6a 5e                	push   $0x5e
  jmp alltraps
801063a9:	e9 e0 f7 ff ff       	jmp    80105b8e <alltraps>

801063ae <vector95>:
.globl vector95
vector95:
  pushl $0
801063ae:	6a 00                	push   $0x0
  pushl $95
801063b0:	6a 5f                	push   $0x5f
  jmp alltraps
801063b2:	e9 d7 f7 ff ff       	jmp    80105b8e <alltraps>

801063b7 <vector96>:
.globl vector96
vector96:
  pushl $0
801063b7:	6a 00                	push   $0x0
  pushl $96
801063b9:	6a 60                	push   $0x60
  jmp alltraps
801063bb:	e9 ce f7 ff ff       	jmp    80105b8e <alltraps>

801063c0 <vector97>:
.globl vector97
vector97:
  pushl $0
801063c0:	6a 00                	push   $0x0
  pushl $97
801063c2:	6a 61                	push   $0x61
  jmp alltraps
801063c4:	e9 c5 f7 ff ff       	jmp    80105b8e <alltraps>

801063c9 <vector98>:
.globl vector98
vector98:
  pushl $0
801063c9:	6a 00                	push   $0x0
  pushl $98
801063cb:	6a 62                	push   $0x62
  jmp alltraps
801063cd:	e9 bc f7 ff ff       	jmp    80105b8e <alltraps>

801063d2 <vector99>:
.globl vector99
vector99:
  pushl $0
801063d2:	6a 00                	push   $0x0
  pushl $99
801063d4:	6a 63                	push   $0x63
  jmp alltraps
801063d6:	e9 b3 f7 ff ff       	jmp    80105b8e <alltraps>

801063db <vector100>:
.globl vector100
vector100:
  pushl $0
801063db:	6a 00                	push   $0x0
  pushl $100
801063dd:	6a 64                	push   $0x64
  jmp alltraps
801063df:	e9 aa f7 ff ff       	jmp    80105b8e <alltraps>

801063e4 <vector101>:
.globl vector101
vector101:
  pushl $0
801063e4:	6a 00                	push   $0x0
  pushl $101
801063e6:	6a 65                	push   $0x65
  jmp alltraps
801063e8:	e9 a1 f7 ff ff       	jmp    80105b8e <alltraps>

801063ed <vector102>:
.globl vector102
vector102:
  pushl $0
801063ed:	6a 00                	push   $0x0
  pushl $102
801063ef:	6a 66                	push   $0x66
  jmp alltraps
801063f1:	e9 98 f7 ff ff       	jmp    80105b8e <alltraps>

801063f6 <vector103>:
.globl vector103
vector103:
  pushl $0
801063f6:	6a 00                	push   $0x0
  pushl $103
801063f8:	6a 67                	push   $0x67
  jmp alltraps
801063fa:	e9 8f f7 ff ff       	jmp    80105b8e <alltraps>

801063ff <vector104>:
.globl vector104
vector104:
  pushl $0
801063ff:	6a 00                	push   $0x0
  pushl $104
80106401:	6a 68                	push   $0x68
  jmp alltraps
80106403:	e9 86 f7 ff ff       	jmp    80105b8e <alltraps>

80106408 <vector105>:
.globl vector105
vector105:
  pushl $0
80106408:	6a 00                	push   $0x0
  pushl $105
8010640a:	6a 69                	push   $0x69
  jmp alltraps
8010640c:	e9 7d f7 ff ff       	jmp    80105b8e <alltraps>

80106411 <vector106>:
.globl vector106
vector106:
  pushl $0
80106411:	6a 00                	push   $0x0
  pushl $106
80106413:	6a 6a                	push   $0x6a
  jmp alltraps
80106415:	e9 74 f7 ff ff       	jmp    80105b8e <alltraps>

8010641a <vector107>:
.globl vector107
vector107:
  pushl $0
8010641a:	6a 00                	push   $0x0
  pushl $107
8010641c:	6a 6b                	push   $0x6b
  jmp alltraps
8010641e:	e9 6b f7 ff ff       	jmp    80105b8e <alltraps>

80106423 <vector108>:
.globl vector108
vector108:
  pushl $0
80106423:	6a 00                	push   $0x0
  pushl $108
80106425:	6a 6c                	push   $0x6c
  jmp alltraps
80106427:	e9 62 f7 ff ff       	jmp    80105b8e <alltraps>

8010642c <vector109>:
.globl vector109
vector109:
  pushl $0
8010642c:	6a 00                	push   $0x0
  pushl $109
8010642e:	6a 6d                	push   $0x6d
  jmp alltraps
80106430:	e9 59 f7 ff ff       	jmp    80105b8e <alltraps>

80106435 <vector110>:
.globl vector110
vector110:
  pushl $0
80106435:	6a 00                	push   $0x0
  pushl $110
80106437:	6a 6e                	push   $0x6e
  jmp alltraps
80106439:	e9 50 f7 ff ff       	jmp    80105b8e <alltraps>

8010643e <vector111>:
.globl vector111
vector111:
  pushl $0
8010643e:	6a 00                	push   $0x0
  pushl $111
80106440:	6a 6f                	push   $0x6f
  jmp alltraps
80106442:	e9 47 f7 ff ff       	jmp    80105b8e <alltraps>

80106447 <vector112>:
.globl vector112
vector112:
  pushl $0
80106447:	6a 00                	push   $0x0
  pushl $112
80106449:	6a 70                	push   $0x70
  jmp alltraps
8010644b:	e9 3e f7 ff ff       	jmp    80105b8e <alltraps>

80106450 <vector113>:
.globl vector113
vector113:
  pushl $0
80106450:	6a 00                	push   $0x0
  pushl $113
80106452:	6a 71                	push   $0x71
  jmp alltraps
80106454:	e9 35 f7 ff ff       	jmp    80105b8e <alltraps>

80106459 <vector114>:
.globl vector114
vector114:
  pushl $0
80106459:	6a 00                	push   $0x0
  pushl $114
8010645b:	6a 72                	push   $0x72
  jmp alltraps
8010645d:	e9 2c f7 ff ff       	jmp    80105b8e <alltraps>

80106462 <vector115>:
.globl vector115
vector115:
  pushl $0
80106462:	6a 00                	push   $0x0
  pushl $115
80106464:	6a 73                	push   $0x73
  jmp alltraps
80106466:	e9 23 f7 ff ff       	jmp    80105b8e <alltraps>

8010646b <vector116>:
.globl vector116
vector116:
  pushl $0
8010646b:	6a 00                	push   $0x0
  pushl $116
8010646d:	6a 74                	push   $0x74
  jmp alltraps
8010646f:	e9 1a f7 ff ff       	jmp    80105b8e <alltraps>

80106474 <vector117>:
.globl vector117
vector117:
  pushl $0
80106474:	6a 00                	push   $0x0
  pushl $117
80106476:	6a 75                	push   $0x75
  jmp alltraps
80106478:	e9 11 f7 ff ff       	jmp    80105b8e <alltraps>

8010647d <vector118>:
.globl vector118
vector118:
  pushl $0
8010647d:	6a 00                	push   $0x0
  pushl $118
8010647f:	6a 76                	push   $0x76
  jmp alltraps
80106481:	e9 08 f7 ff ff       	jmp    80105b8e <alltraps>

80106486 <vector119>:
.globl vector119
vector119:
  pushl $0
80106486:	6a 00                	push   $0x0
  pushl $119
80106488:	6a 77                	push   $0x77
  jmp alltraps
8010648a:	e9 ff f6 ff ff       	jmp    80105b8e <alltraps>

8010648f <vector120>:
.globl vector120
vector120:
  pushl $0
8010648f:	6a 00                	push   $0x0
  pushl $120
80106491:	6a 78                	push   $0x78
  jmp alltraps
80106493:	e9 f6 f6 ff ff       	jmp    80105b8e <alltraps>

80106498 <vector121>:
.globl vector121
vector121:
  pushl $0
80106498:	6a 00                	push   $0x0
  pushl $121
8010649a:	6a 79                	push   $0x79
  jmp alltraps
8010649c:	e9 ed f6 ff ff       	jmp    80105b8e <alltraps>

801064a1 <vector122>:
.globl vector122
vector122:
  pushl $0
801064a1:	6a 00                	push   $0x0
  pushl $122
801064a3:	6a 7a                	push   $0x7a
  jmp alltraps
801064a5:	e9 e4 f6 ff ff       	jmp    80105b8e <alltraps>

801064aa <vector123>:
.globl vector123
vector123:
  pushl $0
801064aa:	6a 00                	push   $0x0
  pushl $123
801064ac:	6a 7b                	push   $0x7b
  jmp alltraps
801064ae:	e9 db f6 ff ff       	jmp    80105b8e <alltraps>

801064b3 <vector124>:
.globl vector124
vector124:
  pushl $0
801064b3:	6a 00                	push   $0x0
  pushl $124
801064b5:	6a 7c                	push   $0x7c
  jmp alltraps
801064b7:	e9 d2 f6 ff ff       	jmp    80105b8e <alltraps>

801064bc <vector125>:
.globl vector125
vector125:
  pushl $0
801064bc:	6a 00                	push   $0x0
  pushl $125
801064be:	6a 7d                	push   $0x7d
  jmp alltraps
801064c0:	e9 c9 f6 ff ff       	jmp    80105b8e <alltraps>

801064c5 <vector126>:
.globl vector126
vector126:
  pushl $0
801064c5:	6a 00                	push   $0x0
  pushl $126
801064c7:	6a 7e                	push   $0x7e
  jmp alltraps
801064c9:	e9 c0 f6 ff ff       	jmp    80105b8e <alltraps>

801064ce <vector127>:
.globl vector127
vector127:
  pushl $0
801064ce:	6a 00                	push   $0x0
  pushl $127
801064d0:	6a 7f                	push   $0x7f
  jmp alltraps
801064d2:	e9 b7 f6 ff ff       	jmp    80105b8e <alltraps>

801064d7 <vector128>:
.globl vector128
vector128:
  pushl $0
801064d7:	6a 00                	push   $0x0
  pushl $128
801064d9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801064de:	e9 ab f6 ff ff       	jmp    80105b8e <alltraps>

801064e3 <vector129>:
.globl vector129
vector129:
  pushl $0
801064e3:	6a 00                	push   $0x0
  pushl $129
801064e5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801064ea:	e9 9f f6 ff ff       	jmp    80105b8e <alltraps>

801064ef <vector130>:
.globl vector130
vector130:
  pushl $0
801064ef:	6a 00                	push   $0x0
  pushl $130
801064f1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801064f6:	e9 93 f6 ff ff       	jmp    80105b8e <alltraps>

801064fb <vector131>:
.globl vector131
vector131:
  pushl $0
801064fb:	6a 00                	push   $0x0
  pushl $131
801064fd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106502:	e9 87 f6 ff ff       	jmp    80105b8e <alltraps>

80106507 <vector132>:
.globl vector132
vector132:
  pushl $0
80106507:	6a 00                	push   $0x0
  pushl $132
80106509:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010650e:	e9 7b f6 ff ff       	jmp    80105b8e <alltraps>

80106513 <vector133>:
.globl vector133
vector133:
  pushl $0
80106513:	6a 00                	push   $0x0
  pushl $133
80106515:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010651a:	e9 6f f6 ff ff       	jmp    80105b8e <alltraps>

8010651f <vector134>:
.globl vector134
vector134:
  pushl $0
8010651f:	6a 00                	push   $0x0
  pushl $134
80106521:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106526:	e9 63 f6 ff ff       	jmp    80105b8e <alltraps>

8010652b <vector135>:
.globl vector135
vector135:
  pushl $0
8010652b:	6a 00                	push   $0x0
  pushl $135
8010652d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106532:	e9 57 f6 ff ff       	jmp    80105b8e <alltraps>

80106537 <vector136>:
.globl vector136
vector136:
  pushl $0
80106537:	6a 00                	push   $0x0
  pushl $136
80106539:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010653e:	e9 4b f6 ff ff       	jmp    80105b8e <alltraps>

80106543 <vector137>:
.globl vector137
vector137:
  pushl $0
80106543:	6a 00                	push   $0x0
  pushl $137
80106545:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010654a:	e9 3f f6 ff ff       	jmp    80105b8e <alltraps>

8010654f <vector138>:
.globl vector138
vector138:
  pushl $0
8010654f:	6a 00                	push   $0x0
  pushl $138
80106551:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106556:	e9 33 f6 ff ff       	jmp    80105b8e <alltraps>

8010655b <vector139>:
.globl vector139
vector139:
  pushl $0
8010655b:	6a 00                	push   $0x0
  pushl $139
8010655d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106562:	e9 27 f6 ff ff       	jmp    80105b8e <alltraps>

80106567 <vector140>:
.globl vector140
vector140:
  pushl $0
80106567:	6a 00                	push   $0x0
  pushl $140
80106569:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010656e:	e9 1b f6 ff ff       	jmp    80105b8e <alltraps>

80106573 <vector141>:
.globl vector141
vector141:
  pushl $0
80106573:	6a 00                	push   $0x0
  pushl $141
80106575:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010657a:	e9 0f f6 ff ff       	jmp    80105b8e <alltraps>

8010657f <vector142>:
.globl vector142
vector142:
  pushl $0
8010657f:	6a 00                	push   $0x0
  pushl $142
80106581:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106586:	e9 03 f6 ff ff       	jmp    80105b8e <alltraps>

8010658b <vector143>:
.globl vector143
vector143:
  pushl $0
8010658b:	6a 00                	push   $0x0
  pushl $143
8010658d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106592:	e9 f7 f5 ff ff       	jmp    80105b8e <alltraps>

80106597 <vector144>:
.globl vector144
vector144:
  pushl $0
80106597:	6a 00                	push   $0x0
  pushl $144
80106599:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010659e:	e9 eb f5 ff ff       	jmp    80105b8e <alltraps>

801065a3 <vector145>:
.globl vector145
vector145:
  pushl $0
801065a3:	6a 00                	push   $0x0
  pushl $145
801065a5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801065aa:	e9 df f5 ff ff       	jmp    80105b8e <alltraps>

801065af <vector146>:
.globl vector146
vector146:
  pushl $0
801065af:	6a 00                	push   $0x0
  pushl $146
801065b1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801065b6:	e9 d3 f5 ff ff       	jmp    80105b8e <alltraps>

801065bb <vector147>:
.globl vector147
vector147:
  pushl $0
801065bb:	6a 00                	push   $0x0
  pushl $147
801065bd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801065c2:	e9 c7 f5 ff ff       	jmp    80105b8e <alltraps>

801065c7 <vector148>:
.globl vector148
vector148:
  pushl $0
801065c7:	6a 00                	push   $0x0
  pushl $148
801065c9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801065ce:	e9 bb f5 ff ff       	jmp    80105b8e <alltraps>

801065d3 <vector149>:
.globl vector149
vector149:
  pushl $0
801065d3:	6a 00                	push   $0x0
  pushl $149
801065d5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801065da:	e9 af f5 ff ff       	jmp    80105b8e <alltraps>

801065df <vector150>:
.globl vector150
vector150:
  pushl $0
801065df:	6a 00                	push   $0x0
  pushl $150
801065e1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801065e6:	e9 a3 f5 ff ff       	jmp    80105b8e <alltraps>

801065eb <vector151>:
.globl vector151
vector151:
  pushl $0
801065eb:	6a 00                	push   $0x0
  pushl $151
801065ed:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801065f2:	e9 97 f5 ff ff       	jmp    80105b8e <alltraps>

801065f7 <vector152>:
.globl vector152
vector152:
  pushl $0
801065f7:	6a 00                	push   $0x0
  pushl $152
801065f9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801065fe:	e9 8b f5 ff ff       	jmp    80105b8e <alltraps>

80106603 <vector153>:
.globl vector153
vector153:
  pushl $0
80106603:	6a 00                	push   $0x0
  pushl $153
80106605:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010660a:	e9 7f f5 ff ff       	jmp    80105b8e <alltraps>

8010660f <vector154>:
.globl vector154
vector154:
  pushl $0
8010660f:	6a 00                	push   $0x0
  pushl $154
80106611:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106616:	e9 73 f5 ff ff       	jmp    80105b8e <alltraps>

8010661b <vector155>:
.globl vector155
vector155:
  pushl $0
8010661b:	6a 00                	push   $0x0
  pushl $155
8010661d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106622:	e9 67 f5 ff ff       	jmp    80105b8e <alltraps>

80106627 <vector156>:
.globl vector156
vector156:
  pushl $0
80106627:	6a 00                	push   $0x0
  pushl $156
80106629:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010662e:	e9 5b f5 ff ff       	jmp    80105b8e <alltraps>

80106633 <vector157>:
.globl vector157
vector157:
  pushl $0
80106633:	6a 00                	push   $0x0
  pushl $157
80106635:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010663a:	e9 4f f5 ff ff       	jmp    80105b8e <alltraps>

8010663f <vector158>:
.globl vector158
vector158:
  pushl $0
8010663f:	6a 00                	push   $0x0
  pushl $158
80106641:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106646:	e9 43 f5 ff ff       	jmp    80105b8e <alltraps>

8010664b <vector159>:
.globl vector159
vector159:
  pushl $0
8010664b:	6a 00                	push   $0x0
  pushl $159
8010664d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106652:	e9 37 f5 ff ff       	jmp    80105b8e <alltraps>

80106657 <vector160>:
.globl vector160
vector160:
  pushl $0
80106657:	6a 00                	push   $0x0
  pushl $160
80106659:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010665e:	e9 2b f5 ff ff       	jmp    80105b8e <alltraps>

80106663 <vector161>:
.globl vector161
vector161:
  pushl $0
80106663:	6a 00                	push   $0x0
  pushl $161
80106665:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010666a:	e9 1f f5 ff ff       	jmp    80105b8e <alltraps>

8010666f <vector162>:
.globl vector162
vector162:
  pushl $0
8010666f:	6a 00                	push   $0x0
  pushl $162
80106671:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106676:	e9 13 f5 ff ff       	jmp    80105b8e <alltraps>

8010667b <vector163>:
.globl vector163
vector163:
  pushl $0
8010667b:	6a 00                	push   $0x0
  pushl $163
8010667d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106682:	e9 07 f5 ff ff       	jmp    80105b8e <alltraps>

80106687 <vector164>:
.globl vector164
vector164:
  pushl $0
80106687:	6a 00                	push   $0x0
  pushl $164
80106689:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010668e:	e9 fb f4 ff ff       	jmp    80105b8e <alltraps>

80106693 <vector165>:
.globl vector165
vector165:
  pushl $0
80106693:	6a 00                	push   $0x0
  pushl $165
80106695:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010669a:	e9 ef f4 ff ff       	jmp    80105b8e <alltraps>

8010669f <vector166>:
.globl vector166
vector166:
  pushl $0
8010669f:	6a 00                	push   $0x0
  pushl $166
801066a1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801066a6:	e9 e3 f4 ff ff       	jmp    80105b8e <alltraps>

801066ab <vector167>:
.globl vector167
vector167:
  pushl $0
801066ab:	6a 00                	push   $0x0
  pushl $167
801066ad:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801066b2:	e9 d7 f4 ff ff       	jmp    80105b8e <alltraps>

801066b7 <vector168>:
.globl vector168
vector168:
  pushl $0
801066b7:	6a 00                	push   $0x0
  pushl $168
801066b9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801066be:	e9 cb f4 ff ff       	jmp    80105b8e <alltraps>

801066c3 <vector169>:
.globl vector169
vector169:
  pushl $0
801066c3:	6a 00                	push   $0x0
  pushl $169
801066c5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801066ca:	e9 bf f4 ff ff       	jmp    80105b8e <alltraps>

801066cf <vector170>:
.globl vector170
vector170:
  pushl $0
801066cf:	6a 00                	push   $0x0
  pushl $170
801066d1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801066d6:	e9 b3 f4 ff ff       	jmp    80105b8e <alltraps>

801066db <vector171>:
.globl vector171
vector171:
  pushl $0
801066db:	6a 00                	push   $0x0
  pushl $171
801066dd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801066e2:	e9 a7 f4 ff ff       	jmp    80105b8e <alltraps>

801066e7 <vector172>:
.globl vector172
vector172:
  pushl $0
801066e7:	6a 00                	push   $0x0
  pushl $172
801066e9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801066ee:	e9 9b f4 ff ff       	jmp    80105b8e <alltraps>

801066f3 <vector173>:
.globl vector173
vector173:
  pushl $0
801066f3:	6a 00                	push   $0x0
  pushl $173
801066f5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801066fa:	e9 8f f4 ff ff       	jmp    80105b8e <alltraps>

801066ff <vector174>:
.globl vector174
vector174:
  pushl $0
801066ff:	6a 00                	push   $0x0
  pushl $174
80106701:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106706:	e9 83 f4 ff ff       	jmp    80105b8e <alltraps>

8010670b <vector175>:
.globl vector175
vector175:
  pushl $0
8010670b:	6a 00                	push   $0x0
  pushl $175
8010670d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106712:	e9 77 f4 ff ff       	jmp    80105b8e <alltraps>

80106717 <vector176>:
.globl vector176
vector176:
  pushl $0
80106717:	6a 00                	push   $0x0
  pushl $176
80106719:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010671e:	e9 6b f4 ff ff       	jmp    80105b8e <alltraps>

80106723 <vector177>:
.globl vector177
vector177:
  pushl $0
80106723:	6a 00                	push   $0x0
  pushl $177
80106725:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010672a:	e9 5f f4 ff ff       	jmp    80105b8e <alltraps>

8010672f <vector178>:
.globl vector178
vector178:
  pushl $0
8010672f:	6a 00                	push   $0x0
  pushl $178
80106731:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106736:	e9 53 f4 ff ff       	jmp    80105b8e <alltraps>

8010673b <vector179>:
.globl vector179
vector179:
  pushl $0
8010673b:	6a 00                	push   $0x0
  pushl $179
8010673d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106742:	e9 47 f4 ff ff       	jmp    80105b8e <alltraps>

80106747 <vector180>:
.globl vector180
vector180:
  pushl $0
80106747:	6a 00                	push   $0x0
  pushl $180
80106749:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010674e:	e9 3b f4 ff ff       	jmp    80105b8e <alltraps>

80106753 <vector181>:
.globl vector181
vector181:
  pushl $0
80106753:	6a 00                	push   $0x0
  pushl $181
80106755:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010675a:	e9 2f f4 ff ff       	jmp    80105b8e <alltraps>

8010675f <vector182>:
.globl vector182
vector182:
  pushl $0
8010675f:	6a 00                	push   $0x0
  pushl $182
80106761:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106766:	e9 23 f4 ff ff       	jmp    80105b8e <alltraps>

8010676b <vector183>:
.globl vector183
vector183:
  pushl $0
8010676b:	6a 00                	push   $0x0
  pushl $183
8010676d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106772:	e9 17 f4 ff ff       	jmp    80105b8e <alltraps>

80106777 <vector184>:
.globl vector184
vector184:
  pushl $0
80106777:	6a 00                	push   $0x0
  pushl $184
80106779:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010677e:	e9 0b f4 ff ff       	jmp    80105b8e <alltraps>

80106783 <vector185>:
.globl vector185
vector185:
  pushl $0
80106783:	6a 00                	push   $0x0
  pushl $185
80106785:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010678a:	e9 ff f3 ff ff       	jmp    80105b8e <alltraps>

8010678f <vector186>:
.globl vector186
vector186:
  pushl $0
8010678f:	6a 00                	push   $0x0
  pushl $186
80106791:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106796:	e9 f3 f3 ff ff       	jmp    80105b8e <alltraps>

8010679b <vector187>:
.globl vector187
vector187:
  pushl $0
8010679b:	6a 00                	push   $0x0
  pushl $187
8010679d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801067a2:	e9 e7 f3 ff ff       	jmp    80105b8e <alltraps>

801067a7 <vector188>:
.globl vector188
vector188:
  pushl $0
801067a7:	6a 00                	push   $0x0
  pushl $188
801067a9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801067ae:	e9 db f3 ff ff       	jmp    80105b8e <alltraps>

801067b3 <vector189>:
.globl vector189
vector189:
  pushl $0
801067b3:	6a 00                	push   $0x0
  pushl $189
801067b5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801067ba:	e9 cf f3 ff ff       	jmp    80105b8e <alltraps>

801067bf <vector190>:
.globl vector190
vector190:
  pushl $0
801067bf:	6a 00                	push   $0x0
  pushl $190
801067c1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801067c6:	e9 c3 f3 ff ff       	jmp    80105b8e <alltraps>

801067cb <vector191>:
.globl vector191
vector191:
  pushl $0
801067cb:	6a 00                	push   $0x0
  pushl $191
801067cd:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801067d2:	e9 b7 f3 ff ff       	jmp    80105b8e <alltraps>

801067d7 <vector192>:
.globl vector192
vector192:
  pushl $0
801067d7:	6a 00                	push   $0x0
  pushl $192
801067d9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801067de:	e9 ab f3 ff ff       	jmp    80105b8e <alltraps>

801067e3 <vector193>:
.globl vector193
vector193:
  pushl $0
801067e3:	6a 00                	push   $0x0
  pushl $193
801067e5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801067ea:	e9 9f f3 ff ff       	jmp    80105b8e <alltraps>

801067ef <vector194>:
.globl vector194
vector194:
  pushl $0
801067ef:	6a 00                	push   $0x0
  pushl $194
801067f1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801067f6:	e9 93 f3 ff ff       	jmp    80105b8e <alltraps>

801067fb <vector195>:
.globl vector195
vector195:
  pushl $0
801067fb:	6a 00                	push   $0x0
  pushl $195
801067fd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106802:	e9 87 f3 ff ff       	jmp    80105b8e <alltraps>

80106807 <vector196>:
.globl vector196
vector196:
  pushl $0
80106807:	6a 00                	push   $0x0
  pushl $196
80106809:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010680e:	e9 7b f3 ff ff       	jmp    80105b8e <alltraps>

80106813 <vector197>:
.globl vector197
vector197:
  pushl $0
80106813:	6a 00                	push   $0x0
  pushl $197
80106815:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010681a:	e9 6f f3 ff ff       	jmp    80105b8e <alltraps>

8010681f <vector198>:
.globl vector198
vector198:
  pushl $0
8010681f:	6a 00                	push   $0x0
  pushl $198
80106821:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106826:	e9 63 f3 ff ff       	jmp    80105b8e <alltraps>

8010682b <vector199>:
.globl vector199
vector199:
  pushl $0
8010682b:	6a 00                	push   $0x0
  pushl $199
8010682d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106832:	e9 57 f3 ff ff       	jmp    80105b8e <alltraps>

80106837 <vector200>:
.globl vector200
vector200:
  pushl $0
80106837:	6a 00                	push   $0x0
  pushl $200
80106839:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010683e:	e9 4b f3 ff ff       	jmp    80105b8e <alltraps>

80106843 <vector201>:
.globl vector201
vector201:
  pushl $0
80106843:	6a 00                	push   $0x0
  pushl $201
80106845:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010684a:	e9 3f f3 ff ff       	jmp    80105b8e <alltraps>

8010684f <vector202>:
.globl vector202
vector202:
  pushl $0
8010684f:	6a 00                	push   $0x0
  pushl $202
80106851:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106856:	e9 33 f3 ff ff       	jmp    80105b8e <alltraps>

8010685b <vector203>:
.globl vector203
vector203:
  pushl $0
8010685b:	6a 00                	push   $0x0
  pushl $203
8010685d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106862:	e9 27 f3 ff ff       	jmp    80105b8e <alltraps>

80106867 <vector204>:
.globl vector204
vector204:
  pushl $0
80106867:	6a 00                	push   $0x0
  pushl $204
80106869:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010686e:	e9 1b f3 ff ff       	jmp    80105b8e <alltraps>

80106873 <vector205>:
.globl vector205
vector205:
  pushl $0
80106873:	6a 00                	push   $0x0
  pushl $205
80106875:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010687a:	e9 0f f3 ff ff       	jmp    80105b8e <alltraps>

8010687f <vector206>:
.globl vector206
vector206:
  pushl $0
8010687f:	6a 00                	push   $0x0
  pushl $206
80106881:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106886:	e9 03 f3 ff ff       	jmp    80105b8e <alltraps>

8010688b <vector207>:
.globl vector207
vector207:
  pushl $0
8010688b:	6a 00                	push   $0x0
  pushl $207
8010688d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106892:	e9 f7 f2 ff ff       	jmp    80105b8e <alltraps>

80106897 <vector208>:
.globl vector208
vector208:
  pushl $0
80106897:	6a 00                	push   $0x0
  pushl $208
80106899:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010689e:	e9 eb f2 ff ff       	jmp    80105b8e <alltraps>

801068a3 <vector209>:
.globl vector209
vector209:
  pushl $0
801068a3:	6a 00                	push   $0x0
  pushl $209
801068a5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801068aa:	e9 df f2 ff ff       	jmp    80105b8e <alltraps>

801068af <vector210>:
.globl vector210
vector210:
  pushl $0
801068af:	6a 00                	push   $0x0
  pushl $210
801068b1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801068b6:	e9 d3 f2 ff ff       	jmp    80105b8e <alltraps>

801068bb <vector211>:
.globl vector211
vector211:
  pushl $0
801068bb:	6a 00                	push   $0x0
  pushl $211
801068bd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801068c2:	e9 c7 f2 ff ff       	jmp    80105b8e <alltraps>

801068c7 <vector212>:
.globl vector212
vector212:
  pushl $0
801068c7:	6a 00                	push   $0x0
  pushl $212
801068c9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801068ce:	e9 bb f2 ff ff       	jmp    80105b8e <alltraps>

801068d3 <vector213>:
.globl vector213
vector213:
  pushl $0
801068d3:	6a 00                	push   $0x0
  pushl $213
801068d5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801068da:	e9 af f2 ff ff       	jmp    80105b8e <alltraps>

801068df <vector214>:
.globl vector214
vector214:
  pushl $0
801068df:	6a 00                	push   $0x0
  pushl $214
801068e1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801068e6:	e9 a3 f2 ff ff       	jmp    80105b8e <alltraps>

801068eb <vector215>:
.globl vector215
vector215:
  pushl $0
801068eb:	6a 00                	push   $0x0
  pushl $215
801068ed:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801068f2:	e9 97 f2 ff ff       	jmp    80105b8e <alltraps>

801068f7 <vector216>:
.globl vector216
vector216:
  pushl $0
801068f7:	6a 00                	push   $0x0
  pushl $216
801068f9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801068fe:	e9 8b f2 ff ff       	jmp    80105b8e <alltraps>

80106903 <vector217>:
.globl vector217
vector217:
  pushl $0
80106903:	6a 00                	push   $0x0
  pushl $217
80106905:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010690a:	e9 7f f2 ff ff       	jmp    80105b8e <alltraps>

8010690f <vector218>:
.globl vector218
vector218:
  pushl $0
8010690f:	6a 00                	push   $0x0
  pushl $218
80106911:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106916:	e9 73 f2 ff ff       	jmp    80105b8e <alltraps>

8010691b <vector219>:
.globl vector219
vector219:
  pushl $0
8010691b:	6a 00                	push   $0x0
  pushl $219
8010691d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106922:	e9 67 f2 ff ff       	jmp    80105b8e <alltraps>

80106927 <vector220>:
.globl vector220
vector220:
  pushl $0
80106927:	6a 00                	push   $0x0
  pushl $220
80106929:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010692e:	e9 5b f2 ff ff       	jmp    80105b8e <alltraps>

80106933 <vector221>:
.globl vector221
vector221:
  pushl $0
80106933:	6a 00                	push   $0x0
  pushl $221
80106935:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010693a:	e9 4f f2 ff ff       	jmp    80105b8e <alltraps>

8010693f <vector222>:
.globl vector222
vector222:
  pushl $0
8010693f:	6a 00                	push   $0x0
  pushl $222
80106941:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106946:	e9 43 f2 ff ff       	jmp    80105b8e <alltraps>

8010694b <vector223>:
.globl vector223
vector223:
  pushl $0
8010694b:	6a 00                	push   $0x0
  pushl $223
8010694d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106952:	e9 37 f2 ff ff       	jmp    80105b8e <alltraps>

80106957 <vector224>:
.globl vector224
vector224:
  pushl $0
80106957:	6a 00                	push   $0x0
  pushl $224
80106959:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010695e:	e9 2b f2 ff ff       	jmp    80105b8e <alltraps>

80106963 <vector225>:
.globl vector225
vector225:
  pushl $0
80106963:	6a 00                	push   $0x0
  pushl $225
80106965:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010696a:	e9 1f f2 ff ff       	jmp    80105b8e <alltraps>

8010696f <vector226>:
.globl vector226
vector226:
  pushl $0
8010696f:	6a 00                	push   $0x0
  pushl $226
80106971:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106976:	e9 13 f2 ff ff       	jmp    80105b8e <alltraps>

8010697b <vector227>:
.globl vector227
vector227:
  pushl $0
8010697b:	6a 00                	push   $0x0
  pushl $227
8010697d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106982:	e9 07 f2 ff ff       	jmp    80105b8e <alltraps>

80106987 <vector228>:
.globl vector228
vector228:
  pushl $0
80106987:	6a 00                	push   $0x0
  pushl $228
80106989:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010698e:	e9 fb f1 ff ff       	jmp    80105b8e <alltraps>

80106993 <vector229>:
.globl vector229
vector229:
  pushl $0
80106993:	6a 00                	push   $0x0
  pushl $229
80106995:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010699a:	e9 ef f1 ff ff       	jmp    80105b8e <alltraps>

8010699f <vector230>:
.globl vector230
vector230:
  pushl $0
8010699f:	6a 00                	push   $0x0
  pushl $230
801069a1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801069a6:	e9 e3 f1 ff ff       	jmp    80105b8e <alltraps>

801069ab <vector231>:
.globl vector231
vector231:
  pushl $0
801069ab:	6a 00                	push   $0x0
  pushl $231
801069ad:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801069b2:	e9 d7 f1 ff ff       	jmp    80105b8e <alltraps>

801069b7 <vector232>:
.globl vector232
vector232:
  pushl $0
801069b7:	6a 00                	push   $0x0
  pushl $232
801069b9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801069be:	e9 cb f1 ff ff       	jmp    80105b8e <alltraps>

801069c3 <vector233>:
.globl vector233
vector233:
  pushl $0
801069c3:	6a 00                	push   $0x0
  pushl $233
801069c5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801069ca:	e9 bf f1 ff ff       	jmp    80105b8e <alltraps>

801069cf <vector234>:
.globl vector234
vector234:
  pushl $0
801069cf:	6a 00                	push   $0x0
  pushl $234
801069d1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801069d6:	e9 b3 f1 ff ff       	jmp    80105b8e <alltraps>

801069db <vector235>:
.globl vector235
vector235:
  pushl $0
801069db:	6a 00                	push   $0x0
  pushl $235
801069dd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801069e2:	e9 a7 f1 ff ff       	jmp    80105b8e <alltraps>

801069e7 <vector236>:
.globl vector236
vector236:
  pushl $0
801069e7:	6a 00                	push   $0x0
  pushl $236
801069e9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801069ee:	e9 9b f1 ff ff       	jmp    80105b8e <alltraps>

801069f3 <vector237>:
.globl vector237
vector237:
  pushl $0
801069f3:	6a 00                	push   $0x0
  pushl $237
801069f5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801069fa:	e9 8f f1 ff ff       	jmp    80105b8e <alltraps>

801069ff <vector238>:
.globl vector238
vector238:
  pushl $0
801069ff:	6a 00                	push   $0x0
  pushl $238
80106a01:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106a06:	e9 83 f1 ff ff       	jmp    80105b8e <alltraps>

80106a0b <vector239>:
.globl vector239
vector239:
  pushl $0
80106a0b:	6a 00                	push   $0x0
  pushl $239
80106a0d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106a12:	e9 77 f1 ff ff       	jmp    80105b8e <alltraps>

80106a17 <vector240>:
.globl vector240
vector240:
  pushl $0
80106a17:	6a 00                	push   $0x0
  pushl $240
80106a19:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106a1e:	e9 6b f1 ff ff       	jmp    80105b8e <alltraps>

80106a23 <vector241>:
.globl vector241
vector241:
  pushl $0
80106a23:	6a 00                	push   $0x0
  pushl $241
80106a25:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106a2a:	e9 5f f1 ff ff       	jmp    80105b8e <alltraps>

80106a2f <vector242>:
.globl vector242
vector242:
  pushl $0
80106a2f:	6a 00                	push   $0x0
  pushl $242
80106a31:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106a36:	e9 53 f1 ff ff       	jmp    80105b8e <alltraps>

80106a3b <vector243>:
.globl vector243
vector243:
  pushl $0
80106a3b:	6a 00                	push   $0x0
  pushl $243
80106a3d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106a42:	e9 47 f1 ff ff       	jmp    80105b8e <alltraps>

80106a47 <vector244>:
.globl vector244
vector244:
  pushl $0
80106a47:	6a 00                	push   $0x0
  pushl $244
80106a49:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106a4e:	e9 3b f1 ff ff       	jmp    80105b8e <alltraps>

80106a53 <vector245>:
.globl vector245
vector245:
  pushl $0
80106a53:	6a 00                	push   $0x0
  pushl $245
80106a55:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106a5a:	e9 2f f1 ff ff       	jmp    80105b8e <alltraps>

80106a5f <vector246>:
.globl vector246
vector246:
  pushl $0
80106a5f:	6a 00                	push   $0x0
  pushl $246
80106a61:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106a66:	e9 23 f1 ff ff       	jmp    80105b8e <alltraps>

80106a6b <vector247>:
.globl vector247
vector247:
  pushl $0
80106a6b:	6a 00                	push   $0x0
  pushl $247
80106a6d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106a72:	e9 17 f1 ff ff       	jmp    80105b8e <alltraps>

80106a77 <vector248>:
.globl vector248
vector248:
  pushl $0
80106a77:	6a 00                	push   $0x0
  pushl $248
80106a79:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106a7e:	e9 0b f1 ff ff       	jmp    80105b8e <alltraps>

80106a83 <vector249>:
.globl vector249
vector249:
  pushl $0
80106a83:	6a 00                	push   $0x0
  pushl $249
80106a85:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106a8a:	e9 ff f0 ff ff       	jmp    80105b8e <alltraps>

80106a8f <vector250>:
.globl vector250
vector250:
  pushl $0
80106a8f:	6a 00                	push   $0x0
  pushl $250
80106a91:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106a96:	e9 f3 f0 ff ff       	jmp    80105b8e <alltraps>

80106a9b <vector251>:
.globl vector251
vector251:
  pushl $0
80106a9b:	6a 00                	push   $0x0
  pushl $251
80106a9d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106aa2:	e9 e7 f0 ff ff       	jmp    80105b8e <alltraps>

80106aa7 <vector252>:
.globl vector252
vector252:
  pushl $0
80106aa7:	6a 00                	push   $0x0
  pushl $252
80106aa9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106aae:	e9 db f0 ff ff       	jmp    80105b8e <alltraps>

80106ab3 <vector253>:
.globl vector253
vector253:
  pushl $0
80106ab3:	6a 00                	push   $0x0
  pushl $253
80106ab5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106aba:	e9 cf f0 ff ff       	jmp    80105b8e <alltraps>

80106abf <vector254>:
.globl vector254
vector254:
  pushl $0
80106abf:	6a 00                	push   $0x0
  pushl $254
80106ac1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106ac6:	e9 c3 f0 ff ff       	jmp    80105b8e <alltraps>

80106acb <vector255>:
.globl vector255
vector255:
  pushl $0
80106acb:	6a 00                	push   $0x0
  pushl $255
80106acd:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106ad2:	e9 b7 f0 ff ff       	jmp    80105b8e <alltraps>
80106ad7:	66 90                	xchg   %ax,%ax
80106ad9:	66 90                	xchg   %ax,%ax
80106adb:	66 90                	xchg   %ax,%ax
80106add:	66 90                	xchg   %ax,%ax
80106adf:	90                   	nop

80106ae0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106ae0:	55                   	push   %ebp
80106ae1:	89 e5                	mov    %esp,%ebp
80106ae3:	57                   	push   %edi
80106ae4:	56                   	push   %esi
80106ae5:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106ae6:	89 d3                	mov    %edx,%ebx
{
80106ae8:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
80106aea:	c1 eb 16             	shr    $0x16,%ebx
80106aed:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106af0:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106af3:	8b 06                	mov    (%esi),%eax
80106af5:	a8 01                	test   $0x1,%al
80106af7:	74 27                	je     80106b20 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106af9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106afe:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106b04:	c1 ef 0a             	shr    $0xa,%edi
}
80106b07:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80106b0a:	89 fa                	mov    %edi,%edx
80106b0c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106b12:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106b15:	5b                   	pop    %ebx
80106b16:	5e                   	pop    %esi
80106b17:	5f                   	pop    %edi
80106b18:	5d                   	pop    %ebp
80106b19:	c3                   	ret    
80106b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106b20:	85 c9                	test   %ecx,%ecx
80106b22:	74 2c                	je     80106b50 <walkpgdir+0x70>
80106b24:	e8 57 b9 ff ff       	call   80102480 <kalloc>
80106b29:	85 c0                	test   %eax,%eax
80106b2b:	89 c3                	mov    %eax,%ebx
80106b2d:	74 21                	je     80106b50 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
80106b2f:	83 ec 04             	sub    $0x4,%esp
80106b32:	68 00 10 00 00       	push   $0x1000
80106b37:	6a 00                	push   $0x0
80106b39:	50                   	push   %eax
80106b3a:	e8 21 db ff ff       	call   80104660 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106b3f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106b45:	83 c4 10             	add    $0x10,%esp
80106b48:	83 c8 07             	or     $0x7,%eax
80106b4b:	89 06                	mov    %eax,(%esi)
80106b4d:	eb b5                	jmp    80106b04 <walkpgdir+0x24>
80106b4f:	90                   	nop
}
80106b50:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106b53:	31 c0                	xor    %eax,%eax
}
80106b55:	5b                   	pop    %ebx
80106b56:	5e                   	pop    %esi
80106b57:	5f                   	pop    %edi
80106b58:	5d                   	pop    %ebp
80106b59:	c3                   	ret    
80106b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106b60 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106b60:	55                   	push   %ebp
80106b61:	89 e5                	mov    %esp,%ebp
80106b63:	57                   	push   %edi
80106b64:	56                   	push   %esi
80106b65:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106b66:	89 d3                	mov    %edx,%ebx
80106b68:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106b6e:	83 ec 1c             	sub    $0x1c,%esp
80106b71:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106b74:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106b78:	8b 7d 08             	mov    0x8(%ebp),%edi
80106b7b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106b80:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106b83:	8b 45 0c             	mov    0xc(%ebp),%eax
80106b86:	29 df                	sub    %ebx,%edi
80106b88:	83 c8 01             	or     $0x1,%eax
80106b8b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106b8e:	eb 15                	jmp    80106ba5 <mappages+0x45>
    if(*pte & PTE_P)
80106b90:	f6 00 01             	testb  $0x1,(%eax)
80106b93:	75 45                	jne    80106bda <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80106b95:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106b98:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
80106b9b:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106b9d:	74 31                	je     80106bd0 <mappages+0x70>
      break;
    a += PGSIZE;
80106b9f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106ba5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ba8:	b9 01 00 00 00       	mov    $0x1,%ecx
80106bad:	89 da                	mov    %ebx,%edx
80106baf:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106bb2:	e8 29 ff ff ff       	call   80106ae0 <walkpgdir>
80106bb7:	85 c0                	test   %eax,%eax
80106bb9:	75 d5                	jne    80106b90 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80106bbb:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106bbe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106bc3:	5b                   	pop    %ebx
80106bc4:	5e                   	pop    %esi
80106bc5:	5f                   	pop    %edi
80106bc6:	5d                   	pop    %ebp
80106bc7:	c3                   	ret    
80106bc8:	90                   	nop
80106bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106bd0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106bd3:	31 c0                	xor    %eax,%eax
}
80106bd5:	5b                   	pop    %ebx
80106bd6:	5e                   	pop    %esi
80106bd7:	5f                   	pop    %edi
80106bd8:	5d                   	pop    %ebp
80106bd9:	c3                   	ret    
      panic("remap");
80106bda:	83 ec 0c             	sub    $0xc,%esp
80106bdd:	68 1c 7d 10 80       	push   $0x80107d1c
80106be2:	e8 89 97 ff ff       	call   80100370 <panic>
80106be7:	89 f6                	mov    %esi,%esi
80106be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106bf0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106bf0:	55                   	push   %ebp
80106bf1:	89 e5                	mov    %esp,%ebp
80106bf3:	57                   	push   %edi
80106bf4:	56                   	push   %esi
80106bf5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106bf6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106bfc:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
80106bfe:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106c04:	83 ec 1c             	sub    $0x1c,%esp
80106c07:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106c0a:	39 d3                	cmp    %edx,%ebx
80106c0c:	73 60                	jae    80106c6e <deallocuvm.part.0+0x7e>
80106c0e:	89 d6                	mov    %edx,%esi
80106c10:	eb 3d                	jmp    80106c4f <deallocuvm.part.0+0x5f>
80106c12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a += (NPTENTRIES - 1) * PGSIZE;
    else if((*pte & PTE_P) != 0){
80106c18:	8b 10                	mov    (%eax),%edx
80106c1a:	f6 c2 01             	test   $0x1,%dl
80106c1d:	74 26                	je     80106c45 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106c1f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106c25:	74 52                	je     80106c79 <deallocuvm.part.0+0x89>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106c27:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106c2a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106c30:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80106c33:	52                   	push   %edx
80106c34:	e8 97 b6 ff ff       	call   801022d0 <kfree>
      *pte = 0;
80106c39:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106c3c:	83 c4 10             	add    $0x10,%esp
80106c3f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80106c45:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c4b:	39 f3                	cmp    %esi,%ebx
80106c4d:	73 1f                	jae    80106c6e <deallocuvm.part.0+0x7e>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106c4f:	31 c9                	xor    %ecx,%ecx
80106c51:	89 da                	mov    %ebx,%edx
80106c53:	89 f8                	mov    %edi,%eax
80106c55:	e8 86 fe ff ff       	call   80106ae0 <walkpgdir>
    if(!pte)
80106c5a:	85 c0                	test   %eax,%eax
80106c5c:	75 ba                	jne    80106c18 <deallocuvm.part.0+0x28>
      a += (NPTENTRIES - 1) * PGSIZE;
80106c5e:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106c64:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c6a:	39 f3                	cmp    %esi,%ebx
80106c6c:	72 e1                	jb     80106c4f <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
80106c6e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106c71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c74:	5b                   	pop    %ebx
80106c75:	5e                   	pop    %esi
80106c76:	5f                   	pop    %edi
80106c77:	5d                   	pop    %ebp
80106c78:	c3                   	ret    
        panic("kfree");
80106c79:	83 ec 0c             	sub    $0xc,%esp
80106c7c:	68 52 76 10 80       	push   $0x80107652
80106c81:	e8 ea 96 ff ff       	call   80100370 <panic>
80106c86:	8d 76 00             	lea    0x0(%esi),%esi
80106c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c90 <seginit>:
{
80106c90:	55                   	push   %ebp
80106c91:	89 e5                	mov    %esp,%ebp
80106c93:	53                   	push   %ebx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106c94:	31 db                	xor    %ebx,%ebx
{
80106c96:	83 ec 14             	sub    $0x14,%esp
  c = &cpus[cpunum()];
80106c99:	e8 52 ba ff ff       	call   801026f0 <cpunum>
80106c9e:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106ca4:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
80106ca9:	8d 90 a0 27 11 80    	lea    -0x7feed860(%eax),%edx
80106caf:	c6 80 1d 28 11 80 9a 	movb   $0x9a,-0x7feed7e3(%eax)
80106cb6:	c6 80 1e 28 11 80 cf 	movb   $0xcf,-0x7feed7e2(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106cbd:	c6 80 25 28 11 80 92 	movb   $0x92,-0x7feed7db(%eax)
80106cc4:	c6 80 26 28 11 80 cf 	movb   $0xcf,-0x7feed7da(%eax)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106ccb:	66 89 4a 78          	mov    %cx,0x78(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106ccf:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106cd4:	66 89 5a 7a          	mov    %bx,0x7a(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106cd8:	66 89 8a 80 00 00 00 	mov    %cx,0x80(%edx)
80106cdf:	31 db                	xor    %ebx,%ebx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106ce1:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106ce6:	66 89 9a 82 00 00 00 	mov    %bx,0x82(%edx)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106ced:	66 89 8a 90 00 00 00 	mov    %cx,0x90(%edx)
80106cf4:	31 db                	xor    %ebx,%ebx
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106cf6:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106cfb:	66 89 9a 92 00 00 00 	mov    %bx,0x92(%edx)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106d02:	31 db                	xor    %ebx,%ebx
80106d04:	66 89 8a 98 00 00 00 	mov    %cx,0x98(%edx)
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106d0b:	8d 88 54 28 11 80    	lea    -0x7feed7ac(%eax),%ecx
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106d11:	66 89 9a 9a 00 00 00 	mov    %bx,0x9a(%edx)
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106d18:	31 db                	xor    %ebx,%ebx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106d1a:	c6 80 35 28 11 80 fa 	movb   $0xfa,-0x7feed7cb(%eax)
80106d21:	c6 80 36 28 11 80 cf 	movb   $0xcf,-0x7feed7ca(%eax)
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106d28:	66 89 9a 88 00 00 00 	mov    %bx,0x88(%edx)
80106d2f:	66 89 8a 8a 00 00 00 	mov    %cx,0x8a(%edx)
80106d36:	89 cb                	mov    %ecx,%ebx
80106d38:	c1 e9 18             	shr    $0x18,%ecx
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106d3b:	c6 80 3d 28 11 80 f2 	movb   $0xf2,-0x7feed7c3(%eax)
80106d42:	c6 80 3e 28 11 80 cf 	movb   $0xcf,-0x7feed7c2(%eax)
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106d49:	88 8a 8f 00 00 00    	mov    %cl,0x8f(%edx)
80106d4f:	c6 80 2d 28 11 80 92 	movb   $0x92,-0x7feed7d3(%eax)
  pd[0] = size-1;
80106d56:	b9 37 00 00 00       	mov    $0x37,%ecx
80106d5b:	c6 80 2e 28 11 80 c0 	movb   $0xc0,-0x7feed7d2(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106d62:	05 10 28 11 80       	add    $0x80112810,%eax
80106d67:	66 89 4d f2          	mov    %cx,-0xe(%ebp)
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106d6b:	c1 eb 10             	shr    $0x10,%ebx
  pd[1] = (uint)p;
80106d6e:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106d72:	c1 e8 10             	shr    $0x10,%eax
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106d75:	c6 42 7c 00          	movb   $0x0,0x7c(%edx)
80106d79:	c6 42 7f 00          	movb   $0x0,0x7f(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106d7d:	c6 82 84 00 00 00 00 	movb   $0x0,0x84(%edx)
80106d84:	c6 82 87 00 00 00 00 	movb   $0x0,0x87(%edx)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106d8b:	c6 82 94 00 00 00 00 	movb   $0x0,0x94(%edx)
80106d92:	c6 82 97 00 00 00 00 	movb   $0x0,0x97(%edx)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106d99:	c6 82 9c 00 00 00 00 	movb   $0x0,0x9c(%edx)
80106da0:	c6 82 9f 00 00 00 00 	movb   $0x0,0x9f(%edx)
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106da7:	88 9a 8c 00 00 00    	mov    %bl,0x8c(%edx)
80106dad:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106db1:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106db4:	0f 01 10             	lgdtl  (%eax)
  asm volatile("movw %0, %%gs" : : "r" (v));
80106db7:	b8 18 00 00 00       	mov    $0x18,%eax
80106dbc:	8e e8                	mov    %eax,%gs
  proc = 0;
80106dbe:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80106dc5:	00 00 00 00 
  c = &cpus[cpunum()];
80106dc9:	65 89 15 00 00 00 00 	mov    %edx,%gs:0x0
}
80106dd0:	83 c4 14             	add    $0x14,%esp
80106dd3:	5b                   	pop    %ebx
80106dd4:	5d                   	pop    %ebp
80106dd5:	c3                   	ret    
80106dd6:	8d 76 00             	lea    0x0(%esi),%esi
80106dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106de0 <setupkvm>:
{
80106de0:	55                   	push   %ebp
80106de1:	89 e5                	mov    %esp,%ebp
80106de3:	56                   	push   %esi
80106de4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106de5:	e8 96 b6 ff ff       	call   80102480 <kalloc>
80106dea:	85 c0                	test   %eax,%eax
80106dec:	74 52                	je     80106e40 <setupkvm+0x60>
  memset(pgdir, 0, PGSIZE);
80106dee:	83 ec 04             	sub    $0x4,%esp
80106df1:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106df3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106df8:	68 00 10 00 00       	push   $0x1000
80106dfd:	6a 00                	push   $0x0
80106dff:	50                   	push   %eax
80106e00:	e8 5b d8 ff ff       	call   80104660 <memset>
80106e05:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0)
80106e08:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106e0b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106e0e:	83 ec 08             	sub    $0x8,%esp
80106e11:	8b 13                	mov    (%ebx),%edx
80106e13:	ff 73 0c             	pushl  0xc(%ebx)
80106e16:	50                   	push   %eax
80106e17:	29 c1                	sub    %eax,%ecx
80106e19:	89 f0                	mov    %esi,%eax
80106e1b:	e8 40 fd ff ff       	call   80106b60 <mappages>
80106e20:	83 c4 10             	add    $0x10,%esp
80106e23:	85 c0                	test   %eax,%eax
80106e25:	78 19                	js     80106e40 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106e27:	83 c3 10             	add    $0x10,%ebx
80106e2a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106e30:	72 d6                	jb     80106e08 <setupkvm+0x28>
}
80106e32:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106e35:	89 f0                	mov    %esi,%eax
80106e37:	5b                   	pop    %ebx
80106e38:	5e                   	pop    %esi
80106e39:	5d                   	pop    %ebp
80106e3a:	c3                   	ret    
80106e3b:	90                   	nop
80106e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106e40:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
80106e43:	31 f6                	xor    %esi,%esi
}
80106e45:	89 f0                	mov    %esi,%eax
80106e47:	5b                   	pop    %ebx
80106e48:	5e                   	pop    %esi
80106e49:	5d                   	pop    %ebp
80106e4a:	c3                   	ret    
80106e4b:	90                   	nop
80106e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106e50 <kvmalloc>:
{
80106e50:	55                   	push   %ebp
80106e51:	89 e5                	mov    %esp,%ebp
80106e53:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106e56:	e8 85 ff ff ff       	call   80106de0 <setupkvm>
80106e5b:	a3 24 57 11 80       	mov    %eax,0x80115724
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106e60:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106e65:	0f 22 d8             	mov    %eax,%cr3
}
80106e68:	c9                   	leave  
80106e69:	c3                   	ret    
80106e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106e70 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106e70:	a1 24 57 11 80       	mov    0x80115724,%eax
{
80106e75:	55                   	push   %ebp
80106e76:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106e78:	05 00 00 00 80       	add    $0x80000000,%eax
80106e7d:	0f 22 d8             	mov    %eax,%cr3
}
80106e80:	5d                   	pop    %ebp
80106e81:	c3                   	ret    
80106e82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e90 <switchuvm>:
{
80106e90:	55                   	push   %ebp
80106e91:	89 e5                	mov    %esp,%ebp
80106e93:	53                   	push   %ebx
80106e94:	83 ec 04             	sub    $0x4,%esp
80106e97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80106e9a:	e8 f1 d6 ff ff       	call   80104590 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106e9f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106ea5:	b9 67 00 00 00       	mov    $0x67,%ecx
80106eaa:	8d 50 08             	lea    0x8(%eax),%edx
80106ead:	66 89 88 a0 00 00 00 	mov    %cx,0xa0(%eax)
80106eb4:	c6 80 a6 00 00 00 40 	movb   $0x40,0xa6(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80106ebb:	c6 80 a5 00 00 00 89 	movb   $0x89,0xa5(%eax)
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106ec2:	66 89 90 a2 00 00 00 	mov    %dx,0xa2(%eax)
80106ec9:	89 d1                	mov    %edx,%ecx
80106ecb:	c1 ea 18             	shr    $0x18,%edx
80106ece:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80106ed4:	ba 10 00 00 00       	mov    $0x10,%edx
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106ed9:	c1 e9 10             	shr    $0x10,%ecx
  cpu->ts.ss0 = SEG_KDATA << 3;
80106edc:	66 89 50 10          	mov    %dx,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80106ee0:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106ee7:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
  cpu->ts.iomb = (ushort) 0xFFFF;
80106eed:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80106ef2:	8b 52 08             	mov    0x8(%edx),%edx
  cpu->ts.iomb = (ushort) 0xFFFF;
80106ef5:	66 89 48 6e          	mov    %cx,0x6e(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80106ef9:	81 c2 00 10 00 00    	add    $0x1000,%edx
80106eff:	89 50 0c             	mov    %edx,0xc(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106f02:	b8 30 00 00 00       	mov    $0x30,%eax
80106f07:	0f 00 d8             	ltr    %ax
  if(p->pgdir == 0)
80106f0a:	8b 43 04             	mov    0x4(%ebx),%eax
80106f0d:	85 c0                	test   %eax,%eax
80106f0f:	74 11                	je     80106f22 <switchuvm+0x92>
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106f11:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106f16:	0f 22 d8             	mov    %eax,%cr3
}
80106f19:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106f1c:	c9                   	leave  
  popcli();
80106f1d:	e9 9e d6 ff ff       	jmp    801045c0 <popcli>
    panic("switchuvm: no pgdir");
80106f22:	83 ec 0c             	sub    $0xc,%esp
80106f25:	68 22 7d 10 80       	push   $0x80107d22
80106f2a:	e8 41 94 ff ff       	call   80100370 <panic>
80106f2f:	90                   	nop

80106f30 <inituvm>:
{
80106f30:	55                   	push   %ebp
80106f31:	89 e5                	mov    %esp,%ebp
80106f33:	57                   	push   %edi
80106f34:	56                   	push   %esi
80106f35:	53                   	push   %ebx
80106f36:	83 ec 1c             	sub    $0x1c,%esp
80106f39:	8b 75 10             	mov    0x10(%ebp),%esi
80106f3c:	8b 45 08             	mov    0x8(%ebp),%eax
80106f3f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106f42:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106f48:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106f4b:	77 49                	ja     80106f96 <inituvm+0x66>
  mem = kalloc();
80106f4d:	e8 2e b5 ff ff       	call   80102480 <kalloc>
  memset(mem, 0, PGSIZE);
80106f52:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80106f55:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106f57:	68 00 10 00 00       	push   $0x1000
80106f5c:	6a 00                	push   $0x0
80106f5e:	50                   	push   %eax
80106f5f:	e8 fc d6 ff ff       	call   80104660 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106f64:	58                   	pop    %eax
80106f65:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106f6b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106f70:	5a                   	pop    %edx
80106f71:	6a 06                	push   $0x6
80106f73:	50                   	push   %eax
80106f74:	31 d2                	xor    %edx,%edx
80106f76:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106f79:	e8 e2 fb ff ff       	call   80106b60 <mappages>
  memmove(mem, init, sz);
80106f7e:	89 75 10             	mov    %esi,0x10(%ebp)
80106f81:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106f84:	83 c4 10             	add    $0x10,%esp
80106f87:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106f8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f8d:	5b                   	pop    %ebx
80106f8e:	5e                   	pop    %esi
80106f8f:	5f                   	pop    %edi
80106f90:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106f91:	e9 7a d7 ff ff       	jmp    80104710 <memmove>
    panic("inituvm: more than a page");
80106f96:	83 ec 0c             	sub    $0xc,%esp
80106f99:	68 36 7d 10 80       	push   $0x80107d36
80106f9e:	e8 cd 93 ff ff       	call   80100370 <panic>
80106fa3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106fb0 <loaduvm>:
{
80106fb0:	55                   	push   %ebp
80106fb1:	89 e5                	mov    %esp,%ebp
80106fb3:	57                   	push   %edi
80106fb4:	56                   	push   %esi
80106fb5:	53                   	push   %ebx
80106fb6:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106fb9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106fc0:	0f 85 91 00 00 00    	jne    80107057 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80106fc6:	8b 75 18             	mov    0x18(%ebp),%esi
80106fc9:	31 db                	xor    %ebx,%ebx
80106fcb:	85 f6                	test   %esi,%esi
80106fcd:	75 1a                	jne    80106fe9 <loaduvm+0x39>
80106fcf:	eb 6f                	jmp    80107040 <loaduvm+0x90>
80106fd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fd8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106fde:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106fe4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106fe7:	76 57                	jbe    80107040 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106fe9:	8b 55 0c             	mov    0xc(%ebp),%edx
80106fec:	8b 45 08             	mov    0x8(%ebp),%eax
80106fef:	31 c9                	xor    %ecx,%ecx
80106ff1:	01 da                	add    %ebx,%edx
80106ff3:	e8 e8 fa ff ff       	call   80106ae0 <walkpgdir>
80106ff8:	85 c0                	test   %eax,%eax
80106ffa:	74 4e                	je     8010704a <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106ffc:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106ffe:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80107001:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107006:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
8010700b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107011:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107014:	01 d9                	add    %ebx,%ecx
80107016:	05 00 00 00 80       	add    $0x80000000,%eax
8010701b:	57                   	push   %edi
8010701c:	51                   	push   %ecx
8010701d:	50                   	push   %eax
8010701e:	ff 75 10             	pushl  0x10(%ebp)
80107021:	e8 fa a8 ff ff       	call   80101920 <readi>
80107026:	83 c4 10             	add    $0x10,%esp
80107029:	39 c7                	cmp    %eax,%edi
8010702b:	74 ab                	je     80106fd8 <loaduvm+0x28>
}
8010702d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107030:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107035:	5b                   	pop    %ebx
80107036:	5e                   	pop    %esi
80107037:	5f                   	pop    %edi
80107038:	5d                   	pop    %ebp
80107039:	c3                   	ret    
8010703a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107040:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107043:	31 c0                	xor    %eax,%eax
}
80107045:	5b                   	pop    %ebx
80107046:	5e                   	pop    %esi
80107047:	5f                   	pop    %edi
80107048:	5d                   	pop    %ebp
80107049:	c3                   	ret    
      panic("loaduvm: address should exist");
8010704a:	83 ec 0c             	sub    $0xc,%esp
8010704d:	68 50 7d 10 80       	push   $0x80107d50
80107052:	e8 19 93 ff ff       	call   80100370 <panic>
    panic("loaduvm: addr must be page aligned");
80107057:	83 ec 0c             	sub    $0xc,%esp
8010705a:	68 f4 7d 10 80       	push   $0x80107df4
8010705f:	e8 0c 93 ff ff       	call   80100370 <panic>
80107064:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010706a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107070 <allocuvm>:
{
80107070:	55                   	push   %ebp
80107071:	89 e5                	mov    %esp,%ebp
80107073:	57                   	push   %edi
80107074:	56                   	push   %esi
80107075:	53                   	push   %ebx
80107076:	83 ec 0c             	sub    $0xc,%esp
80107079:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(newsz >= KERNBASE)
8010707c:	85 ff                	test   %edi,%edi
8010707e:	78 7b                	js     801070fb <allocuvm+0x8b>
  if(newsz < oldsz)
80107080:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80107083:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80107086:	72 75                	jb     801070fd <allocuvm+0x8d>
  a = PGROUNDUP(oldsz);
80107088:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
8010708e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80107094:	39 df                	cmp    %ebx,%edi
80107096:	77 43                	ja     801070db <allocuvm+0x6b>
80107098:	eb 6e                	jmp    80107108 <allocuvm+0x98>
8010709a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
801070a0:	83 ec 04             	sub    $0x4,%esp
801070a3:	68 00 10 00 00       	push   $0x1000
801070a8:	6a 00                	push   $0x0
801070aa:	50                   	push   %eax
801070ab:	e8 b0 d5 ff ff       	call   80104660 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801070b0:	58                   	pop    %eax
801070b1:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801070b7:	b9 00 10 00 00       	mov    $0x1000,%ecx
801070bc:	5a                   	pop    %edx
801070bd:	6a 06                	push   $0x6
801070bf:	50                   	push   %eax
801070c0:	89 da                	mov    %ebx,%edx
801070c2:	8b 45 08             	mov    0x8(%ebp),%eax
801070c5:	e8 96 fa ff ff       	call   80106b60 <mappages>
801070ca:	83 c4 10             	add    $0x10,%esp
801070cd:	85 c0                	test   %eax,%eax
801070cf:	78 47                	js     80107118 <allocuvm+0xa8>
  for(; a < newsz; a += PGSIZE){
801070d1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801070d7:	39 df                	cmp    %ebx,%edi
801070d9:	76 2d                	jbe    80107108 <allocuvm+0x98>
    mem = kalloc();
801070db:	e8 a0 b3 ff ff       	call   80102480 <kalloc>
    if(mem == 0){
801070e0:	85 c0                	test   %eax,%eax
    mem = kalloc();
801070e2:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801070e4:	75 ba                	jne    801070a0 <allocuvm+0x30>
      cprintf("allocuvm out of memory\n");
801070e6:	83 ec 0c             	sub    $0xc,%esp
801070e9:	68 6e 7d 10 80       	push   $0x80107d6e
801070ee:	e8 6d 95 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
801070f3:	83 c4 10             	add    $0x10,%esp
801070f6:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801070f9:	77 4f                	ja     8010714a <allocuvm+0xda>
      return 0;
801070fb:	31 c0                	xor    %eax,%eax
}
801070fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107100:	5b                   	pop    %ebx
80107101:	5e                   	pop    %esi
80107102:	5f                   	pop    %edi
80107103:	5d                   	pop    %ebp
80107104:	c3                   	ret    
80107105:	8d 76 00             	lea    0x0(%esi),%esi
80107108:	8d 65 f4             	lea    -0xc(%ebp),%esp
  for(; a < newsz; a += PGSIZE){
8010710b:	89 f8                	mov    %edi,%eax
}
8010710d:	5b                   	pop    %ebx
8010710e:	5e                   	pop    %esi
8010710f:	5f                   	pop    %edi
80107110:	5d                   	pop    %ebp
80107111:	c3                   	ret    
80107112:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107118:	83 ec 0c             	sub    $0xc,%esp
8010711b:	68 86 7d 10 80       	push   $0x80107d86
80107120:	e8 3b 95 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80107125:	83 c4 10             	add    $0x10,%esp
80107128:	3b 7d 0c             	cmp    0xc(%ebp),%edi
8010712b:	76 0d                	jbe    8010713a <allocuvm+0xca>
8010712d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107130:	8b 45 08             	mov    0x8(%ebp),%eax
80107133:	89 fa                	mov    %edi,%edx
80107135:	e8 b6 fa ff ff       	call   80106bf0 <deallocuvm.part.0>
      kfree(mem);
8010713a:	83 ec 0c             	sub    $0xc,%esp
8010713d:	56                   	push   %esi
8010713e:	e8 8d b1 ff ff       	call   801022d0 <kfree>
      return 0;
80107143:	83 c4 10             	add    $0x10,%esp
80107146:	31 c0                	xor    %eax,%eax
80107148:	eb b3                	jmp    801070fd <allocuvm+0x8d>
8010714a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010714d:	8b 45 08             	mov    0x8(%ebp),%eax
80107150:	89 fa                	mov    %edi,%edx
80107152:	e8 99 fa ff ff       	call   80106bf0 <deallocuvm.part.0>
      return 0;
80107157:	31 c0                	xor    %eax,%eax
80107159:	eb a2                	jmp    801070fd <allocuvm+0x8d>
8010715b:	90                   	nop
8010715c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107160 <deallocuvm>:
{
80107160:	55                   	push   %ebp
80107161:	89 e5                	mov    %esp,%ebp
80107163:	8b 55 0c             	mov    0xc(%ebp),%edx
80107166:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107169:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010716c:	39 d1                	cmp    %edx,%ecx
8010716e:	73 10                	jae    80107180 <deallocuvm+0x20>
}
80107170:	5d                   	pop    %ebp
80107171:	e9 7a fa ff ff       	jmp    80106bf0 <deallocuvm.part.0>
80107176:	8d 76 00             	lea    0x0(%esi),%esi
80107179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107180:	89 d0                	mov    %edx,%eax
80107182:	5d                   	pop    %ebp
80107183:	c3                   	ret    
80107184:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010718a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107190 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107190:	55                   	push   %ebp
80107191:	89 e5                	mov    %esp,%ebp
80107193:	57                   	push   %edi
80107194:	56                   	push   %esi
80107195:	53                   	push   %ebx
80107196:	83 ec 0c             	sub    $0xc,%esp
80107199:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010719c:	85 f6                	test   %esi,%esi
8010719e:	74 59                	je     801071f9 <freevm+0x69>
801071a0:	31 c9                	xor    %ecx,%ecx
801071a2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801071a7:	89 f0                	mov    %esi,%eax
801071a9:	e8 42 fa ff ff       	call   80106bf0 <deallocuvm.part.0>
801071ae:	89 f3                	mov    %esi,%ebx
801071b0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801071b6:	eb 0f                	jmp    801071c7 <freevm+0x37>
801071b8:	90                   	nop
801071b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071c0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801071c3:	39 fb                	cmp    %edi,%ebx
801071c5:	74 23                	je     801071ea <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801071c7:	8b 03                	mov    (%ebx),%eax
801071c9:	a8 01                	test   $0x1,%al
801071cb:	74 f3                	je     801071c0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801071cd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
801071d2:	83 ec 0c             	sub    $0xc,%esp
801071d5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801071d8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801071dd:	50                   	push   %eax
801071de:	e8 ed b0 ff ff       	call   801022d0 <kfree>
801071e3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801071e6:	39 fb                	cmp    %edi,%ebx
801071e8:	75 dd                	jne    801071c7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801071ea:	89 75 08             	mov    %esi,0x8(%ebp)
}
801071ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801071f0:	5b                   	pop    %ebx
801071f1:	5e                   	pop    %esi
801071f2:	5f                   	pop    %edi
801071f3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801071f4:	e9 d7 b0 ff ff       	jmp    801022d0 <kfree>
    panic("freevm: no pgdir");
801071f9:	83 ec 0c             	sub    $0xc,%esp
801071fc:	68 a2 7d 10 80       	push   $0x80107da2
80107201:	e8 6a 91 ff ff       	call   80100370 <panic>
80107206:	8d 76 00             	lea    0x0(%esi),%esi
80107209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107210 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107210:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107211:	31 c9                	xor    %ecx,%ecx
{
80107213:	89 e5                	mov    %esp,%ebp
80107215:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107218:	8b 55 0c             	mov    0xc(%ebp),%edx
8010721b:	8b 45 08             	mov    0x8(%ebp),%eax
8010721e:	e8 bd f8 ff ff       	call   80106ae0 <walkpgdir>
  if(pte == 0)
80107223:	85 c0                	test   %eax,%eax
80107225:	74 05                	je     8010722c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107227:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010722a:	c9                   	leave  
8010722b:	c3                   	ret    
    panic("clearpteu");
8010722c:	83 ec 0c             	sub    $0xc,%esp
8010722f:	68 b3 7d 10 80       	push   $0x80107db3
80107234:	e8 37 91 ff ff       	call   80100370 <panic>
80107239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107240 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107240:	55                   	push   %ebp
80107241:	89 e5                	mov    %esp,%ebp
80107243:	57                   	push   %edi
80107244:	56                   	push   %esi
80107245:	53                   	push   %ebx
80107246:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107249:	e8 92 fb ff ff       	call   80106de0 <setupkvm>
8010724e:	85 c0                	test   %eax,%eax
80107250:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107253:	0f 84 a0 00 00 00    	je     801072f9 <copyuvm+0xb9>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107259:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010725c:	85 c9                	test   %ecx,%ecx
8010725e:	0f 84 95 00 00 00    	je     801072f9 <copyuvm+0xb9>
80107264:	31 f6                	xor    %esi,%esi
80107266:	eb 4e                	jmp    801072b6 <copyuvm+0x76>
80107268:	90                   	nop
80107269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107270:	83 ec 04             	sub    $0x4,%esp
80107273:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107279:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010727c:	68 00 10 00 00       	push   $0x1000
80107281:	57                   	push   %edi
80107282:	50                   	push   %eax
80107283:	e8 88 d4 ff ff       	call   80104710 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80107288:	58                   	pop    %eax
80107289:	5a                   	pop    %edx
8010728a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010728d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107290:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107295:	53                   	push   %ebx
80107296:	81 c2 00 00 00 80    	add    $0x80000000,%edx
8010729c:	52                   	push   %edx
8010729d:	89 f2                	mov    %esi,%edx
8010729f:	e8 bc f8 ff ff       	call   80106b60 <mappages>
801072a4:	83 c4 10             	add    $0x10,%esp
801072a7:	85 c0                	test   %eax,%eax
801072a9:	78 39                	js     801072e4 <copyuvm+0xa4>
  for(i = 0; i < sz; i += PGSIZE){
801072ab:	81 c6 00 10 00 00    	add    $0x1000,%esi
801072b1:	39 75 0c             	cmp    %esi,0xc(%ebp)
801072b4:	76 43                	jbe    801072f9 <copyuvm+0xb9>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801072b6:	8b 45 08             	mov    0x8(%ebp),%eax
801072b9:	31 c9                	xor    %ecx,%ecx
801072bb:	89 f2                	mov    %esi,%edx
801072bd:	e8 1e f8 ff ff       	call   80106ae0 <walkpgdir>
801072c2:	85 c0                	test   %eax,%eax
801072c4:	74 3e                	je     80107304 <copyuvm+0xc4>
    if(!(*pte & PTE_P))
801072c6:	8b 18                	mov    (%eax),%ebx
801072c8:	f6 c3 01             	test   $0x1,%bl
801072cb:	74 44                	je     80107311 <copyuvm+0xd1>
    pa = PTE_ADDR(*pte);
801072cd:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
801072cf:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
801072d5:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
801072db:	e8 a0 b1 ff ff       	call   80102480 <kalloc>
801072e0:	85 c0                	test   %eax,%eax
801072e2:	75 8c                	jne    80107270 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
801072e4:	83 ec 0c             	sub    $0xc,%esp
801072e7:	ff 75 e0             	pushl  -0x20(%ebp)
801072ea:	e8 a1 fe ff ff       	call   80107190 <freevm>
  return 0;
801072ef:	83 c4 10             	add    $0x10,%esp
801072f2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
801072f9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801072fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072ff:	5b                   	pop    %ebx
80107300:	5e                   	pop    %esi
80107301:	5f                   	pop    %edi
80107302:	5d                   	pop    %ebp
80107303:	c3                   	ret    
      panic("copyuvm: pte should exist");
80107304:	83 ec 0c             	sub    $0xc,%esp
80107307:	68 bd 7d 10 80       	push   $0x80107dbd
8010730c:	e8 5f 90 ff ff       	call   80100370 <panic>
      panic("copyuvm: page not present");
80107311:	83 ec 0c             	sub    $0xc,%esp
80107314:	68 d7 7d 10 80       	push   $0x80107dd7
80107319:	e8 52 90 ff ff       	call   80100370 <panic>
8010731e:	66 90                	xchg   %ax,%ax

80107320 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107320:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107321:	31 c9                	xor    %ecx,%ecx
{
80107323:	89 e5                	mov    %esp,%ebp
80107325:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107328:	8b 55 0c             	mov    0xc(%ebp),%edx
8010732b:	8b 45 08             	mov    0x8(%ebp),%eax
8010732e:	e8 ad f7 ff ff       	call   80106ae0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107333:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107335:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107336:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107338:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
8010733d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107340:	05 00 00 00 80       	add    $0x80000000,%eax
80107345:	83 fa 05             	cmp    $0x5,%edx
80107348:	ba 00 00 00 00       	mov    $0x0,%edx
8010734d:	0f 45 c2             	cmovne %edx,%eax
}
80107350:	c3                   	ret    
80107351:	eb 0d                	jmp    80107360 <copyout>
80107353:	90                   	nop
80107354:	90                   	nop
80107355:	90                   	nop
80107356:	90                   	nop
80107357:	90                   	nop
80107358:	90                   	nop
80107359:	90                   	nop
8010735a:	90                   	nop
8010735b:	90                   	nop
8010735c:	90                   	nop
8010735d:	90                   	nop
8010735e:	90                   	nop
8010735f:	90                   	nop

80107360 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107360:	55                   	push   %ebp
80107361:	89 e5                	mov    %esp,%ebp
80107363:	57                   	push   %edi
80107364:	56                   	push   %esi
80107365:	53                   	push   %ebx
80107366:	83 ec 1c             	sub    $0x1c,%esp
80107369:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010736c:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
8010736f:	8b 7d 10             	mov    0x10(%ebp),%edi
80107372:	85 db                	test   %ebx,%ebx
80107374:	75 40                	jne    801073b6 <copyout+0x56>
80107376:	eb 70                	jmp    801073e8 <copyout+0x88>
80107378:	90                   	nop
80107379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107380:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107383:	89 f1                	mov    %esi,%ecx
80107385:	29 d1                	sub    %edx,%ecx
80107387:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010738d:	39 d9                	cmp    %ebx,%ecx
8010738f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107392:	29 f2                	sub    %esi,%edx
80107394:	83 ec 04             	sub    $0x4,%esp
80107397:	01 d0                	add    %edx,%eax
80107399:	51                   	push   %ecx
8010739a:	57                   	push   %edi
8010739b:	50                   	push   %eax
8010739c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010739f:	e8 6c d3 ff ff       	call   80104710 <memmove>
    len -= n;
    buf += n;
801073a4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
801073a7:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
801073aa:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
801073b0:	01 cf                	add    %ecx,%edi
  while(len > 0){
801073b2:	29 cb                	sub    %ecx,%ebx
801073b4:	74 32                	je     801073e8 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
801073b6:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801073b8:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
801073bb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801073be:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801073c4:	56                   	push   %esi
801073c5:	ff 75 08             	pushl  0x8(%ebp)
801073c8:	e8 53 ff ff ff       	call   80107320 <uva2ka>
    if(pa0 == 0)
801073cd:	83 c4 10             	add    $0x10,%esp
801073d0:	85 c0                	test   %eax,%eax
801073d2:	75 ac                	jne    80107380 <copyout+0x20>
  }
  return 0;
}
801073d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801073d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801073dc:	5b                   	pop    %ebx
801073dd:	5e                   	pop    %esi
801073de:	5f                   	pop    %edi
801073df:	5d                   	pop    %ebp
801073e0:	c3                   	ret    
801073e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801073eb:	31 c0                	xor    %eax,%eax
}
801073ed:	5b                   	pop    %ebx
801073ee:	5e                   	pop    %esi
801073ef:	5f                   	pop    %edi
801073f0:	5d                   	pop    %ebp
801073f1:	c3                   	ret    
