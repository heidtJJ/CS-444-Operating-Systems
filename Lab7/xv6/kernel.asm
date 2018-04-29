
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
8010004c:	68 40 75 10 80       	push   $0x80107540
80100051:	68 e0 b5 10 80       	push   $0x8010b5e0
80100056:	e8 95 42 00 00       	call   801042f0 <initlock>
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
80100092:	68 47 75 10 80       	push   $0x80107547
80100097:	50                   	push   %eax
80100098:	e8 43 41 00 00       	call   801041e0 <initsleeplock>
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
801000e4:	e8 27 42 00 00       	call   80104310 <acquire>
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
80100162:	e8 89 43 00 00       	call   801044f0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ae 40 00 00       	call   80104220 <acquiresleep>
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
80100193:	68 4e 75 10 80       	push   $0x8010754e
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
801001ae:	e8 0d 41 00 00       	call   801042c0 <holdingsleep>
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
801001cc:	68 5f 75 10 80       	push   $0x8010755f
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
801001ef:	e8 cc 40 00 00       	call   801042c0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 7c 40 00 00       	call   80104280 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
8010020b:	e8 00 41 00 00       	call   80104310 <acquire>
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
8010025c:	e9 8f 42 00 00       	jmp    801044f0 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 66 75 10 80       	push   $0x80107566
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
8010028c:	e8 7f 40 00 00       	call   80104310 <acquire>
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
801002bd:	e8 ae 3b 00 00       	call   80103e70 <sleep>
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
801002e7:	e8 04 42 00 00       	call   801044f0 <release>
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
80100346:	e8 a5 41 00 00       	call   801044f0 <release>
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
80100393:	68 6d 75 10 80       	push   $0x8010756d
80100398:	e8 c3 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
8010039d:	58                   	pop    %eax
8010039e:	ff 75 08             	pushl  0x8(%ebp)
801003a1:	e8 ba 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003a6:	c7 04 24 66 7a 10 80 	movl   $0x80107a66,(%esp)
801003ad:	e8 ae 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003b2:	5a                   	pop    %edx
801003b3:	8d 45 08             	lea    0x8(%ebp),%eax
801003b6:	59                   	pop    %ecx
801003b7:	53                   	push   %ebx
801003b8:	50                   	push   %eax
801003b9:	e8 22 40 00 00       	call   801043e0 <getcallerpcs>
801003be:	83 c4 10             	add    $0x10,%esp
801003c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cprintf(" %p", pcs[i]);
801003c8:	83 ec 08             	sub    $0x8,%esp
801003cb:	ff 33                	pushl  (%ebx)
801003cd:	83 c3 04             	add    $0x4,%ebx
801003d0:	68 89 75 10 80       	push   $0x80107589
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
8010041a:	e8 c1 5a 00 00       	call   80105ee0 <uartputc>
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
801004d3:	e8 08 5a 00 00       	call   80105ee0 <uartputc>
801004d8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004df:	e8 fc 59 00 00       	call   80105ee0 <uartputc>
801004e4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004eb:	e8 f0 59 00 00       	call   80105ee0 <uartputc>
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
80100519:	e8 d2 40 00 00       	call   801045f0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010051e:	b8 80 07 00 00       	mov    $0x780,%eax
80100523:	83 c4 0c             	add    $0xc,%esp
80100526:	29 f8                	sub    %edi,%eax
80100528:	01 c0                	add    %eax,%eax
8010052a:	50                   	push   %eax
8010052b:	6a 00                	push   $0x0
8010052d:	53                   	push   %ebx
8010052e:	e8 0d 40 00 00       	call   80104540 <memset>
80100533:	89 f9                	mov    %edi,%ecx
80100535:	83 c4 10             	add    $0x10,%esp
80100538:	e9 5c ff ff ff       	jmp    80100499 <consputc+0xa9>
    panic("pos under/overflow");
8010053d:	83 ec 0c             	sub    $0xc,%esp
80100540:	68 8d 75 10 80       	push   $0x8010758d
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
801005a9:	0f b6 92 b8 75 10 80 	movzbl -0x7fef8a48(%edx),%edx
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
8010061b:	e8 f0 3c 00 00       	call   80104310 <acquire>
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
80100647:	e8 a4 3e 00 00       	call   801044f0 <release>
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
80100705:	e8 e6 3d 00 00       	call   801044f0 <release>
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
801007a8:	e8 63 3b 00 00       	call   80104310 <acquire>
801007ad:	83 c4 10             	add    $0x10,%esp
801007b0:	e9 c4 fe ff ff       	jmp    80100679 <cprintf+0x19>
801007b5:	8d 76 00             	lea    0x0(%esi),%esi
      for(; *s; s++)
801007b8:	b8 28 00 00 00       	mov    $0x28,%eax
        s = "(null)";
801007bd:	bf a0 75 10 80       	mov    $0x801075a0,%edi
801007c2:	eb bc                	jmp    80100780 <cprintf+0x120>
    panic("null fmt");
801007c4:	83 ec 0c             	sub    $0xc,%esp
801007c7:	68 a7 75 10 80       	push   $0x801075a7
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
801007f3:	e8 18 3b 00 00       	call   80104310 <acquire>
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
80100858:	e8 93 3c 00 00       	call   801044f0 <release>
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
801008e6:	e8 35 37 00 00       	call   80104020 <wakeup>
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
80100967:	e9 a4 37 00 00       	jmp    80104110 <procdump>
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
80100996:	68 b0 75 10 80       	push   $0x801075b0
8010099b:	68 20 a5 10 80       	push   $0x8010a520
801009a0:	e8 4b 39 00 00       	call   801042f0 <initlock>

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
80100a5c:	e8 4f 64 00 00       	call   80106eb0 <setupkvm>
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
80100aec:	e8 4f 66 00 00       	call   80107140 <allocuvm>
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
80100b22:	e8 59 65 00 00       	call   80107080 <loaduvm>
80100b27:	83 c4 20             	add    $0x20,%esp
80100b2a:	85 c0                	test   %eax,%eax
80100b2c:	0f 89 5e ff ff ff    	jns    80100a90 <exec+0xb0>
80100b32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    freevm(pgdir);
80100b38:	83 ec 0c             	sub    $0xc,%esp
80100b3b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b41:	e8 1a 67 00 00       	call   80107260 <freevm>
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
80100b81:	e8 ba 65 00 00       	call   80107140 <allocuvm>
80100b86:	83 c4 10             	add    $0x10,%esp
80100b89:	85 c0                	test   %eax,%eax
80100b8b:	89 c6                	mov    %eax,%esi
80100b8d:	75 2a                	jne    80100bb9 <exec+0x1d9>
    freevm(pgdir);
80100b8f:	83 ec 0c             	sub    $0xc,%esp
80100b92:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b98:	e8 c3 66 00 00       	call   80107260 <freevm>
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
80100bcd:	e8 0e 67 00 00       	call   801072e0 <clearpteu>
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
80100c01:	e8 5a 3b 00 00       	call   80104760 <strlen>
80100c06:	f7 d0                	not    %eax
80100c08:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c0a:	58                   	pop    %eax
80100c0b:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c0e:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c11:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c14:	e8 47 3b 00 00       	call   80104760 <strlen>
80100c19:	83 c0 01             	add    $0x1,%eax
80100c1c:	50                   	push   %eax
80100c1d:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c20:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c23:	53                   	push   %ebx
80100c24:	56                   	push   %esi
80100c25:	e8 66 68 00 00       	call   80107490 <copyout>
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
80100c8f:	e8 fc 67 00 00       	call   80107490 <copyout>
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
80100cd5:	e8 46 3a 00 00       	call   80104720 <safestrcpy>
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
80100d09:	e8 52 62 00 00       	call   80106f60 <switchuvm>
  freevm(oldpgdir);
80100d0e:	89 3c 24             	mov    %edi,(%esp)
80100d11:	e8 4a 65 00 00       	call   80107260 <freevm>
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
80100d36:	68 c9 75 10 80       	push   $0x801075c9
80100d3b:	68 e0 ff 10 80       	push   $0x8010ffe0
80100d40:	e8 ab 35 00 00       	call   801042f0 <initlock>
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
80100d61:	e8 aa 35 00 00       	call   80104310 <acquire>
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
80100d91:	e8 5a 37 00 00       	call   801044f0 <release>
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
80100daa:	e8 41 37 00 00       	call   801044f0 <release>
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
80100dcf:	e8 3c 35 00 00       	call   80104310 <acquire>
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
80100dec:	e8 ff 36 00 00       	call   801044f0 <release>
  return f;
}
80100df1:	89 d8                	mov    %ebx,%eax
80100df3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100df6:	c9                   	leave  
80100df7:	c3                   	ret    
    panic("filedup");
80100df8:	83 ec 0c             	sub    $0xc,%esp
80100dfb:	68 d0 75 10 80       	push   $0x801075d0
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
80100e21:	e8 ea 34 00 00       	call   80104310 <acquire>
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
80100e4c:	e9 9f 36 00 00       	jmp    801044f0 <release>
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
80100e78:	e8 73 36 00 00       	call   801044f0 <release>
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
80100ed2:	68 d8 75 10 80       	push   $0x801075d8
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
80100fb2:	68 e2 75 10 80       	push   $0x801075e2
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
801010d0:	68 eb 75 10 80       	push   $0x801075eb
801010d5:	e8 96 f2 ff ff       	call   80100370 <panic>
  panic("filewrite");
801010da:	83 ec 0c             	sub    $0xc,%esp
801010dd:	68 f1 75 10 80       	push   $0x801075f1
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
80101194:	68 fb 75 10 80       	push   $0x801075fb
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
801011d5:	e8 66 33 00 00       	call   80104540 <memset>
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
8010121a:	e8 f1 30 00 00       	call   80104310 <acquire>
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
80101262:	e8 89 32 00 00       	call   801044f0 <release>
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
801012af:	e8 3c 32 00 00       	call   801044f0 <release>
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
801012c4:	68 11 76 10 80       	push   $0x80107611
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
80101395:	68 21 76 10 80       	push   $0x80107621
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
801013c1:	e8 2a 32 00 00       	call   801045f0 <memmove>
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
80101454:	68 34 76 10 80       	push   $0x80107634
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
8010146c:	68 47 76 10 80       	push   $0x80107647
80101471:	68 00 0a 11 80       	push   $0x80110a00
80101476:	e8 75 2e 00 00       	call   801042f0 <initlock>
8010147b:	83 c4 10             	add    $0x10,%esp
8010147e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101480:	83 ec 08             	sub    $0x8,%esp
80101483:	68 4e 76 10 80       	push   $0x8010764e
80101488:	53                   	push   %ebx
80101489:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010148f:	e8 4c 2d 00 00       	call   801041e0 <initsleeplock>
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
801014d9:	68 a4 76 10 80       	push   $0x801076a4
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
8010156e:	e8 cd 2f 00 00       	call   80104540 <memset>
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
801015a3:	68 54 76 10 80       	push   $0x80107654
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
80101611:	e8 da 2f 00 00       	call   801045f0 <memmove>
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
8010163f:	e8 cc 2c 00 00       	call   80104310 <acquire>
  ip->ref++;
80101644:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101648:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010164f:	e8 9c 2e 00 00       	call   801044f0 <release>
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
80101682:	e8 99 2b 00 00       	call   80104220 <acquiresleep>
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
801016f8:	e8 f3 2e 00 00       	call   801045f0 <memmove>
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
8010171a:	68 6c 76 10 80       	push   $0x8010766c
8010171f:	e8 4c ec ff ff       	call   80100370 <panic>
    panic("ilock");
80101724:	83 ec 0c             	sub    $0xc,%esp
80101727:	68 66 76 10 80       	push   $0x80107666
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
80101753:	e8 68 2b 00 00       	call   801042c0 <holdingsleep>
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
8010176f:	e9 0c 2b 00 00       	jmp    80104280 <releasesleep>
    panic("iunlock");
80101774:	83 ec 0c             	sub    $0xc,%esp
80101777:	68 7b 76 10 80       	push   $0x8010767b
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
801017a1:	e8 6a 2b 00 00       	call   80104310 <acquire>
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
801017c5:	e9 26 2d 00 00       	jmp    801044f0 <release>
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
801017ee:	e8 fd 2c 00 00       	call   801044f0 <release>
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
8010184f:	e8 bc 2a 00 00       	call   80104310 <acquire>
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
801019c7:	e8 24 2c 00 00       	call   801045f0 <memmove>
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
80101ac3:	e8 28 2b 00 00       	call   801045f0 <memmove>
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
80101b5e:	e8 fd 2a 00 00       	call   80104660 <strncmp>
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
80101bc5:	e8 96 2a 00 00       	call   80104660 <strncmp>
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
80101bfd:	68 95 76 10 80       	push   $0x80107695
80101c02:	e8 69 e7 ff ff       	call   80100370 <panic>
    panic("dirlookup not DIR");
80101c07:	83 ec 0c             	sub    $0xc,%esp
80101c0a:	68 83 76 10 80       	push   $0x80107683
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
80101c4a:	e8 c1 26 00 00       	call   80104310 <acquire>
  ip->ref++;
80101c4f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101c53:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101c5a:	e8 91 28 00 00       	call   801044f0 <release>
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
80101cb5:	e8 36 29 00 00       	call   801045f0 <memmove>
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
80101d44:	e8 a7 28 00 00       	call   801045f0 <memmove>
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
80101e2d:	e8 8e 28 00 00       	call   801046c0 <strncpy>
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
80101e6b:	68 95 76 10 80       	push   $0x80107695
80101e70:	e8 fb e4 ff ff       	call   80100370 <panic>
    panic("dirlink");
80101e75:	83 ec 0c             	sub    $0xc,%esp
80101e78:	68 6a 7c 10 80       	push   $0x80107c6a
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
80101f80:	68 00 77 10 80       	push   $0x80107700
80101f85:	e8 e6 e3 ff ff       	call   80100370 <panic>
    panic("idestart");
80101f8a:	83 ec 0c             	sub    $0xc,%esp
80101f8d:	68 f7 76 10 80       	push   $0x801076f7
80101f92:	e8 d9 e3 ff ff       	call   80100370 <panic>
80101f97:	89 f6                	mov    %esi,%esi
80101f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fa0 <ideinit>:
{
80101fa0:	55                   	push   %ebp
80101fa1:	89 e5                	mov    %esp,%ebp
80101fa3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80101fa6:	68 12 77 10 80       	push   $0x80107712
80101fab:	68 80 a5 10 80       	push   $0x8010a580
80101fb0:	e8 3b 23 00 00       	call   801042f0 <initlock>
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
8010203e:	e8 cd 22 00 00       	call   80104310 <acquire>
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
8010206e:	e8 ad 1f 00 00       	call   80104020 <wakeup>

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
8010208c:	e8 5f 24 00 00       	call   801044f0 <release>

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
801020de:	e8 dd 21 00 00       	call   801042c0 <holdingsleep>
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
80102118:	e8 f3 21 00 00       	call   80104310 <acquire>

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
80102169:	e8 02 1d 00 00       	call   80103e70 <sleep>
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
80102186:	e9 65 23 00 00       	jmp    801044f0 <release>
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010218b:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
80102190:	eb b2                	jmp    80102144 <iderw+0x74>
    idestart(b);
80102192:	89 d8                	mov    %ebx,%eax
80102194:	e8 37 fd ff ff       	call   80101ed0 <idestart>
80102199:	eb b3                	jmp    8010214e <iderw+0x7e>
    panic("iderw: buf not locked");
8010219b:	83 ec 0c             	sub    $0xc,%esp
8010219e:	68 16 77 10 80       	push   $0x80107716
801021a3:	e8 c8 e1 ff ff       	call   80100370 <panic>
    panic("iderw: ide disk 1 not present");
801021a8:	83 ec 0c             	sub    $0xc,%esp
801021ab:	68 41 77 10 80       	push   $0x80107741
801021b0:	e8 bb e1 ff ff       	call   80100370 <panic>
    panic("iderw: nothing to do");
801021b5:	83 ec 0c             	sub    $0xc,%esp
801021b8:	68 2c 77 10 80       	push   $0x8010772c
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
80102227:	68 60 77 10 80       	push   $0x80107760
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
801022e2:	81 fb b0 7f 11 80    	cmp    $0x80117fb0,%ebx
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
80102302:	e8 39 22 00 00       	call   80104540 <memset>

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
8010233b:	e9 b0 21 00 00       	jmp    801044f0 <release>
    acquire(&kmem.lock);
80102340:	83 ec 0c             	sub    $0xc,%esp
80102343:	68 60 26 11 80       	push   $0x80112660
80102348:	e8 c3 1f 00 00       	call   80104310 <acquire>
8010234d:	83 c4 10             	add    $0x10,%esp
80102350:	eb c2                	jmp    80102314 <kfree+0x44>
    panic("kfree");
80102352:	83 ec 0c             	sub    $0xc,%esp
80102355:	68 92 77 10 80       	push   $0x80107792
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
801023bb:	68 98 77 10 80       	push   $0x80107798
801023c0:	68 60 26 11 80       	push   $0x80112660
801023c5:	e8 26 1f 00 00       	call   801042f0 <initlock>
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
801024ae:	e8 3d 20 00 00       	call   801044f0 <release>
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
801024c8:	e8 43 1e 00 00       	call   80104310 <acquire>
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
8010252f:	0f b6 8a c0 78 10 80 	movzbl -0x7fef8740(%edx),%ecx
  shift ^= togglecode[data];
80102536:	0f b6 82 c0 77 10 80 	movzbl -0x7fef8840(%edx),%eax
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
8010254f:	8b 04 85 a0 77 10 80 	mov    -0x7fef8860(,%eax,4),%eax
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
8010257f:	0f b6 82 c0 78 10 80 	movzbl -0x7fef8740(%edx),%eax
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
80102761:	68 c0 79 10 80       	push   $0x801079c0
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
80102783:	68 ec 79 10 80       	push   $0x801079ec
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
80102977:	e8 14 1c 00 00       	call   80104590 <memcmp>
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
80102aa4:	e8 47 1b 00 00       	call   801045f0 <memmove>
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
80102b4a:	68 fc 79 10 80       	push   $0x801079fc
80102b4f:	68 a0 26 11 80       	push   $0x801126a0
80102b54:	e8 97 17 00 00       	call   801042f0 <initlock>
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
80102beb:	e8 20 17 00 00       	call   80104310 <acquire>
80102bf0:	83 c4 10             	add    $0x10,%esp
80102bf3:	eb 18                	jmp    80102c0d <begin_op+0x2d>
80102bf5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102bf8:	83 ec 08             	sub    $0x8,%esp
80102bfb:	68 a0 26 11 80       	push   $0x801126a0
80102c00:	68 a0 26 11 80       	push   $0x801126a0
80102c05:	e8 66 12 00 00       	call   80103e70 <sleep>
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
80102c3c:	e8 af 18 00 00       	call   801044f0 <release>
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
80102c5e:	e8 ad 16 00 00       	call   80104310 <acquire>
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
80102c9c:	e8 4f 18 00 00       	call   801044f0 <release>
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
80102cfc:	e8 ef 18 00 00       	call   801045f0 <memmove>
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
80102d45:	e8 c6 15 00 00       	call   80104310 <acquire>
    wakeup(&log);
80102d4a:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
    log.committing = 0;
80102d51:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102d58:	00 00 00 
    wakeup(&log);
80102d5b:	e8 c0 12 00 00       	call   80104020 <wakeup>
    release(&log.lock);
80102d60:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102d67:	e8 84 17 00 00       	call   801044f0 <release>
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
80102d88:	e8 93 12 00 00       	call   80104020 <wakeup>
  release(&log.lock);
80102d8d:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102d94:	e8 57 17 00 00       	call   801044f0 <release>
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
80102da7:	68 00 7a 10 80       	push   $0x80107a00
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
80102dfe:	e8 0d 15 00 00       	call   80104310 <acquire>
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
80102e4d:	e9 9e 16 00 00       	jmp    801044f0 <release>
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
80102e73:	68 0f 7a 10 80       	push   $0x80107a0f
80102e78:	e8 f3 d4 ff ff       	call   80100370 <panic>
    panic("log_write outside of trans");
80102e7d:	83 ec 0c             	sub    $0xc,%esp
80102e80:	68 25 7a 10 80       	push   $0x80107a25
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
80102e9f:	68 40 7a 10 80       	push   $0x80107a40
80102ea4:	e8 b7 d7 ff ff       	call   80100660 <cprintf>
 
  idtinit();       // load idt register
80102ea9:	e8 72 2c 00 00       	call   80105b20 <idtinit>
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
80102ec1:	e8 ba 0c 00 00       	call   80103b80 <scheduler>
80102ec6:	8d 76 00             	lea    0x0(%esi),%esi
80102ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ed0 <mpenter>:
{
80102ed0:	55                   	push   %ebp
80102ed1:	89 e5                	mov    %esp,%ebp
80102ed3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102ed6:	e8 65 40 00 00       	call   80106f40 <switchkvm>
  seginit();
80102edb:	e8 80 3e 00 00       	call   80106d60 <seginit>
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
80102f07:	68 b0 7f 11 80       	push   $0x80117fb0
80102f0c:	e8 9f f4 ff ff       	call   801023b0 <kinit1>
  kvmalloc();      // kernel page table
80102f11:	e8 0a 40 00 00       	call   80106f20 <kvmalloc>
  mpinit();        // detect other processors
80102f16:	e8 a5 01 00 00       	call   801030c0 <mpinit>
  lapicinit();     // interrupt controller
80102f1b:	e8 d0 f6 ff ff       	call   801025f0 <lapicinit>
  seginit();       // segment descriptors
80102f20:	e8 3b 3e 00 00       	call   80106d60 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpunum());
80102f25:	e8 c6 f7 ff ff       	call   801026f0 <cpunum>
80102f2a:	5a                   	pop    %edx
80102f2b:	59                   	pop    %ecx
80102f2c:	50                   	push   %eax
80102f2d:	68 51 7a 10 80       	push   $0x80107a51
80102f32:	e8 29 d7 ff ff       	call   80100660 <cprintf>
  picinit();       // another interrupt controller
80102f37:	e8 94 03 00 00       	call   801032d0 <picinit>
  ioapicinit();    // another interrupt controller
80102f3c:	e8 8f f2 ff ff       	call   801021d0 <ioapicinit>
  consoleinit();   // console hardware
80102f41:	e8 4a da ff ff       	call   80100990 <consoleinit>
  uartinit();      // serial port
80102f46:	e8 d5 2e 00 00       	call   80105e20 <uartinit>
  pinit();         // process table
80102f4b:	e8 60 09 00 00       	call   801038b0 <pinit>
  tvinit();        // trap vectors
80102f50:	e8 2b 2b 00 00       	call   80105a80 <tvinit>
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
80102f6f:	0f 84 cf 00 00 00    	je     80103044 <main+0x154>

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
80102f8c:	e8 5f 16 00 00       	call   801045f0 <memmove>
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
80103035:	e8 96 08 00 00       	call   801038d0 <userinit>
  ShareMemInit();
8010303a:	e8 41 3b 00 00       	call   80106b80 <ShareMemInit>
  mpmain();        // finish this processor's setup
8010303f:	e8 4c fe ff ff       	call   80102e90 <mpmain>
    timerinit();   // uniprocessor timer
80103044:	e8 d7 29 00 00       	call   80105a20 <timerinit>
80103049:	e9 27 ff ff ff       	jmp    80102f75 <main+0x85>
8010304e:	66 90                	xchg   %ax,%ax

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
80103078:	68 68 7a 10 80       	push   $0x80107a68
8010307d:	56                   	push   %esi
8010307e:	e8 0d 15 00 00       	call   80104590 <memcmp>
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
80103128:	68 6d 7a 10 80       	push   $0x80107a6d
8010312d:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010312e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103131:	e8 5a 14 00 00       	call   80104590 <memcmp>
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
801031bc:	ff 24 95 74 7a 10 80 	jmp    *-0x7fef858c(,%edx,4)
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
801033e3:	68 88 7a 10 80       	push   $0x80107a88
801033e8:	50                   	push   %eax
801033e9:	e8 02 0f 00 00       	call   801042f0 <initlock>
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
8010347f:	e8 8c 0e 00 00       	call   80104310 <acquire>
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
8010349f:	e8 7c 0b 00 00       	call   80104020 <wakeup>
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
801034c4:	e9 27 10 00 00       	jmp    801044f0 <release>
801034c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801034d0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801034d6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
801034d9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801034e0:	00 00 00 
    wakeup(&p->nwrite);
801034e3:	50                   	push   %eax
801034e4:	e8 37 0b 00 00       	call   80104020 <wakeup>
801034e9:	83 c4 10             	add    $0x10,%esp
801034ec:	eb b9                	jmp    801034a7 <pipeclose+0x37>
801034ee:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801034f0:	83 ec 0c             	sub    $0xc,%esp
801034f3:	53                   	push   %ebx
801034f4:	e8 f7 0f 00 00       	call   801044f0 <release>
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
8010351d:	e8 ee 0d 00 00       	call   80104310 <acquire>
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
801035a7:	e8 74 0a 00 00       	call   80104020 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035ac:	59                   	pop    %ecx
801035ad:	58                   	pop    %eax
801035ae:	57                   	push   %edi
801035af:	53                   	push   %ebx
801035b0:	e8 bb 08 00 00       	call   80103e70 <sleep>
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
80103600:	e8 1b 0a 00 00       	call   80104020 <wakeup>
  release(&p->lock);
80103605:	89 3c 24             	mov    %edi,(%esp)
80103608:	e8 e3 0e 00 00       	call   801044f0 <release>
  return n;
8010360d:	83 c4 10             	add    $0x10,%esp
80103610:	8b 45 10             	mov    0x10(%ebp),%eax
80103613:	eb 14                	jmp    80103629 <pipewrite+0x119>
80103615:	8d 76 00             	lea    0x0(%esi),%esi
        release(&p->lock);
80103618:	83 ec 0c             	sub    $0xc,%esp
8010361b:	57                   	push   %edi
8010361c:	e8 cf 0e 00 00       	call   801044f0 <release>
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
80103650:	e8 bb 0c 00 00       	call   80104310 <acquire>
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
80103685:	e8 e6 07 00 00       	call   80103e70 <sleep>
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
801036bf:	e8 2c 0e 00 00       	call   801044f0 <release>
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
8010371f:	e8 fc 08 00 00       	call   80104020 <wakeup>
  release(&p->lock);
80103724:	89 34 24             	mov    %esi,(%esp)
80103727:	e8 c4 0d 00 00       	call   801044f0 <release>
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
80103761:	e8 aa 0b 00 00       	call   80104310 <acquire>
80103766:	83 c4 10             	add    $0x10,%esp
80103769:	eb 17                	jmp    80103782 <allocproc+0x32>
8010376b:	90                   	nop
8010376c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103770:	81 c3 20 01 00 00    	add    $0x120,%ebx
80103776:	81 fb d4 75 11 80    	cmp    $0x801175d4,%ebx
8010377c:	0f 83 ae 00 00 00    	jae    80103830 <allocproc+0xe0>
    if(p->state == UNUSED)
80103782:	8b 43 0c             	mov    0xc(%ebx),%eax
80103785:	85 c0                	test   %eax,%eax
80103787:	75 e7                	jne    80103770 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103789:	a1 08 a0 10 80       	mov    0x8010a008,%eax

  release(&ptable.lock);
8010378e:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103791:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103798:	8d 50 01             	lea    0x1(%eax),%edx
8010379b:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
8010379e:	68 a0 2d 11 80       	push   $0x80112da0
  p->pid = nextpid++;
801037a3:	89 15 08 a0 10 80    	mov    %edx,0x8010a008
  release(&ptable.lock);
801037a9:	e8 42 0d 00 00       	call   801044f0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801037ae:	e8 cd ec ff ff       	call   80102480 <kalloc>
801037b3:	83 c4 10             	add    $0x10,%esp
801037b6:	85 c0                	test   %eax,%eax
801037b8:	89 43 08             	mov    %eax,0x8(%ebx)
801037bb:	0f 84 88 00 00 00    	je     80103849 <allocproc+0xf9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801037c1:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801037c7:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
801037ca:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
801037cf:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
801037d2:	c7 40 14 6e 5a 10 80 	movl   $0x80105a6e,0x14(%eax)
  p->context = (struct context*)sp;
801037d9:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801037dc:	6a 14                	push   $0x14
801037de:	6a 00                	push   $0x0
801037e0:	50                   	push   %eax
801037e1:	e8 5a 0d 00 00       	call   80104540 <memset>
  p->context->eip = (uint)forkret;
801037e6:	8b 43 1c             	mov    0x1c(%ebx),%eax
801037e9:	8d 93 d0 00 00 00    	lea    0xd0(%ebx),%edx
801037ef:	83 c4 10             	add    $0x10,%esp
801037f2:	c7 40 10 60 38 10 80 	movl   $0x80103860,0x10(%eax)
801037f9:	8d 83 80 00 00 00    	lea    0x80(%ebx),%eax


  p->allocatedPages = 0;
801037ff:	c7 43 7c 00 00 00 00 	movl   $0x0,0x7c(%ebx)
80103806:	8d 76 00             	lea    0x0(%esi),%esi
80103809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(int i = 0; i < 20; ++i){
    p->keysUsed[i] = -1;
80103810:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    p->keyAddresses[i] = -1;
80103816:	c7 40 50 ff ff ff ff 	movl   $0xffffffff,0x50(%eax)
8010381d:	83 c0 04             	add    $0x4,%eax
  for(int i = 0; i < 20; ++i){
80103820:	39 c2                	cmp    %eax,%edx
80103822:	75 ec                	jne    80103810 <allocproc+0xc0>
  }
  return p;
}
80103824:	89 d8                	mov    %ebx,%eax
80103826:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103829:	c9                   	leave  
8010382a:	c3                   	ret    
8010382b:	90                   	nop
8010382c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80103830:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103833:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103835:	68 a0 2d 11 80       	push   $0x80112da0
8010383a:	e8 b1 0c 00 00       	call   801044f0 <release>
}
8010383f:	89 d8                	mov    %ebx,%eax
  return 0;
80103841:	83 c4 10             	add    $0x10,%esp
}
80103844:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103847:	c9                   	leave  
80103848:	c3                   	ret    
    p->state = UNUSED;
80103849:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103850:	31 db                	xor    %ebx,%ebx
80103852:	eb d0                	jmp    80103824 <allocproc+0xd4>
80103854:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010385a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103860 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103860:	55                   	push   %ebp
80103861:	89 e5                	mov    %esp,%ebp
80103863:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103866:	68 a0 2d 11 80       	push   $0x80112da0
8010386b:	e8 80 0c 00 00       	call   801044f0 <release>

  if (first) {
80103870:	a1 04 a0 10 80       	mov    0x8010a004,%eax
80103875:	83 c4 10             	add    $0x10,%esp
80103878:	85 c0                	test   %eax,%eax
8010387a:	75 04                	jne    80103880 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010387c:	c9                   	leave  
8010387d:	c3                   	ret    
8010387e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103880:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103883:	c7 05 04 a0 10 80 00 	movl   $0x0,0x8010a004
8010388a:	00 00 00 
    iinit(ROOTDEV);
8010388d:	6a 01                	push   $0x1
8010388f:	e8 cc db ff ff       	call   80101460 <iinit>
    initlog(ROOTDEV);
80103894:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010389b:	e8 a0 f2 ff ff       	call   80102b40 <initlog>
801038a0:	83 c4 10             	add    $0x10,%esp
}
801038a3:	c9                   	leave  
801038a4:	c3                   	ret    
801038a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801038a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801038b0 <pinit>:
{
801038b0:	55                   	push   %ebp
801038b1:	89 e5                	mov    %esp,%ebp
801038b3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801038b6:	68 8d 7a 10 80       	push   $0x80107a8d
801038bb:	68 a0 2d 11 80       	push   $0x80112da0
801038c0:	e8 2b 0a 00 00       	call   801042f0 <initlock>
}
801038c5:	83 c4 10             	add    $0x10,%esp
801038c8:	c9                   	leave  
801038c9:	c3                   	ret    
801038ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801038d0 <userinit>:
{
801038d0:	55                   	push   %ebp
801038d1:	89 e5                	mov    %esp,%ebp
801038d3:	53                   	push   %ebx
801038d4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
801038d7:	e8 74 fe ff ff       	call   80103750 <allocproc>
801038dc:	89 c3                	mov    %eax,%ebx
  initproc = p;
801038de:	a3 bc a5 10 80       	mov    %eax,0x8010a5bc
  if((p->pgdir = setupkvm()) == 0)
801038e3:	e8 c8 35 00 00       	call   80106eb0 <setupkvm>
801038e8:	85 c0                	test   %eax,%eax
801038ea:	89 43 04             	mov    %eax,0x4(%ebx)
801038ed:	0f 84 bd 00 00 00    	je     801039b0 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801038f3:	83 ec 04             	sub    $0x4,%esp
801038f6:	68 2c 00 00 00       	push   $0x2c
801038fb:	68 60 a4 10 80       	push   $0x8010a460
80103900:	50                   	push   %eax
80103901:	e8 fa 36 00 00       	call   80107000 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103906:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103909:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010390f:	6a 4c                	push   $0x4c
80103911:	6a 00                	push   $0x0
80103913:	ff 73 18             	pushl  0x18(%ebx)
80103916:	e8 25 0c 00 00       	call   80104540 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010391b:	8b 43 18             	mov    0x18(%ebx),%eax
8010391e:	ba 23 00 00 00       	mov    $0x23,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103923:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103928:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010392b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010392f:	8b 43 18             	mov    0x18(%ebx),%eax
80103932:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103936:	8b 43 18             	mov    0x18(%ebx),%eax
80103939:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010393d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103941:	8b 43 18             	mov    0x18(%ebx),%eax
80103944:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103948:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010394c:	8b 43 18             	mov    0x18(%ebx),%eax
8010394f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103956:	8b 43 18             	mov    0x18(%ebx),%eax
80103959:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103960:	8b 43 18             	mov    0x18(%ebx),%eax
80103963:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010396a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010396d:	6a 10                	push   $0x10
8010396f:	68 ad 7a 10 80       	push   $0x80107aad
80103974:	50                   	push   %eax
80103975:	e8 a6 0d 00 00       	call   80104720 <safestrcpy>
  p->cwd = namei("/");
8010397a:	c7 04 24 b6 7a 10 80 	movl   $0x80107ab6,(%esp)
80103981:	e8 0a e5 ff ff       	call   80101e90 <namei>
80103986:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103989:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103990:	e8 7b 09 00 00       	call   80104310 <acquire>
  p->state = RUNNABLE;
80103995:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
8010399c:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
801039a3:	e8 48 0b 00 00       	call   801044f0 <release>
}
801039a8:	83 c4 10             	add    $0x10,%esp
801039ab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039ae:	c9                   	leave  
801039af:	c3                   	ret    
    panic("userinit: out of memory?");
801039b0:	83 ec 0c             	sub    $0xc,%esp
801039b3:	68 94 7a 10 80       	push   $0x80107a94
801039b8:	e8 b3 c9 ff ff       	call   80100370 <panic>
801039bd:	8d 76 00             	lea    0x0(%esi),%esi

801039c0 <growproc>:
{
801039c0:	55                   	push   %ebp
801039c1:	89 e5                	mov    %esp,%ebp
801039c3:	83 ec 08             	sub    $0x8,%esp
  sz = proc->sz;
801039c6:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
{
801039cd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  sz = proc->sz;
801039d0:	8b 02                	mov    (%edx),%eax
  if(n > 0){
801039d2:	83 f9 00             	cmp    $0x0,%ecx
801039d5:	7e 39                	jle    80103a10 <growproc+0x50>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
801039d7:	83 ec 04             	sub    $0x4,%esp
801039da:	01 c1                	add    %eax,%ecx
801039dc:	51                   	push   %ecx
801039dd:	50                   	push   %eax
801039de:	ff 72 04             	pushl  0x4(%edx)
801039e1:	e8 5a 37 00 00       	call   80107140 <allocuvm>
801039e6:	83 c4 10             	add    $0x10,%esp
801039e9:	85 c0                	test   %eax,%eax
801039eb:	74 3b                	je     80103a28 <growproc+0x68>
801039ed:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  proc->sz = sz;
801039f4:	89 02                	mov    %eax,(%edx)
  switchuvm(proc);
801039f6:	83 ec 0c             	sub    $0xc,%esp
801039f9:	65 ff 35 04 00 00 00 	pushl  %gs:0x4
80103a00:	e8 5b 35 00 00       	call   80106f60 <switchuvm>
  return 0;
80103a05:	83 c4 10             	add    $0x10,%esp
80103a08:	31 c0                	xor    %eax,%eax
}
80103a0a:	c9                   	leave  
80103a0b:	c3                   	ret    
80103a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  } else if(n < 0){
80103a10:	74 e2                	je     801039f4 <growproc+0x34>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80103a12:	83 ec 04             	sub    $0x4,%esp
80103a15:	01 c1                	add    %eax,%ecx
80103a17:	51                   	push   %ecx
80103a18:	50                   	push   %eax
80103a19:	ff 72 04             	pushl  0x4(%edx)
80103a1c:	e8 0f 38 00 00       	call   80107230 <deallocuvm>
80103a21:	83 c4 10             	add    $0x10,%esp
80103a24:	85 c0                	test   %eax,%eax
80103a26:	75 c5                	jne    801039ed <growproc+0x2d>
      return -1;
80103a28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103a2d:	c9                   	leave  
80103a2e:	c3                   	ret    
80103a2f:	90                   	nop

80103a30 <fork>:
{
80103a30:	55                   	push   %ebp
80103a31:	89 e5                	mov    %esp,%ebp
80103a33:	57                   	push   %edi
80103a34:	56                   	push   %esi
80103a35:	53                   	push   %ebx
80103a36:	83 ec 0c             	sub    $0xc,%esp
  if((np = allocproc()) == 0){
80103a39:	e8 12 fd ff ff       	call   80103750 <allocproc>
80103a3e:	85 c0                	test   %eax,%eax
80103a40:	0f 84 10 01 00 00    	je     80103b56 <fork+0x126>
80103a46:	89 c3                	mov    %eax,%ebx
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80103a48:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103a4e:	83 ec 08             	sub    $0x8,%esp
80103a51:	ff 30                	pushl  (%eax)
80103a53:	ff 70 04             	pushl  0x4(%eax)
80103a56:	e8 b5 38 00 00       	call   80107310 <copyuvm>
80103a5b:	83 c4 10             	add    $0x10,%esp
80103a5e:	85 c0                	test   %eax,%eax
80103a60:	89 43 04             	mov    %eax,0x4(%ebx)
80103a63:	0f 84 f4 00 00 00    	je     80103b5d <fork+0x12d>
  np->sz = proc->sz;
80103a69:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  *np->tf = *proc->tf;
80103a6f:	8b 7b 18             	mov    0x18(%ebx),%edi
80103a72:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = proc->sz;
80103a77:	8b 00                	mov    (%eax),%eax
80103a79:	89 03                	mov    %eax,(%ebx)
  np->parent = proc;
80103a7b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103a81:	89 43 14             	mov    %eax,0x14(%ebx)
  *np->tf = *proc->tf;
80103a84:	8b 70 18             	mov    0x18(%eax),%esi
80103a87:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103a89:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103a8b:	8b 43 18             	mov    0x18(%ebx),%eax
80103a8e:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103a95:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->ofile[i])
80103aa0:	8b 44 b2 28          	mov    0x28(%edx,%esi,4),%eax
80103aa4:	85 c0                	test   %eax,%eax
80103aa6:	74 17                	je     80103abf <fork+0x8f>
      np->ofile[i] = filedup(proc->ofile[i]);
80103aa8:	83 ec 0c             	sub    $0xc,%esp
80103aab:	50                   	push   %eax
80103aac:	e8 0f d3 ff ff       	call   80100dc0 <filedup>
80103ab1:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
80103ab5:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103abc:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NOFILE; i++)
80103abf:	83 c6 01             	add    $0x1,%esi
80103ac2:	83 fe 10             	cmp    $0x10,%esi
80103ac5:	75 d9                	jne    80103aa0 <fork+0x70>
  np->cwd = idup(proc->cwd);
80103ac7:	83 ec 0c             	sub    $0xc,%esp
80103aca:	ff 72 68             	pushl  0x68(%edx)
80103acd:	e8 5e db ff ff       	call   80101630 <idup>
80103ad2:	89 43 68             	mov    %eax,0x68(%ebx)
  safestrcpy(np->name, proc->name, sizeof(proc->name));
80103ad5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103adb:	83 c4 0c             	add    $0xc,%esp
80103ade:	6a 10                	push   $0x10
80103ae0:	83 c0 6c             	add    $0x6c,%eax
80103ae3:	50                   	push   %eax
80103ae4:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103ae7:	50                   	push   %eax
80103ae8:	e8 33 0c 00 00       	call   80104720 <safestrcpy>
  pid = np->pid;
80103aed:	8b 73 10             	mov    0x10(%ebx),%esi
  acquire(&ptable.lock);
80103af0:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103af7:	e8 14 08 00 00       	call   80104310 <acquire>
  np->allocatedPages = proc->allocatedPages;
80103afc:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  np->state = RUNNABLE;
80103b03:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  np->allocatedPages = proc->allocatedPages;
80103b0a:	83 c4 10             	add    $0x10,%esp
80103b0d:	8b 42 7c             	mov    0x7c(%edx),%eax
80103b10:	89 43 7c             	mov    %eax,0x7c(%ebx)
  for(int i = 0; i < 20; ++i){
80103b13:	31 c0                	xor    %eax,%eax
80103b15:	8d 76 00             	lea    0x0(%esi),%esi
   np->keysUsed[i] = proc->keysUsed[i]; 
80103b18:	8b 8c 82 80 00 00 00 	mov    0x80(%edx,%eax,4),%ecx
80103b1f:	89 8c 83 80 00 00 00 	mov    %ecx,0x80(%ebx,%eax,4)
   np->keyAddresses[i] = proc->keyAddresses[i];   
80103b26:	8b 8c 82 d0 00 00 00 	mov    0xd0(%edx,%eax,4),%ecx
80103b2d:	89 8c 83 d0 00 00 00 	mov    %ecx,0xd0(%ebx,%eax,4)
  for(int i = 0; i < 20; ++i){
80103b34:	83 c0 01             	add    $0x1,%eax
80103b37:	83 f8 14             	cmp    $0x14,%eax
80103b3a:	75 dc                	jne    80103b18 <fork+0xe8>
  release(&ptable.lock);
80103b3c:	83 ec 0c             	sub    $0xc,%esp
80103b3f:	68 a0 2d 11 80       	push   $0x80112da0
80103b44:	e8 a7 09 00 00       	call   801044f0 <release>
  return pid;
80103b49:	83 c4 10             	add    $0x10,%esp
}
80103b4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b4f:	89 f0                	mov    %esi,%eax
80103b51:	5b                   	pop    %ebx
80103b52:	5e                   	pop    %esi
80103b53:	5f                   	pop    %edi
80103b54:	5d                   	pop    %ebp
80103b55:	c3                   	ret    
    return -1;
80103b56:	be ff ff ff ff       	mov    $0xffffffff,%esi
80103b5b:	eb ef                	jmp    80103b4c <fork+0x11c>
    kfree(np->kstack);
80103b5d:	83 ec 0c             	sub    $0xc,%esp
80103b60:	ff 73 08             	pushl  0x8(%ebx)
    return -1;
80103b63:	be ff ff ff ff       	mov    $0xffffffff,%esi
    kfree(np->kstack);
80103b68:	e8 63 e7 ff ff       	call   801022d0 <kfree>
    np->kstack = 0;
80103b6d:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103b74:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103b7b:	83 c4 10             	add    $0x10,%esp
80103b7e:	eb cc                	jmp    80103b4c <fork+0x11c>

80103b80 <scheduler>:
{
80103b80:	55                   	push   %ebp
80103b81:	89 e5                	mov    %esp,%ebp
80103b83:	53                   	push   %ebx
80103b84:	83 ec 04             	sub    $0x4,%esp
80103b87:	89 f6                	mov    %esi,%esi
80103b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  asm volatile("sti");
80103b90:	fb                   	sti    
    acquire(&ptable.lock);
80103b91:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b94:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
    acquire(&ptable.lock);
80103b99:	68 a0 2d 11 80       	push   $0x80112da0
80103b9e:	e8 6d 07 00 00       	call   80104310 <acquire>
80103ba3:	83 c4 10             	add    $0x10,%esp
80103ba6:	eb 16                	jmp    80103bbe <scheduler+0x3e>
80103ba8:	90                   	nop
80103ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bb0:	81 c3 20 01 00 00    	add    $0x120,%ebx
80103bb6:	81 fb d4 75 11 80    	cmp    $0x801175d4,%ebx
80103bbc:	73 62                	jae    80103c20 <scheduler+0xa0>
      if(p->state != RUNNABLE)
80103bbe:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103bc2:	75 ec                	jne    80103bb0 <scheduler+0x30>
      switchuvm(p);
80103bc4:	83 ec 0c             	sub    $0xc,%esp
      proc = p;
80103bc7:	65 89 1d 04 00 00 00 	mov    %ebx,%gs:0x4
      switchuvm(p);
80103bce:	53                   	push   %ebx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bcf:	81 c3 20 01 00 00    	add    $0x120,%ebx
      switchuvm(p);
80103bd5:	e8 86 33 00 00       	call   80106f60 <switchuvm>
      swtch(&cpu->scheduler, p->context);
80103bda:	58                   	pop    %eax
80103bdb:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
      p->state = RUNNING;
80103be1:	c7 83 ec fe ff ff 04 	movl   $0x4,-0x114(%ebx)
80103be8:	00 00 00 
      swtch(&cpu->scheduler, p->context);
80103beb:	5a                   	pop    %edx
80103bec:	ff b3 fc fe ff ff    	pushl  -0x104(%ebx)
80103bf2:	83 c0 04             	add    $0x4,%eax
80103bf5:	50                   	push   %eax
80103bf6:	e8 80 0b 00 00       	call   8010477b <swtch>
      switchkvm();
80103bfb:	e8 40 33 00 00       	call   80106f40 <switchkvm>
      proc = 0;
80103c00:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c03:	81 fb d4 75 11 80    	cmp    $0x801175d4,%ebx
      proc = 0;
80103c09:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80103c10:	00 00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c14:	72 a8                	jb     80103bbe <scheduler+0x3e>
80103c16:	8d 76 00             	lea    0x0(%esi),%esi
80103c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    release(&ptable.lock);
80103c20:	83 ec 0c             	sub    $0xc,%esp
80103c23:	68 a0 2d 11 80       	push   $0x80112da0
80103c28:	e8 c3 08 00 00       	call   801044f0 <release>
    sti();
80103c2d:	83 c4 10             	add    $0x10,%esp
80103c30:	e9 5b ff ff ff       	jmp    80103b90 <scheduler+0x10>
80103c35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c40 <sched>:
{
80103c40:	55                   	push   %ebp
80103c41:	89 e5                	mov    %esp,%ebp
80103c43:	53                   	push   %ebx
80103c44:	83 ec 10             	sub    $0x10,%esp
  if(!holding(&ptable.lock))
80103c47:	68 a0 2d 11 80       	push   $0x80112da0
80103c4c:	e8 ef 07 00 00       	call   80104440 <holding>
80103c51:	83 c4 10             	add    $0x10,%esp
80103c54:	85 c0                	test   %eax,%eax
80103c56:	74 4c                	je     80103ca4 <sched+0x64>
  if(cpu->ncli != 1)
80103c58:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80103c5f:	83 ba ac 00 00 00 01 	cmpl   $0x1,0xac(%edx)
80103c66:	75 63                	jne    80103ccb <sched+0x8b>
  if(proc->state == RUNNING)
80103c68:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103c6e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80103c72:	74 4a                	je     80103cbe <sched+0x7e>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103c74:	9c                   	pushf  
80103c75:	59                   	pop    %ecx
  if(readeflags()&FL_IF)
80103c76:	80 e5 02             	and    $0x2,%ch
80103c79:	75 36                	jne    80103cb1 <sched+0x71>
  swtch(&proc->context, cpu->scheduler);
80103c7b:	83 ec 08             	sub    $0x8,%esp
80103c7e:	83 c0 1c             	add    $0x1c,%eax
  intena = cpu->intena;
80103c81:	8b 9a b0 00 00 00    	mov    0xb0(%edx),%ebx
  swtch(&proc->context, cpu->scheduler);
80103c87:	ff 72 04             	pushl  0x4(%edx)
80103c8a:	50                   	push   %eax
80103c8b:	e8 eb 0a 00 00       	call   8010477b <swtch>
  cpu->intena = intena;
80103c90:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
}
80103c96:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
80103c99:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
}
80103c9f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ca2:	c9                   	leave  
80103ca3:	c3                   	ret    
    panic("sched ptable.lock");
80103ca4:	83 ec 0c             	sub    $0xc,%esp
80103ca7:	68 b8 7a 10 80       	push   $0x80107ab8
80103cac:	e8 bf c6 ff ff       	call   80100370 <panic>
    panic("sched interruptible");
80103cb1:	83 ec 0c             	sub    $0xc,%esp
80103cb4:	68 e4 7a 10 80       	push   $0x80107ae4
80103cb9:	e8 b2 c6 ff ff       	call   80100370 <panic>
    panic("sched running");
80103cbe:	83 ec 0c             	sub    $0xc,%esp
80103cc1:	68 d6 7a 10 80       	push   $0x80107ad6
80103cc6:	e8 a5 c6 ff ff       	call   80100370 <panic>
    panic("sched locks");
80103ccb:	83 ec 0c             	sub    $0xc,%esp
80103cce:	68 ca 7a 10 80       	push   $0x80107aca
80103cd3:	e8 98 c6 ff ff       	call   80100370 <panic>
80103cd8:	90                   	nop
80103cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103ce0 <exit>:
  if(proc == initproc)
80103ce0:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103ce7:	3b 15 bc a5 10 80    	cmp    0x8010a5bc,%edx
{
80103ced:	55                   	push   %ebp
80103cee:	89 e5                	mov    %esp,%ebp
80103cf0:	56                   	push   %esi
80103cf1:	53                   	push   %ebx
  if(proc == initproc)
80103cf2:	0f 84 29 01 00 00    	je     80103e21 <exit+0x141>
80103cf8:	31 db                	xor    %ebx,%ebx
80103cfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(proc->ofile[fd]){
80103d00:	8d 73 08             	lea    0x8(%ebx),%esi
80103d03:	8b 44 b2 08          	mov    0x8(%edx,%esi,4),%eax
80103d07:	85 c0                	test   %eax,%eax
80103d09:	74 1b                	je     80103d26 <exit+0x46>
      fileclose(proc->ofile[fd]);
80103d0b:	83 ec 0c             	sub    $0xc,%esp
80103d0e:	50                   	push   %eax
80103d0f:	e8 fc d0 ff ff       	call   80100e10 <fileclose>
      proc->ofile[fd] = 0;
80103d14:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103d1b:	83 c4 10             	add    $0x10,%esp
80103d1e:	c7 44 b2 08 00 00 00 	movl   $0x0,0x8(%edx,%esi,4)
80103d25:	00 
  for(fd = 0; fd < NOFILE; fd++){
80103d26:	83 c3 01             	add    $0x1,%ebx
80103d29:	83 fb 10             	cmp    $0x10,%ebx
80103d2c:	75 d2                	jne    80103d00 <exit+0x20>
  begin_op();
80103d2e:	e8 ad ee ff ff       	call   80102be0 <begin_op>
  iput(proc->cwd);
80103d33:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103d39:	83 ec 0c             	sub    $0xc,%esp
80103d3c:	ff 70 68             	pushl  0x68(%eax)
80103d3f:	e8 4c da ff ff       	call   80101790 <iput>
  end_op();
80103d44:	e8 07 ef ff ff       	call   80102c50 <end_op>
  proc->cwd = 0;
80103d49:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103d4f:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
  acquire(&ptable.lock);
80103d56:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103d5d:	e8 ae 05 00 00       	call   80104310 <acquire>
  wakeup1(proc->parent);
80103d62:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
80103d69:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d6c:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
  wakeup1(proc->parent);
80103d71:	8b 51 14             	mov    0x14(%ecx),%edx
80103d74:	eb 16                	jmp    80103d8c <exit+0xac>
80103d76:	8d 76 00             	lea    0x0(%esi),%esi
80103d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d80:	05 20 01 00 00       	add    $0x120,%eax
80103d85:	3d d4 75 11 80       	cmp    $0x801175d4,%eax
80103d8a:	73 1e                	jae    80103daa <exit+0xca>
    if(p->state == SLEEPING && p->chan == chan)
80103d8c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d90:	75 ee                	jne    80103d80 <exit+0xa0>
80103d92:	3b 50 20             	cmp    0x20(%eax),%edx
80103d95:	75 e9                	jne    80103d80 <exit+0xa0>
      p->state = RUNNABLE;
80103d97:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d9e:	05 20 01 00 00       	add    $0x120,%eax
80103da3:	3d d4 75 11 80       	cmp    $0x801175d4,%eax
80103da8:	72 e2                	jb     80103d8c <exit+0xac>
      p->parent = initproc;
80103daa:	8b 1d bc a5 10 80    	mov    0x8010a5bc,%ebx
80103db0:	ba d4 2d 11 80       	mov    $0x80112dd4,%edx
80103db5:	eb 17                	jmp    80103dce <exit+0xee>
80103db7:	89 f6                	mov    %esi,%esi
80103db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103dc0:	81 c2 20 01 00 00    	add    $0x120,%edx
80103dc6:	81 fa d4 75 11 80    	cmp    $0x801175d4,%edx
80103dcc:	73 3a                	jae    80103e08 <exit+0x128>
    if(p->parent == proc){
80103dce:	3b 4a 14             	cmp    0x14(%edx),%ecx
80103dd1:	75 ed                	jne    80103dc0 <exit+0xe0>
      if(p->state == ZOMBIE)
80103dd3:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103dd7:	89 5a 14             	mov    %ebx,0x14(%edx)
      if(p->state == ZOMBIE)
80103dda:	75 e4                	jne    80103dc0 <exit+0xe0>
80103ddc:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
80103de1:	eb 11                	jmp    80103df4 <exit+0x114>
80103de3:	90                   	nop
80103de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103de8:	05 20 01 00 00       	add    $0x120,%eax
80103ded:	3d d4 75 11 80       	cmp    $0x801175d4,%eax
80103df2:	73 cc                	jae    80103dc0 <exit+0xe0>
    if(p->state == SLEEPING && p->chan == chan)
80103df4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103df8:	75 ee                	jne    80103de8 <exit+0x108>
80103dfa:	3b 58 20             	cmp    0x20(%eax),%ebx
80103dfd:	75 e9                	jne    80103de8 <exit+0x108>
      p->state = RUNNABLE;
80103dff:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103e06:	eb e0                	jmp    80103de8 <exit+0x108>
  proc->state = ZOMBIE;
80103e08:	c7 41 0c 05 00 00 00 	movl   $0x5,0xc(%ecx)
  sched();
80103e0f:	e8 2c fe ff ff       	call   80103c40 <sched>
  panic("zombie exit");
80103e14:	83 ec 0c             	sub    $0xc,%esp
80103e17:	68 05 7b 10 80       	push   $0x80107b05
80103e1c:	e8 4f c5 ff ff       	call   80100370 <panic>
    panic("init exiting");
80103e21:	83 ec 0c             	sub    $0xc,%esp
80103e24:	68 f8 7a 10 80       	push   $0x80107af8
80103e29:	e8 42 c5 ff ff       	call   80100370 <panic>
80103e2e:	66 90                	xchg   %ax,%ax

80103e30 <yield>:
{
80103e30:	55                   	push   %ebp
80103e31:	89 e5                	mov    %esp,%ebp
80103e33:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103e36:	68 a0 2d 11 80       	push   $0x80112da0
80103e3b:	e8 d0 04 00 00       	call   80104310 <acquire>
  proc->state = RUNNABLE;
80103e40:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e46:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80103e4d:	e8 ee fd ff ff       	call   80103c40 <sched>
  release(&ptable.lock);
80103e52:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103e59:	e8 92 06 00 00       	call   801044f0 <release>
}
80103e5e:	83 c4 10             	add    $0x10,%esp
80103e61:	c9                   	leave  
80103e62:	c3                   	ret    
80103e63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e70 <sleep>:
  if(proc == 0)
80103e70:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
80103e76:	55                   	push   %ebp
80103e77:	89 e5                	mov    %esp,%ebp
80103e79:	56                   	push   %esi
80103e7a:	53                   	push   %ebx
  if(proc == 0)
80103e7b:	85 c0                	test   %eax,%eax
{
80103e7d:	8b 75 08             	mov    0x8(%ebp),%esi
80103e80:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(proc == 0)
80103e83:	0f 84 97 00 00 00    	je     80103f20 <sleep+0xb0>
  if(lk == 0)
80103e89:	85 db                	test   %ebx,%ebx
80103e8b:	0f 84 82 00 00 00    	je     80103f13 <sleep+0xa3>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103e91:	81 fb a0 2d 11 80    	cmp    $0x80112da0,%ebx
80103e97:	74 57                	je     80103ef0 <sleep+0x80>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103e99:	83 ec 0c             	sub    $0xc,%esp
80103e9c:	68 a0 2d 11 80       	push   $0x80112da0
80103ea1:	e8 6a 04 00 00       	call   80104310 <acquire>
    release(lk);
80103ea6:	89 1c 24             	mov    %ebx,(%esp)
80103ea9:	e8 42 06 00 00       	call   801044f0 <release>
  proc->chan = chan;
80103eae:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103eb4:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80103eb7:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103ebe:	e8 7d fd ff ff       	call   80103c40 <sched>
  proc->chan = 0;
80103ec3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103ec9:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
    release(&ptable.lock);
80103ed0:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103ed7:	e8 14 06 00 00       	call   801044f0 <release>
    acquire(lk);
80103edc:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103edf:	83 c4 10             	add    $0x10,%esp
}
80103ee2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ee5:	5b                   	pop    %ebx
80103ee6:	5e                   	pop    %esi
80103ee7:	5d                   	pop    %ebp
    acquire(lk);
80103ee8:	e9 23 04 00 00       	jmp    80104310 <acquire>
80103eed:	8d 76 00             	lea    0x0(%esi),%esi
  proc->chan = chan;
80103ef0:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80103ef3:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103efa:	e8 41 fd ff ff       	call   80103c40 <sched>
  proc->chan = 0;
80103eff:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103f05:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
}
80103f0c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103f0f:	5b                   	pop    %ebx
80103f10:	5e                   	pop    %esi
80103f11:	5d                   	pop    %ebp
80103f12:	c3                   	ret    
    panic("sleep without lk");
80103f13:	83 ec 0c             	sub    $0xc,%esp
80103f16:	68 17 7b 10 80       	push   $0x80107b17
80103f1b:	e8 50 c4 ff ff       	call   80100370 <panic>
    panic("sleep");
80103f20:	83 ec 0c             	sub    $0xc,%esp
80103f23:	68 11 7b 10 80       	push   $0x80107b11
80103f28:	e8 43 c4 ff ff       	call   80100370 <panic>
80103f2d:	8d 76 00             	lea    0x0(%esi),%esi

80103f30 <wait>:
{
80103f30:	55                   	push   %ebp
80103f31:	89 e5                	mov    %esp,%ebp
80103f33:	56                   	push   %esi
80103f34:	53                   	push   %ebx
  acquire(&ptable.lock);
80103f35:	83 ec 0c             	sub    $0xc,%esp
80103f38:	68 a0 2d 11 80       	push   $0x80112da0
80103f3d:	e8 ce 03 00 00       	call   80104310 <acquire>
80103f42:	83 c4 10             	add    $0x10,%esp
80103f45:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    havekids = 0;
80103f4b:	31 d2                	xor    %edx,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f4d:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
80103f52:	eb 12                	jmp    80103f66 <wait+0x36>
80103f54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f58:	81 c3 20 01 00 00    	add    $0x120,%ebx
80103f5e:	81 fb d4 75 11 80    	cmp    $0x801175d4,%ebx
80103f64:	73 22                	jae    80103f88 <wait+0x58>
      if(p->parent != proc)
80103f66:	3b 43 14             	cmp    0x14(%ebx),%eax
80103f69:	75 ed                	jne    80103f58 <wait+0x28>
      if(p->state == ZOMBIE){
80103f6b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103f6f:	74 35                	je     80103fa6 <wait+0x76>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f71:	81 c3 20 01 00 00    	add    $0x120,%ebx
      havekids = 1;
80103f77:	ba 01 00 00 00       	mov    $0x1,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f7c:	81 fb d4 75 11 80    	cmp    $0x801175d4,%ebx
80103f82:	72 e2                	jb     80103f66 <wait+0x36>
80103f84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(!havekids || proc->killed){
80103f88:	85 d2                	test   %edx,%edx
80103f8a:	74 70                	je     80103ffc <wait+0xcc>
80103f8c:	8b 50 24             	mov    0x24(%eax),%edx
80103f8f:	85 d2                	test   %edx,%edx
80103f91:	75 69                	jne    80103ffc <wait+0xcc>
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80103f93:	83 ec 08             	sub    $0x8,%esp
80103f96:	68 a0 2d 11 80       	push   $0x80112da0
80103f9b:	50                   	push   %eax
80103f9c:	e8 cf fe ff ff       	call   80103e70 <sleep>
    havekids = 0;
80103fa1:	83 c4 10             	add    $0x10,%esp
80103fa4:	eb 9f                	jmp    80103f45 <wait+0x15>
        kfree(p->kstack);
80103fa6:	83 ec 0c             	sub    $0xc,%esp
80103fa9:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80103fac:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103faf:	e8 1c e3 ff ff       	call   801022d0 <kfree>
        freevm(p->pgdir);
80103fb4:	59                   	pop    %ecx
80103fb5:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80103fb8:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103fbf:	e8 9c 32 00 00       	call   80107260 <freevm>
        p->pid = 0;
80103fc4:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103fcb:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103fd2:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103fd6:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103fdd:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103fe4:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103feb:	e8 00 05 00 00       	call   801044f0 <release>
        return pid;
80103ff0:	83 c4 10             	add    $0x10,%esp
}
80103ff3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ff6:	89 f0                	mov    %esi,%eax
80103ff8:	5b                   	pop    %ebx
80103ff9:	5e                   	pop    %esi
80103ffa:	5d                   	pop    %ebp
80103ffb:	c3                   	ret    
      release(&ptable.lock);
80103ffc:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103fff:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104004:	68 a0 2d 11 80       	push   $0x80112da0
80104009:	e8 e2 04 00 00       	call   801044f0 <release>
      return -1;
8010400e:	83 c4 10             	add    $0x10,%esp
}
80104011:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104014:	89 f0                	mov    %esi,%eax
80104016:	5b                   	pop    %ebx
80104017:	5e                   	pop    %esi
80104018:	5d                   	pop    %ebp
80104019:	c3                   	ret    
8010401a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104020 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104020:	55                   	push   %ebp
80104021:	89 e5                	mov    %esp,%ebp
80104023:	53                   	push   %ebx
80104024:	83 ec 10             	sub    $0x10,%esp
80104027:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010402a:	68 a0 2d 11 80       	push   $0x80112da0
8010402f:	e8 dc 02 00 00       	call   80104310 <acquire>
80104034:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104037:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
8010403c:	eb 0e                	jmp    8010404c <wakeup+0x2c>
8010403e:	66 90                	xchg   %ax,%ax
80104040:	05 20 01 00 00       	add    $0x120,%eax
80104045:	3d d4 75 11 80       	cmp    $0x801175d4,%eax
8010404a:	73 1e                	jae    8010406a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010404c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104050:	75 ee                	jne    80104040 <wakeup+0x20>
80104052:	3b 58 20             	cmp    0x20(%eax),%ebx
80104055:	75 e9                	jne    80104040 <wakeup+0x20>
      p->state = RUNNABLE;
80104057:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010405e:	05 20 01 00 00       	add    $0x120,%eax
80104063:	3d d4 75 11 80       	cmp    $0x801175d4,%eax
80104068:	72 e2                	jb     8010404c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010406a:	c7 45 08 a0 2d 11 80 	movl   $0x80112da0,0x8(%ebp)
}
80104071:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104074:	c9                   	leave  
  release(&ptable.lock);
80104075:	e9 76 04 00 00       	jmp    801044f0 <release>
8010407a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104080 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104080:	55                   	push   %ebp
80104081:	89 e5                	mov    %esp,%ebp
80104083:	53                   	push   %ebx
80104084:	83 ec 10             	sub    $0x10,%esp
80104087:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010408a:	68 a0 2d 11 80       	push   $0x80112da0
8010408f:	e8 7c 02 00 00       	call   80104310 <acquire>
80104094:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104097:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
8010409c:	eb 0e                	jmp    801040ac <kill+0x2c>
8010409e:	66 90                	xchg   %ax,%ax
801040a0:	05 20 01 00 00       	add    $0x120,%eax
801040a5:	3d d4 75 11 80       	cmp    $0x801175d4,%eax
801040aa:	73 3c                	jae    801040e8 <kill+0x68>
    if(p->pid == pid){
801040ac:	39 58 10             	cmp    %ebx,0x10(%eax)
801040af:	75 ef                	jne    801040a0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801040b1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801040b5:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801040bc:	74 1a                	je     801040d8 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
801040be:	83 ec 0c             	sub    $0xc,%esp
801040c1:	68 a0 2d 11 80       	push   $0x80112da0
801040c6:	e8 25 04 00 00       	call   801044f0 <release>
      return 0;
801040cb:	83 c4 10             	add    $0x10,%esp
801040ce:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801040d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040d3:	c9                   	leave  
801040d4:	c3                   	ret    
801040d5:	8d 76 00             	lea    0x0(%esi),%esi
        p->state = RUNNABLE;
801040d8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801040df:	eb dd                	jmp    801040be <kill+0x3e>
801040e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801040e8:	83 ec 0c             	sub    $0xc,%esp
801040eb:	68 a0 2d 11 80       	push   $0x80112da0
801040f0:	e8 fb 03 00 00       	call   801044f0 <release>
  return -1;
801040f5:	83 c4 10             	add    $0x10,%esp
801040f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801040fd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104100:	c9                   	leave  
80104101:	c3                   	ret    
80104102:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104110 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104110:	55                   	push   %ebp
80104111:	89 e5                	mov    %esp,%ebp
80104113:	57                   	push   %edi
80104114:	56                   	push   %esi
80104115:	53                   	push   %ebx
80104116:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104119:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
{
8010411e:	83 ec 3c             	sub    $0x3c,%esp
80104121:	eb 27                	jmp    8010414a <procdump+0x3a>
80104123:	90                   	nop
80104124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104128:	83 ec 0c             	sub    $0xc,%esp
8010412b:	68 66 7a 10 80       	push   $0x80107a66
80104130:	e8 2b c5 ff ff       	call   80100660 <cprintf>
80104135:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104138:	81 c3 20 01 00 00    	add    $0x120,%ebx
8010413e:	81 fb d4 75 11 80    	cmp    $0x801175d4,%ebx
80104144:	0f 83 86 00 00 00    	jae    801041d0 <procdump+0xc0>
    if(p->state == UNUSED)
8010414a:	8b 43 0c             	mov    0xc(%ebx),%eax
8010414d:	85 c0                	test   %eax,%eax
8010414f:	74 e7                	je     80104138 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104151:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104154:	ba 28 7b 10 80       	mov    $0x80107b28,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104159:	77 11                	ja     8010416c <procdump+0x5c>
8010415b:	8b 14 85 60 7b 10 80 	mov    -0x7fef84a0(,%eax,4),%edx
      state = "???";
80104162:	b8 28 7b 10 80       	mov    $0x80107b28,%eax
80104167:	85 d2                	test   %edx,%edx
80104169:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010416c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010416f:	50                   	push   %eax
80104170:	52                   	push   %edx
80104171:	ff 73 10             	pushl  0x10(%ebx)
80104174:	68 2c 7b 10 80       	push   $0x80107b2c
80104179:	e8 e2 c4 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
8010417e:	83 c4 10             	add    $0x10,%esp
80104181:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104185:	75 a1                	jne    80104128 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104187:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010418a:	83 ec 08             	sub    $0x8,%esp
8010418d:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104190:	50                   	push   %eax
80104191:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104194:	8b 40 0c             	mov    0xc(%eax),%eax
80104197:	83 c0 08             	add    $0x8,%eax
8010419a:	50                   	push   %eax
8010419b:	e8 40 02 00 00       	call   801043e0 <getcallerpcs>
801041a0:	83 c4 10             	add    $0x10,%esp
801041a3:	90                   	nop
801041a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
801041a8:	8b 17                	mov    (%edi),%edx
801041aa:	85 d2                	test   %edx,%edx
801041ac:	0f 84 76 ff ff ff    	je     80104128 <procdump+0x18>
        cprintf(" %p", pc[i]);
801041b2:	83 ec 08             	sub    $0x8,%esp
801041b5:	83 c7 04             	add    $0x4,%edi
801041b8:	52                   	push   %edx
801041b9:	68 89 75 10 80       	push   $0x80107589
801041be:	e8 9d c4 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801041c3:	83 c4 10             	add    $0x10,%esp
801041c6:	39 fe                	cmp    %edi,%esi
801041c8:	75 de                	jne    801041a8 <procdump+0x98>
801041ca:	e9 59 ff ff ff       	jmp    80104128 <procdump+0x18>
801041cf:	90                   	nop
  }
}
801041d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041d3:	5b                   	pop    %ebx
801041d4:	5e                   	pop    %esi
801041d5:	5f                   	pop    %edi
801041d6:	5d                   	pop    %ebp
801041d7:	c3                   	ret    
801041d8:	66 90                	xchg   %ax,%ax
801041da:	66 90                	xchg   %ax,%ax
801041dc:	66 90                	xchg   %ax,%ax
801041de:	66 90                	xchg   %ax,%ax

801041e0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801041e0:	55                   	push   %ebp
801041e1:	89 e5                	mov    %esp,%ebp
801041e3:	53                   	push   %ebx
801041e4:	83 ec 0c             	sub    $0xc,%esp
801041e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801041ea:	68 78 7b 10 80       	push   $0x80107b78
801041ef:	8d 43 04             	lea    0x4(%ebx),%eax
801041f2:	50                   	push   %eax
801041f3:	e8 f8 00 00 00       	call   801042f0 <initlock>
  lk->name = name;
801041f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801041fb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104201:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104204:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010420b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010420e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104211:	c9                   	leave  
80104212:	c3                   	ret    
80104213:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104220 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104220:	55                   	push   %ebp
80104221:	89 e5                	mov    %esp,%ebp
80104223:	56                   	push   %esi
80104224:	53                   	push   %ebx
80104225:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104228:	83 ec 0c             	sub    $0xc,%esp
8010422b:	8d 73 04             	lea    0x4(%ebx),%esi
8010422e:	56                   	push   %esi
8010422f:	e8 dc 00 00 00       	call   80104310 <acquire>
  while (lk->locked) {
80104234:	8b 13                	mov    (%ebx),%edx
80104236:	83 c4 10             	add    $0x10,%esp
80104239:	85 d2                	test   %edx,%edx
8010423b:	74 16                	je     80104253 <acquiresleep+0x33>
8010423d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104240:	83 ec 08             	sub    $0x8,%esp
80104243:	56                   	push   %esi
80104244:	53                   	push   %ebx
80104245:	e8 26 fc ff ff       	call   80103e70 <sleep>
  while (lk->locked) {
8010424a:	8b 03                	mov    (%ebx),%eax
8010424c:	83 c4 10             	add    $0x10,%esp
8010424f:	85 c0                	test   %eax,%eax
80104251:	75 ed                	jne    80104240 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104253:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = proc->pid;
80104259:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010425f:	8b 40 10             	mov    0x10(%eax),%eax
80104262:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104265:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104268:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010426b:	5b                   	pop    %ebx
8010426c:	5e                   	pop    %esi
8010426d:	5d                   	pop    %ebp
  release(&lk->lk);
8010426e:	e9 7d 02 00 00       	jmp    801044f0 <release>
80104273:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104280 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104280:	55                   	push   %ebp
80104281:	89 e5                	mov    %esp,%ebp
80104283:	56                   	push   %esi
80104284:	53                   	push   %ebx
80104285:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104288:	83 ec 0c             	sub    $0xc,%esp
8010428b:	8d 73 04             	lea    0x4(%ebx),%esi
8010428e:	56                   	push   %esi
8010428f:	e8 7c 00 00 00       	call   80104310 <acquire>
  lk->locked = 0;
80104294:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010429a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801042a1:	89 1c 24             	mov    %ebx,(%esp)
801042a4:	e8 77 fd ff ff       	call   80104020 <wakeup>
  release(&lk->lk);
801042a9:	89 75 08             	mov    %esi,0x8(%ebp)
801042ac:	83 c4 10             	add    $0x10,%esp
}
801042af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042b2:	5b                   	pop    %ebx
801042b3:	5e                   	pop    %esi
801042b4:	5d                   	pop    %ebp
  release(&lk->lk);
801042b5:	e9 36 02 00 00       	jmp    801044f0 <release>
801042ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801042c0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801042c0:	55                   	push   %ebp
801042c1:	89 e5                	mov    %esp,%ebp
801042c3:	56                   	push   %esi
801042c4:	53                   	push   %ebx
801042c5:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
801042c8:	83 ec 0c             	sub    $0xc,%esp
801042cb:	8d 5e 04             	lea    0x4(%esi),%ebx
801042ce:	53                   	push   %ebx
801042cf:	e8 3c 00 00 00       	call   80104310 <acquire>
  r = lk->locked;
801042d4:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
801042d6:	89 1c 24             	mov    %ebx,(%esp)
801042d9:	e8 12 02 00 00       	call   801044f0 <release>
  return r;
}
801042de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042e1:	89 f0                	mov    %esi,%eax
801042e3:	5b                   	pop    %ebx
801042e4:	5e                   	pop    %esi
801042e5:	5d                   	pop    %ebp
801042e6:	c3                   	ret    
801042e7:	66 90                	xchg   %ax,%ax
801042e9:	66 90                	xchg   %ax,%ax
801042eb:	66 90                	xchg   %ax,%ax
801042ed:	66 90                	xchg   %ax,%ax
801042ef:	90                   	nop

801042f0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801042f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801042f9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801042ff:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104302:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104309:	5d                   	pop    %ebp
8010430a:	c3                   	ret    
8010430b:	90                   	nop
8010430c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104310 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104310:	55                   	push   %ebp
80104311:	89 e5                	mov    %esp,%ebp
80104313:	53                   	push   %ebx
80104314:	83 ec 04             	sub    $0x4,%esp
80104317:	9c                   	pushf  
80104318:	5a                   	pop    %edx
  asm volatile("cli");
80104319:	fa                   	cli    
{
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
8010431a:	65 8b 0d 00 00 00 00 	mov    %gs:0x0,%ecx
80104321:	8b 81 ac 00 00 00    	mov    0xac(%ecx),%eax
80104327:	85 c0                	test   %eax,%eax
80104329:	75 0c                	jne    80104337 <acquire+0x27>
    cpu->intena = eflags & FL_IF;
8010432b:	81 e2 00 02 00 00    	and    $0x200,%edx
80104331:	89 91 b0 00 00 00    	mov    %edx,0xb0(%ecx)
  if(holding(lk))
80104337:	8b 55 08             	mov    0x8(%ebp),%edx
  cpu->ncli += 1;
8010433a:	83 c0 01             	add    $0x1,%eax
8010433d:	89 81 ac 00 00 00    	mov    %eax,0xac(%ecx)
  return lock->locked && lock->cpu == cpu;
80104343:	8b 02                	mov    (%edx),%eax
80104345:	85 c0                	test   %eax,%eax
80104347:	74 05                	je     8010434e <acquire+0x3e>
80104349:	39 4a 08             	cmp    %ecx,0x8(%edx)
8010434c:	74 7a                	je     801043c8 <acquire+0xb8>
  asm volatile("lock; xchgl %0, %1" :
8010434e:	b9 01 00 00 00       	mov    $0x1,%ecx
80104353:	90                   	nop
80104354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104358:	89 c8                	mov    %ecx,%eax
8010435a:	f0 87 02             	lock xchg %eax,(%edx)
  while(xchg(&lk->locked, 1) != 0)
8010435d:	85 c0                	test   %eax,%eax
8010435f:	75 f7                	jne    80104358 <acquire+0x48>
  __sync_synchronize();
80104361:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = cpu;
80104366:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104369:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  ebp = (uint*)v - 2;
8010436f:	89 ea                	mov    %ebp,%edx
  lk->cpu = cpu;
80104371:	89 41 08             	mov    %eax,0x8(%ecx)
  getcallerpcs(&lk, lk->pcs);
80104374:	83 c1 0c             	add    $0xc,%ecx
  for(i = 0; i < 10; i++){
80104377:	31 c0                	xor    %eax,%eax
80104379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104380:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104386:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010438c:	77 1a                	ja     801043a8 <acquire+0x98>
    pcs[i] = ebp[1];     // saved %eip
8010438e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104391:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104394:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104397:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104399:	83 f8 0a             	cmp    $0xa,%eax
8010439c:	75 e2                	jne    80104380 <acquire+0x70>
}
8010439e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043a1:	c9                   	leave  
801043a2:	c3                   	ret    
801043a3:	90                   	nop
801043a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
801043a8:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
801043af:	83 c0 01             	add    $0x1,%eax
801043b2:	83 f8 0a             	cmp    $0xa,%eax
801043b5:	74 e7                	je     8010439e <acquire+0x8e>
    pcs[i] = 0;
801043b7:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
801043be:	83 c0 01             	add    $0x1,%eax
801043c1:	83 f8 0a             	cmp    $0xa,%eax
801043c4:	75 e2                	jne    801043a8 <acquire+0x98>
801043c6:	eb d6                	jmp    8010439e <acquire+0x8e>
    panic("acquire");
801043c8:	83 ec 0c             	sub    $0xc,%esp
801043cb:	68 83 7b 10 80       	push   $0x80107b83
801043d0:	e8 9b bf ff ff       	call   80100370 <panic>
801043d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801043e0 <getcallerpcs>:
{
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801043e4:	8b 45 08             	mov    0x8(%ebp),%eax
{
801043e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801043ea:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
801043ed:	31 c0                	xor    %eax,%eax
801043ef:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801043f0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801043f6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801043fc:	77 1a                	ja     80104418 <getcallerpcs+0x38>
    pcs[i] = ebp[1];     // saved %eip
801043fe:	8b 5a 04             	mov    0x4(%edx),%ebx
80104401:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104404:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104407:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104409:	83 f8 0a             	cmp    $0xa,%eax
8010440c:	75 e2                	jne    801043f0 <getcallerpcs+0x10>
}
8010440e:	5b                   	pop    %ebx
8010440f:	5d                   	pop    %ebp
80104410:	c3                   	ret    
80104411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
80104418:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
8010441f:	83 c0 01             	add    $0x1,%eax
80104422:	83 f8 0a             	cmp    $0xa,%eax
80104425:	74 e7                	je     8010440e <getcallerpcs+0x2e>
    pcs[i] = 0;
80104427:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
8010442e:	83 c0 01             	add    $0x1,%eax
80104431:	83 f8 0a             	cmp    $0xa,%eax
80104434:	75 e2                	jne    80104418 <getcallerpcs+0x38>
80104436:	eb d6                	jmp    8010440e <getcallerpcs+0x2e>
80104438:	90                   	nop
80104439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104440 <holding>:
{
80104440:	55                   	push   %ebp
80104441:	89 e5                	mov    %esp,%ebp
80104443:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu;
80104446:	8b 02                	mov    (%edx),%eax
80104448:	85 c0                	test   %eax,%eax
8010444a:	74 14                	je     80104460 <holding+0x20>
8010444c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104452:	39 42 08             	cmp    %eax,0x8(%edx)
}
80104455:	5d                   	pop    %ebp
  return lock->locked && lock->cpu == cpu;
80104456:	0f 94 c0             	sete   %al
80104459:	0f b6 c0             	movzbl %al,%eax
}
8010445c:	c3                   	ret    
8010445d:	8d 76 00             	lea    0x0(%esi),%esi
80104460:	31 c0                	xor    %eax,%eax
  return lock->locked && lock->cpu == cpu;
80104462:	0f b6 c0             	movzbl %al,%eax
}
80104465:	5d                   	pop    %ebp
80104466:	c3                   	ret    
80104467:	89 f6                	mov    %esi,%esi
80104469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104470 <pushcli>:
{
80104470:	55                   	push   %ebp
80104471:	89 e5                	mov    %esp,%ebp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104473:	9c                   	pushf  
80104474:	59                   	pop    %ecx
  asm volatile("cli");
80104475:	fa                   	cli    
  if(cpu->ncli == 0)
80104476:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010447d:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
80104483:	85 c0                	test   %eax,%eax
80104485:	75 0c                	jne    80104493 <pushcli+0x23>
    cpu->intena = eflags & FL_IF;
80104487:	81 e1 00 02 00 00    	and    $0x200,%ecx
8010448d:	89 8a b0 00 00 00    	mov    %ecx,0xb0(%edx)
  cpu->ncli += 1;
80104493:	83 c0 01             	add    $0x1,%eax
80104496:	89 82 ac 00 00 00    	mov    %eax,0xac(%edx)
}
8010449c:	5d                   	pop    %ebp
8010449d:	c3                   	ret    
8010449e:	66 90                	xchg   %ax,%ax

801044a0 <popcli>:

void
popcli(void)
{
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801044a6:	9c                   	pushf  
801044a7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801044a8:	f6 c4 02             	test   $0x2,%ah
801044ab:	75 2c                	jne    801044d9 <popcli+0x39>
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
801044ad:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801044b4:	83 aa ac 00 00 00 01 	subl   $0x1,0xac(%edx)
801044bb:	78 0f                	js     801044cc <popcli+0x2c>
    panic("popcli");
  if(cpu->ncli == 0 && cpu->intena)
801044bd:	75 0b                	jne    801044ca <popcli+0x2a>
801044bf:	8b 82 b0 00 00 00    	mov    0xb0(%edx),%eax
801044c5:	85 c0                	test   %eax,%eax
801044c7:	74 01                	je     801044ca <popcli+0x2a>
  asm volatile("sti");
801044c9:	fb                   	sti    
    sti();
}
801044ca:	c9                   	leave  
801044cb:	c3                   	ret    
    panic("popcli");
801044cc:	83 ec 0c             	sub    $0xc,%esp
801044cf:	68 a2 7b 10 80       	push   $0x80107ba2
801044d4:	e8 97 be ff ff       	call   80100370 <panic>
    panic("popcli - interruptible");
801044d9:	83 ec 0c             	sub    $0xc,%esp
801044dc:	68 8b 7b 10 80       	push   $0x80107b8b
801044e1:	e8 8a be ff ff       	call   80100370 <panic>
801044e6:	8d 76 00             	lea    0x0(%esi),%esi
801044e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044f0 <release>:
{
801044f0:	55                   	push   %ebp
801044f1:	89 e5                	mov    %esp,%ebp
801044f3:	83 ec 08             	sub    $0x8,%esp
801044f6:	8b 45 08             	mov    0x8(%ebp),%eax
  return lock->locked && lock->cpu == cpu;
801044f9:	8b 10                	mov    (%eax),%edx
801044fb:	85 d2                	test   %edx,%edx
801044fd:	74 0c                	je     8010450b <release+0x1b>
801044ff:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104506:	39 50 08             	cmp    %edx,0x8(%eax)
80104509:	74 15                	je     80104520 <release+0x30>
    panic("release");
8010450b:	83 ec 0c             	sub    $0xc,%esp
8010450e:	68 a9 7b 10 80       	push   $0x80107ba9
80104513:	e8 58 be ff ff       	call   80100370 <panic>
80104518:	90                   	nop
80104519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lk->pcs[0] = 0;
80104520:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104527:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  __sync_synchronize();
8010452e:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104533:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
80104539:	c9                   	leave  
  popcli();
8010453a:	e9 61 ff ff ff       	jmp    801044a0 <popcli>
8010453f:	90                   	nop

80104540 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	57                   	push   %edi
80104544:	53                   	push   %ebx
80104545:	8b 55 08             	mov    0x8(%ebp),%edx
80104548:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010454b:	f6 c2 03             	test   $0x3,%dl
8010454e:	75 05                	jne    80104555 <memset+0x15>
80104550:	f6 c1 03             	test   $0x3,%cl
80104553:	74 13                	je     80104568 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104555:	89 d7                	mov    %edx,%edi
80104557:	8b 45 0c             	mov    0xc(%ebp),%eax
8010455a:	fc                   	cld    
8010455b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010455d:	5b                   	pop    %ebx
8010455e:	89 d0                	mov    %edx,%eax
80104560:	5f                   	pop    %edi
80104561:	5d                   	pop    %ebp
80104562:	c3                   	ret    
80104563:	90                   	nop
80104564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104568:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010456c:	c1 e9 02             	shr    $0x2,%ecx
8010456f:	89 f8                	mov    %edi,%eax
80104571:	89 fb                	mov    %edi,%ebx
80104573:	c1 e0 18             	shl    $0x18,%eax
80104576:	c1 e3 10             	shl    $0x10,%ebx
80104579:	09 d8                	or     %ebx,%eax
8010457b:	09 f8                	or     %edi,%eax
8010457d:	c1 e7 08             	shl    $0x8,%edi
80104580:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104582:	89 d7                	mov    %edx,%edi
80104584:	fc                   	cld    
80104585:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104587:	5b                   	pop    %ebx
80104588:	89 d0                	mov    %edx,%eax
8010458a:	5f                   	pop    %edi
8010458b:	5d                   	pop    %ebp
8010458c:	c3                   	ret    
8010458d:	8d 76 00             	lea    0x0(%esi),%esi

80104590 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104590:	55                   	push   %ebp
80104591:	89 e5                	mov    %esp,%ebp
80104593:	57                   	push   %edi
80104594:	56                   	push   %esi
80104595:	53                   	push   %ebx
80104596:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104599:	8b 75 08             	mov    0x8(%ebp),%esi
8010459c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010459f:	85 db                	test   %ebx,%ebx
801045a1:	74 29                	je     801045cc <memcmp+0x3c>
    if(*s1 != *s2)
801045a3:	0f b6 16             	movzbl (%esi),%edx
801045a6:	0f b6 0f             	movzbl (%edi),%ecx
801045a9:	38 d1                	cmp    %dl,%cl
801045ab:	75 2b                	jne    801045d8 <memcmp+0x48>
801045ad:	b8 01 00 00 00       	mov    $0x1,%eax
801045b2:	eb 14                	jmp    801045c8 <memcmp+0x38>
801045b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045b8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
801045bc:	83 c0 01             	add    $0x1,%eax
801045bf:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
801045c4:	38 ca                	cmp    %cl,%dl
801045c6:	75 10                	jne    801045d8 <memcmp+0x48>
  while(n-- > 0){
801045c8:	39 d8                	cmp    %ebx,%eax
801045ca:	75 ec                	jne    801045b8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
801045cc:	5b                   	pop    %ebx
  return 0;
801045cd:	31 c0                	xor    %eax,%eax
}
801045cf:	5e                   	pop    %esi
801045d0:	5f                   	pop    %edi
801045d1:	5d                   	pop    %ebp
801045d2:	c3                   	ret    
801045d3:	90                   	nop
801045d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
801045d8:	0f b6 c2             	movzbl %dl,%eax
}
801045db:	5b                   	pop    %ebx
      return *s1 - *s2;
801045dc:	29 c8                	sub    %ecx,%eax
}
801045de:	5e                   	pop    %esi
801045df:	5f                   	pop    %edi
801045e0:	5d                   	pop    %ebp
801045e1:	c3                   	ret    
801045e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045f0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801045f0:	55                   	push   %ebp
801045f1:	89 e5                	mov    %esp,%ebp
801045f3:	56                   	push   %esi
801045f4:	53                   	push   %ebx
801045f5:	8b 45 08             	mov    0x8(%ebp),%eax
801045f8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801045fb:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801045fe:	39 c3                	cmp    %eax,%ebx
80104600:	73 26                	jae    80104628 <memmove+0x38>
80104602:	8d 14 33             	lea    (%ebx,%esi,1),%edx
80104605:	39 d0                	cmp    %edx,%eax
80104607:	73 1f                	jae    80104628 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104609:	85 f6                	test   %esi,%esi
8010460b:	8d 56 ff             	lea    -0x1(%esi),%edx
8010460e:	74 0f                	je     8010461f <memmove+0x2f>
      *--d = *--s;
80104610:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104614:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104617:	83 ea 01             	sub    $0x1,%edx
8010461a:	83 fa ff             	cmp    $0xffffffff,%edx
8010461d:	75 f1                	jne    80104610 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010461f:	5b                   	pop    %ebx
80104620:	5e                   	pop    %esi
80104621:	5d                   	pop    %ebp
80104622:	c3                   	ret    
80104623:	90                   	nop
80104624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104628:	31 d2                	xor    %edx,%edx
8010462a:	85 f6                	test   %esi,%esi
8010462c:	74 f1                	je     8010461f <memmove+0x2f>
8010462e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104630:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104634:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104637:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
8010463a:	39 f2                	cmp    %esi,%edx
8010463c:	75 f2                	jne    80104630 <memmove+0x40>
}
8010463e:	5b                   	pop    %ebx
8010463f:	5e                   	pop    %esi
80104640:	5d                   	pop    %ebp
80104641:	c3                   	ret    
80104642:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104650 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104653:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104654:	eb 9a                	jmp    801045f0 <memmove>
80104656:	8d 76 00             	lea    0x0(%esi),%esi
80104659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104660 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104660:	55                   	push   %ebp
80104661:	89 e5                	mov    %esp,%ebp
80104663:	57                   	push   %edi
80104664:	56                   	push   %esi
80104665:	8b 7d 10             	mov    0x10(%ebp),%edi
80104668:	53                   	push   %ebx
80104669:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010466c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010466f:	85 ff                	test   %edi,%edi
80104671:	74 2f                	je     801046a2 <strncmp+0x42>
80104673:	0f b6 11             	movzbl (%ecx),%edx
80104676:	0f b6 1e             	movzbl (%esi),%ebx
80104679:	84 d2                	test   %dl,%dl
8010467b:	74 37                	je     801046b4 <strncmp+0x54>
8010467d:	38 d3                	cmp    %dl,%bl
8010467f:	75 33                	jne    801046b4 <strncmp+0x54>
80104681:	01 f7                	add    %esi,%edi
80104683:	eb 13                	jmp    80104698 <strncmp+0x38>
80104685:	8d 76 00             	lea    0x0(%esi),%esi
80104688:	0f b6 11             	movzbl (%ecx),%edx
8010468b:	84 d2                	test   %dl,%dl
8010468d:	74 21                	je     801046b0 <strncmp+0x50>
8010468f:	0f b6 18             	movzbl (%eax),%ebx
80104692:	89 c6                	mov    %eax,%esi
80104694:	38 da                	cmp    %bl,%dl
80104696:	75 1c                	jne    801046b4 <strncmp+0x54>
    n--, p++, q++;
80104698:	8d 46 01             	lea    0x1(%esi),%eax
8010469b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
8010469e:	39 f8                	cmp    %edi,%eax
801046a0:	75 e6                	jne    80104688 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
801046a2:	5b                   	pop    %ebx
    return 0;
801046a3:	31 c0                	xor    %eax,%eax
}
801046a5:	5e                   	pop    %esi
801046a6:	5f                   	pop    %edi
801046a7:	5d                   	pop    %ebp
801046a8:	c3                   	ret    
801046a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046b0:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
801046b4:	0f b6 c2             	movzbl %dl,%eax
801046b7:	29 d8                	sub    %ebx,%eax
}
801046b9:	5b                   	pop    %ebx
801046ba:	5e                   	pop    %esi
801046bb:	5f                   	pop    %edi
801046bc:	5d                   	pop    %ebp
801046bd:	c3                   	ret    
801046be:	66 90                	xchg   %ax,%ax

801046c0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801046c0:	55                   	push   %ebp
801046c1:	89 e5                	mov    %esp,%ebp
801046c3:	56                   	push   %esi
801046c4:	53                   	push   %ebx
801046c5:	8b 45 08             	mov    0x8(%ebp),%eax
801046c8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801046cb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801046ce:	89 c2                	mov    %eax,%edx
801046d0:	eb 19                	jmp    801046eb <strncpy+0x2b>
801046d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046d8:	83 c3 01             	add    $0x1,%ebx
801046db:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
801046df:	83 c2 01             	add    $0x1,%edx
801046e2:	84 c9                	test   %cl,%cl
801046e4:	88 4a ff             	mov    %cl,-0x1(%edx)
801046e7:	74 09                	je     801046f2 <strncpy+0x32>
801046e9:	89 f1                	mov    %esi,%ecx
801046eb:	85 c9                	test   %ecx,%ecx
801046ed:	8d 71 ff             	lea    -0x1(%ecx),%esi
801046f0:	7f e6                	jg     801046d8 <strncpy+0x18>
    ;
  while(n-- > 0)
801046f2:	31 c9                	xor    %ecx,%ecx
801046f4:	85 f6                	test   %esi,%esi
801046f6:	7e 17                	jle    8010470f <strncpy+0x4f>
801046f8:	90                   	nop
801046f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104700:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104704:	89 f3                	mov    %esi,%ebx
80104706:	83 c1 01             	add    $0x1,%ecx
80104709:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
8010470b:	85 db                	test   %ebx,%ebx
8010470d:	7f f1                	jg     80104700 <strncpy+0x40>
  return os;
}
8010470f:	5b                   	pop    %ebx
80104710:	5e                   	pop    %esi
80104711:	5d                   	pop    %ebp
80104712:	c3                   	ret    
80104713:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104720 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	56                   	push   %esi
80104724:	53                   	push   %ebx
80104725:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104728:	8b 45 08             	mov    0x8(%ebp),%eax
8010472b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010472e:	85 c9                	test   %ecx,%ecx
80104730:	7e 26                	jle    80104758 <safestrcpy+0x38>
80104732:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104736:	89 c1                	mov    %eax,%ecx
80104738:	eb 17                	jmp    80104751 <safestrcpy+0x31>
8010473a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104740:	83 c2 01             	add    $0x1,%edx
80104743:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104747:	83 c1 01             	add    $0x1,%ecx
8010474a:	84 db                	test   %bl,%bl
8010474c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010474f:	74 04                	je     80104755 <safestrcpy+0x35>
80104751:	39 f2                	cmp    %esi,%edx
80104753:	75 eb                	jne    80104740 <safestrcpy+0x20>
    ;
  *s = 0;
80104755:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104758:	5b                   	pop    %ebx
80104759:	5e                   	pop    %esi
8010475a:	5d                   	pop    %ebp
8010475b:	c3                   	ret    
8010475c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104760 <strlen>:

int
strlen(const char *s)
{
80104760:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104761:	31 c0                	xor    %eax,%eax
{
80104763:	89 e5                	mov    %esp,%ebp
80104765:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104768:	80 3a 00             	cmpb   $0x0,(%edx)
8010476b:	74 0c                	je     80104779 <strlen+0x19>
8010476d:	8d 76 00             	lea    0x0(%esi),%esi
80104770:	83 c0 01             	add    $0x1,%eax
80104773:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104777:	75 f7                	jne    80104770 <strlen+0x10>
    ;
  return n;
}
80104779:	5d                   	pop    %ebp
8010477a:	c3                   	ret    

8010477b <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010477b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010477f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104783:	55                   	push   %ebp
  pushl %ebx
80104784:	53                   	push   %ebx
  pushl %esi
80104785:	56                   	push   %esi
  pushl %edi
80104786:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104787:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104789:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010478b:	5f                   	pop    %edi
  popl %esi
8010478c:	5e                   	pop    %esi
  popl %ebx
8010478d:	5b                   	pop    %ebx
  popl %ebp
8010478e:	5d                   	pop    %ebp
  ret
8010478f:	c3                   	ret    

80104790 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104790:	55                   	push   %ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
80104791:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
{
80104798:	89 e5                	mov    %esp,%ebp
8010479a:	8b 45 08             	mov    0x8(%ebp),%eax
  if(addr >= proc->sz || addr+4 > proc->sz)
8010479d:	8b 12                	mov    (%edx),%edx
8010479f:	39 c2                	cmp    %eax,%edx
801047a1:	76 15                	jbe    801047b8 <fetchint+0x28>
801047a3:	8d 48 04             	lea    0x4(%eax),%ecx
801047a6:	39 ca                	cmp    %ecx,%edx
801047a8:	72 0e                	jb     801047b8 <fetchint+0x28>
    return -1;
  *ip = *(int*)(addr);
801047aa:	8b 10                	mov    (%eax),%edx
801047ac:	8b 45 0c             	mov    0xc(%ebp),%eax
801047af:	89 10                	mov    %edx,(%eax)
  return 0;
801047b1:	31 c0                	xor    %eax,%eax
}
801047b3:	5d                   	pop    %ebp
801047b4:	c3                   	ret    
801047b5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801047b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801047bd:	5d                   	pop    %ebp
801047be:	c3                   	ret    
801047bf:	90                   	nop

801047c0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801047c0:	55                   	push   %ebp
  char *s, *ep;

  if(addr >= proc->sz)
801047c1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
801047c7:	89 e5                	mov    %esp,%ebp
801047c9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if(addr >= proc->sz)
801047cc:	39 08                	cmp    %ecx,(%eax)
801047ce:	76 2c                	jbe    801047fc <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
801047d0:	8b 55 0c             	mov    0xc(%ebp),%edx
801047d3:	89 c8                	mov    %ecx,%eax
801047d5:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
801047d7:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801047de:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
801047e0:	39 d1                	cmp    %edx,%ecx
801047e2:	73 18                	jae    801047fc <fetchstr+0x3c>
    if(*s == 0)
801047e4:	80 39 00             	cmpb   $0x0,(%ecx)
801047e7:	75 0c                	jne    801047f5 <fetchstr+0x35>
801047e9:	eb 1d                	jmp    80104808 <fetchstr+0x48>
801047eb:	90                   	nop
801047ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801047f0:	80 38 00             	cmpb   $0x0,(%eax)
801047f3:	74 13                	je     80104808 <fetchstr+0x48>
  for(s = *pp; s < ep; s++)
801047f5:	83 c0 01             	add    $0x1,%eax
801047f8:	39 c2                	cmp    %eax,%edx
801047fa:	77 f4                	ja     801047f0 <fetchstr+0x30>
    return -1;
801047fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  return -1;
}
80104801:	5d                   	pop    %ebp
80104802:	c3                   	ret    
80104803:	90                   	nop
80104804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return s - *pp;
80104808:	29 c8                	sub    %ecx,%eax
}
8010480a:	5d                   	pop    %ebp
8010480b:	c3                   	ret    
8010480c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104810 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104810:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
{
80104817:	55                   	push   %ebp
80104818:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
8010481a:	8b 42 18             	mov    0x18(%edx),%eax
8010481d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104820:	8b 12                	mov    (%edx),%edx
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104822:	8b 40 44             	mov    0x44(%eax),%eax
80104825:	8d 04 88             	lea    (%eax,%ecx,4),%eax
80104828:	8d 48 04             	lea    0x4(%eax),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
8010482b:	39 d1                	cmp    %edx,%ecx
8010482d:	73 19                	jae    80104848 <argint+0x38>
8010482f:	8d 48 08             	lea    0x8(%eax),%ecx
80104832:	39 ca                	cmp    %ecx,%edx
80104834:	72 12                	jb     80104848 <argint+0x38>
  *ip = *(int*)(addr);
80104836:	8b 50 04             	mov    0x4(%eax),%edx
80104839:	8b 45 0c             	mov    0xc(%ebp),%eax
8010483c:	89 10                	mov    %edx,(%eax)
  return 0;
8010483e:	31 c0                	xor    %eax,%eax
}
80104840:	5d                   	pop    %ebp
80104841:	c3                   	ret    
80104842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104848:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010484d:	5d                   	pop    %ebp
8010484e:	c3                   	ret    
8010484f:	90                   	nop

80104850 <argptr>:
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104850:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104856:	55                   	push   %ebp
80104857:	89 e5                	mov    %esp,%ebp
80104859:	56                   	push   %esi
8010485a:	53                   	push   %ebx
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
8010485b:	8b 48 18             	mov    0x18(%eax),%ecx
8010485e:	8b 5d 08             	mov    0x8(%ebp),%ebx
{
80104861:	8b 55 10             	mov    0x10(%ebp),%edx
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104864:	8b 49 44             	mov    0x44(%ecx),%ecx
80104867:	8d 1c 99             	lea    (%ecx,%ebx,4),%ebx
  if(addr >= proc->sz || addr+4 > proc->sz)
8010486a:	8b 08                	mov    (%eax),%ecx
  int i;

  if(argint(n, &i) < 0)
    return -1;
8010486c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104871:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= proc->sz || addr+4 > proc->sz)
80104874:	39 ce                	cmp    %ecx,%esi
80104876:	73 1f                	jae    80104897 <argptr+0x47>
80104878:	8d 73 08             	lea    0x8(%ebx),%esi
8010487b:	39 f1                	cmp    %esi,%ecx
8010487d:	72 18                	jb     80104897 <argptr+0x47>
  if(size < 0 || (uint)i >= proc->sz || (uint)i+size > proc->sz)
8010487f:	85 d2                	test   %edx,%edx
  *ip = *(int*)(addr);
80104881:	8b 5b 04             	mov    0x4(%ebx),%ebx
  if(size < 0 || (uint)i >= proc->sz || (uint)i+size > proc->sz)
80104884:	78 11                	js     80104897 <argptr+0x47>
80104886:	39 cb                	cmp    %ecx,%ebx
80104888:	73 0d                	jae    80104897 <argptr+0x47>
8010488a:	01 da                	add    %ebx,%edx
8010488c:	39 ca                	cmp    %ecx,%edx
8010488e:	77 07                	ja     80104897 <argptr+0x47>
    return -1;
  *pp = (char*)i;
80104890:	8b 45 0c             	mov    0xc(%ebp),%eax
80104893:	89 18                	mov    %ebx,(%eax)
  return 0;
80104895:	31 c0                	xor    %eax,%eax
}
80104897:	5b                   	pop    %ebx
80104898:	5e                   	pop    %esi
80104899:	5d                   	pop    %ebp
8010489a:	c3                   	ret    
8010489b:	90                   	nop
8010489c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801048a0 <argstr>:
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801048a0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801048a6:	55                   	push   %ebp
801048a7:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801048a9:	8b 50 18             	mov    0x18(%eax),%edx
801048ac:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
801048af:	8b 00                	mov    (%eax),%eax
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801048b1:	8b 52 44             	mov    0x44(%edx),%edx
801048b4:	8d 14 8a             	lea    (%edx,%ecx,4),%edx
801048b7:	8d 4a 04             	lea    0x4(%edx),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
801048ba:	39 c1                	cmp    %eax,%ecx
801048bc:	73 3e                	jae    801048fc <argstr+0x5c>
801048be:	8d 4a 08             	lea    0x8(%edx),%ecx
801048c1:	39 c8                	cmp    %ecx,%eax
801048c3:	72 37                	jb     801048fc <argstr+0x5c>
  *ip = *(int*)(addr);
801048c5:	8b 4a 04             	mov    0x4(%edx),%ecx
  if(addr >= proc->sz)
801048c8:	39 c1                	cmp    %eax,%ecx
801048ca:	73 30                	jae    801048fc <argstr+0x5c>
  *pp = (char*)addr;
801048cc:	8b 55 0c             	mov    0xc(%ebp),%edx
801048cf:	89 c8                	mov    %ecx,%eax
801048d1:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
801048d3:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801048da:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
801048dc:	39 d1                	cmp    %edx,%ecx
801048de:	73 1c                	jae    801048fc <argstr+0x5c>
    if(*s == 0)
801048e0:	80 39 00             	cmpb   $0x0,(%ecx)
801048e3:	75 10                	jne    801048f5 <argstr+0x55>
801048e5:	eb 21                	jmp    80104908 <argstr+0x68>
801048e7:	89 f6                	mov    %esi,%esi
801048e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801048f0:	80 38 00             	cmpb   $0x0,(%eax)
801048f3:	74 13                	je     80104908 <argstr+0x68>
  for(s = *pp; s < ep; s++)
801048f5:	83 c0 01             	add    $0x1,%eax
801048f8:	39 c2                	cmp    %eax,%edx
801048fa:	77 f4                	ja     801048f0 <argstr+0x50>
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
801048fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80104901:	5d                   	pop    %ebp
80104902:	c3                   	ret    
80104903:	90                   	nop
80104904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return s - *pp;
80104908:	29 c8                	sub    %ecx,%eax
}
8010490a:	5d                   	pop    %ebp
8010490b:	c3                   	ret    
8010490c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104910 <syscall>:
[SYS_shm_jared]  sys_shm_jared,
};

void
syscall(void)
{
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	53                   	push   %ebx
80104914:	83 ec 04             	sub    $0x4,%esp
  int num;

  num = proc->tf->eax;
80104917:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010491e:	8b 5a 18             	mov    0x18(%edx),%ebx
80104921:	8b 43 1c             	mov    0x1c(%ebx),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104924:	8d 48 ff             	lea    -0x1(%eax),%ecx
80104927:	83 f9 17             	cmp    $0x17,%ecx
8010492a:	77 1c                	ja     80104948 <syscall+0x38>
8010492c:	8b 0c 85 e0 7b 10 80 	mov    -0x7fef8420(,%eax,4),%ecx
80104933:	85 c9                	test   %ecx,%ecx
80104935:	74 11                	je     80104948 <syscall+0x38>
    proc->tf->eax = syscalls[num]();
80104937:	ff d1                	call   *%ecx
80104939:	89 43 1c             	mov    %eax,0x1c(%ebx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  }
}
8010493c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010493f:	c9                   	leave  
80104940:	c3                   	ret    
80104941:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104948:	50                   	push   %eax
            proc->pid, proc->name, num);
80104949:	8d 42 6c             	lea    0x6c(%edx),%eax
    cprintf("%d %s: unknown sys call %d\n",
8010494c:	50                   	push   %eax
8010494d:	ff 72 10             	pushl  0x10(%edx)
80104950:	68 b1 7b 10 80       	push   $0x80107bb1
80104955:	e8 06 bd ff ff       	call   80100660 <cprintf>
    proc->tf->eax = -1;
8010495a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104960:	83 c4 10             	add    $0x10,%esp
80104963:	8b 40 18             	mov    0x18(%eax),%eax
80104966:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
8010496d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104970:	c9                   	leave  
80104971:	c3                   	ret    
80104972:	66 90                	xchg   %ax,%ax
80104974:	66 90                	xchg   %ax,%ax
80104976:	66 90                	xchg   %ax,%ax
80104978:	66 90                	xchg   %ax,%ax
8010497a:	66 90                	xchg   %ax,%ax
8010497c:	66 90                	xchg   %ax,%ax
8010497e:	66 90                	xchg   %ax,%ax

80104980 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104980:	55                   	push   %ebp
80104981:	89 e5                	mov    %esp,%ebp
80104983:	57                   	push   %edi
80104984:	56                   	push   %esi
80104985:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104986:	8d 5d da             	lea    -0x26(%ebp),%ebx
{
80104989:	83 ec 44             	sub    $0x44,%esp
8010498c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
8010498f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104992:	53                   	push   %ebx
80104993:	50                   	push   %eax
{
80104994:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104997:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010499a:	e8 11 d5 ff ff       	call   80101eb0 <nameiparent>
8010499f:	83 c4 10             	add    $0x10,%esp
801049a2:	85 c0                	test   %eax,%eax
801049a4:	0f 84 f6 00 00 00    	je     80104aa0 <create+0x120>
    return 0;
  ilock(dp);
801049aa:	83 ec 0c             	sub    $0xc,%esp
801049ad:	89 c6                	mov    %eax,%esi
801049af:	50                   	push   %eax
801049b0:	e8 ab cc ff ff       	call   80101660 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
801049b5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801049b8:	83 c4 0c             	add    $0xc,%esp
801049bb:	50                   	push   %eax
801049bc:	53                   	push   %ebx
801049bd:	56                   	push   %esi
801049be:	e8 ad d1 ff ff       	call   80101b70 <dirlookup>
801049c3:	83 c4 10             	add    $0x10,%esp
801049c6:	85 c0                	test   %eax,%eax
801049c8:	89 c7                	mov    %eax,%edi
801049ca:	74 54                	je     80104a20 <create+0xa0>
    iunlockput(dp);
801049cc:	83 ec 0c             	sub    $0xc,%esp
801049cf:	56                   	push   %esi
801049d0:	e8 fb ce ff ff       	call   801018d0 <iunlockput>
    ilock(ip);
801049d5:	89 3c 24             	mov    %edi,(%esp)
801049d8:	e8 83 cc ff ff       	call   80101660 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801049dd:	83 c4 10             	add    $0x10,%esp
801049e0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
801049e5:	75 19                	jne    80104a00 <create+0x80>
801049e7:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
801049ec:	75 12                	jne    80104a00 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801049ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
801049f1:	89 f8                	mov    %edi,%eax
801049f3:	5b                   	pop    %ebx
801049f4:	5e                   	pop    %esi
801049f5:	5f                   	pop    %edi
801049f6:	5d                   	pop    %ebp
801049f7:	c3                   	ret    
801049f8:	90                   	nop
801049f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80104a00:	83 ec 0c             	sub    $0xc,%esp
80104a03:	57                   	push   %edi
    return 0;
80104a04:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104a06:	e8 c5 ce ff ff       	call   801018d0 <iunlockput>
    return 0;
80104a0b:	83 c4 10             	add    $0x10,%esp
}
80104a0e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a11:	89 f8                	mov    %edi,%eax
80104a13:	5b                   	pop    %ebx
80104a14:	5e                   	pop    %esi
80104a15:	5f                   	pop    %edi
80104a16:	5d                   	pop    %ebp
80104a17:	c3                   	ret    
80104a18:	90                   	nop
80104a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = ialloc(dp->dev, type)) == 0)
80104a20:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104a24:	83 ec 08             	sub    $0x8,%esp
80104a27:	50                   	push   %eax
80104a28:	ff 36                	pushl  (%esi)
80104a2a:	e8 c1 ca ff ff       	call   801014f0 <ialloc>
80104a2f:	83 c4 10             	add    $0x10,%esp
80104a32:	85 c0                	test   %eax,%eax
80104a34:	89 c7                	mov    %eax,%edi
80104a36:	0f 84 cc 00 00 00    	je     80104b08 <create+0x188>
  ilock(ip);
80104a3c:	83 ec 0c             	sub    $0xc,%esp
80104a3f:	50                   	push   %eax
80104a40:	e8 1b cc ff ff       	call   80101660 <ilock>
  ip->major = major;
80104a45:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104a49:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104a4d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104a51:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104a55:	b8 01 00 00 00       	mov    $0x1,%eax
80104a5a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104a5e:	89 3c 24             	mov    %edi,(%esp)
80104a61:	e8 4a cb ff ff       	call   801015b0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104a66:	83 c4 10             	add    $0x10,%esp
80104a69:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104a6e:	74 40                	je     80104ab0 <create+0x130>
  if(dirlink(dp, name, ip->inum) < 0)
80104a70:	83 ec 04             	sub    $0x4,%esp
80104a73:	ff 77 04             	pushl  0x4(%edi)
80104a76:	53                   	push   %ebx
80104a77:	56                   	push   %esi
80104a78:	e8 53 d3 ff ff       	call   80101dd0 <dirlink>
80104a7d:	83 c4 10             	add    $0x10,%esp
80104a80:	85 c0                	test   %eax,%eax
80104a82:	78 77                	js     80104afb <create+0x17b>
  iunlockput(dp);
80104a84:	83 ec 0c             	sub    $0xc,%esp
80104a87:	56                   	push   %esi
80104a88:	e8 43 ce ff ff       	call   801018d0 <iunlockput>
  return ip;
80104a8d:	83 c4 10             	add    $0x10,%esp
}
80104a90:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a93:	89 f8                	mov    %edi,%eax
80104a95:	5b                   	pop    %ebx
80104a96:	5e                   	pop    %esi
80104a97:	5f                   	pop    %edi
80104a98:	5d                   	pop    %ebp
80104a99:	c3                   	ret    
80104a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return 0;
80104aa0:	31 ff                	xor    %edi,%edi
80104aa2:	e9 47 ff ff ff       	jmp    801049ee <create+0x6e>
80104aa7:	89 f6                	mov    %esi,%esi
80104aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    dp->nlink++;  // for ".."
80104ab0:	66 83 46 56 01       	addw   $0x1,0x56(%esi)
    iupdate(dp);
80104ab5:	83 ec 0c             	sub    $0xc,%esp
80104ab8:	56                   	push   %esi
80104ab9:	e8 f2 ca ff ff       	call   801015b0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104abe:	83 c4 0c             	add    $0xc,%esp
80104ac1:	ff 77 04             	pushl  0x4(%edi)
80104ac4:	68 60 7c 10 80       	push   $0x80107c60
80104ac9:	57                   	push   %edi
80104aca:	e8 01 d3 ff ff       	call   80101dd0 <dirlink>
80104acf:	83 c4 10             	add    $0x10,%esp
80104ad2:	85 c0                	test   %eax,%eax
80104ad4:	78 18                	js     80104aee <create+0x16e>
80104ad6:	83 ec 04             	sub    $0x4,%esp
80104ad9:	ff 76 04             	pushl  0x4(%esi)
80104adc:	68 5f 7c 10 80       	push   $0x80107c5f
80104ae1:	57                   	push   %edi
80104ae2:	e8 e9 d2 ff ff       	call   80101dd0 <dirlink>
80104ae7:	83 c4 10             	add    $0x10,%esp
80104aea:	85 c0                	test   %eax,%eax
80104aec:	79 82                	jns    80104a70 <create+0xf0>
      panic("create dots");
80104aee:	83 ec 0c             	sub    $0xc,%esp
80104af1:	68 53 7c 10 80       	push   $0x80107c53
80104af6:	e8 75 b8 ff ff       	call   80100370 <panic>
    panic("create: dirlink");
80104afb:	83 ec 0c             	sub    $0xc,%esp
80104afe:	68 62 7c 10 80       	push   $0x80107c62
80104b03:	e8 68 b8 ff ff       	call   80100370 <panic>
    panic("create: ialloc");
80104b08:	83 ec 0c             	sub    $0xc,%esp
80104b0b:	68 44 7c 10 80       	push   $0x80107c44
80104b10:	e8 5b b8 ff ff       	call   80100370 <panic>
80104b15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b20 <argfd.constprop.1>:
argfd(int n, int *pfd, struct file **pf)
80104b20:	55                   	push   %ebp
80104b21:	89 e5                	mov    %esp,%ebp
80104b23:	56                   	push   %esi
80104b24:	53                   	push   %ebx
80104b25:	89 c6                	mov    %eax,%esi
  if(argint(n, &fd) < 0)
80104b27:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104b2a:	89 d3                	mov    %edx,%ebx
80104b2c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104b2f:	50                   	push   %eax
80104b30:	6a 00                	push   $0x0
80104b32:	e8 d9 fc ff ff       	call   80104810 <argint>
80104b37:	83 c4 10             	add    $0x10,%esp
80104b3a:	85 c0                	test   %eax,%eax
80104b3c:	78 3a                	js     80104b78 <argfd.constprop.1+0x58>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80104b3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b41:	83 f8 0f             	cmp    $0xf,%eax
80104b44:	77 32                	ja     80104b78 <argfd.constprop.1+0x58>
80104b46:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104b4d:	8b 54 82 28          	mov    0x28(%edx,%eax,4),%edx
80104b51:	85 d2                	test   %edx,%edx
80104b53:	74 23                	je     80104b78 <argfd.constprop.1+0x58>
  if(pfd)
80104b55:	85 f6                	test   %esi,%esi
80104b57:	74 02                	je     80104b5b <argfd.constprop.1+0x3b>
    *pfd = fd;
80104b59:	89 06                	mov    %eax,(%esi)
  if(pf)
80104b5b:	85 db                	test   %ebx,%ebx
80104b5d:	74 11                	je     80104b70 <argfd.constprop.1+0x50>
    *pf = f;
80104b5f:	89 13                	mov    %edx,(%ebx)
  return 0;
80104b61:	31 c0                	xor    %eax,%eax
}
80104b63:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b66:	5b                   	pop    %ebx
80104b67:	5e                   	pop    %esi
80104b68:	5d                   	pop    %ebp
80104b69:	c3                   	ret    
80104b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return 0;
80104b70:	31 c0                	xor    %eax,%eax
80104b72:	eb ef                	jmp    80104b63 <argfd.constprop.1+0x43>
80104b74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104b78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b7d:	eb e4                	jmp    80104b63 <argfd.constprop.1+0x43>
80104b7f:	90                   	nop

80104b80 <sys_dup>:
{
80104b80:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104b81:	31 c0                	xor    %eax,%eax
{
80104b83:	89 e5                	mov    %esp,%ebp
80104b85:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104b86:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104b89:	83 ec 14             	sub    $0x14,%esp
  if(argfd(0, 0, &f) < 0)
80104b8c:	e8 8f ff ff ff       	call   80104b20 <argfd.constprop.1>
80104b91:	85 c0                	test   %eax,%eax
80104b93:	78 1b                	js     80104bb0 <sys_dup+0x30>
  if((fd=fdalloc(f)) < 0)
80104b95:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104b98:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  for(fd = 0; fd < NOFILE; fd++){
80104b9e:	31 db                	xor    %ebx,%ebx
    if(proc->ofile[fd] == 0){
80104ba0:	8b 4c 98 28          	mov    0x28(%eax,%ebx,4),%ecx
80104ba4:	85 c9                	test   %ecx,%ecx
80104ba6:	74 18                	je     80104bc0 <sys_dup+0x40>
  for(fd = 0; fd < NOFILE; fd++){
80104ba8:	83 c3 01             	add    $0x1,%ebx
80104bab:	83 fb 10             	cmp    $0x10,%ebx
80104bae:	75 f0                	jne    80104ba0 <sys_dup+0x20>
    return -1;
80104bb0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104bb5:	89 d8                	mov    %ebx,%eax
80104bb7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104bba:	c9                   	leave  
80104bbb:	c3                   	ret    
80104bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  filedup(f);
80104bc0:	83 ec 0c             	sub    $0xc,%esp
      proc->ofile[fd] = f;
80104bc3:	89 54 98 28          	mov    %edx,0x28(%eax,%ebx,4)
  filedup(f);
80104bc7:	52                   	push   %edx
80104bc8:	e8 f3 c1 ff ff       	call   80100dc0 <filedup>
}
80104bcd:	89 d8                	mov    %ebx,%eax
  return fd;
80104bcf:	83 c4 10             	add    $0x10,%esp
}
80104bd2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104bd5:	c9                   	leave  
80104bd6:	c3                   	ret    
80104bd7:	89 f6                	mov    %esi,%esi
80104bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104be0 <sys_dup2>:
sys_dup2(void) {
80104be0:	55                   	push   %ebp
	if(argfd(0, 0, &f) < 0)
80104be1:	31 c0                	xor    %eax,%eax
sys_dup2(void) {
80104be3:	89 e5                	mov    %esp,%ebp
80104be5:	83 ec 18             	sub    $0x18,%esp
	if(argfd(0, 0, &f) < 0)
80104be8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104beb:	e8 30 ff ff ff       	call   80104b20 <argfd.constprop.1>
80104bf0:	85 c0                	test   %eax,%eax
80104bf2:	78 5c                	js     80104c50 <sys_dup2+0x70>
	if(argint(1, &fd) < 0)
80104bf4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104bf7:	83 ec 08             	sub    $0x8,%esp
80104bfa:	50                   	push   %eax
80104bfb:	6a 01                	push   $0x1
80104bfd:	e8 0e fc ff ff       	call   80104810 <argint>
80104c02:	83 c4 10             	add    $0x10,%esp
80104c05:	85 c0                	test   %eax,%eax
80104c07:	78 47                	js     80104c50 <sys_dup2+0x70>
	if(fd < 0 || fd >= NOFILE)
80104c09:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c0c:	83 f8 0f             	cmp    $0xf,%eax
80104c0f:	77 3f                	ja     80104c50 <sys_dup2+0x70>
	if(proc->ofile[fd])
80104c11:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104c18:	8b 44 82 28          	mov    0x28(%edx,%eax,4),%eax
80104c1c:	85 c0                	test   %eax,%eax
80104c1e:	74 0c                	je     80104c2c <sys_dup2+0x4c>
		fileclose(proc->ofile[fd]);
80104c20:	83 ec 0c             	sub    $0xc,%esp
80104c23:	50                   	push   %eax
80104c24:	e8 e7 c1 ff ff       	call   80100e10 <fileclose>
80104c29:	83 c4 10             	add    $0x10,%esp
	filedup(f);
80104c2c:	83 ec 0c             	sub    $0xc,%esp
80104c2f:	ff 75 f0             	pushl  -0x10(%ebp)
80104c32:	e8 89 c1 ff ff       	call   80100dc0 <filedup>
	proc->ofile[fd] = f;
80104c37:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c3d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
	return 0;
80104c40:	83 c4 10             	add    $0x10,%esp
	proc->ofile[fd] = f;
80104c43:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c46:	89 4c 90 28          	mov    %ecx,0x28(%eax,%edx,4)
	return 0;
80104c4a:	31 c0                	xor    %eax,%eax
}
80104c4c:	c9                   	leave  
80104c4d:	c3                   	ret    
80104c4e:	66 90                	xchg   %ax,%ax
		return -1;
80104c50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c55:	c9                   	leave  
80104c56:	c3                   	ret    
80104c57:	89 f6                	mov    %esi,%esi
80104c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c60 <sys_read>:
{
80104c60:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c61:	31 c0                	xor    %eax,%eax
{
80104c63:	89 e5                	mov    %esp,%ebp
80104c65:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c68:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104c6b:	e8 b0 fe ff ff       	call   80104b20 <argfd.constprop.1>
80104c70:	85 c0                	test   %eax,%eax
80104c72:	78 4c                	js     80104cc0 <sys_read+0x60>
80104c74:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104c77:	83 ec 08             	sub    $0x8,%esp
80104c7a:	50                   	push   %eax
80104c7b:	6a 02                	push   $0x2
80104c7d:	e8 8e fb ff ff       	call   80104810 <argint>
80104c82:	83 c4 10             	add    $0x10,%esp
80104c85:	85 c0                	test   %eax,%eax
80104c87:	78 37                	js     80104cc0 <sys_read+0x60>
80104c89:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c8c:	83 ec 04             	sub    $0x4,%esp
80104c8f:	ff 75 f0             	pushl  -0x10(%ebp)
80104c92:	50                   	push   %eax
80104c93:	6a 01                	push   $0x1
80104c95:	e8 b6 fb ff ff       	call   80104850 <argptr>
80104c9a:	83 c4 10             	add    $0x10,%esp
80104c9d:	85 c0                	test   %eax,%eax
80104c9f:	78 1f                	js     80104cc0 <sys_read+0x60>
  return fileread(f, p, n);
80104ca1:	83 ec 04             	sub    $0x4,%esp
80104ca4:	ff 75 f0             	pushl  -0x10(%ebp)
80104ca7:	ff 75 f4             	pushl  -0xc(%ebp)
80104caa:	ff 75 ec             	pushl  -0x14(%ebp)
80104cad:	e8 7e c2 ff ff       	call   80100f30 <fileread>
80104cb2:	83 c4 10             	add    $0x10,%esp
}
80104cb5:	c9                   	leave  
80104cb6:	c3                   	ret    
80104cb7:	89 f6                	mov    %esi,%esi
80104cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104cc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104cc5:	c9                   	leave  
80104cc6:	c3                   	ret    
80104cc7:	89 f6                	mov    %esi,%esi
80104cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104cd0 <sys_write>:
{
80104cd0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104cd1:	31 c0                	xor    %eax,%eax
{
80104cd3:	89 e5                	mov    %esp,%ebp
80104cd5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104cd8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104cdb:	e8 40 fe ff ff       	call   80104b20 <argfd.constprop.1>
80104ce0:	85 c0                	test   %eax,%eax
80104ce2:	78 4c                	js     80104d30 <sys_write+0x60>
80104ce4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104ce7:	83 ec 08             	sub    $0x8,%esp
80104cea:	50                   	push   %eax
80104ceb:	6a 02                	push   $0x2
80104ced:	e8 1e fb ff ff       	call   80104810 <argint>
80104cf2:	83 c4 10             	add    $0x10,%esp
80104cf5:	85 c0                	test   %eax,%eax
80104cf7:	78 37                	js     80104d30 <sys_write+0x60>
80104cf9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104cfc:	83 ec 04             	sub    $0x4,%esp
80104cff:	ff 75 f0             	pushl  -0x10(%ebp)
80104d02:	50                   	push   %eax
80104d03:	6a 01                	push   $0x1
80104d05:	e8 46 fb ff ff       	call   80104850 <argptr>
80104d0a:	83 c4 10             	add    $0x10,%esp
80104d0d:	85 c0                	test   %eax,%eax
80104d0f:	78 1f                	js     80104d30 <sys_write+0x60>
  return filewrite(f, p, n);
80104d11:	83 ec 04             	sub    $0x4,%esp
80104d14:	ff 75 f0             	pushl  -0x10(%ebp)
80104d17:	ff 75 f4             	pushl  -0xc(%ebp)
80104d1a:	ff 75 ec             	pushl  -0x14(%ebp)
80104d1d:	e8 9e c2 ff ff       	call   80100fc0 <filewrite>
80104d22:	83 c4 10             	add    $0x10,%esp
}
80104d25:	c9                   	leave  
80104d26:	c3                   	ret    
80104d27:	89 f6                	mov    %esi,%esi
80104d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104d30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d35:	c9                   	leave  
80104d36:	c3                   	ret    
80104d37:	89 f6                	mov    %esi,%esi
80104d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d40 <sys_close>:
{
80104d40:	55                   	push   %ebp
80104d41:	89 e5                	mov    %esp,%ebp
80104d43:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104d46:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104d49:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d4c:	e8 cf fd ff ff       	call   80104b20 <argfd.constprop.1>
80104d51:	85 c0                	test   %eax,%eax
80104d53:	78 2b                	js     80104d80 <sys_close+0x40>
  proc->ofile[fd] = 0;
80104d55:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104d58:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  fileclose(f);
80104d5e:	83 ec 0c             	sub    $0xc,%esp
  proc->ofile[fd] = 0;
80104d61:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104d68:	00 
  fileclose(f);
80104d69:	ff 75 f4             	pushl  -0xc(%ebp)
80104d6c:	e8 9f c0 ff ff       	call   80100e10 <fileclose>
  return 0;
80104d71:	83 c4 10             	add    $0x10,%esp
80104d74:	31 c0                	xor    %eax,%eax
}
80104d76:	c9                   	leave  
80104d77:	c3                   	ret    
80104d78:	90                   	nop
80104d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104d80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d85:	c9                   	leave  
80104d86:	c3                   	ret    
80104d87:	89 f6                	mov    %esi,%esi
80104d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d90 <sys_fstat>:
{
80104d90:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104d91:	31 c0                	xor    %eax,%eax
{
80104d93:	89 e5                	mov    %esp,%ebp
80104d95:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104d98:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104d9b:	e8 80 fd ff ff       	call   80104b20 <argfd.constprop.1>
80104da0:	85 c0                	test   %eax,%eax
80104da2:	78 2c                	js     80104dd0 <sys_fstat+0x40>
80104da4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104da7:	83 ec 04             	sub    $0x4,%esp
80104daa:	6a 14                	push   $0x14
80104dac:	50                   	push   %eax
80104dad:	6a 01                	push   $0x1
80104daf:	e8 9c fa ff ff       	call   80104850 <argptr>
80104db4:	83 c4 10             	add    $0x10,%esp
80104db7:	85 c0                	test   %eax,%eax
80104db9:	78 15                	js     80104dd0 <sys_fstat+0x40>
  return filestat(f, st);
80104dbb:	83 ec 08             	sub    $0x8,%esp
80104dbe:	ff 75 f4             	pushl  -0xc(%ebp)
80104dc1:	ff 75 f0             	pushl  -0x10(%ebp)
80104dc4:	e8 17 c1 ff ff       	call   80100ee0 <filestat>
80104dc9:	83 c4 10             	add    $0x10,%esp
}
80104dcc:	c9                   	leave  
80104dcd:	c3                   	ret    
80104dce:	66 90                	xchg   %ax,%ax
    return -1;
80104dd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104dd5:	c9                   	leave  
80104dd6:	c3                   	ret    
80104dd7:	89 f6                	mov    %esi,%esi
80104dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104de0 <sys_link>:
{
80104de0:	55                   	push   %ebp
80104de1:	89 e5                	mov    %esp,%ebp
80104de3:	57                   	push   %edi
80104de4:	56                   	push   %esi
80104de5:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104de6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104de9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104dec:	50                   	push   %eax
80104ded:	6a 00                	push   $0x0
80104def:	e8 ac fa ff ff       	call   801048a0 <argstr>
80104df4:	83 c4 10             	add    $0x10,%esp
80104df7:	85 c0                	test   %eax,%eax
80104df9:	0f 88 fb 00 00 00    	js     80104efa <sys_link+0x11a>
80104dff:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104e02:	83 ec 08             	sub    $0x8,%esp
80104e05:	50                   	push   %eax
80104e06:	6a 01                	push   $0x1
80104e08:	e8 93 fa ff ff       	call   801048a0 <argstr>
80104e0d:	83 c4 10             	add    $0x10,%esp
80104e10:	85 c0                	test   %eax,%eax
80104e12:	0f 88 e2 00 00 00    	js     80104efa <sys_link+0x11a>
  begin_op();
80104e18:	e8 c3 dd ff ff       	call   80102be0 <begin_op>
  if((ip = namei(old)) == 0){
80104e1d:	83 ec 0c             	sub    $0xc,%esp
80104e20:	ff 75 d4             	pushl  -0x2c(%ebp)
80104e23:	e8 68 d0 ff ff       	call   80101e90 <namei>
80104e28:	83 c4 10             	add    $0x10,%esp
80104e2b:	85 c0                	test   %eax,%eax
80104e2d:	89 c3                	mov    %eax,%ebx
80104e2f:	0f 84 f3 00 00 00    	je     80104f28 <sys_link+0x148>
  ilock(ip);
80104e35:	83 ec 0c             	sub    $0xc,%esp
80104e38:	50                   	push   %eax
80104e39:	e8 22 c8 ff ff       	call   80101660 <ilock>
  if(ip->type == T_DIR){
80104e3e:	83 c4 10             	add    $0x10,%esp
80104e41:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104e46:	0f 84 c4 00 00 00    	je     80104f10 <sys_link+0x130>
  ip->nlink++;
80104e4c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104e51:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80104e54:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104e57:	53                   	push   %ebx
80104e58:	e8 53 c7 ff ff       	call   801015b0 <iupdate>
  iunlock(ip);
80104e5d:	89 1c 24             	mov    %ebx,(%esp)
80104e60:	e8 db c8 ff ff       	call   80101740 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104e65:	58                   	pop    %eax
80104e66:	5a                   	pop    %edx
80104e67:	57                   	push   %edi
80104e68:	ff 75 d0             	pushl  -0x30(%ebp)
80104e6b:	e8 40 d0 ff ff       	call   80101eb0 <nameiparent>
80104e70:	83 c4 10             	add    $0x10,%esp
80104e73:	85 c0                	test   %eax,%eax
80104e75:	89 c6                	mov    %eax,%esi
80104e77:	74 5b                	je     80104ed4 <sys_link+0xf4>
  ilock(dp);
80104e79:	83 ec 0c             	sub    $0xc,%esp
80104e7c:	50                   	push   %eax
80104e7d:	e8 de c7 ff ff       	call   80101660 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104e82:	83 c4 10             	add    $0x10,%esp
80104e85:	8b 03                	mov    (%ebx),%eax
80104e87:	39 06                	cmp    %eax,(%esi)
80104e89:	75 3d                	jne    80104ec8 <sys_link+0xe8>
80104e8b:	83 ec 04             	sub    $0x4,%esp
80104e8e:	ff 73 04             	pushl  0x4(%ebx)
80104e91:	57                   	push   %edi
80104e92:	56                   	push   %esi
80104e93:	e8 38 cf ff ff       	call   80101dd0 <dirlink>
80104e98:	83 c4 10             	add    $0x10,%esp
80104e9b:	85 c0                	test   %eax,%eax
80104e9d:	78 29                	js     80104ec8 <sys_link+0xe8>
  iunlockput(dp);
80104e9f:	83 ec 0c             	sub    $0xc,%esp
80104ea2:	56                   	push   %esi
80104ea3:	e8 28 ca ff ff       	call   801018d0 <iunlockput>
  iput(ip);
80104ea8:	89 1c 24             	mov    %ebx,(%esp)
80104eab:	e8 e0 c8 ff ff       	call   80101790 <iput>
  end_op();
80104eb0:	e8 9b dd ff ff       	call   80102c50 <end_op>
  return 0;
80104eb5:	83 c4 10             	add    $0x10,%esp
80104eb8:	31 c0                	xor    %eax,%eax
}
80104eba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ebd:	5b                   	pop    %ebx
80104ebe:	5e                   	pop    %esi
80104ebf:	5f                   	pop    %edi
80104ec0:	5d                   	pop    %ebp
80104ec1:	c3                   	ret    
80104ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80104ec8:	83 ec 0c             	sub    $0xc,%esp
80104ecb:	56                   	push   %esi
80104ecc:	e8 ff c9 ff ff       	call   801018d0 <iunlockput>
    goto bad;
80104ed1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80104ed4:	83 ec 0c             	sub    $0xc,%esp
80104ed7:	53                   	push   %ebx
80104ed8:	e8 83 c7 ff ff       	call   80101660 <ilock>
  ip->nlink--;
80104edd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104ee2:	89 1c 24             	mov    %ebx,(%esp)
80104ee5:	e8 c6 c6 ff ff       	call   801015b0 <iupdate>
  iunlockput(ip);
80104eea:	89 1c 24             	mov    %ebx,(%esp)
80104eed:	e8 de c9 ff ff       	call   801018d0 <iunlockput>
  end_op();
80104ef2:	e8 59 dd ff ff       	call   80102c50 <end_op>
  return -1;
80104ef7:	83 c4 10             	add    $0x10,%esp
}
80104efa:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80104efd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f02:	5b                   	pop    %ebx
80104f03:	5e                   	pop    %esi
80104f04:	5f                   	pop    %edi
80104f05:	5d                   	pop    %ebp
80104f06:	c3                   	ret    
80104f07:	89 f6                	mov    %esi,%esi
80104f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80104f10:	83 ec 0c             	sub    $0xc,%esp
80104f13:	53                   	push   %ebx
80104f14:	e8 b7 c9 ff ff       	call   801018d0 <iunlockput>
    end_op();
80104f19:	e8 32 dd ff ff       	call   80102c50 <end_op>
    return -1;
80104f1e:	83 c4 10             	add    $0x10,%esp
80104f21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f26:	eb 92                	jmp    80104eba <sys_link+0xda>
    end_op();
80104f28:	e8 23 dd ff ff       	call   80102c50 <end_op>
    return -1;
80104f2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f32:	eb 86                	jmp    80104eba <sys_link+0xda>
80104f34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104f40 <sys_unlink>:
{
80104f40:	55                   	push   %ebp
80104f41:	89 e5                	mov    %esp,%ebp
80104f43:	57                   	push   %edi
80104f44:	56                   	push   %esi
80104f45:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80104f46:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80104f49:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80104f4c:	50                   	push   %eax
80104f4d:	6a 00                	push   $0x0
80104f4f:	e8 4c f9 ff ff       	call   801048a0 <argstr>
80104f54:	83 c4 10             	add    $0x10,%esp
80104f57:	85 c0                	test   %eax,%eax
80104f59:	0f 88 82 01 00 00    	js     801050e1 <sys_unlink+0x1a1>
  if((dp = nameiparent(path, name)) == 0){
80104f5f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80104f62:	e8 79 dc ff ff       	call   80102be0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104f67:	83 ec 08             	sub    $0x8,%esp
80104f6a:	53                   	push   %ebx
80104f6b:	ff 75 c0             	pushl  -0x40(%ebp)
80104f6e:	e8 3d cf ff ff       	call   80101eb0 <nameiparent>
80104f73:	83 c4 10             	add    $0x10,%esp
80104f76:	85 c0                	test   %eax,%eax
80104f78:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80104f7b:	0f 84 6a 01 00 00    	je     801050eb <sys_unlink+0x1ab>
  ilock(dp);
80104f81:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80104f84:	83 ec 0c             	sub    $0xc,%esp
80104f87:	56                   	push   %esi
80104f88:	e8 d3 c6 ff ff       	call   80101660 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104f8d:	58                   	pop    %eax
80104f8e:	5a                   	pop    %edx
80104f8f:	68 60 7c 10 80       	push   $0x80107c60
80104f94:	53                   	push   %ebx
80104f95:	e8 b6 cb ff ff       	call   80101b50 <namecmp>
80104f9a:	83 c4 10             	add    $0x10,%esp
80104f9d:	85 c0                	test   %eax,%eax
80104f9f:	0f 84 fc 00 00 00    	je     801050a1 <sys_unlink+0x161>
80104fa5:	83 ec 08             	sub    $0x8,%esp
80104fa8:	68 5f 7c 10 80       	push   $0x80107c5f
80104fad:	53                   	push   %ebx
80104fae:	e8 9d cb ff ff       	call   80101b50 <namecmp>
80104fb3:	83 c4 10             	add    $0x10,%esp
80104fb6:	85 c0                	test   %eax,%eax
80104fb8:	0f 84 e3 00 00 00    	je     801050a1 <sys_unlink+0x161>
  if((ip = dirlookup(dp, name, &off)) == 0)
80104fbe:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104fc1:	83 ec 04             	sub    $0x4,%esp
80104fc4:	50                   	push   %eax
80104fc5:	53                   	push   %ebx
80104fc6:	56                   	push   %esi
80104fc7:	e8 a4 cb ff ff       	call   80101b70 <dirlookup>
80104fcc:	83 c4 10             	add    $0x10,%esp
80104fcf:	85 c0                	test   %eax,%eax
80104fd1:	89 c3                	mov    %eax,%ebx
80104fd3:	0f 84 c8 00 00 00    	je     801050a1 <sys_unlink+0x161>
  ilock(ip);
80104fd9:	83 ec 0c             	sub    $0xc,%esp
80104fdc:	50                   	push   %eax
80104fdd:	e8 7e c6 ff ff       	call   80101660 <ilock>
  if(ip->nlink < 1)
80104fe2:	83 c4 10             	add    $0x10,%esp
80104fe5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80104fea:	0f 8e 24 01 00 00    	jle    80105114 <sys_unlink+0x1d4>
  if(ip->type == T_DIR && !isdirempty(ip)){
80104ff0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104ff5:	8d 75 d8             	lea    -0x28(%ebp),%esi
80104ff8:	74 66                	je     80105060 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80104ffa:	83 ec 04             	sub    $0x4,%esp
80104ffd:	6a 10                	push   $0x10
80104fff:	6a 00                	push   $0x0
80105001:	56                   	push   %esi
80105002:	e8 39 f5 ff ff       	call   80104540 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105007:	6a 10                	push   $0x10
80105009:	ff 75 c4             	pushl  -0x3c(%ebp)
8010500c:	56                   	push   %esi
8010500d:	ff 75 b4             	pushl  -0x4c(%ebp)
80105010:	e8 0b ca ff ff       	call   80101a20 <writei>
80105015:	83 c4 20             	add    $0x20,%esp
80105018:	83 f8 10             	cmp    $0x10,%eax
8010501b:	0f 85 e6 00 00 00    	jne    80105107 <sys_unlink+0x1c7>
  if(ip->type == T_DIR){
80105021:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105026:	0f 84 9c 00 00 00    	je     801050c8 <sys_unlink+0x188>
  iunlockput(dp);
8010502c:	83 ec 0c             	sub    $0xc,%esp
8010502f:	ff 75 b4             	pushl  -0x4c(%ebp)
80105032:	e8 99 c8 ff ff       	call   801018d0 <iunlockput>
  ip->nlink--;
80105037:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010503c:	89 1c 24             	mov    %ebx,(%esp)
8010503f:	e8 6c c5 ff ff       	call   801015b0 <iupdate>
  iunlockput(ip);
80105044:	89 1c 24             	mov    %ebx,(%esp)
80105047:	e8 84 c8 ff ff       	call   801018d0 <iunlockput>
  end_op();
8010504c:	e8 ff db ff ff       	call   80102c50 <end_op>
  return 0;
80105051:	83 c4 10             	add    $0x10,%esp
80105054:	31 c0                	xor    %eax,%eax
}
80105056:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105059:	5b                   	pop    %ebx
8010505a:	5e                   	pop    %esi
8010505b:	5f                   	pop    %edi
8010505c:	5d                   	pop    %ebp
8010505d:	c3                   	ret    
8010505e:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105060:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105064:	76 94                	jbe    80104ffa <sys_unlink+0xba>
80105066:	bf 20 00 00 00       	mov    $0x20,%edi
8010506b:	eb 0f                	jmp    8010507c <sys_unlink+0x13c>
8010506d:	8d 76 00             	lea    0x0(%esi),%esi
80105070:	83 c7 10             	add    $0x10,%edi
80105073:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105076:	0f 83 7e ff ff ff    	jae    80104ffa <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010507c:	6a 10                	push   $0x10
8010507e:	57                   	push   %edi
8010507f:	56                   	push   %esi
80105080:	53                   	push   %ebx
80105081:	e8 9a c8 ff ff       	call   80101920 <readi>
80105086:	83 c4 10             	add    $0x10,%esp
80105089:	83 f8 10             	cmp    $0x10,%eax
8010508c:	75 6c                	jne    801050fa <sys_unlink+0x1ba>
    if(de.inum != 0)
8010508e:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105093:	74 db                	je     80105070 <sys_unlink+0x130>
    iunlockput(ip);
80105095:	83 ec 0c             	sub    $0xc,%esp
80105098:	53                   	push   %ebx
80105099:	e8 32 c8 ff ff       	call   801018d0 <iunlockput>
    goto bad;
8010509e:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
801050a1:	83 ec 0c             	sub    $0xc,%esp
801050a4:	ff 75 b4             	pushl  -0x4c(%ebp)
801050a7:	e8 24 c8 ff ff       	call   801018d0 <iunlockput>
  end_op();
801050ac:	e8 9f db ff ff       	call   80102c50 <end_op>
  return -1;
801050b1:	83 c4 10             	add    $0x10,%esp
}
801050b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801050b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050bc:	5b                   	pop    %ebx
801050bd:	5e                   	pop    %esi
801050be:	5f                   	pop    %edi
801050bf:	5d                   	pop    %ebp
801050c0:	c3                   	ret    
801050c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
801050c8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
801050cb:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
801050ce:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
801050d3:	50                   	push   %eax
801050d4:	e8 d7 c4 ff ff       	call   801015b0 <iupdate>
801050d9:	83 c4 10             	add    $0x10,%esp
801050dc:	e9 4b ff ff ff       	jmp    8010502c <sys_unlink+0xec>
    return -1;
801050e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050e6:	e9 6b ff ff ff       	jmp    80105056 <sys_unlink+0x116>
    end_op();
801050eb:	e8 60 db ff ff       	call   80102c50 <end_op>
    return -1;
801050f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050f5:	e9 5c ff ff ff       	jmp    80105056 <sys_unlink+0x116>
      panic("isdirempty: readi");
801050fa:	83 ec 0c             	sub    $0xc,%esp
801050fd:	68 84 7c 10 80       	push   $0x80107c84
80105102:	e8 69 b2 ff ff       	call   80100370 <panic>
    panic("unlink: writei");
80105107:	83 ec 0c             	sub    $0xc,%esp
8010510a:	68 96 7c 10 80       	push   $0x80107c96
8010510f:	e8 5c b2 ff ff       	call   80100370 <panic>
    panic("unlink: nlink < 1");
80105114:	83 ec 0c             	sub    $0xc,%esp
80105117:	68 72 7c 10 80       	push   $0x80107c72
8010511c:	e8 4f b2 ff ff       	call   80100370 <panic>
80105121:	eb 0d                	jmp    80105130 <sys_open>
80105123:	90                   	nop
80105124:	90                   	nop
80105125:	90                   	nop
80105126:	90                   	nop
80105127:	90                   	nop
80105128:	90                   	nop
80105129:	90                   	nop
8010512a:	90                   	nop
8010512b:	90                   	nop
8010512c:	90                   	nop
8010512d:	90                   	nop
8010512e:	90                   	nop
8010512f:	90                   	nop

80105130 <sys_open>:

int
sys_open(void)
{
80105130:	55                   	push   %ebp
80105131:	89 e5                	mov    %esp,%ebp
80105133:	57                   	push   %edi
80105134:	56                   	push   %esi
80105135:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105136:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105139:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010513c:	50                   	push   %eax
8010513d:	6a 00                	push   $0x0
8010513f:	e8 5c f7 ff ff       	call   801048a0 <argstr>
80105144:	83 c4 10             	add    $0x10,%esp
80105147:	85 c0                	test   %eax,%eax
80105149:	0f 88 9e 00 00 00    	js     801051ed <sys_open+0xbd>
8010514f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105152:	83 ec 08             	sub    $0x8,%esp
80105155:	50                   	push   %eax
80105156:	6a 01                	push   $0x1
80105158:	e8 b3 f6 ff ff       	call   80104810 <argint>
8010515d:	83 c4 10             	add    $0x10,%esp
80105160:	85 c0                	test   %eax,%eax
80105162:	0f 88 85 00 00 00    	js     801051ed <sys_open+0xbd>
    return -1;

  begin_op();
80105168:	e8 73 da ff ff       	call   80102be0 <begin_op>

  if(omode & O_CREATE){
8010516d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105171:	0f 85 89 00 00 00    	jne    80105200 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105177:	83 ec 0c             	sub    $0xc,%esp
8010517a:	ff 75 e0             	pushl  -0x20(%ebp)
8010517d:	e8 0e cd ff ff       	call   80101e90 <namei>
80105182:	83 c4 10             	add    $0x10,%esp
80105185:	85 c0                	test   %eax,%eax
80105187:	89 c7                	mov    %eax,%edi
80105189:	0f 84 8e 00 00 00    	je     8010521d <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
8010518f:	83 ec 0c             	sub    $0xc,%esp
80105192:	50                   	push   %eax
80105193:	e8 c8 c4 ff ff       	call   80101660 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105198:	83 c4 10             	add    $0x10,%esp
8010519b:	66 83 7f 50 01       	cmpw   $0x1,0x50(%edi)
801051a0:	0f 84 d2 00 00 00    	je     80105278 <sys_open+0x148>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801051a6:	e8 a5 bb ff ff       	call   80100d50 <filealloc>
801051ab:	85 c0                	test   %eax,%eax
801051ad:	89 c6                	mov    %eax,%esi
801051af:	74 2b                	je     801051dc <sys_open+0xac>
801051b1:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801051b8:	31 db                	xor    %ebx,%ebx
801051ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(proc->ofile[fd] == 0){
801051c0:	8b 44 9a 28          	mov    0x28(%edx,%ebx,4),%eax
801051c4:	85 c0                	test   %eax,%eax
801051c6:	74 68                	je     80105230 <sys_open+0x100>
  for(fd = 0; fd < NOFILE; fd++){
801051c8:	83 c3 01             	add    $0x1,%ebx
801051cb:	83 fb 10             	cmp    $0x10,%ebx
801051ce:	75 f0                	jne    801051c0 <sys_open+0x90>
    if(f)
      fileclose(f);
801051d0:	83 ec 0c             	sub    $0xc,%esp
801051d3:	56                   	push   %esi
801051d4:	e8 37 bc ff ff       	call   80100e10 <fileclose>
801051d9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801051dc:	83 ec 0c             	sub    $0xc,%esp
801051df:	57                   	push   %edi
801051e0:	e8 eb c6 ff ff       	call   801018d0 <iunlockput>
    end_op();
801051e5:	e8 66 da ff ff       	call   80102c50 <end_op>
    return -1;
801051ea:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
801051ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801051f0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801051f5:	89 d8                	mov    %ebx,%eax
801051f7:	5b                   	pop    %ebx
801051f8:	5e                   	pop    %esi
801051f9:	5f                   	pop    %edi
801051fa:	5d                   	pop    %ebp
801051fb:	c3                   	ret    
801051fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105200:	83 ec 0c             	sub    $0xc,%esp
80105203:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105206:	31 c9                	xor    %ecx,%ecx
80105208:	6a 00                	push   $0x0
8010520a:	ba 02 00 00 00       	mov    $0x2,%edx
8010520f:	e8 6c f7 ff ff       	call   80104980 <create>
    if(ip == 0){
80105214:	83 c4 10             	add    $0x10,%esp
80105217:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105219:	89 c7                	mov    %eax,%edi
    if(ip == 0){
8010521b:	75 89                	jne    801051a6 <sys_open+0x76>
      end_op();
8010521d:	e8 2e da ff ff       	call   80102c50 <end_op>
      return -1;
80105222:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105227:	eb 40                	jmp    80105269 <sys_open+0x139>
80105229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80105230:	83 ec 0c             	sub    $0xc,%esp
      proc->ofile[fd] = f;
80105233:	89 74 9a 28          	mov    %esi,0x28(%edx,%ebx,4)
  iunlock(ip);
80105237:	57                   	push   %edi
80105238:	e8 03 c5 ff ff       	call   80101740 <iunlock>
  end_op();
8010523d:	e8 0e da ff ff       	call   80102c50 <end_op>
  f->type = FD_INODE;
80105242:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f->readable = !(omode & O_WRONLY);
80105248:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010524b:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
8010524e:	89 7e 10             	mov    %edi,0x10(%esi)
  f->off = 0;
80105251:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
80105258:	89 c2                	mov    %eax,%edx
8010525a:	f7 d2                	not    %edx
8010525c:	88 56 08             	mov    %dl,0x8(%esi)
8010525f:	80 66 08 01          	andb   $0x1,0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105263:	a8 03                	test   $0x3,%al
80105265:	0f 95 46 09          	setne  0x9(%esi)
}
80105269:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010526c:	89 d8                	mov    %ebx,%eax
8010526e:	5b                   	pop    %ebx
8010526f:	5e                   	pop    %esi
80105270:	5f                   	pop    %edi
80105271:	5d                   	pop    %ebp
80105272:	c3                   	ret    
80105273:	90                   	nop
80105274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105278:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010527b:	85 d2                	test   %edx,%edx
8010527d:	0f 84 23 ff ff ff    	je     801051a6 <sys_open+0x76>
80105283:	e9 54 ff ff ff       	jmp    801051dc <sys_open+0xac>
80105288:	90                   	nop
80105289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105290 <sys_mkdir>:

int
sys_mkdir(void)
{
80105290:	55                   	push   %ebp
80105291:	89 e5                	mov    %esp,%ebp
80105293:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105296:	e8 45 d9 ff ff       	call   80102be0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010529b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010529e:	83 ec 08             	sub    $0x8,%esp
801052a1:	50                   	push   %eax
801052a2:	6a 00                	push   $0x0
801052a4:	e8 f7 f5 ff ff       	call   801048a0 <argstr>
801052a9:	83 c4 10             	add    $0x10,%esp
801052ac:	85 c0                	test   %eax,%eax
801052ae:	78 30                	js     801052e0 <sys_mkdir+0x50>
801052b0:	83 ec 0c             	sub    $0xc,%esp
801052b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052b6:	31 c9                	xor    %ecx,%ecx
801052b8:	6a 00                	push   $0x0
801052ba:	ba 01 00 00 00       	mov    $0x1,%edx
801052bf:	e8 bc f6 ff ff       	call   80104980 <create>
801052c4:	83 c4 10             	add    $0x10,%esp
801052c7:	85 c0                	test   %eax,%eax
801052c9:	74 15                	je     801052e0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801052cb:	83 ec 0c             	sub    $0xc,%esp
801052ce:	50                   	push   %eax
801052cf:	e8 fc c5 ff ff       	call   801018d0 <iunlockput>
  end_op();
801052d4:	e8 77 d9 ff ff       	call   80102c50 <end_op>
  return 0;
801052d9:	83 c4 10             	add    $0x10,%esp
801052dc:	31 c0                	xor    %eax,%eax
}
801052de:	c9                   	leave  
801052df:	c3                   	ret    
    end_op();
801052e0:	e8 6b d9 ff ff       	call   80102c50 <end_op>
    return -1;
801052e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801052ea:	c9                   	leave  
801052eb:	c3                   	ret    
801052ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801052f0 <sys_mknod>:

int
sys_mknod(void)
{
801052f0:	55                   	push   %ebp
801052f1:	89 e5                	mov    %esp,%ebp
801052f3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801052f6:	e8 e5 d8 ff ff       	call   80102be0 <begin_op>
  if((argstr(0, &path)) < 0 ||
801052fb:	8d 45 ec             	lea    -0x14(%ebp),%eax
801052fe:	83 ec 08             	sub    $0x8,%esp
80105301:	50                   	push   %eax
80105302:	6a 00                	push   $0x0
80105304:	e8 97 f5 ff ff       	call   801048a0 <argstr>
80105309:	83 c4 10             	add    $0x10,%esp
8010530c:	85 c0                	test   %eax,%eax
8010530e:	78 60                	js     80105370 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105310:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105313:	83 ec 08             	sub    $0x8,%esp
80105316:	50                   	push   %eax
80105317:	6a 01                	push   $0x1
80105319:	e8 f2 f4 ff ff       	call   80104810 <argint>
  if((argstr(0, &path)) < 0 ||
8010531e:	83 c4 10             	add    $0x10,%esp
80105321:	85 c0                	test   %eax,%eax
80105323:	78 4b                	js     80105370 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105325:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105328:	83 ec 08             	sub    $0x8,%esp
8010532b:	50                   	push   %eax
8010532c:	6a 02                	push   $0x2
8010532e:	e8 dd f4 ff ff       	call   80104810 <argint>
     argint(1, &major) < 0 ||
80105333:	83 c4 10             	add    $0x10,%esp
80105336:	85 c0                	test   %eax,%eax
80105338:	78 36                	js     80105370 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010533a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
8010533e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105341:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105345:	ba 03 00 00 00       	mov    $0x3,%edx
8010534a:	50                   	push   %eax
8010534b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010534e:	e8 2d f6 ff ff       	call   80104980 <create>
80105353:	83 c4 10             	add    $0x10,%esp
80105356:	85 c0                	test   %eax,%eax
80105358:	74 16                	je     80105370 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010535a:	83 ec 0c             	sub    $0xc,%esp
8010535d:	50                   	push   %eax
8010535e:	e8 6d c5 ff ff       	call   801018d0 <iunlockput>
  end_op();
80105363:	e8 e8 d8 ff ff       	call   80102c50 <end_op>
  return 0;
80105368:	83 c4 10             	add    $0x10,%esp
8010536b:	31 c0                	xor    %eax,%eax
}
8010536d:	c9                   	leave  
8010536e:	c3                   	ret    
8010536f:	90                   	nop
    end_op();
80105370:	e8 db d8 ff ff       	call   80102c50 <end_op>
    return -1;
80105375:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010537a:	c9                   	leave  
8010537b:	c3                   	ret    
8010537c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105380 <sys_chdir>:

int
sys_chdir(void)
{
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	53                   	push   %ebx
80105384:	83 ec 14             	sub    $0x14,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105387:	e8 54 d8 ff ff       	call   80102be0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
8010538c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010538f:	83 ec 08             	sub    $0x8,%esp
80105392:	50                   	push   %eax
80105393:	6a 00                	push   $0x0
80105395:	e8 06 f5 ff ff       	call   801048a0 <argstr>
8010539a:	83 c4 10             	add    $0x10,%esp
8010539d:	85 c0                	test   %eax,%eax
8010539f:	78 7f                	js     80105420 <sys_chdir+0xa0>
801053a1:	83 ec 0c             	sub    $0xc,%esp
801053a4:	ff 75 f4             	pushl  -0xc(%ebp)
801053a7:	e8 e4 ca ff ff       	call   80101e90 <namei>
801053ac:	83 c4 10             	add    $0x10,%esp
801053af:	85 c0                	test   %eax,%eax
801053b1:	89 c3                	mov    %eax,%ebx
801053b3:	74 6b                	je     80105420 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801053b5:	83 ec 0c             	sub    $0xc,%esp
801053b8:	50                   	push   %eax
801053b9:	e8 a2 c2 ff ff       	call   80101660 <ilock>
  if(ip->type != T_DIR){
801053be:	83 c4 10             	add    $0x10,%esp
801053c1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801053c6:	75 38                	jne    80105400 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801053c8:	83 ec 0c             	sub    $0xc,%esp
801053cb:	53                   	push   %ebx
801053cc:	e8 6f c3 ff ff       	call   80101740 <iunlock>
  iput(proc->cwd);
801053d1:	58                   	pop    %eax
801053d2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801053d8:	ff 70 68             	pushl  0x68(%eax)
801053db:	e8 b0 c3 ff ff       	call   80101790 <iput>
  end_op();
801053e0:	e8 6b d8 ff ff       	call   80102c50 <end_op>
  proc->cwd = ip;
801053e5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return 0;
801053eb:	83 c4 10             	add    $0x10,%esp
  proc->cwd = ip;
801053ee:	89 58 68             	mov    %ebx,0x68(%eax)
  return 0;
801053f1:	31 c0                	xor    %eax,%eax
}
801053f3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801053f6:	c9                   	leave  
801053f7:	c3                   	ret    
801053f8:	90                   	nop
801053f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80105400:	83 ec 0c             	sub    $0xc,%esp
80105403:	53                   	push   %ebx
80105404:	e8 c7 c4 ff ff       	call   801018d0 <iunlockput>
    end_op();
80105409:	e8 42 d8 ff ff       	call   80102c50 <end_op>
    return -1;
8010540e:	83 c4 10             	add    $0x10,%esp
80105411:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105416:	eb db                	jmp    801053f3 <sys_chdir+0x73>
80105418:	90                   	nop
80105419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105420:	e8 2b d8 ff ff       	call   80102c50 <end_op>
    return -1;
80105425:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010542a:	eb c7                	jmp    801053f3 <sys_chdir+0x73>
8010542c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105430 <sys_exec>:

int
sys_exec(void)
{
80105430:	55                   	push   %ebp
80105431:	89 e5                	mov    %esp,%ebp
80105433:	57                   	push   %edi
80105434:	56                   	push   %esi
80105435:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105436:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010543c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105442:	50                   	push   %eax
80105443:	6a 00                	push   $0x0
80105445:	e8 56 f4 ff ff       	call   801048a0 <argstr>
8010544a:	83 c4 10             	add    $0x10,%esp
8010544d:	85 c0                	test   %eax,%eax
8010544f:	78 7f                	js     801054d0 <sys_exec+0xa0>
80105451:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105457:	83 ec 08             	sub    $0x8,%esp
8010545a:	50                   	push   %eax
8010545b:	6a 01                	push   $0x1
8010545d:	e8 ae f3 ff ff       	call   80104810 <argint>
80105462:	83 c4 10             	add    $0x10,%esp
80105465:	85 c0                	test   %eax,%eax
80105467:	78 67                	js     801054d0 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105469:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010546f:	83 ec 04             	sub    $0x4,%esp
80105472:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105478:	68 80 00 00 00       	push   $0x80
8010547d:	6a 00                	push   $0x0
8010547f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105485:	50                   	push   %eax
80105486:	31 db                	xor    %ebx,%ebx
80105488:	e8 b3 f0 ff ff       	call   80104540 <memset>
8010548d:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105490:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105496:	83 ec 08             	sub    $0x8,%esp
80105499:	57                   	push   %edi
8010549a:	8d 04 98             	lea    (%eax,%ebx,4),%eax
8010549d:	50                   	push   %eax
8010549e:	e8 ed f2 ff ff       	call   80104790 <fetchint>
801054a3:	83 c4 10             	add    $0x10,%esp
801054a6:	85 c0                	test   %eax,%eax
801054a8:	78 26                	js     801054d0 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
801054aa:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801054b0:	85 c0                	test   %eax,%eax
801054b2:	74 2c                	je     801054e0 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801054b4:	83 ec 08             	sub    $0x8,%esp
801054b7:	56                   	push   %esi
801054b8:	50                   	push   %eax
801054b9:	e8 02 f3 ff ff       	call   801047c0 <fetchstr>
801054be:	83 c4 10             	add    $0x10,%esp
801054c1:	85 c0                	test   %eax,%eax
801054c3:	78 0b                	js     801054d0 <sys_exec+0xa0>
  for(i=0;; i++){
801054c5:	83 c3 01             	add    $0x1,%ebx
801054c8:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
801054cb:	83 fb 20             	cmp    $0x20,%ebx
801054ce:	75 c0                	jne    80105490 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
801054d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801054d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054d8:	5b                   	pop    %ebx
801054d9:	5e                   	pop    %esi
801054da:	5f                   	pop    %edi
801054db:	5d                   	pop    %ebp
801054dc:	c3                   	ret    
801054dd:	8d 76 00             	lea    0x0(%esi),%esi
  return exec(path, argv);
801054e0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801054e6:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
801054e9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801054f0:	00 00 00 00 
  return exec(path, argv);
801054f4:	50                   	push   %eax
801054f5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801054fb:	e8 e0 b4 ff ff       	call   801009e0 <exec>
80105500:	83 c4 10             	add    $0x10,%esp
}
80105503:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105506:	5b                   	pop    %ebx
80105507:	5e                   	pop    %esi
80105508:	5f                   	pop    %edi
80105509:	5d                   	pop    %ebp
8010550a:	c3                   	ret    
8010550b:	90                   	nop
8010550c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105510 <sys_pipe>:

int
sys_pipe(void)
{
80105510:	55                   	push   %ebp
80105511:	89 e5                	mov    %esp,%ebp
80105513:	57                   	push   %edi
80105514:	56                   	push   %esi
80105515:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105516:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105519:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010551c:	6a 08                	push   $0x8
8010551e:	50                   	push   %eax
8010551f:	6a 00                	push   $0x0
80105521:	e8 2a f3 ff ff       	call   80104850 <argptr>
80105526:	83 c4 10             	add    $0x10,%esp
80105529:	85 c0                	test   %eax,%eax
8010552b:	78 48                	js     80105575 <sys_pipe+0x65>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010552d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105530:	83 ec 08             	sub    $0x8,%esp
80105533:	50                   	push   %eax
80105534:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105537:	50                   	push   %eax
80105538:	e8 33 de ff ff       	call   80103370 <pipealloc>
8010553d:	83 c4 10             	add    $0x10,%esp
80105540:	85 c0                	test   %eax,%eax
80105542:	78 31                	js     80105575 <sys_pipe+0x65>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105544:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80105547:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
  for(fd = 0; fd < NOFILE; fd++){
8010554e:	31 c0                	xor    %eax,%eax
    if(proc->ofile[fd] == 0){
80105550:	8b 54 81 28          	mov    0x28(%ecx,%eax,4),%edx
80105554:	85 d2                	test   %edx,%edx
80105556:	74 28                	je     80105580 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
80105558:	83 c0 01             	add    $0x1,%eax
8010555b:	83 f8 10             	cmp    $0x10,%eax
8010555e:	75 f0                	jne    80105550 <sys_pipe+0x40>
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
    fileclose(rf);
80105560:	83 ec 0c             	sub    $0xc,%esp
80105563:	53                   	push   %ebx
80105564:	e8 a7 b8 ff ff       	call   80100e10 <fileclose>
    fileclose(wf);
80105569:	58                   	pop    %eax
8010556a:	ff 75 e4             	pushl  -0x1c(%ebp)
8010556d:	e8 9e b8 ff ff       	call   80100e10 <fileclose>
    return -1;
80105572:	83 c4 10             	add    $0x10,%esp
80105575:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010557a:	eb 45                	jmp    801055c1 <sys_pipe+0xb1>
8010557c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105580:	8d 34 81             	lea    (%ecx,%eax,4),%esi
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105583:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105586:	31 d2                	xor    %edx,%edx
      proc->ofile[fd] = f;
80105588:	89 5e 28             	mov    %ebx,0x28(%esi)
8010558b:	90                   	nop
8010558c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->ofile[fd] == 0){
80105590:	83 7c 91 28 00       	cmpl   $0x0,0x28(%ecx,%edx,4)
80105595:	74 19                	je     801055b0 <sys_pipe+0xa0>
  for(fd = 0; fd < NOFILE; fd++){
80105597:	83 c2 01             	add    $0x1,%edx
8010559a:	83 fa 10             	cmp    $0x10,%edx
8010559d:	75 f1                	jne    80105590 <sys_pipe+0x80>
      proc->ofile[fd0] = 0;
8010559f:	c7 46 28 00 00 00 00 	movl   $0x0,0x28(%esi)
801055a6:	eb b8                	jmp    80105560 <sys_pipe+0x50>
801055a8:	90                   	nop
801055a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      proc->ofile[fd] = f;
801055b0:	89 7c 91 28          	mov    %edi,0x28(%ecx,%edx,4)
  }
  fd[0] = fd0;
801055b4:	8b 4d dc             	mov    -0x24(%ebp),%ecx
801055b7:	89 01                	mov    %eax,(%ecx)
  fd[1] = fd1;
801055b9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801055bc:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801055bf:	31 c0                	xor    %eax,%eax
}
801055c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055c4:	5b                   	pop    %ebx
801055c5:	5e                   	pop    %esi
801055c6:	5f                   	pop    %edi
801055c7:	5d                   	pop    %ebp
801055c8:	c3                   	ret    
801055c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801055d0 <name_of_inode>:

// Must be inside a transaction, as it calls readi.
int
name_of_inode(struct inode *ip, struct inode *parent, char buf[DIRSIZ]) {
801055d0:	55                   	push   %ebp
801055d1:	89 e5                	mov    %esp,%ebp
801055d3:	57                   	push   %edi
801055d4:	56                   	push   %esi
801055d5:	53                   	push   %ebx
801055d6:	31 ff                	xor    %edi,%edi
801055d8:	8d 75 d8             	lea    -0x28(%ebp),%esi
801055db:	83 ec 1c             	sub    $0x1c,%esp
801055de:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  uint off;
  struct dirent de;
  for (off = 0; off < parent->size; off += sizeof(de)) {
801055e1:	8b 43 58             	mov    0x58(%ebx),%eax
801055e4:	85 c0                	test   %eax,%eax
801055e6:	75 10                	jne    801055f8 <name_of_inode+0x28>
801055e8:	eb 4e                	jmp    80105638 <name_of_inode+0x68>
801055ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801055f0:	83 c7 10             	add    $0x10,%edi
801055f3:	39 7b 58             	cmp    %edi,0x58(%ebx)
801055f6:	76 40                	jbe    80105638 <name_of_inode+0x68>
    if (readi(parent, (char*)&de, off, sizeof(de)) != sizeof(de))
801055f8:	6a 10                	push   $0x10
801055fa:	57                   	push   %edi
801055fb:	56                   	push   %esi
801055fc:	53                   	push   %ebx
801055fd:	e8 1e c3 ff ff       	call   80101920 <readi>
80105602:	83 c4 10             	add    $0x10,%esp
80105605:	83 f8 10             	cmp    $0x10,%eax
80105608:	75 3b                	jne    80105645 <name_of_inode+0x75>
      panic("couldn't read dir entry");
    if (de.inum == ip->inum) {
8010560a:	8b 55 08             	mov    0x8(%ebp),%edx
8010560d:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
80105611:	3b 42 04             	cmp    0x4(%edx),%eax
80105614:	75 da                	jne    801055f0 <name_of_inode+0x20>
      safestrcpy(buf, de.name, DIRSIZ);
80105616:	8d 45 da             	lea    -0x26(%ebp),%eax
80105619:	83 ec 04             	sub    $0x4,%esp
8010561c:	6a 0e                	push   $0xe
8010561e:	50                   	push   %eax
8010561f:	ff 75 10             	pushl  0x10(%ebp)
80105622:	e8 f9 f0 ff ff       	call   80104720 <safestrcpy>
      return 0;
80105627:	83 c4 10             	add    $0x10,%esp
    }
  }
  return -1;
}
8010562a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
8010562d:	31 c0                	xor    %eax,%eax
}
8010562f:	5b                   	pop    %ebx
80105630:	5e                   	pop    %esi
80105631:	5f                   	pop    %edi
80105632:	5d                   	pop    %ebp
80105633:	c3                   	ret    
80105634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105638:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010563b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105640:	5b                   	pop    %ebx
80105641:	5e                   	pop    %esi
80105642:	5f                   	pop    %edi
80105643:	5d                   	pop    %ebp
80105644:	c3                   	ret    
      panic("couldn't read dir entry");
80105645:	83 ec 0c             	sub    $0xc,%esp
80105648:	68 a5 7c 10 80       	push   $0x80107ca5
8010564d:	e8 1e ad ff ff       	call   80100370 <panic>
80105652:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105660 <name_for_inode>:

int
name_for_inode(char* buf, int n, struct inode *ip) {
80105660:	55                   	push   %ebp
80105661:	89 e5                	mov    %esp,%ebp
80105663:	57                   	push   %edi
80105664:	56                   	push   %esi
80105665:	53                   	push   %ebx
80105666:	83 ec 2c             	sub    $0x2c,%esp
80105669:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int path_offset;
  struct inode *parent;
  char node_name[DIRSIZ];

  begin_op();
8010566c:	e8 6f d5 ff ff       	call   80102be0 <begin_op>

  if (ip->inum == namei("/")->inum) {
80105671:	83 ec 0c             	sub    $0xc,%esp
80105674:	8b 73 04             	mov    0x4(%ebx),%esi
80105677:	68 b6 7a 10 80       	push   $0x80107ab6
8010567c:	e8 0f c8 ff ff       	call   80101e90 <namei>
80105681:	83 c4 10             	add    $0x10,%esp
80105684:	3b 70 04             	cmp    0x4(%eax),%esi
80105687:	0f 84 e3 00 00 00    	je     80105770 <name_for_inode+0x110>
	buf[0] = '/';
    buf[1] = '\0';
    end_op();
	return 1;
  } else if (ip->type == T_DIR) {
8010568d:	0f b7 43 50          	movzwl 0x50(%ebx),%eax
80105691:	66 83 f8 01          	cmp    $0x1,%ax
80105695:	74 39                	je     801056d0 <name_for_inode+0x70>
	  buf[path_offset++] = '/';
	}
	iunlockput(parent);
    end_op();
	return path_offset;
  } else if (ip->type == T_DEV || ip->type == T_FILE) {
80105697:	83 e8 02             	sub    $0x2,%eax
8010569a:	66 83 f8 01          	cmp    $0x1,%ax
8010569e:	76 18                	jbe    801056b8 <name_for_inode+0x58>
    end_op();
	panic("process cwd is a device node / file, not a directory!");
  } else {
    end_op();
801056a0:	e8 ab d5 ff ff       	call   80102c50 <end_op>
	panic("unknown inode type");
801056a5:	83 ec 0c             	sub    $0xc,%esp
801056a8:	68 bd 7c 10 80       	push   $0x80107cbd
801056ad:	e8 be ac ff ff       	call   80100370 <panic>
801056b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    end_op();
801056b8:	e8 93 d5 ff ff       	call   80102c50 <end_op>
	panic("process cwd is a device node / file, not a directory!");
801056bd:	83 ec 0c             	sub    $0xc,%esp
801056c0:	68 f8 7c 10 80       	push   $0x80107cf8
801056c5:	e8 a6 ac ff ff       	call   80100370 <panic>
801056ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	parent = dirlookup(ip, "..", 0);
801056d0:	83 ec 04             	sub    $0x4,%esp
	if (name_of_inode(ip, parent, node_name)) {
801056d3:	8d 7d da             	lea    -0x26(%ebp),%edi
	parent = dirlookup(ip, "..", 0);
801056d6:	6a 00                	push   $0x0
801056d8:	68 5f 7c 10 80       	push   $0x80107c5f
801056dd:	53                   	push   %ebx
801056de:	e8 8d c4 ff ff       	call   80101b70 <dirlookup>
801056e3:	89 c6                	mov    %eax,%esi
	ilock(parent);
801056e5:	89 04 24             	mov    %eax,(%esp)
801056e8:	e8 73 bf ff ff       	call   80101660 <ilock>
	if (name_of_inode(ip, parent, node_name)) {
801056ed:	83 c4 0c             	add    $0xc,%esp
801056f0:	57                   	push   %edi
801056f1:	56                   	push   %esi
801056f2:	53                   	push   %ebx
801056f3:	e8 d8 fe ff ff       	call   801055d0 <name_of_inode>
801056f8:	83 c4 10             	add    $0x10,%esp
801056fb:	85 c0                	test   %eax,%eax
801056fd:	0f 85 aa 00 00 00    	jne    801057ad <name_for_inode+0x14d>
	path_offset = name_for_inode(buf, n, parent);
80105703:	83 ec 04             	sub    $0x4,%esp
80105706:	56                   	push   %esi
80105707:	ff 75 0c             	pushl  0xc(%ebp)
8010570a:	ff 75 08             	pushl  0x8(%ebp)
8010570d:	e8 4e ff ff ff       	call   80105660 <name_for_inode>
80105712:	89 c3                	mov    %eax,%ebx
	safestrcpy(buf + path_offset, node_name, n - path_offset);
80105714:	8b 45 0c             	mov    0xc(%ebp),%eax
80105717:	83 c4 0c             	add    $0xc,%esp
8010571a:	29 d8                	sub    %ebx,%eax
8010571c:	50                   	push   %eax
8010571d:	8b 45 08             	mov    0x8(%ebp),%eax
80105720:	57                   	push   %edi
80105721:	01 d8                	add    %ebx,%eax
80105723:	50                   	push   %eax
80105724:	e8 f7 ef ff ff       	call   80104720 <safestrcpy>
	path_offset += strlen(node_name);
80105729:	89 3c 24             	mov    %edi,(%esp)
8010572c:	e8 2f f0 ff ff       	call   80104760 <strlen>
80105731:	01 c3                	add    %eax,%ebx
	if (path_offset == n - 1) {
80105733:	8b 45 0c             	mov    0xc(%ebp),%eax
80105736:	83 c4 10             	add    $0x10,%esp
80105739:	83 e8 01             	sub    $0x1,%eax
8010573c:	39 c3                	cmp    %eax,%ebx
8010573e:	74 50                	je     80105790 <name_for_inode+0x130>
	  buf[path_offset++] = '/';
80105740:	8d 43 01             	lea    0x1(%ebx),%eax
	iunlockput(parent);
80105743:	83 ec 0c             	sub    $0xc,%esp
	  buf[path_offset++] = '/';
80105746:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80105749:	8b 45 08             	mov    0x8(%ebp),%eax
8010574c:	c6 04 18 2f          	movb   $0x2f,(%eax,%ebx,1)
	iunlockput(parent);
80105750:	56                   	push   %esi
80105751:	e8 7a c1 ff ff       	call   801018d0 <iunlockput>
    end_op();
80105756:	e8 f5 d4 ff ff       	call   80102c50 <end_op>
8010575b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010575e:	83 c4 10             	add    $0x10,%esp
  }
}
80105761:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105764:	5b                   	pop    %ebx
80105765:	5e                   	pop    %esi
80105766:	5f                   	pop    %edi
80105767:	5d                   	pop    %ebp
80105768:	c3                   	ret    
80105769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	buf[0] = '/';
80105770:	8b 45 08             	mov    0x8(%ebp),%eax
80105773:	c6 00 2f             	movb   $0x2f,(%eax)
    buf[1] = '\0';
80105776:	c6 40 01 00          	movb   $0x0,0x1(%eax)
    end_op();
8010577a:	e8 d1 d4 ff ff       	call   80102c50 <end_op>
	return 1;
8010577f:	b8 01 00 00 00       	mov    $0x1,%eax
80105784:	eb db                	jmp    80105761 <name_for_inode+0x101>
80105786:	8d 76 00             	lea    0x0(%esi),%esi
80105789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	  buf[path_offset] = '\0';
80105790:	8b 45 08             	mov    0x8(%ebp),%eax
      iunlockput(parent);
80105793:	83 ec 0c             	sub    $0xc,%esp
	  buf[path_offset] = '\0';
80105796:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
      iunlockput(parent);
8010579a:	56                   	push   %esi
8010579b:	e8 30 c1 ff ff       	call   801018d0 <iunlockput>
      end_op();
801057a0:	e8 ab d4 ff ff       	call   80102c50 <end_op>
801057a5:	83 c4 10             	add    $0x10,%esp
	  return n;
801057a8:	8b 45 0c             	mov    0xc(%ebp),%eax
801057ab:	eb b4                	jmp    80105761 <name_for_inode+0x101>
      end_op();
801057ad:	e8 9e d4 ff ff       	call   80102c50 <end_op>
	  panic("could not find name of inode in parent!");
801057b2:	83 ec 0c             	sub    $0xc,%esp
801057b5:	68 d0 7c 10 80       	push   $0x80107cd0
801057ba:	e8 b1 ab ff ff       	call   80100370 <panic>
801057bf:	90                   	nop

801057c0 <sys_getcwd>:

/* NB: Return from here is cast to char*, thus 0 == NULL */
int
sys_getcwd(void)
{
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
801057c3:	83 ec 20             	sub    $0x20,%esp
  char *p;
  int n;
  if (argint(1, &n) < 0)
801057c6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057c9:	50                   	push   %eax
801057ca:	6a 01                	push   $0x1
801057cc:	e8 3f f0 ff ff       	call   80104810 <argint>
801057d1:	83 c4 10             	add    $0x10,%esp
801057d4:	85 c0                	test   %eax,%eax
801057d6:	78 38                	js     80105810 <sys_getcwd+0x50>
    return 0;
  if(argptr(0, &p, n) < 0)
801057d8:	8d 45 f0             	lea    -0x10(%ebp),%eax
801057db:	83 ec 04             	sub    $0x4,%esp
801057de:	ff 75 f4             	pushl  -0xc(%ebp)
801057e1:	50                   	push   %eax
801057e2:	6a 00                	push   $0x0
801057e4:	e8 67 f0 ff ff       	call   80104850 <argptr>
801057e9:	83 c4 10             	add    $0x10,%esp
801057ec:	85 c0                	test   %eax,%eax
801057ee:	78 20                	js     80105810 <sys_getcwd+0x50>
	return 0;
  name_for_inode(p, n, proc->cwd);
801057f0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057f6:	83 ec 04             	sub    $0x4,%esp
801057f9:	ff 70 68             	pushl  0x68(%eax)
801057fc:	ff 75 f4             	pushl  -0xc(%ebp)
801057ff:	ff 75 f0             	pushl  -0x10(%ebp)
80105802:	e8 59 fe ff ff       	call   80105660 <name_for_inode>
  return (int) p;
80105807:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010580a:	83 c4 10             	add    $0x10,%esp
}
8010580d:	c9                   	leave  
8010580e:	c3                   	ret    
8010580f:	90                   	nop
    return 0;
80105810:	31 c0                	xor    %eax,%eax
}
80105812:	c9                   	leave  
80105813:	c3                   	ret    
80105814:	66 90                	xchg   %ax,%ax
80105816:	66 90                	xchg   %ax,%ax
80105818:	66 90                	xchg   %ax,%ax
8010581a:	66 90                	xchg   %ax,%ax
8010581c:	66 90                	xchg   %ax,%ax
8010581e:	66 90                	xchg   %ax,%ax

80105820 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105820:	55                   	push   %ebp
80105821:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105823:	5d                   	pop    %ebp
  return fork();
80105824:	e9 07 e2 ff ff       	jmp    80103a30 <fork>
80105829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105830 <sys_exit>:

int
sys_exit(void)
{
80105830:	55                   	push   %ebp
80105831:	89 e5                	mov    %esp,%ebp
80105833:	83 ec 08             	sub    $0x8,%esp
  exit();
80105836:	e8 a5 e4 ff ff       	call   80103ce0 <exit>
  return 0;  // not reached
}
8010583b:	31 c0                	xor    %eax,%eax
8010583d:	c9                   	leave  
8010583e:	c3                   	ret    
8010583f:	90                   	nop

80105840 <sys_wait>:

int
sys_wait(void)
{
80105840:	55                   	push   %ebp
80105841:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105843:	5d                   	pop    %ebp
  return wait();
80105844:	e9 e7 e6 ff ff       	jmp    80103f30 <wait>
80105849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105850 <sys_shm_jared>:

int sys_shm_jared(void)
{
80105850:	55                   	push   %ebp
80105851:	89 e5                	mov    %esp,%ebp
80105853:	83 ec 20             	sub    $0x20,%esp
  int key;
  int num_pages;
  if(argint(0, &key) < 0){
80105856:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105859:	50                   	push   %eax
8010585a:	6a 00                	push   $0x0
8010585c:	e8 af ef ff ff       	call   80104810 <argint>
80105861:	83 c4 10             	add    $0x10,%esp
80105864:	85 c0                	test   %eax,%eax
80105866:	78 28                	js     80105890 <sys_shm_jared+0x40>
    return -1;
  }
  if(argint(1,&num_pages) < 0){
80105868:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010586b:	83 ec 08             	sub    $0x8,%esp
8010586e:	50                   	push   %eax
8010586f:	6a 01                	push   $0x1
80105871:	e8 9a ef ff ff       	call   80104810 <argint>
80105876:	83 c4 10             	add    $0x10,%esp
80105879:	85 c0                	test   %eax,%eax
8010587b:	78 13                	js     80105890 <sys_shm_jared+0x40>
    return -1;
  }

  return shm_jared(key, num_pages);
8010587d:	83 ec 08             	sub    $0x8,%esp
80105880:	ff 75 f4             	pushl  -0xc(%ebp)
80105883:	ff 75 f0             	pushl  -0x10(%ebp)
80105886:	e8 35 13 00 00       	call   80106bc0 <shm_jared>
8010588b:	83 c4 10             	add    $0x10,%esp
}
8010588e:	c9                   	leave  
8010588f:	c3                   	ret    
    return -1;
80105890:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105895:	c9                   	leave  
80105896:	c3                   	ret    
80105897:	89 f6                	mov    %esi,%esi
80105899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058a0 <sys_kill>:

int
sys_kill(void)
{
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
801058a3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801058a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058a9:	50                   	push   %eax
801058aa:	6a 00                	push   $0x0
801058ac:	e8 5f ef ff ff       	call   80104810 <argint>
801058b1:	83 c4 10             	add    $0x10,%esp
801058b4:	85 c0                	test   %eax,%eax
801058b6:	78 18                	js     801058d0 <sys_kill+0x30>
    return -1;
  return kill(pid);
801058b8:	83 ec 0c             	sub    $0xc,%esp
801058bb:	ff 75 f4             	pushl  -0xc(%ebp)
801058be:	e8 bd e7 ff ff       	call   80104080 <kill>
801058c3:	83 c4 10             	add    $0x10,%esp
}
801058c6:	c9                   	leave  
801058c7:	c3                   	ret    
801058c8:	90                   	nop
801058c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801058d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058d5:	c9                   	leave  
801058d6:	c3                   	ret    
801058d7:	89 f6                	mov    %esi,%esi
801058d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058e0 <sys_getpid>:

int
sys_getpid(void)
{
  return proc->pid;
801058e0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
801058e6:	55                   	push   %ebp
801058e7:	89 e5                	mov    %esp,%ebp
  return proc->pid;
801058e9:	8b 40 10             	mov    0x10(%eax),%eax
}
801058ec:	5d                   	pop    %ebp
801058ed:	c3                   	ret    
801058ee:	66 90                	xchg   %ax,%ax

801058f0 <sys_sbrk>:

int
sys_sbrk(void)
{
801058f0:	55                   	push   %ebp
801058f1:	89 e5                	mov    %esp,%ebp
801058f3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801058f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801058f7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801058fa:	50                   	push   %eax
801058fb:	6a 00                	push   $0x0
801058fd:	e8 0e ef ff ff       	call   80104810 <argint>
80105902:	83 c4 10             	add    $0x10,%esp
80105905:	85 c0                	test   %eax,%eax
80105907:	78 27                	js     80105930 <sys_sbrk+0x40>
    return -1;
  addr = proc->sz;
80105909:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(growproc(n) < 0)
8010590f:	83 ec 0c             	sub    $0xc,%esp
  addr = proc->sz;
80105912:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105914:	ff 75 f4             	pushl  -0xc(%ebp)
80105917:	e8 a4 e0 ff ff       	call   801039c0 <growproc>
8010591c:	83 c4 10             	add    $0x10,%esp
8010591f:	85 c0                	test   %eax,%eax
80105921:	78 0d                	js     80105930 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105923:	89 d8                	mov    %ebx,%eax
80105925:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105928:	c9                   	leave  
80105929:	c3                   	ret    
8010592a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105930:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105935:	eb ec                	jmp    80105923 <sys_sbrk+0x33>
80105937:	89 f6                	mov    %esi,%esi
80105939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105940 <sys_sleep>:

int
sys_sleep(void)
{
80105940:	55                   	push   %ebp
80105941:	89 e5                	mov    %esp,%ebp
80105943:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105944:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105947:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010594a:	50                   	push   %eax
8010594b:	6a 00                	push   $0x0
8010594d:	e8 be ee ff ff       	call   80104810 <argint>
80105952:	83 c4 10             	add    $0x10,%esp
80105955:	85 c0                	test   %eax,%eax
80105957:	0f 88 8a 00 00 00    	js     801059e7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010595d:	83 ec 0c             	sub    $0xc,%esp
80105960:	68 e0 75 11 80       	push   $0x801175e0
80105965:	e8 a6 e9 ff ff       	call   80104310 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010596a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010596d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105970:	8b 1d 20 7e 11 80    	mov    0x80117e20,%ebx
  while(ticks - ticks0 < n){
80105976:	85 d2                	test   %edx,%edx
80105978:	75 27                	jne    801059a1 <sys_sleep+0x61>
8010597a:	eb 54                	jmp    801059d0 <sys_sleep+0x90>
8010597c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105980:	83 ec 08             	sub    $0x8,%esp
80105983:	68 e0 75 11 80       	push   $0x801175e0
80105988:	68 20 7e 11 80       	push   $0x80117e20
8010598d:	e8 de e4 ff ff       	call   80103e70 <sleep>
  while(ticks - ticks0 < n){
80105992:	a1 20 7e 11 80       	mov    0x80117e20,%eax
80105997:	83 c4 10             	add    $0x10,%esp
8010599a:	29 d8                	sub    %ebx,%eax
8010599c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010599f:	73 2f                	jae    801059d0 <sys_sleep+0x90>
    if(proc->killed){
801059a1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801059a7:	8b 40 24             	mov    0x24(%eax),%eax
801059aa:	85 c0                	test   %eax,%eax
801059ac:	74 d2                	je     80105980 <sys_sleep+0x40>
      release(&tickslock);
801059ae:	83 ec 0c             	sub    $0xc,%esp
801059b1:	68 e0 75 11 80       	push   $0x801175e0
801059b6:	e8 35 eb ff ff       	call   801044f0 <release>
      return -1;
801059bb:	83 c4 10             	add    $0x10,%esp
801059be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
801059c3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801059c6:	c9                   	leave  
801059c7:	c3                   	ret    
801059c8:	90                   	nop
801059c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&tickslock);
801059d0:	83 ec 0c             	sub    $0xc,%esp
801059d3:	68 e0 75 11 80       	push   $0x801175e0
801059d8:	e8 13 eb ff ff       	call   801044f0 <release>
  return 0;
801059dd:	83 c4 10             	add    $0x10,%esp
801059e0:	31 c0                	xor    %eax,%eax
}
801059e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801059e5:	c9                   	leave  
801059e6:	c3                   	ret    
    return -1;
801059e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059ec:	eb d5                	jmp    801059c3 <sys_sleep+0x83>
801059ee:	66 90                	xchg   %ax,%ax

801059f0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801059f0:	55                   	push   %ebp
801059f1:	89 e5                	mov    %esp,%ebp
801059f3:	53                   	push   %ebx
801059f4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801059f7:	68 e0 75 11 80       	push   $0x801175e0
801059fc:	e8 0f e9 ff ff       	call   80104310 <acquire>
  xticks = ticks;
80105a01:	8b 1d 20 7e 11 80    	mov    0x80117e20,%ebx
  release(&tickslock);
80105a07:	c7 04 24 e0 75 11 80 	movl   $0x801175e0,(%esp)
80105a0e:	e8 dd ea ff ff       	call   801044f0 <release>
  return xticks;
}
80105a13:	89 d8                	mov    %ebx,%eax
80105a15:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a18:	c9                   	leave  
80105a19:	c3                   	ret    
80105a1a:	66 90                	xchg   %ax,%ax
80105a1c:	66 90                	xchg   %ax,%ax
80105a1e:	66 90                	xchg   %ax,%ax

80105a20 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
80105a20:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105a21:	ba 43 00 00 00       	mov    $0x43,%edx
80105a26:	b8 34 00 00 00       	mov    $0x34,%eax
80105a2b:	89 e5                	mov    %esp,%ebp
80105a2d:	83 ec 14             	sub    $0x14,%esp
80105a30:	ee                   	out    %al,(%dx)
80105a31:	ba 40 00 00 00       	mov    $0x40,%edx
80105a36:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
80105a3b:	ee                   	out    %al,(%dx)
80105a3c:	b8 2e 00 00 00       	mov    $0x2e,%eax
80105a41:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  picenable(IRQ_TIMER);
80105a42:	6a 00                	push   $0x0
80105a44:	e8 57 d8 ff ff       	call   801032a0 <picenable>
}
80105a49:	83 c4 10             	add    $0x10,%esp
80105a4c:	c9                   	leave  
80105a4d:	c3                   	ret    

80105a4e <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105a4e:	1e                   	push   %ds
  pushl %es
80105a4f:	06                   	push   %es
  pushl %fs
80105a50:	0f a0                	push   %fs
  pushl %gs
80105a52:	0f a8                	push   %gs
  pushal
80105a54:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
80105a55:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105a59:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105a5b:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
80105a5d:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
80105a61:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
80105a63:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
80105a65:	54                   	push   %esp
  call trap
80105a66:	e8 e5 00 00 00       	call   80105b50 <trap>
  addl $4, %esp
80105a6b:	83 c4 04             	add    $0x4,%esp

80105a6e <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105a6e:	61                   	popa   
  popl %gs
80105a6f:	0f a9                	pop    %gs
  popl %fs
80105a71:	0f a1                	pop    %fs
  popl %es
80105a73:	07                   	pop    %es
  popl %ds
80105a74:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105a75:	83 c4 08             	add    $0x8,%esp
  iret
80105a78:	cf                   	iret   
80105a79:	66 90                	xchg   %ax,%ax
80105a7b:	66 90                	xchg   %ax,%ax
80105a7d:	66 90                	xchg   %ax,%ax
80105a7f:	90                   	nop

80105a80 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105a80:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105a81:	31 c0                	xor    %eax,%eax
{
80105a83:	89 e5                	mov    %esp,%ebp
80105a85:	83 ec 08             	sub    $0x8,%esp
80105a88:	90                   	nop
80105a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105a90:	8b 14 85 0c a0 10 80 	mov    -0x7fef5ff4(,%eax,4),%edx
80105a97:	b9 08 00 00 00       	mov    $0x8,%ecx
80105a9c:	c6 04 c5 24 76 11 80 	movb   $0x0,-0x7fee89dc(,%eax,8)
80105aa3:	00 
80105aa4:	66 89 0c c5 22 76 11 	mov    %cx,-0x7fee89de(,%eax,8)
80105aab:	80 
80105aac:	c6 04 c5 25 76 11 80 	movb   $0x8e,-0x7fee89db(,%eax,8)
80105ab3:	8e 
80105ab4:	66 89 14 c5 20 76 11 	mov    %dx,-0x7fee89e0(,%eax,8)
80105abb:	80 
80105abc:	c1 ea 10             	shr    $0x10,%edx
80105abf:	66 89 14 c5 26 76 11 	mov    %dx,-0x7fee89da(,%eax,8)
80105ac6:	80 
  for(i = 0; i < 256; i++)
80105ac7:	83 c0 01             	add    $0x1,%eax
80105aca:	3d 00 01 00 00       	cmp    $0x100,%eax
80105acf:	75 bf                	jne    80105a90 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105ad1:	a1 0c a1 10 80       	mov    0x8010a10c,%eax

  initlock(&tickslock, "time");
80105ad6:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105ad9:	ba 08 00 00 00       	mov    $0x8,%edx
  initlock(&tickslock, "time");
80105ade:	68 2e 7d 10 80       	push   $0x80107d2e
80105ae3:	68 e0 75 11 80       	push   $0x801175e0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105ae8:	66 89 15 22 78 11 80 	mov    %dx,0x80117822
80105aef:	c6 05 24 78 11 80 00 	movb   $0x0,0x80117824
80105af6:	66 a3 20 78 11 80    	mov    %ax,0x80117820
80105afc:	c1 e8 10             	shr    $0x10,%eax
80105aff:	c6 05 25 78 11 80 ef 	movb   $0xef,0x80117825
80105b06:	66 a3 26 78 11 80    	mov    %ax,0x80117826
  initlock(&tickslock, "time");
80105b0c:	e8 df e7 ff ff       	call   801042f0 <initlock>
}
80105b11:	83 c4 10             	add    $0x10,%esp
80105b14:	c9                   	leave  
80105b15:	c3                   	ret    
80105b16:	8d 76 00             	lea    0x0(%esi),%esi
80105b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b20 <idtinit>:

void
idtinit(void)
{
80105b20:	55                   	push   %ebp
  pd[0] = size-1;
80105b21:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105b26:	89 e5                	mov    %esp,%ebp
80105b28:	83 ec 10             	sub    $0x10,%esp
80105b2b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105b2f:	b8 20 76 11 80       	mov    $0x80117620,%eax
80105b34:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105b38:	c1 e8 10             	shr    $0x10,%eax
80105b3b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105b3f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105b42:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105b45:	c9                   	leave  
80105b46:	c3                   	ret    
80105b47:	89 f6                	mov    %esi,%esi
80105b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b50 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105b50:	55                   	push   %ebp
80105b51:	89 e5                	mov    %esp,%ebp
80105b53:	57                   	push   %edi
80105b54:	56                   	push   %esi
80105b55:	53                   	push   %ebx
80105b56:	83 ec 0c             	sub    $0xc,%esp
80105b59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105b5c:	8b 43 30             	mov    0x30(%ebx),%eax
80105b5f:	83 f8 40             	cmp    $0x40,%eax
80105b62:	0f 84 f8 00 00 00    	je     80105c60 <trap+0x110>
    if(proc->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105b68:	83 e8 20             	sub    $0x20,%eax
80105b6b:	83 f8 1f             	cmp    $0x1f,%eax
80105b6e:	77 68                	ja     80105bd8 <trap+0x88>
80105b70:	ff 24 85 d4 7d 10 80 	jmp    *-0x7fef822c(,%eax,4)
80105b77:	89 f6                	mov    %esi,%esi
80105b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
80105b80:	e8 6b cb ff ff       	call   801026f0 <cpunum>
80105b85:	85 c0                	test   %eax,%eax
80105b87:	0f 84 b3 01 00 00    	je     80105d40 <trap+0x1f0>
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
    lapiceoi();
80105b8d:	e8 fe cb ff ff       	call   80102790 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105b92:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105b98:	85 c0                	test   %eax,%eax
80105b9a:	74 2d                	je     80105bc9 <trap+0x79>
80105b9c:	8b 50 24             	mov    0x24(%eax),%edx
80105b9f:	85 d2                	test   %edx,%edx
80105ba1:	0f 85 86 00 00 00    	jne    80105c2d <trap+0xdd>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105ba7:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105bab:	0f 84 ef 00 00 00    	je     80105ca0 <trap+0x150>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105bb1:	8b 40 24             	mov    0x24(%eax),%eax
80105bb4:	85 c0                	test   %eax,%eax
80105bb6:	74 11                	je     80105bc9 <trap+0x79>
80105bb8:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105bbc:	83 e0 03             	and    $0x3,%eax
80105bbf:	66 83 f8 03          	cmp    $0x3,%ax
80105bc3:	0f 84 c1 00 00 00    	je     80105c8a <trap+0x13a>
    exit();
}
80105bc9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bcc:	5b                   	pop    %ebx
80105bcd:	5e                   	pop    %esi
80105bce:	5f                   	pop    %edi
80105bcf:	5d                   	pop    %ebp
80105bd0:	c3                   	ret    
80105bd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(proc == 0 || (tf->cs&3) == 0){
80105bd8:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
80105bdf:	85 c9                	test   %ecx,%ecx
80105be1:	0f 84 8d 01 00 00    	je     80105d74 <trap+0x224>
80105be7:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105beb:	0f 84 83 01 00 00    	je     80105d74 <trap+0x224>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105bf1:	0f 20 d7             	mov    %cr2,%edi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105bf4:	8b 73 38             	mov    0x38(%ebx),%esi
80105bf7:	e8 f4 ca ff ff       	call   801026f0 <cpunum>
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80105bfc:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105c03:	57                   	push   %edi
80105c04:	56                   	push   %esi
80105c05:	50                   	push   %eax
80105c06:	ff 73 34             	pushl  0x34(%ebx)
80105c09:	ff 73 30             	pushl  0x30(%ebx)
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80105c0c:	8d 42 6c             	lea    0x6c(%edx),%eax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105c0f:	50                   	push   %eax
80105c10:	ff 72 10             	pushl  0x10(%edx)
80105c13:	68 90 7d 10 80       	push   $0x80107d90
80105c18:	e8 43 aa ff ff       	call   80100660 <cprintf>
    proc->killed = 1;
80105c1d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105c23:	83 c4 20             	add    $0x20,%esp
80105c26:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105c2d:	0f b7 53 3c          	movzwl 0x3c(%ebx),%edx
80105c31:	83 e2 03             	and    $0x3,%edx
80105c34:	66 83 fa 03          	cmp    $0x3,%dx
80105c38:	0f 85 69 ff ff ff    	jne    80105ba7 <trap+0x57>
    exit();
80105c3e:	e8 9d e0 ff ff       	call   80103ce0 <exit>
80105c43:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105c49:	85 c0                	test   %eax,%eax
80105c4b:	0f 85 56 ff ff ff    	jne    80105ba7 <trap+0x57>
80105c51:	e9 73 ff ff ff       	jmp    80105bc9 <trap+0x79>
80105c56:	8d 76 00             	lea    0x0(%esi),%esi
80105c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(proc->killed)
80105c60:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105c66:	8b 70 24             	mov    0x24(%eax),%esi
80105c69:	85 f6                	test   %esi,%esi
80105c6b:	0f 85 bf 00 00 00    	jne    80105d30 <trap+0x1e0>
    proc->tf = tf;
80105c71:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105c74:	e8 97 ec ff ff       	call   80104910 <syscall>
    if(proc->killed)
80105c79:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105c7f:	8b 58 24             	mov    0x24(%eax),%ebx
80105c82:	85 db                	test   %ebx,%ebx
80105c84:	0f 84 3f ff ff ff    	je     80105bc9 <trap+0x79>
}
80105c8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c8d:	5b                   	pop    %ebx
80105c8e:	5e                   	pop    %esi
80105c8f:	5f                   	pop    %edi
80105c90:	5d                   	pop    %ebp
      exit();
80105c91:	e9 4a e0 ff ff       	jmp    80103ce0 <exit>
80105c96:	8d 76 00             	lea    0x0(%esi),%esi
80105c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105ca0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105ca4:	0f 85 07 ff ff ff    	jne    80105bb1 <trap+0x61>
    yield();
80105caa:	e8 81 e1 ff ff       	call   80103e30 <yield>
80105caf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105cb5:	85 c0                	test   %eax,%eax
80105cb7:	0f 85 f4 fe ff ff    	jne    80105bb1 <trap+0x61>
80105cbd:	e9 07 ff ff ff       	jmp    80105bc9 <trap+0x79>
80105cc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    kbdintr();
80105cc8:	e8 03 c9 ff ff       	call   801025d0 <kbdintr>
    lapiceoi();
80105ccd:	e8 be ca ff ff       	call   80102790 <lapiceoi>
    break;
80105cd2:	e9 bb fe ff ff       	jmp    80105b92 <trap+0x42>
80105cd7:	89 f6                	mov    %esi,%esi
80105cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    uartintr();
80105ce0:	e8 2b 02 00 00       	call   80105f10 <uartintr>
80105ce5:	e9 a3 fe ff ff       	jmp    80105b8d <trap+0x3d>
80105cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105cf0:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105cf4:	8b 7b 38             	mov    0x38(%ebx),%edi
80105cf7:	e8 f4 c9 ff ff       	call   801026f0 <cpunum>
80105cfc:	57                   	push   %edi
80105cfd:	56                   	push   %esi
80105cfe:	50                   	push   %eax
80105cff:	68 38 7d 10 80       	push   $0x80107d38
80105d04:	e8 57 a9 ff ff       	call   80100660 <cprintf>
    lapiceoi();
80105d09:	e8 82 ca ff ff       	call   80102790 <lapiceoi>
    break;
80105d0e:	83 c4 10             	add    $0x10,%esp
80105d11:	e9 7c fe ff ff       	jmp    80105b92 <trap+0x42>
80105d16:	8d 76 00             	lea    0x0(%esi),%esi
80105d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ideintr();
80105d20:	e8 0b c3 ff ff       	call   80102030 <ideintr>
    lapiceoi();
80105d25:	e8 66 ca ff ff       	call   80102790 <lapiceoi>
    break;
80105d2a:	e9 63 fe ff ff       	jmp    80105b92 <trap+0x42>
80105d2f:	90                   	nop
      exit();
80105d30:	e8 ab df ff ff       	call   80103ce0 <exit>
80105d35:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105d3b:	e9 31 ff ff ff       	jmp    80105c71 <trap+0x121>
      acquire(&tickslock);
80105d40:	83 ec 0c             	sub    $0xc,%esp
80105d43:	68 e0 75 11 80       	push   $0x801175e0
80105d48:	e8 c3 e5 ff ff       	call   80104310 <acquire>
      wakeup(&ticks);
80105d4d:	c7 04 24 20 7e 11 80 	movl   $0x80117e20,(%esp)
      ticks++;
80105d54:	83 05 20 7e 11 80 01 	addl   $0x1,0x80117e20
      wakeup(&ticks);
80105d5b:	e8 c0 e2 ff ff       	call   80104020 <wakeup>
      release(&tickslock);
80105d60:	c7 04 24 e0 75 11 80 	movl   $0x801175e0,(%esp)
80105d67:	e8 84 e7 ff ff       	call   801044f0 <release>
80105d6c:	83 c4 10             	add    $0x10,%esp
80105d6f:	e9 19 fe ff ff       	jmp    80105b8d <trap+0x3d>
80105d74:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105d77:	8b 73 38             	mov    0x38(%ebx),%esi
80105d7a:	e8 71 c9 ff ff       	call   801026f0 <cpunum>
80105d7f:	83 ec 0c             	sub    $0xc,%esp
80105d82:	57                   	push   %edi
80105d83:	56                   	push   %esi
80105d84:	50                   	push   %eax
80105d85:	ff 73 30             	pushl  0x30(%ebx)
80105d88:	68 5c 7d 10 80       	push   $0x80107d5c
80105d8d:	e8 ce a8 ff ff       	call   80100660 <cprintf>
      panic("trap");
80105d92:	83 c4 14             	add    $0x14,%esp
80105d95:	68 33 7d 10 80       	push   $0x80107d33
80105d9a:	e8 d1 a5 ff ff       	call   80100370 <panic>
80105d9f:	90                   	nop

80105da0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105da0:	a1 c0 a5 10 80       	mov    0x8010a5c0,%eax
{
80105da5:	55                   	push   %ebp
80105da6:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105da8:	85 c0                	test   %eax,%eax
80105daa:	74 1c                	je     80105dc8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105dac:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105db1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105db2:	a8 01                	test   $0x1,%al
80105db4:	74 12                	je     80105dc8 <uartgetc+0x28>
80105db6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105dbb:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105dbc:	0f b6 c0             	movzbl %al,%eax
}
80105dbf:	5d                   	pop    %ebp
80105dc0:	c3                   	ret    
80105dc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105dc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105dcd:	5d                   	pop    %ebp
80105dce:	c3                   	ret    
80105dcf:	90                   	nop

80105dd0 <uartputc.part.0>:
uartputc(int c)
80105dd0:	55                   	push   %ebp
80105dd1:	89 e5                	mov    %esp,%ebp
80105dd3:	57                   	push   %edi
80105dd4:	56                   	push   %esi
80105dd5:	53                   	push   %ebx
80105dd6:	89 c7                	mov    %eax,%edi
80105dd8:	bb 80 00 00 00       	mov    $0x80,%ebx
80105ddd:	be fd 03 00 00       	mov    $0x3fd,%esi
80105de2:	83 ec 0c             	sub    $0xc,%esp
80105de5:	eb 1b                	jmp    80105e02 <uartputc.part.0+0x32>
80105de7:	89 f6                	mov    %esi,%esi
80105de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80105df0:	83 ec 0c             	sub    $0xc,%esp
80105df3:	6a 0a                	push   $0xa
80105df5:	e8 b6 c9 ff ff       	call   801027b0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105dfa:	83 c4 10             	add    $0x10,%esp
80105dfd:	83 eb 01             	sub    $0x1,%ebx
80105e00:	74 07                	je     80105e09 <uartputc.part.0+0x39>
80105e02:	89 f2                	mov    %esi,%edx
80105e04:	ec                   	in     (%dx),%al
80105e05:	a8 20                	test   $0x20,%al
80105e07:	74 e7                	je     80105df0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105e09:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e0e:	89 f8                	mov    %edi,%eax
80105e10:	ee                   	out    %al,(%dx)
}
80105e11:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e14:	5b                   	pop    %ebx
80105e15:	5e                   	pop    %esi
80105e16:	5f                   	pop    %edi
80105e17:	5d                   	pop    %ebp
80105e18:	c3                   	ret    
80105e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e20 <uartinit>:
{
80105e20:	55                   	push   %ebp
80105e21:	31 c9                	xor    %ecx,%ecx
80105e23:	89 c8                	mov    %ecx,%eax
80105e25:	89 e5                	mov    %esp,%ebp
80105e27:	57                   	push   %edi
80105e28:	56                   	push   %esi
80105e29:	53                   	push   %ebx
80105e2a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105e2f:	89 da                	mov    %ebx,%edx
80105e31:	83 ec 0c             	sub    $0xc,%esp
80105e34:	ee                   	out    %al,(%dx)
80105e35:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105e3a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105e3f:	89 fa                	mov    %edi,%edx
80105e41:	ee                   	out    %al,(%dx)
80105e42:	b8 0c 00 00 00       	mov    $0xc,%eax
80105e47:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e4c:	ee                   	out    %al,(%dx)
80105e4d:	be f9 03 00 00       	mov    $0x3f9,%esi
80105e52:	89 c8                	mov    %ecx,%eax
80105e54:	89 f2                	mov    %esi,%edx
80105e56:	ee                   	out    %al,(%dx)
80105e57:	b8 03 00 00 00       	mov    $0x3,%eax
80105e5c:	89 fa                	mov    %edi,%edx
80105e5e:	ee                   	out    %al,(%dx)
80105e5f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105e64:	89 c8                	mov    %ecx,%eax
80105e66:	ee                   	out    %al,(%dx)
80105e67:	b8 01 00 00 00       	mov    $0x1,%eax
80105e6c:	89 f2                	mov    %esi,%edx
80105e6e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105e6f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105e74:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105e75:	3c ff                	cmp    $0xff,%al
80105e77:	74 5a                	je     80105ed3 <uartinit+0xb3>
  uart = 1;
80105e79:	c7 05 c0 a5 10 80 01 	movl   $0x1,0x8010a5c0
80105e80:	00 00 00 
80105e83:	89 da                	mov    %ebx,%edx
80105e85:	ec                   	in     (%dx),%al
80105e86:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e8b:	ec                   	in     (%dx),%al
  picenable(IRQ_COM1);
80105e8c:	83 ec 0c             	sub    $0xc,%esp
80105e8f:	6a 04                	push   $0x4
80105e91:	e8 0a d4 ff ff       	call   801032a0 <picenable>
  ioapicenable(IRQ_COM1, 0);
80105e96:	59                   	pop    %ecx
80105e97:	5b                   	pop    %ebx
80105e98:	6a 00                	push   $0x0
80105e9a:	6a 04                	push   $0x4
80105e9c:	bb 54 7e 10 80       	mov    $0x80107e54,%ebx
80105ea1:	e8 ea c3 ff ff       	call   80102290 <ioapicenable>
80105ea6:	83 c4 10             	add    $0x10,%esp
80105ea9:	b8 78 00 00 00       	mov    $0x78,%eax
80105eae:	eb 0a                	jmp    80105eba <uartinit+0x9a>
  for(p="xv6...\n"; *p; p++)
80105eb0:	83 c3 01             	add    $0x1,%ebx
80105eb3:	0f be 03             	movsbl (%ebx),%eax
80105eb6:	84 c0                	test   %al,%al
80105eb8:	74 19                	je     80105ed3 <uartinit+0xb3>
  if(!uart)
80105eba:	8b 15 c0 a5 10 80    	mov    0x8010a5c0,%edx
80105ec0:	85 d2                	test   %edx,%edx
80105ec2:	74 ec                	je     80105eb0 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80105ec4:	83 c3 01             	add    $0x1,%ebx
80105ec7:	e8 04 ff ff ff       	call   80105dd0 <uartputc.part.0>
80105ecc:	0f be 03             	movsbl (%ebx),%eax
80105ecf:	84 c0                	test   %al,%al
80105ed1:	75 e7                	jne    80105eba <uartinit+0x9a>
}
80105ed3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ed6:	5b                   	pop    %ebx
80105ed7:	5e                   	pop    %esi
80105ed8:	5f                   	pop    %edi
80105ed9:	5d                   	pop    %ebp
80105eda:	c3                   	ret    
80105edb:	90                   	nop
80105edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ee0 <uartputc>:
  if(!uart)
80105ee0:	8b 15 c0 a5 10 80    	mov    0x8010a5c0,%edx
{
80105ee6:	55                   	push   %ebp
80105ee7:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105ee9:	85 d2                	test   %edx,%edx
{
80105eeb:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105eee:	74 10                	je     80105f00 <uartputc+0x20>
}
80105ef0:	5d                   	pop    %ebp
80105ef1:	e9 da fe ff ff       	jmp    80105dd0 <uartputc.part.0>
80105ef6:	8d 76 00             	lea    0x0(%esi),%esi
80105ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105f00:	5d                   	pop    %ebp
80105f01:	c3                   	ret    
80105f02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105f10 <uartintr>:

void
uartintr(void)
{
80105f10:	55                   	push   %ebp
80105f11:	89 e5                	mov    %esp,%ebp
80105f13:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105f16:	68 a0 5d 10 80       	push   $0x80105da0
80105f1b:	e8 c0 a8 ff ff       	call   801007e0 <consoleintr>
}
80105f20:	83 c4 10             	add    $0x10,%esp
80105f23:	c9                   	leave  
80105f24:	c3                   	ret    

80105f25 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105f25:	6a 00                	push   $0x0
  pushl $0
80105f27:	6a 00                	push   $0x0
  jmp alltraps
80105f29:	e9 20 fb ff ff       	jmp    80105a4e <alltraps>

80105f2e <vector1>:
.globl vector1
vector1:
  pushl $0
80105f2e:	6a 00                	push   $0x0
  pushl $1
80105f30:	6a 01                	push   $0x1
  jmp alltraps
80105f32:	e9 17 fb ff ff       	jmp    80105a4e <alltraps>

80105f37 <vector2>:
.globl vector2
vector2:
  pushl $0
80105f37:	6a 00                	push   $0x0
  pushl $2
80105f39:	6a 02                	push   $0x2
  jmp alltraps
80105f3b:	e9 0e fb ff ff       	jmp    80105a4e <alltraps>

80105f40 <vector3>:
.globl vector3
vector3:
  pushl $0
80105f40:	6a 00                	push   $0x0
  pushl $3
80105f42:	6a 03                	push   $0x3
  jmp alltraps
80105f44:	e9 05 fb ff ff       	jmp    80105a4e <alltraps>

80105f49 <vector4>:
.globl vector4
vector4:
  pushl $0
80105f49:	6a 00                	push   $0x0
  pushl $4
80105f4b:	6a 04                	push   $0x4
  jmp alltraps
80105f4d:	e9 fc fa ff ff       	jmp    80105a4e <alltraps>

80105f52 <vector5>:
.globl vector5
vector5:
  pushl $0
80105f52:	6a 00                	push   $0x0
  pushl $5
80105f54:	6a 05                	push   $0x5
  jmp alltraps
80105f56:	e9 f3 fa ff ff       	jmp    80105a4e <alltraps>

80105f5b <vector6>:
.globl vector6
vector6:
  pushl $0
80105f5b:	6a 00                	push   $0x0
  pushl $6
80105f5d:	6a 06                	push   $0x6
  jmp alltraps
80105f5f:	e9 ea fa ff ff       	jmp    80105a4e <alltraps>

80105f64 <vector7>:
.globl vector7
vector7:
  pushl $0
80105f64:	6a 00                	push   $0x0
  pushl $7
80105f66:	6a 07                	push   $0x7
  jmp alltraps
80105f68:	e9 e1 fa ff ff       	jmp    80105a4e <alltraps>

80105f6d <vector8>:
.globl vector8
vector8:
  pushl $8
80105f6d:	6a 08                	push   $0x8
  jmp alltraps
80105f6f:	e9 da fa ff ff       	jmp    80105a4e <alltraps>

80105f74 <vector9>:
.globl vector9
vector9:
  pushl $0
80105f74:	6a 00                	push   $0x0
  pushl $9
80105f76:	6a 09                	push   $0x9
  jmp alltraps
80105f78:	e9 d1 fa ff ff       	jmp    80105a4e <alltraps>

80105f7d <vector10>:
.globl vector10
vector10:
  pushl $10
80105f7d:	6a 0a                	push   $0xa
  jmp alltraps
80105f7f:	e9 ca fa ff ff       	jmp    80105a4e <alltraps>

80105f84 <vector11>:
.globl vector11
vector11:
  pushl $11
80105f84:	6a 0b                	push   $0xb
  jmp alltraps
80105f86:	e9 c3 fa ff ff       	jmp    80105a4e <alltraps>

80105f8b <vector12>:
.globl vector12
vector12:
  pushl $12
80105f8b:	6a 0c                	push   $0xc
  jmp alltraps
80105f8d:	e9 bc fa ff ff       	jmp    80105a4e <alltraps>

80105f92 <vector13>:
.globl vector13
vector13:
  pushl $13
80105f92:	6a 0d                	push   $0xd
  jmp alltraps
80105f94:	e9 b5 fa ff ff       	jmp    80105a4e <alltraps>

80105f99 <vector14>:
.globl vector14
vector14:
  pushl $14
80105f99:	6a 0e                	push   $0xe
  jmp alltraps
80105f9b:	e9 ae fa ff ff       	jmp    80105a4e <alltraps>

80105fa0 <vector15>:
.globl vector15
vector15:
  pushl $0
80105fa0:	6a 00                	push   $0x0
  pushl $15
80105fa2:	6a 0f                	push   $0xf
  jmp alltraps
80105fa4:	e9 a5 fa ff ff       	jmp    80105a4e <alltraps>

80105fa9 <vector16>:
.globl vector16
vector16:
  pushl $0
80105fa9:	6a 00                	push   $0x0
  pushl $16
80105fab:	6a 10                	push   $0x10
  jmp alltraps
80105fad:	e9 9c fa ff ff       	jmp    80105a4e <alltraps>

80105fb2 <vector17>:
.globl vector17
vector17:
  pushl $17
80105fb2:	6a 11                	push   $0x11
  jmp alltraps
80105fb4:	e9 95 fa ff ff       	jmp    80105a4e <alltraps>

80105fb9 <vector18>:
.globl vector18
vector18:
  pushl $0
80105fb9:	6a 00                	push   $0x0
  pushl $18
80105fbb:	6a 12                	push   $0x12
  jmp alltraps
80105fbd:	e9 8c fa ff ff       	jmp    80105a4e <alltraps>

80105fc2 <vector19>:
.globl vector19
vector19:
  pushl $0
80105fc2:	6a 00                	push   $0x0
  pushl $19
80105fc4:	6a 13                	push   $0x13
  jmp alltraps
80105fc6:	e9 83 fa ff ff       	jmp    80105a4e <alltraps>

80105fcb <vector20>:
.globl vector20
vector20:
  pushl $0
80105fcb:	6a 00                	push   $0x0
  pushl $20
80105fcd:	6a 14                	push   $0x14
  jmp alltraps
80105fcf:	e9 7a fa ff ff       	jmp    80105a4e <alltraps>

80105fd4 <vector21>:
.globl vector21
vector21:
  pushl $0
80105fd4:	6a 00                	push   $0x0
  pushl $21
80105fd6:	6a 15                	push   $0x15
  jmp alltraps
80105fd8:	e9 71 fa ff ff       	jmp    80105a4e <alltraps>

80105fdd <vector22>:
.globl vector22
vector22:
  pushl $0
80105fdd:	6a 00                	push   $0x0
  pushl $22
80105fdf:	6a 16                	push   $0x16
  jmp alltraps
80105fe1:	e9 68 fa ff ff       	jmp    80105a4e <alltraps>

80105fe6 <vector23>:
.globl vector23
vector23:
  pushl $0
80105fe6:	6a 00                	push   $0x0
  pushl $23
80105fe8:	6a 17                	push   $0x17
  jmp alltraps
80105fea:	e9 5f fa ff ff       	jmp    80105a4e <alltraps>

80105fef <vector24>:
.globl vector24
vector24:
  pushl $0
80105fef:	6a 00                	push   $0x0
  pushl $24
80105ff1:	6a 18                	push   $0x18
  jmp alltraps
80105ff3:	e9 56 fa ff ff       	jmp    80105a4e <alltraps>

80105ff8 <vector25>:
.globl vector25
vector25:
  pushl $0
80105ff8:	6a 00                	push   $0x0
  pushl $25
80105ffa:	6a 19                	push   $0x19
  jmp alltraps
80105ffc:	e9 4d fa ff ff       	jmp    80105a4e <alltraps>

80106001 <vector26>:
.globl vector26
vector26:
  pushl $0
80106001:	6a 00                	push   $0x0
  pushl $26
80106003:	6a 1a                	push   $0x1a
  jmp alltraps
80106005:	e9 44 fa ff ff       	jmp    80105a4e <alltraps>

8010600a <vector27>:
.globl vector27
vector27:
  pushl $0
8010600a:	6a 00                	push   $0x0
  pushl $27
8010600c:	6a 1b                	push   $0x1b
  jmp alltraps
8010600e:	e9 3b fa ff ff       	jmp    80105a4e <alltraps>

80106013 <vector28>:
.globl vector28
vector28:
  pushl $0
80106013:	6a 00                	push   $0x0
  pushl $28
80106015:	6a 1c                	push   $0x1c
  jmp alltraps
80106017:	e9 32 fa ff ff       	jmp    80105a4e <alltraps>

8010601c <vector29>:
.globl vector29
vector29:
  pushl $0
8010601c:	6a 00                	push   $0x0
  pushl $29
8010601e:	6a 1d                	push   $0x1d
  jmp alltraps
80106020:	e9 29 fa ff ff       	jmp    80105a4e <alltraps>

80106025 <vector30>:
.globl vector30
vector30:
  pushl $0
80106025:	6a 00                	push   $0x0
  pushl $30
80106027:	6a 1e                	push   $0x1e
  jmp alltraps
80106029:	e9 20 fa ff ff       	jmp    80105a4e <alltraps>

8010602e <vector31>:
.globl vector31
vector31:
  pushl $0
8010602e:	6a 00                	push   $0x0
  pushl $31
80106030:	6a 1f                	push   $0x1f
  jmp alltraps
80106032:	e9 17 fa ff ff       	jmp    80105a4e <alltraps>

80106037 <vector32>:
.globl vector32
vector32:
  pushl $0
80106037:	6a 00                	push   $0x0
  pushl $32
80106039:	6a 20                	push   $0x20
  jmp alltraps
8010603b:	e9 0e fa ff ff       	jmp    80105a4e <alltraps>

80106040 <vector33>:
.globl vector33
vector33:
  pushl $0
80106040:	6a 00                	push   $0x0
  pushl $33
80106042:	6a 21                	push   $0x21
  jmp alltraps
80106044:	e9 05 fa ff ff       	jmp    80105a4e <alltraps>

80106049 <vector34>:
.globl vector34
vector34:
  pushl $0
80106049:	6a 00                	push   $0x0
  pushl $34
8010604b:	6a 22                	push   $0x22
  jmp alltraps
8010604d:	e9 fc f9 ff ff       	jmp    80105a4e <alltraps>

80106052 <vector35>:
.globl vector35
vector35:
  pushl $0
80106052:	6a 00                	push   $0x0
  pushl $35
80106054:	6a 23                	push   $0x23
  jmp alltraps
80106056:	e9 f3 f9 ff ff       	jmp    80105a4e <alltraps>

8010605b <vector36>:
.globl vector36
vector36:
  pushl $0
8010605b:	6a 00                	push   $0x0
  pushl $36
8010605d:	6a 24                	push   $0x24
  jmp alltraps
8010605f:	e9 ea f9 ff ff       	jmp    80105a4e <alltraps>

80106064 <vector37>:
.globl vector37
vector37:
  pushl $0
80106064:	6a 00                	push   $0x0
  pushl $37
80106066:	6a 25                	push   $0x25
  jmp alltraps
80106068:	e9 e1 f9 ff ff       	jmp    80105a4e <alltraps>

8010606d <vector38>:
.globl vector38
vector38:
  pushl $0
8010606d:	6a 00                	push   $0x0
  pushl $38
8010606f:	6a 26                	push   $0x26
  jmp alltraps
80106071:	e9 d8 f9 ff ff       	jmp    80105a4e <alltraps>

80106076 <vector39>:
.globl vector39
vector39:
  pushl $0
80106076:	6a 00                	push   $0x0
  pushl $39
80106078:	6a 27                	push   $0x27
  jmp alltraps
8010607a:	e9 cf f9 ff ff       	jmp    80105a4e <alltraps>

8010607f <vector40>:
.globl vector40
vector40:
  pushl $0
8010607f:	6a 00                	push   $0x0
  pushl $40
80106081:	6a 28                	push   $0x28
  jmp alltraps
80106083:	e9 c6 f9 ff ff       	jmp    80105a4e <alltraps>

80106088 <vector41>:
.globl vector41
vector41:
  pushl $0
80106088:	6a 00                	push   $0x0
  pushl $41
8010608a:	6a 29                	push   $0x29
  jmp alltraps
8010608c:	e9 bd f9 ff ff       	jmp    80105a4e <alltraps>

80106091 <vector42>:
.globl vector42
vector42:
  pushl $0
80106091:	6a 00                	push   $0x0
  pushl $42
80106093:	6a 2a                	push   $0x2a
  jmp alltraps
80106095:	e9 b4 f9 ff ff       	jmp    80105a4e <alltraps>

8010609a <vector43>:
.globl vector43
vector43:
  pushl $0
8010609a:	6a 00                	push   $0x0
  pushl $43
8010609c:	6a 2b                	push   $0x2b
  jmp alltraps
8010609e:	e9 ab f9 ff ff       	jmp    80105a4e <alltraps>

801060a3 <vector44>:
.globl vector44
vector44:
  pushl $0
801060a3:	6a 00                	push   $0x0
  pushl $44
801060a5:	6a 2c                	push   $0x2c
  jmp alltraps
801060a7:	e9 a2 f9 ff ff       	jmp    80105a4e <alltraps>

801060ac <vector45>:
.globl vector45
vector45:
  pushl $0
801060ac:	6a 00                	push   $0x0
  pushl $45
801060ae:	6a 2d                	push   $0x2d
  jmp alltraps
801060b0:	e9 99 f9 ff ff       	jmp    80105a4e <alltraps>

801060b5 <vector46>:
.globl vector46
vector46:
  pushl $0
801060b5:	6a 00                	push   $0x0
  pushl $46
801060b7:	6a 2e                	push   $0x2e
  jmp alltraps
801060b9:	e9 90 f9 ff ff       	jmp    80105a4e <alltraps>

801060be <vector47>:
.globl vector47
vector47:
  pushl $0
801060be:	6a 00                	push   $0x0
  pushl $47
801060c0:	6a 2f                	push   $0x2f
  jmp alltraps
801060c2:	e9 87 f9 ff ff       	jmp    80105a4e <alltraps>

801060c7 <vector48>:
.globl vector48
vector48:
  pushl $0
801060c7:	6a 00                	push   $0x0
  pushl $48
801060c9:	6a 30                	push   $0x30
  jmp alltraps
801060cb:	e9 7e f9 ff ff       	jmp    80105a4e <alltraps>

801060d0 <vector49>:
.globl vector49
vector49:
  pushl $0
801060d0:	6a 00                	push   $0x0
  pushl $49
801060d2:	6a 31                	push   $0x31
  jmp alltraps
801060d4:	e9 75 f9 ff ff       	jmp    80105a4e <alltraps>

801060d9 <vector50>:
.globl vector50
vector50:
  pushl $0
801060d9:	6a 00                	push   $0x0
  pushl $50
801060db:	6a 32                	push   $0x32
  jmp alltraps
801060dd:	e9 6c f9 ff ff       	jmp    80105a4e <alltraps>

801060e2 <vector51>:
.globl vector51
vector51:
  pushl $0
801060e2:	6a 00                	push   $0x0
  pushl $51
801060e4:	6a 33                	push   $0x33
  jmp alltraps
801060e6:	e9 63 f9 ff ff       	jmp    80105a4e <alltraps>

801060eb <vector52>:
.globl vector52
vector52:
  pushl $0
801060eb:	6a 00                	push   $0x0
  pushl $52
801060ed:	6a 34                	push   $0x34
  jmp alltraps
801060ef:	e9 5a f9 ff ff       	jmp    80105a4e <alltraps>

801060f4 <vector53>:
.globl vector53
vector53:
  pushl $0
801060f4:	6a 00                	push   $0x0
  pushl $53
801060f6:	6a 35                	push   $0x35
  jmp alltraps
801060f8:	e9 51 f9 ff ff       	jmp    80105a4e <alltraps>

801060fd <vector54>:
.globl vector54
vector54:
  pushl $0
801060fd:	6a 00                	push   $0x0
  pushl $54
801060ff:	6a 36                	push   $0x36
  jmp alltraps
80106101:	e9 48 f9 ff ff       	jmp    80105a4e <alltraps>

80106106 <vector55>:
.globl vector55
vector55:
  pushl $0
80106106:	6a 00                	push   $0x0
  pushl $55
80106108:	6a 37                	push   $0x37
  jmp alltraps
8010610a:	e9 3f f9 ff ff       	jmp    80105a4e <alltraps>

8010610f <vector56>:
.globl vector56
vector56:
  pushl $0
8010610f:	6a 00                	push   $0x0
  pushl $56
80106111:	6a 38                	push   $0x38
  jmp alltraps
80106113:	e9 36 f9 ff ff       	jmp    80105a4e <alltraps>

80106118 <vector57>:
.globl vector57
vector57:
  pushl $0
80106118:	6a 00                	push   $0x0
  pushl $57
8010611a:	6a 39                	push   $0x39
  jmp alltraps
8010611c:	e9 2d f9 ff ff       	jmp    80105a4e <alltraps>

80106121 <vector58>:
.globl vector58
vector58:
  pushl $0
80106121:	6a 00                	push   $0x0
  pushl $58
80106123:	6a 3a                	push   $0x3a
  jmp alltraps
80106125:	e9 24 f9 ff ff       	jmp    80105a4e <alltraps>

8010612a <vector59>:
.globl vector59
vector59:
  pushl $0
8010612a:	6a 00                	push   $0x0
  pushl $59
8010612c:	6a 3b                	push   $0x3b
  jmp alltraps
8010612e:	e9 1b f9 ff ff       	jmp    80105a4e <alltraps>

80106133 <vector60>:
.globl vector60
vector60:
  pushl $0
80106133:	6a 00                	push   $0x0
  pushl $60
80106135:	6a 3c                	push   $0x3c
  jmp alltraps
80106137:	e9 12 f9 ff ff       	jmp    80105a4e <alltraps>

8010613c <vector61>:
.globl vector61
vector61:
  pushl $0
8010613c:	6a 00                	push   $0x0
  pushl $61
8010613e:	6a 3d                	push   $0x3d
  jmp alltraps
80106140:	e9 09 f9 ff ff       	jmp    80105a4e <alltraps>

80106145 <vector62>:
.globl vector62
vector62:
  pushl $0
80106145:	6a 00                	push   $0x0
  pushl $62
80106147:	6a 3e                	push   $0x3e
  jmp alltraps
80106149:	e9 00 f9 ff ff       	jmp    80105a4e <alltraps>

8010614e <vector63>:
.globl vector63
vector63:
  pushl $0
8010614e:	6a 00                	push   $0x0
  pushl $63
80106150:	6a 3f                	push   $0x3f
  jmp alltraps
80106152:	e9 f7 f8 ff ff       	jmp    80105a4e <alltraps>

80106157 <vector64>:
.globl vector64
vector64:
  pushl $0
80106157:	6a 00                	push   $0x0
  pushl $64
80106159:	6a 40                	push   $0x40
  jmp alltraps
8010615b:	e9 ee f8 ff ff       	jmp    80105a4e <alltraps>

80106160 <vector65>:
.globl vector65
vector65:
  pushl $0
80106160:	6a 00                	push   $0x0
  pushl $65
80106162:	6a 41                	push   $0x41
  jmp alltraps
80106164:	e9 e5 f8 ff ff       	jmp    80105a4e <alltraps>

80106169 <vector66>:
.globl vector66
vector66:
  pushl $0
80106169:	6a 00                	push   $0x0
  pushl $66
8010616b:	6a 42                	push   $0x42
  jmp alltraps
8010616d:	e9 dc f8 ff ff       	jmp    80105a4e <alltraps>

80106172 <vector67>:
.globl vector67
vector67:
  pushl $0
80106172:	6a 00                	push   $0x0
  pushl $67
80106174:	6a 43                	push   $0x43
  jmp alltraps
80106176:	e9 d3 f8 ff ff       	jmp    80105a4e <alltraps>

8010617b <vector68>:
.globl vector68
vector68:
  pushl $0
8010617b:	6a 00                	push   $0x0
  pushl $68
8010617d:	6a 44                	push   $0x44
  jmp alltraps
8010617f:	e9 ca f8 ff ff       	jmp    80105a4e <alltraps>

80106184 <vector69>:
.globl vector69
vector69:
  pushl $0
80106184:	6a 00                	push   $0x0
  pushl $69
80106186:	6a 45                	push   $0x45
  jmp alltraps
80106188:	e9 c1 f8 ff ff       	jmp    80105a4e <alltraps>

8010618d <vector70>:
.globl vector70
vector70:
  pushl $0
8010618d:	6a 00                	push   $0x0
  pushl $70
8010618f:	6a 46                	push   $0x46
  jmp alltraps
80106191:	e9 b8 f8 ff ff       	jmp    80105a4e <alltraps>

80106196 <vector71>:
.globl vector71
vector71:
  pushl $0
80106196:	6a 00                	push   $0x0
  pushl $71
80106198:	6a 47                	push   $0x47
  jmp alltraps
8010619a:	e9 af f8 ff ff       	jmp    80105a4e <alltraps>

8010619f <vector72>:
.globl vector72
vector72:
  pushl $0
8010619f:	6a 00                	push   $0x0
  pushl $72
801061a1:	6a 48                	push   $0x48
  jmp alltraps
801061a3:	e9 a6 f8 ff ff       	jmp    80105a4e <alltraps>

801061a8 <vector73>:
.globl vector73
vector73:
  pushl $0
801061a8:	6a 00                	push   $0x0
  pushl $73
801061aa:	6a 49                	push   $0x49
  jmp alltraps
801061ac:	e9 9d f8 ff ff       	jmp    80105a4e <alltraps>

801061b1 <vector74>:
.globl vector74
vector74:
  pushl $0
801061b1:	6a 00                	push   $0x0
  pushl $74
801061b3:	6a 4a                	push   $0x4a
  jmp alltraps
801061b5:	e9 94 f8 ff ff       	jmp    80105a4e <alltraps>

801061ba <vector75>:
.globl vector75
vector75:
  pushl $0
801061ba:	6a 00                	push   $0x0
  pushl $75
801061bc:	6a 4b                	push   $0x4b
  jmp alltraps
801061be:	e9 8b f8 ff ff       	jmp    80105a4e <alltraps>

801061c3 <vector76>:
.globl vector76
vector76:
  pushl $0
801061c3:	6a 00                	push   $0x0
  pushl $76
801061c5:	6a 4c                	push   $0x4c
  jmp alltraps
801061c7:	e9 82 f8 ff ff       	jmp    80105a4e <alltraps>

801061cc <vector77>:
.globl vector77
vector77:
  pushl $0
801061cc:	6a 00                	push   $0x0
  pushl $77
801061ce:	6a 4d                	push   $0x4d
  jmp alltraps
801061d0:	e9 79 f8 ff ff       	jmp    80105a4e <alltraps>

801061d5 <vector78>:
.globl vector78
vector78:
  pushl $0
801061d5:	6a 00                	push   $0x0
  pushl $78
801061d7:	6a 4e                	push   $0x4e
  jmp alltraps
801061d9:	e9 70 f8 ff ff       	jmp    80105a4e <alltraps>

801061de <vector79>:
.globl vector79
vector79:
  pushl $0
801061de:	6a 00                	push   $0x0
  pushl $79
801061e0:	6a 4f                	push   $0x4f
  jmp alltraps
801061e2:	e9 67 f8 ff ff       	jmp    80105a4e <alltraps>

801061e7 <vector80>:
.globl vector80
vector80:
  pushl $0
801061e7:	6a 00                	push   $0x0
  pushl $80
801061e9:	6a 50                	push   $0x50
  jmp alltraps
801061eb:	e9 5e f8 ff ff       	jmp    80105a4e <alltraps>

801061f0 <vector81>:
.globl vector81
vector81:
  pushl $0
801061f0:	6a 00                	push   $0x0
  pushl $81
801061f2:	6a 51                	push   $0x51
  jmp alltraps
801061f4:	e9 55 f8 ff ff       	jmp    80105a4e <alltraps>

801061f9 <vector82>:
.globl vector82
vector82:
  pushl $0
801061f9:	6a 00                	push   $0x0
  pushl $82
801061fb:	6a 52                	push   $0x52
  jmp alltraps
801061fd:	e9 4c f8 ff ff       	jmp    80105a4e <alltraps>

80106202 <vector83>:
.globl vector83
vector83:
  pushl $0
80106202:	6a 00                	push   $0x0
  pushl $83
80106204:	6a 53                	push   $0x53
  jmp alltraps
80106206:	e9 43 f8 ff ff       	jmp    80105a4e <alltraps>

8010620b <vector84>:
.globl vector84
vector84:
  pushl $0
8010620b:	6a 00                	push   $0x0
  pushl $84
8010620d:	6a 54                	push   $0x54
  jmp alltraps
8010620f:	e9 3a f8 ff ff       	jmp    80105a4e <alltraps>

80106214 <vector85>:
.globl vector85
vector85:
  pushl $0
80106214:	6a 00                	push   $0x0
  pushl $85
80106216:	6a 55                	push   $0x55
  jmp alltraps
80106218:	e9 31 f8 ff ff       	jmp    80105a4e <alltraps>

8010621d <vector86>:
.globl vector86
vector86:
  pushl $0
8010621d:	6a 00                	push   $0x0
  pushl $86
8010621f:	6a 56                	push   $0x56
  jmp alltraps
80106221:	e9 28 f8 ff ff       	jmp    80105a4e <alltraps>

80106226 <vector87>:
.globl vector87
vector87:
  pushl $0
80106226:	6a 00                	push   $0x0
  pushl $87
80106228:	6a 57                	push   $0x57
  jmp alltraps
8010622a:	e9 1f f8 ff ff       	jmp    80105a4e <alltraps>

8010622f <vector88>:
.globl vector88
vector88:
  pushl $0
8010622f:	6a 00                	push   $0x0
  pushl $88
80106231:	6a 58                	push   $0x58
  jmp alltraps
80106233:	e9 16 f8 ff ff       	jmp    80105a4e <alltraps>

80106238 <vector89>:
.globl vector89
vector89:
  pushl $0
80106238:	6a 00                	push   $0x0
  pushl $89
8010623a:	6a 59                	push   $0x59
  jmp alltraps
8010623c:	e9 0d f8 ff ff       	jmp    80105a4e <alltraps>

80106241 <vector90>:
.globl vector90
vector90:
  pushl $0
80106241:	6a 00                	push   $0x0
  pushl $90
80106243:	6a 5a                	push   $0x5a
  jmp alltraps
80106245:	e9 04 f8 ff ff       	jmp    80105a4e <alltraps>

8010624a <vector91>:
.globl vector91
vector91:
  pushl $0
8010624a:	6a 00                	push   $0x0
  pushl $91
8010624c:	6a 5b                	push   $0x5b
  jmp alltraps
8010624e:	e9 fb f7 ff ff       	jmp    80105a4e <alltraps>

80106253 <vector92>:
.globl vector92
vector92:
  pushl $0
80106253:	6a 00                	push   $0x0
  pushl $92
80106255:	6a 5c                	push   $0x5c
  jmp alltraps
80106257:	e9 f2 f7 ff ff       	jmp    80105a4e <alltraps>

8010625c <vector93>:
.globl vector93
vector93:
  pushl $0
8010625c:	6a 00                	push   $0x0
  pushl $93
8010625e:	6a 5d                	push   $0x5d
  jmp alltraps
80106260:	e9 e9 f7 ff ff       	jmp    80105a4e <alltraps>

80106265 <vector94>:
.globl vector94
vector94:
  pushl $0
80106265:	6a 00                	push   $0x0
  pushl $94
80106267:	6a 5e                	push   $0x5e
  jmp alltraps
80106269:	e9 e0 f7 ff ff       	jmp    80105a4e <alltraps>

8010626e <vector95>:
.globl vector95
vector95:
  pushl $0
8010626e:	6a 00                	push   $0x0
  pushl $95
80106270:	6a 5f                	push   $0x5f
  jmp alltraps
80106272:	e9 d7 f7 ff ff       	jmp    80105a4e <alltraps>

80106277 <vector96>:
.globl vector96
vector96:
  pushl $0
80106277:	6a 00                	push   $0x0
  pushl $96
80106279:	6a 60                	push   $0x60
  jmp alltraps
8010627b:	e9 ce f7 ff ff       	jmp    80105a4e <alltraps>

80106280 <vector97>:
.globl vector97
vector97:
  pushl $0
80106280:	6a 00                	push   $0x0
  pushl $97
80106282:	6a 61                	push   $0x61
  jmp alltraps
80106284:	e9 c5 f7 ff ff       	jmp    80105a4e <alltraps>

80106289 <vector98>:
.globl vector98
vector98:
  pushl $0
80106289:	6a 00                	push   $0x0
  pushl $98
8010628b:	6a 62                	push   $0x62
  jmp alltraps
8010628d:	e9 bc f7 ff ff       	jmp    80105a4e <alltraps>

80106292 <vector99>:
.globl vector99
vector99:
  pushl $0
80106292:	6a 00                	push   $0x0
  pushl $99
80106294:	6a 63                	push   $0x63
  jmp alltraps
80106296:	e9 b3 f7 ff ff       	jmp    80105a4e <alltraps>

8010629b <vector100>:
.globl vector100
vector100:
  pushl $0
8010629b:	6a 00                	push   $0x0
  pushl $100
8010629d:	6a 64                	push   $0x64
  jmp alltraps
8010629f:	e9 aa f7 ff ff       	jmp    80105a4e <alltraps>

801062a4 <vector101>:
.globl vector101
vector101:
  pushl $0
801062a4:	6a 00                	push   $0x0
  pushl $101
801062a6:	6a 65                	push   $0x65
  jmp alltraps
801062a8:	e9 a1 f7 ff ff       	jmp    80105a4e <alltraps>

801062ad <vector102>:
.globl vector102
vector102:
  pushl $0
801062ad:	6a 00                	push   $0x0
  pushl $102
801062af:	6a 66                	push   $0x66
  jmp alltraps
801062b1:	e9 98 f7 ff ff       	jmp    80105a4e <alltraps>

801062b6 <vector103>:
.globl vector103
vector103:
  pushl $0
801062b6:	6a 00                	push   $0x0
  pushl $103
801062b8:	6a 67                	push   $0x67
  jmp alltraps
801062ba:	e9 8f f7 ff ff       	jmp    80105a4e <alltraps>

801062bf <vector104>:
.globl vector104
vector104:
  pushl $0
801062bf:	6a 00                	push   $0x0
  pushl $104
801062c1:	6a 68                	push   $0x68
  jmp alltraps
801062c3:	e9 86 f7 ff ff       	jmp    80105a4e <alltraps>

801062c8 <vector105>:
.globl vector105
vector105:
  pushl $0
801062c8:	6a 00                	push   $0x0
  pushl $105
801062ca:	6a 69                	push   $0x69
  jmp alltraps
801062cc:	e9 7d f7 ff ff       	jmp    80105a4e <alltraps>

801062d1 <vector106>:
.globl vector106
vector106:
  pushl $0
801062d1:	6a 00                	push   $0x0
  pushl $106
801062d3:	6a 6a                	push   $0x6a
  jmp alltraps
801062d5:	e9 74 f7 ff ff       	jmp    80105a4e <alltraps>

801062da <vector107>:
.globl vector107
vector107:
  pushl $0
801062da:	6a 00                	push   $0x0
  pushl $107
801062dc:	6a 6b                	push   $0x6b
  jmp alltraps
801062de:	e9 6b f7 ff ff       	jmp    80105a4e <alltraps>

801062e3 <vector108>:
.globl vector108
vector108:
  pushl $0
801062e3:	6a 00                	push   $0x0
  pushl $108
801062e5:	6a 6c                	push   $0x6c
  jmp alltraps
801062e7:	e9 62 f7 ff ff       	jmp    80105a4e <alltraps>

801062ec <vector109>:
.globl vector109
vector109:
  pushl $0
801062ec:	6a 00                	push   $0x0
  pushl $109
801062ee:	6a 6d                	push   $0x6d
  jmp alltraps
801062f0:	e9 59 f7 ff ff       	jmp    80105a4e <alltraps>

801062f5 <vector110>:
.globl vector110
vector110:
  pushl $0
801062f5:	6a 00                	push   $0x0
  pushl $110
801062f7:	6a 6e                	push   $0x6e
  jmp alltraps
801062f9:	e9 50 f7 ff ff       	jmp    80105a4e <alltraps>

801062fe <vector111>:
.globl vector111
vector111:
  pushl $0
801062fe:	6a 00                	push   $0x0
  pushl $111
80106300:	6a 6f                	push   $0x6f
  jmp alltraps
80106302:	e9 47 f7 ff ff       	jmp    80105a4e <alltraps>

80106307 <vector112>:
.globl vector112
vector112:
  pushl $0
80106307:	6a 00                	push   $0x0
  pushl $112
80106309:	6a 70                	push   $0x70
  jmp alltraps
8010630b:	e9 3e f7 ff ff       	jmp    80105a4e <alltraps>

80106310 <vector113>:
.globl vector113
vector113:
  pushl $0
80106310:	6a 00                	push   $0x0
  pushl $113
80106312:	6a 71                	push   $0x71
  jmp alltraps
80106314:	e9 35 f7 ff ff       	jmp    80105a4e <alltraps>

80106319 <vector114>:
.globl vector114
vector114:
  pushl $0
80106319:	6a 00                	push   $0x0
  pushl $114
8010631b:	6a 72                	push   $0x72
  jmp alltraps
8010631d:	e9 2c f7 ff ff       	jmp    80105a4e <alltraps>

80106322 <vector115>:
.globl vector115
vector115:
  pushl $0
80106322:	6a 00                	push   $0x0
  pushl $115
80106324:	6a 73                	push   $0x73
  jmp alltraps
80106326:	e9 23 f7 ff ff       	jmp    80105a4e <alltraps>

8010632b <vector116>:
.globl vector116
vector116:
  pushl $0
8010632b:	6a 00                	push   $0x0
  pushl $116
8010632d:	6a 74                	push   $0x74
  jmp alltraps
8010632f:	e9 1a f7 ff ff       	jmp    80105a4e <alltraps>

80106334 <vector117>:
.globl vector117
vector117:
  pushl $0
80106334:	6a 00                	push   $0x0
  pushl $117
80106336:	6a 75                	push   $0x75
  jmp alltraps
80106338:	e9 11 f7 ff ff       	jmp    80105a4e <alltraps>

8010633d <vector118>:
.globl vector118
vector118:
  pushl $0
8010633d:	6a 00                	push   $0x0
  pushl $118
8010633f:	6a 76                	push   $0x76
  jmp alltraps
80106341:	e9 08 f7 ff ff       	jmp    80105a4e <alltraps>

80106346 <vector119>:
.globl vector119
vector119:
  pushl $0
80106346:	6a 00                	push   $0x0
  pushl $119
80106348:	6a 77                	push   $0x77
  jmp alltraps
8010634a:	e9 ff f6 ff ff       	jmp    80105a4e <alltraps>

8010634f <vector120>:
.globl vector120
vector120:
  pushl $0
8010634f:	6a 00                	push   $0x0
  pushl $120
80106351:	6a 78                	push   $0x78
  jmp alltraps
80106353:	e9 f6 f6 ff ff       	jmp    80105a4e <alltraps>

80106358 <vector121>:
.globl vector121
vector121:
  pushl $0
80106358:	6a 00                	push   $0x0
  pushl $121
8010635a:	6a 79                	push   $0x79
  jmp alltraps
8010635c:	e9 ed f6 ff ff       	jmp    80105a4e <alltraps>

80106361 <vector122>:
.globl vector122
vector122:
  pushl $0
80106361:	6a 00                	push   $0x0
  pushl $122
80106363:	6a 7a                	push   $0x7a
  jmp alltraps
80106365:	e9 e4 f6 ff ff       	jmp    80105a4e <alltraps>

8010636a <vector123>:
.globl vector123
vector123:
  pushl $0
8010636a:	6a 00                	push   $0x0
  pushl $123
8010636c:	6a 7b                	push   $0x7b
  jmp alltraps
8010636e:	e9 db f6 ff ff       	jmp    80105a4e <alltraps>

80106373 <vector124>:
.globl vector124
vector124:
  pushl $0
80106373:	6a 00                	push   $0x0
  pushl $124
80106375:	6a 7c                	push   $0x7c
  jmp alltraps
80106377:	e9 d2 f6 ff ff       	jmp    80105a4e <alltraps>

8010637c <vector125>:
.globl vector125
vector125:
  pushl $0
8010637c:	6a 00                	push   $0x0
  pushl $125
8010637e:	6a 7d                	push   $0x7d
  jmp alltraps
80106380:	e9 c9 f6 ff ff       	jmp    80105a4e <alltraps>

80106385 <vector126>:
.globl vector126
vector126:
  pushl $0
80106385:	6a 00                	push   $0x0
  pushl $126
80106387:	6a 7e                	push   $0x7e
  jmp alltraps
80106389:	e9 c0 f6 ff ff       	jmp    80105a4e <alltraps>

8010638e <vector127>:
.globl vector127
vector127:
  pushl $0
8010638e:	6a 00                	push   $0x0
  pushl $127
80106390:	6a 7f                	push   $0x7f
  jmp alltraps
80106392:	e9 b7 f6 ff ff       	jmp    80105a4e <alltraps>

80106397 <vector128>:
.globl vector128
vector128:
  pushl $0
80106397:	6a 00                	push   $0x0
  pushl $128
80106399:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010639e:	e9 ab f6 ff ff       	jmp    80105a4e <alltraps>

801063a3 <vector129>:
.globl vector129
vector129:
  pushl $0
801063a3:	6a 00                	push   $0x0
  pushl $129
801063a5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801063aa:	e9 9f f6 ff ff       	jmp    80105a4e <alltraps>

801063af <vector130>:
.globl vector130
vector130:
  pushl $0
801063af:	6a 00                	push   $0x0
  pushl $130
801063b1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801063b6:	e9 93 f6 ff ff       	jmp    80105a4e <alltraps>

801063bb <vector131>:
.globl vector131
vector131:
  pushl $0
801063bb:	6a 00                	push   $0x0
  pushl $131
801063bd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801063c2:	e9 87 f6 ff ff       	jmp    80105a4e <alltraps>

801063c7 <vector132>:
.globl vector132
vector132:
  pushl $0
801063c7:	6a 00                	push   $0x0
  pushl $132
801063c9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801063ce:	e9 7b f6 ff ff       	jmp    80105a4e <alltraps>

801063d3 <vector133>:
.globl vector133
vector133:
  pushl $0
801063d3:	6a 00                	push   $0x0
  pushl $133
801063d5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801063da:	e9 6f f6 ff ff       	jmp    80105a4e <alltraps>

801063df <vector134>:
.globl vector134
vector134:
  pushl $0
801063df:	6a 00                	push   $0x0
  pushl $134
801063e1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801063e6:	e9 63 f6 ff ff       	jmp    80105a4e <alltraps>

801063eb <vector135>:
.globl vector135
vector135:
  pushl $0
801063eb:	6a 00                	push   $0x0
  pushl $135
801063ed:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801063f2:	e9 57 f6 ff ff       	jmp    80105a4e <alltraps>

801063f7 <vector136>:
.globl vector136
vector136:
  pushl $0
801063f7:	6a 00                	push   $0x0
  pushl $136
801063f9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801063fe:	e9 4b f6 ff ff       	jmp    80105a4e <alltraps>

80106403 <vector137>:
.globl vector137
vector137:
  pushl $0
80106403:	6a 00                	push   $0x0
  pushl $137
80106405:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010640a:	e9 3f f6 ff ff       	jmp    80105a4e <alltraps>

8010640f <vector138>:
.globl vector138
vector138:
  pushl $0
8010640f:	6a 00                	push   $0x0
  pushl $138
80106411:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106416:	e9 33 f6 ff ff       	jmp    80105a4e <alltraps>

8010641b <vector139>:
.globl vector139
vector139:
  pushl $0
8010641b:	6a 00                	push   $0x0
  pushl $139
8010641d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106422:	e9 27 f6 ff ff       	jmp    80105a4e <alltraps>

80106427 <vector140>:
.globl vector140
vector140:
  pushl $0
80106427:	6a 00                	push   $0x0
  pushl $140
80106429:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010642e:	e9 1b f6 ff ff       	jmp    80105a4e <alltraps>

80106433 <vector141>:
.globl vector141
vector141:
  pushl $0
80106433:	6a 00                	push   $0x0
  pushl $141
80106435:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010643a:	e9 0f f6 ff ff       	jmp    80105a4e <alltraps>

8010643f <vector142>:
.globl vector142
vector142:
  pushl $0
8010643f:	6a 00                	push   $0x0
  pushl $142
80106441:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106446:	e9 03 f6 ff ff       	jmp    80105a4e <alltraps>

8010644b <vector143>:
.globl vector143
vector143:
  pushl $0
8010644b:	6a 00                	push   $0x0
  pushl $143
8010644d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106452:	e9 f7 f5 ff ff       	jmp    80105a4e <alltraps>

80106457 <vector144>:
.globl vector144
vector144:
  pushl $0
80106457:	6a 00                	push   $0x0
  pushl $144
80106459:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010645e:	e9 eb f5 ff ff       	jmp    80105a4e <alltraps>

80106463 <vector145>:
.globl vector145
vector145:
  pushl $0
80106463:	6a 00                	push   $0x0
  pushl $145
80106465:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010646a:	e9 df f5 ff ff       	jmp    80105a4e <alltraps>

8010646f <vector146>:
.globl vector146
vector146:
  pushl $0
8010646f:	6a 00                	push   $0x0
  pushl $146
80106471:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106476:	e9 d3 f5 ff ff       	jmp    80105a4e <alltraps>

8010647b <vector147>:
.globl vector147
vector147:
  pushl $0
8010647b:	6a 00                	push   $0x0
  pushl $147
8010647d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106482:	e9 c7 f5 ff ff       	jmp    80105a4e <alltraps>

80106487 <vector148>:
.globl vector148
vector148:
  pushl $0
80106487:	6a 00                	push   $0x0
  pushl $148
80106489:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010648e:	e9 bb f5 ff ff       	jmp    80105a4e <alltraps>

80106493 <vector149>:
.globl vector149
vector149:
  pushl $0
80106493:	6a 00                	push   $0x0
  pushl $149
80106495:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010649a:	e9 af f5 ff ff       	jmp    80105a4e <alltraps>

8010649f <vector150>:
.globl vector150
vector150:
  pushl $0
8010649f:	6a 00                	push   $0x0
  pushl $150
801064a1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801064a6:	e9 a3 f5 ff ff       	jmp    80105a4e <alltraps>

801064ab <vector151>:
.globl vector151
vector151:
  pushl $0
801064ab:	6a 00                	push   $0x0
  pushl $151
801064ad:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801064b2:	e9 97 f5 ff ff       	jmp    80105a4e <alltraps>

801064b7 <vector152>:
.globl vector152
vector152:
  pushl $0
801064b7:	6a 00                	push   $0x0
  pushl $152
801064b9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801064be:	e9 8b f5 ff ff       	jmp    80105a4e <alltraps>

801064c3 <vector153>:
.globl vector153
vector153:
  pushl $0
801064c3:	6a 00                	push   $0x0
  pushl $153
801064c5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801064ca:	e9 7f f5 ff ff       	jmp    80105a4e <alltraps>

801064cf <vector154>:
.globl vector154
vector154:
  pushl $0
801064cf:	6a 00                	push   $0x0
  pushl $154
801064d1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801064d6:	e9 73 f5 ff ff       	jmp    80105a4e <alltraps>

801064db <vector155>:
.globl vector155
vector155:
  pushl $0
801064db:	6a 00                	push   $0x0
  pushl $155
801064dd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801064e2:	e9 67 f5 ff ff       	jmp    80105a4e <alltraps>

801064e7 <vector156>:
.globl vector156
vector156:
  pushl $0
801064e7:	6a 00                	push   $0x0
  pushl $156
801064e9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801064ee:	e9 5b f5 ff ff       	jmp    80105a4e <alltraps>

801064f3 <vector157>:
.globl vector157
vector157:
  pushl $0
801064f3:	6a 00                	push   $0x0
  pushl $157
801064f5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801064fa:	e9 4f f5 ff ff       	jmp    80105a4e <alltraps>

801064ff <vector158>:
.globl vector158
vector158:
  pushl $0
801064ff:	6a 00                	push   $0x0
  pushl $158
80106501:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106506:	e9 43 f5 ff ff       	jmp    80105a4e <alltraps>

8010650b <vector159>:
.globl vector159
vector159:
  pushl $0
8010650b:	6a 00                	push   $0x0
  pushl $159
8010650d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106512:	e9 37 f5 ff ff       	jmp    80105a4e <alltraps>

80106517 <vector160>:
.globl vector160
vector160:
  pushl $0
80106517:	6a 00                	push   $0x0
  pushl $160
80106519:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010651e:	e9 2b f5 ff ff       	jmp    80105a4e <alltraps>

80106523 <vector161>:
.globl vector161
vector161:
  pushl $0
80106523:	6a 00                	push   $0x0
  pushl $161
80106525:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010652a:	e9 1f f5 ff ff       	jmp    80105a4e <alltraps>

8010652f <vector162>:
.globl vector162
vector162:
  pushl $0
8010652f:	6a 00                	push   $0x0
  pushl $162
80106531:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106536:	e9 13 f5 ff ff       	jmp    80105a4e <alltraps>

8010653b <vector163>:
.globl vector163
vector163:
  pushl $0
8010653b:	6a 00                	push   $0x0
  pushl $163
8010653d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106542:	e9 07 f5 ff ff       	jmp    80105a4e <alltraps>

80106547 <vector164>:
.globl vector164
vector164:
  pushl $0
80106547:	6a 00                	push   $0x0
  pushl $164
80106549:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010654e:	e9 fb f4 ff ff       	jmp    80105a4e <alltraps>

80106553 <vector165>:
.globl vector165
vector165:
  pushl $0
80106553:	6a 00                	push   $0x0
  pushl $165
80106555:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010655a:	e9 ef f4 ff ff       	jmp    80105a4e <alltraps>

8010655f <vector166>:
.globl vector166
vector166:
  pushl $0
8010655f:	6a 00                	push   $0x0
  pushl $166
80106561:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106566:	e9 e3 f4 ff ff       	jmp    80105a4e <alltraps>

8010656b <vector167>:
.globl vector167
vector167:
  pushl $0
8010656b:	6a 00                	push   $0x0
  pushl $167
8010656d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106572:	e9 d7 f4 ff ff       	jmp    80105a4e <alltraps>

80106577 <vector168>:
.globl vector168
vector168:
  pushl $0
80106577:	6a 00                	push   $0x0
  pushl $168
80106579:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010657e:	e9 cb f4 ff ff       	jmp    80105a4e <alltraps>

80106583 <vector169>:
.globl vector169
vector169:
  pushl $0
80106583:	6a 00                	push   $0x0
  pushl $169
80106585:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010658a:	e9 bf f4 ff ff       	jmp    80105a4e <alltraps>

8010658f <vector170>:
.globl vector170
vector170:
  pushl $0
8010658f:	6a 00                	push   $0x0
  pushl $170
80106591:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106596:	e9 b3 f4 ff ff       	jmp    80105a4e <alltraps>

8010659b <vector171>:
.globl vector171
vector171:
  pushl $0
8010659b:	6a 00                	push   $0x0
  pushl $171
8010659d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801065a2:	e9 a7 f4 ff ff       	jmp    80105a4e <alltraps>

801065a7 <vector172>:
.globl vector172
vector172:
  pushl $0
801065a7:	6a 00                	push   $0x0
  pushl $172
801065a9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801065ae:	e9 9b f4 ff ff       	jmp    80105a4e <alltraps>

801065b3 <vector173>:
.globl vector173
vector173:
  pushl $0
801065b3:	6a 00                	push   $0x0
  pushl $173
801065b5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801065ba:	e9 8f f4 ff ff       	jmp    80105a4e <alltraps>

801065bf <vector174>:
.globl vector174
vector174:
  pushl $0
801065bf:	6a 00                	push   $0x0
  pushl $174
801065c1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801065c6:	e9 83 f4 ff ff       	jmp    80105a4e <alltraps>

801065cb <vector175>:
.globl vector175
vector175:
  pushl $0
801065cb:	6a 00                	push   $0x0
  pushl $175
801065cd:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801065d2:	e9 77 f4 ff ff       	jmp    80105a4e <alltraps>

801065d7 <vector176>:
.globl vector176
vector176:
  pushl $0
801065d7:	6a 00                	push   $0x0
  pushl $176
801065d9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801065de:	e9 6b f4 ff ff       	jmp    80105a4e <alltraps>

801065e3 <vector177>:
.globl vector177
vector177:
  pushl $0
801065e3:	6a 00                	push   $0x0
  pushl $177
801065e5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801065ea:	e9 5f f4 ff ff       	jmp    80105a4e <alltraps>

801065ef <vector178>:
.globl vector178
vector178:
  pushl $0
801065ef:	6a 00                	push   $0x0
  pushl $178
801065f1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801065f6:	e9 53 f4 ff ff       	jmp    80105a4e <alltraps>

801065fb <vector179>:
.globl vector179
vector179:
  pushl $0
801065fb:	6a 00                	push   $0x0
  pushl $179
801065fd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106602:	e9 47 f4 ff ff       	jmp    80105a4e <alltraps>

80106607 <vector180>:
.globl vector180
vector180:
  pushl $0
80106607:	6a 00                	push   $0x0
  pushl $180
80106609:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010660e:	e9 3b f4 ff ff       	jmp    80105a4e <alltraps>

80106613 <vector181>:
.globl vector181
vector181:
  pushl $0
80106613:	6a 00                	push   $0x0
  pushl $181
80106615:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010661a:	e9 2f f4 ff ff       	jmp    80105a4e <alltraps>

8010661f <vector182>:
.globl vector182
vector182:
  pushl $0
8010661f:	6a 00                	push   $0x0
  pushl $182
80106621:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106626:	e9 23 f4 ff ff       	jmp    80105a4e <alltraps>

8010662b <vector183>:
.globl vector183
vector183:
  pushl $0
8010662b:	6a 00                	push   $0x0
  pushl $183
8010662d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106632:	e9 17 f4 ff ff       	jmp    80105a4e <alltraps>

80106637 <vector184>:
.globl vector184
vector184:
  pushl $0
80106637:	6a 00                	push   $0x0
  pushl $184
80106639:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010663e:	e9 0b f4 ff ff       	jmp    80105a4e <alltraps>

80106643 <vector185>:
.globl vector185
vector185:
  pushl $0
80106643:	6a 00                	push   $0x0
  pushl $185
80106645:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010664a:	e9 ff f3 ff ff       	jmp    80105a4e <alltraps>

8010664f <vector186>:
.globl vector186
vector186:
  pushl $0
8010664f:	6a 00                	push   $0x0
  pushl $186
80106651:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106656:	e9 f3 f3 ff ff       	jmp    80105a4e <alltraps>

8010665b <vector187>:
.globl vector187
vector187:
  pushl $0
8010665b:	6a 00                	push   $0x0
  pushl $187
8010665d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106662:	e9 e7 f3 ff ff       	jmp    80105a4e <alltraps>

80106667 <vector188>:
.globl vector188
vector188:
  pushl $0
80106667:	6a 00                	push   $0x0
  pushl $188
80106669:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010666e:	e9 db f3 ff ff       	jmp    80105a4e <alltraps>

80106673 <vector189>:
.globl vector189
vector189:
  pushl $0
80106673:	6a 00                	push   $0x0
  pushl $189
80106675:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010667a:	e9 cf f3 ff ff       	jmp    80105a4e <alltraps>

8010667f <vector190>:
.globl vector190
vector190:
  pushl $0
8010667f:	6a 00                	push   $0x0
  pushl $190
80106681:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106686:	e9 c3 f3 ff ff       	jmp    80105a4e <alltraps>

8010668b <vector191>:
.globl vector191
vector191:
  pushl $0
8010668b:	6a 00                	push   $0x0
  pushl $191
8010668d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106692:	e9 b7 f3 ff ff       	jmp    80105a4e <alltraps>

80106697 <vector192>:
.globl vector192
vector192:
  pushl $0
80106697:	6a 00                	push   $0x0
  pushl $192
80106699:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010669e:	e9 ab f3 ff ff       	jmp    80105a4e <alltraps>

801066a3 <vector193>:
.globl vector193
vector193:
  pushl $0
801066a3:	6a 00                	push   $0x0
  pushl $193
801066a5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801066aa:	e9 9f f3 ff ff       	jmp    80105a4e <alltraps>

801066af <vector194>:
.globl vector194
vector194:
  pushl $0
801066af:	6a 00                	push   $0x0
  pushl $194
801066b1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801066b6:	e9 93 f3 ff ff       	jmp    80105a4e <alltraps>

801066bb <vector195>:
.globl vector195
vector195:
  pushl $0
801066bb:	6a 00                	push   $0x0
  pushl $195
801066bd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801066c2:	e9 87 f3 ff ff       	jmp    80105a4e <alltraps>

801066c7 <vector196>:
.globl vector196
vector196:
  pushl $0
801066c7:	6a 00                	push   $0x0
  pushl $196
801066c9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801066ce:	e9 7b f3 ff ff       	jmp    80105a4e <alltraps>

801066d3 <vector197>:
.globl vector197
vector197:
  pushl $0
801066d3:	6a 00                	push   $0x0
  pushl $197
801066d5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801066da:	e9 6f f3 ff ff       	jmp    80105a4e <alltraps>

801066df <vector198>:
.globl vector198
vector198:
  pushl $0
801066df:	6a 00                	push   $0x0
  pushl $198
801066e1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801066e6:	e9 63 f3 ff ff       	jmp    80105a4e <alltraps>

801066eb <vector199>:
.globl vector199
vector199:
  pushl $0
801066eb:	6a 00                	push   $0x0
  pushl $199
801066ed:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801066f2:	e9 57 f3 ff ff       	jmp    80105a4e <alltraps>

801066f7 <vector200>:
.globl vector200
vector200:
  pushl $0
801066f7:	6a 00                	push   $0x0
  pushl $200
801066f9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801066fe:	e9 4b f3 ff ff       	jmp    80105a4e <alltraps>

80106703 <vector201>:
.globl vector201
vector201:
  pushl $0
80106703:	6a 00                	push   $0x0
  pushl $201
80106705:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010670a:	e9 3f f3 ff ff       	jmp    80105a4e <alltraps>

8010670f <vector202>:
.globl vector202
vector202:
  pushl $0
8010670f:	6a 00                	push   $0x0
  pushl $202
80106711:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106716:	e9 33 f3 ff ff       	jmp    80105a4e <alltraps>

8010671b <vector203>:
.globl vector203
vector203:
  pushl $0
8010671b:	6a 00                	push   $0x0
  pushl $203
8010671d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106722:	e9 27 f3 ff ff       	jmp    80105a4e <alltraps>

80106727 <vector204>:
.globl vector204
vector204:
  pushl $0
80106727:	6a 00                	push   $0x0
  pushl $204
80106729:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010672e:	e9 1b f3 ff ff       	jmp    80105a4e <alltraps>

80106733 <vector205>:
.globl vector205
vector205:
  pushl $0
80106733:	6a 00                	push   $0x0
  pushl $205
80106735:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010673a:	e9 0f f3 ff ff       	jmp    80105a4e <alltraps>

8010673f <vector206>:
.globl vector206
vector206:
  pushl $0
8010673f:	6a 00                	push   $0x0
  pushl $206
80106741:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106746:	e9 03 f3 ff ff       	jmp    80105a4e <alltraps>

8010674b <vector207>:
.globl vector207
vector207:
  pushl $0
8010674b:	6a 00                	push   $0x0
  pushl $207
8010674d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106752:	e9 f7 f2 ff ff       	jmp    80105a4e <alltraps>

80106757 <vector208>:
.globl vector208
vector208:
  pushl $0
80106757:	6a 00                	push   $0x0
  pushl $208
80106759:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010675e:	e9 eb f2 ff ff       	jmp    80105a4e <alltraps>

80106763 <vector209>:
.globl vector209
vector209:
  pushl $0
80106763:	6a 00                	push   $0x0
  pushl $209
80106765:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010676a:	e9 df f2 ff ff       	jmp    80105a4e <alltraps>

8010676f <vector210>:
.globl vector210
vector210:
  pushl $0
8010676f:	6a 00                	push   $0x0
  pushl $210
80106771:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106776:	e9 d3 f2 ff ff       	jmp    80105a4e <alltraps>

8010677b <vector211>:
.globl vector211
vector211:
  pushl $0
8010677b:	6a 00                	push   $0x0
  pushl $211
8010677d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106782:	e9 c7 f2 ff ff       	jmp    80105a4e <alltraps>

80106787 <vector212>:
.globl vector212
vector212:
  pushl $0
80106787:	6a 00                	push   $0x0
  pushl $212
80106789:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010678e:	e9 bb f2 ff ff       	jmp    80105a4e <alltraps>

80106793 <vector213>:
.globl vector213
vector213:
  pushl $0
80106793:	6a 00                	push   $0x0
  pushl $213
80106795:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010679a:	e9 af f2 ff ff       	jmp    80105a4e <alltraps>

8010679f <vector214>:
.globl vector214
vector214:
  pushl $0
8010679f:	6a 00                	push   $0x0
  pushl $214
801067a1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801067a6:	e9 a3 f2 ff ff       	jmp    80105a4e <alltraps>

801067ab <vector215>:
.globl vector215
vector215:
  pushl $0
801067ab:	6a 00                	push   $0x0
  pushl $215
801067ad:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801067b2:	e9 97 f2 ff ff       	jmp    80105a4e <alltraps>

801067b7 <vector216>:
.globl vector216
vector216:
  pushl $0
801067b7:	6a 00                	push   $0x0
  pushl $216
801067b9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801067be:	e9 8b f2 ff ff       	jmp    80105a4e <alltraps>

801067c3 <vector217>:
.globl vector217
vector217:
  pushl $0
801067c3:	6a 00                	push   $0x0
  pushl $217
801067c5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801067ca:	e9 7f f2 ff ff       	jmp    80105a4e <alltraps>

801067cf <vector218>:
.globl vector218
vector218:
  pushl $0
801067cf:	6a 00                	push   $0x0
  pushl $218
801067d1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801067d6:	e9 73 f2 ff ff       	jmp    80105a4e <alltraps>

801067db <vector219>:
.globl vector219
vector219:
  pushl $0
801067db:	6a 00                	push   $0x0
  pushl $219
801067dd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801067e2:	e9 67 f2 ff ff       	jmp    80105a4e <alltraps>

801067e7 <vector220>:
.globl vector220
vector220:
  pushl $0
801067e7:	6a 00                	push   $0x0
  pushl $220
801067e9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801067ee:	e9 5b f2 ff ff       	jmp    80105a4e <alltraps>

801067f3 <vector221>:
.globl vector221
vector221:
  pushl $0
801067f3:	6a 00                	push   $0x0
  pushl $221
801067f5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801067fa:	e9 4f f2 ff ff       	jmp    80105a4e <alltraps>

801067ff <vector222>:
.globl vector222
vector222:
  pushl $0
801067ff:	6a 00                	push   $0x0
  pushl $222
80106801:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106806:	e9 43 f2 ff ff       	jmp    80105a4e <alltraps>

8010680b <vector223>:
.globl vector223
vector223:
  pushl $0
8010680b:	6a 00                	push   $0x0
  pushl $223
8010680d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106812:	e9 37 f2 ff ff       	jmp    80105a4e <alltraps>

80106817 <vector224>:
.globl vector224
vector224:
  pushl $0
80106817:	6a 00                	push   $0x0
  pushl $224
80106819:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010681e:	e9 2b f2 ff ff       	jmp    80105a4e <alltraps>

80106823 <vector225>:
.globl vector225
vector225:
  pushl $0
80106823:	6a 00                	push   $0x0
  pushl $225
80106825:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010682a:	e9 1f f2 ff ff       	jmp    80105a4e <alltraps>

8010682f <vector226>:
.globl vector226
vector226:
  pushl $0
8010682f:	6a 00                	push   $0x0
  pushl $226
80106831:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106836:	e9 13 f2 ff ff       	jmp    80105a4e <alltraps>

8010683b <vector227>:
.globl vector227
vector227:
  pushl $0
8010683b:	6a 00                	push   $0x0
  pushl $227
8010683d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106842:	e9 07 f2 ff ff       	jmp    80105a4e <alltraps>

80106847 <vector228>:
.globl vector228
vector228:
  pushl $0
80106847:	6a 00                	push   $0x0
  pushl $228
80106849:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010684e:	e9 fb f1 ff ff       	jmp    80105a4e <alltraps>

80106853 <vector229>:
.globl vector229
vector229:
  pushl $0
80106853:	6a 00                	push   $0x0
  pushl $229
80106855:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010685a:	e9 ef f1 ff ff       	jmp    80105a4e <alltraps>

8010685f <vector230>:
.globl vector230
vector230:
  pushl $0
8010685f:	6a 00                	push   $0x0
  pushl $230
80106861:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106866:	e9 e3 f1 ff ff       	jmp    80105a4e <alltraps>

8010686b <vector231>:
.globl vector231
vector231:
  pushl $0
8010686b:	6a 00                	push   $0x0
  pushl $231
8010686d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106872:	e9 d7 f1 ff ff       	jmp    80105a4e <alltraps>

80106877 <vector232>:
.globl vector232
vector232:
  pushl $0
80106877:	6a 00                	push   $0x0
  pushl $232
80106879:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010687e:	e9 cb f1 ff ff       	jmp    80105a4e <alltraps>

80106883 <vector233>:
.globl vector233
vector233:
  pushl $0
80106883:	6a 00                	push   $0x0
  pushl $233
80106885:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010688a:	e9 bf f1 ff ff       	jmp    80105a4e <alltraps>

8010688f <vector234>:
.globl vector234
vector234:
  pushl $0
8010688f:	6a 00                	push   $0x0
  pushl $234
80106891:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106896:	e9 b3 f1 ff ff       	jmp    80105a4e <alltraps>

8010689b <vector235>:
.globl vector235
vector235:
  pushl $0
8010689b:	6a 00                	push   $0x0
  pushl $235
8010689d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801068a2:	e9 a7 f1 ff ff       	jmp    80105a4e <alltraps>

801068a7 <vector236>:
.globl vector236
vector236:
  pushl $0
801068a7:	6a 00                	push   $0x0
  pushl $236
801068a9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801068ae:	e9 9b f1 ff ff       	jmp    80105a4e <alltraps>

801068b3 <vector237>:
.globl vector237
vector237:
  pushl $0
801068b3:	6a 00                	push   $0x0
  pushl $237
801068b5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801068ba:	e9 8f f1 ff ff       	jmp    80105a4e <alltraps>

801068bf <vector238>:
.globl vector238
vector238:
  pushl $0
801068bf:	6a 00                	push   $0x0
  pushl $238
801068c1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801068c6:	e9 83 f1 ff ff       	jmp    80105a4e <alltraps>

801068cb <vector239>:
.globl vector239
vector239:
  pushl $0
801068cb:	6a 00                	push   $0x0
  pushl $239
801068cd:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801068d2:	e9 77 f1 ff ff       	jmp    80105a4e <alltraps>

801068d7 <vector240>:
.globl vector240
vector240:
  pushl $0
801068d7:	6a 00                	push   $0x0
  pushl $240
801068d9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801068de:	e9 6b f1 ff ff       	jmp    80105a4e <alltraps>

801068e3 <vector241>:
.globl vector241
vector241:
  pushl $0
801068e3:	6a 00                	push   $0x0
  pushl $241
801068e5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801068ea:	e9 5f f1 ff ff       	jmp    80105a4e <alltraps>

801068ef <vector242>:
.globl vector242
vector242:
  pushl $0
801068ef:	6a 00                	push   $0x0
  pushl $242
801068f1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801068f6:	e9 53 f1 ff ff       	jmp    80105a4e <alltraps>

801068fb <vector243>:
.globl vector243
vector243:
  pushl $0
801068fb:	6a 00                	push   $0x0
  pushl $243
801068fd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106902:	e9 47 f1 ff ff       	jmp    80105a4e <alltraps>

80106907 <vector244>:
.globl vector244
vector244:
  pushl $0
80106907:	6a 00                	push   $0x0
  pushl $244
80106909:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010690e:	e9 3b f1 ff ff       	jmp    80105a4e <alltraps>

80106913 <vector245>:
.globl vector245
vector245:
  pushl $0
80106913:	6a 00                	push   $0x0
  pushl $245
80106915:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010691a:	e9 2f f1 ff ff       	jmp    80105a4e <alltraps>

8010691f <vector246>:
.globl vector246
vector246:
  pushl $0
8010691f:	6a 00                	push   $0x0
  pushl $246
80106921:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106926:	e9 23 f1 ff ff       	jmp    80105a4e <alltraps>

8010692b <vector247>:
.globl vector247
vector247:
  pushl $0
8010692b:	6a 00                	push   $0x0
  pushl $247
8010692d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106932:	e9 17 f1 ff ff       	jmp    80105a4e <alltraps>

80106937 <vector248>:
.globl vector248
vector248:
  pushl $0
80106937:	6a 00                	push   $0x0
  pushl $248
80106939:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010693e:	e9 0b f1 ff ff       	jmp    80105a4e <alltraps>

80106943 <vector249>:
.globl vector249
vector249:
  pushl $0
80106943:	6a 00                	push   $0x0
  pushl $249
80106945:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010694a:	e9 ff f0 ff ff       	jmp    80105a4e <alltraps>

8010694f <vector250>:
.globl vector250
vector250:
  pushl $0
8010694f:	6a 00                	push   $0x0
  pushl $250
80106951:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106956:	e9 f3 f0 ff ff       	jmp    80105a4e <alltraps>

8010695b <vector251>:
.globl vector251
vector251:
  pushl $0
8010695b:	6a 00                	push   $0x0
  pushl $251
8010695d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106962:	e9 e7 f0 ff ff       	jmp    80105a4e <alltraps>

80106967 <vector252>:
.globl vector252
vector252:
  pushl $0
80106967:	6a 00                	push   $0x0
  pushl $252
80106969:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010696e:	e9 db f0 ff ff       	jmp    80105a4e <alltraps>

80106973 <vector253>:
.globl vector253
vector253:
  pushl $0
80106973:	6a 00                	push   $0x0
  pushl $253
80106975:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010697a:	e9 cf f0 ff ff       	jmp    80105a4e <alltraps>

8010697f <vector254>:
.globl vector254
vector254:
  pushl $0
8010697f:	6a 00                	push   $0x0
  pushl $254
80106981:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106986:	e9 c3 f0 ff ff       	jmp    80105a4e <alltraps>

8010698b <vector255>:
.globl vector255
vector255:
  pushl $0
8010698b:	6a 00                	push   $0x0
  pushl $255
8010698d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106992:	e9 b7 f0 ff ff       	jmp    80105a4e <alltraps>
80106997:	66 90                	xchg   %ax,%ax
80106999:	66 90                	xchg   %ax,%ax
8010699b:	66 90                	xchg   %ax,%ax
8010699d:	66 90                	xchg   %ax,%ax
8010699f:	90                   	nop

801069a0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801069a0:	55                   	push   %ebp
801069a1:	89 e5                	mov    %esp,%ebp
801069a3:	57                   	push   %edi
801069a4:	56                   	push   %esi
801069a5:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801069a6:	89 d3                	mov    %edx,%ebx
{
801069a8:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
801069aa:	c1 eb 16             	shr    $0x16,%ebx
801069ad:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
801069b0:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
801069b3:	8b 06                	mov    (%esi),%eax
801069b5:	a8 01                	test   $0x1,%al
801069b7:	74 27                	je     801069e0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801069b9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801069be:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801069c4:	c1 ef 0a             	shr    $0xa,%edi
}
801069c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
801069ca:	89 fa                	mov    %edi,%edx
801069cc:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801069d2:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
801069d5:	5b                   	pop    %ebx
801069d6:	5e                   	pop    %esi
801069d7:	5f                   	pop    %edi
801069d8:	5d                   	pop    %ebp
801069d9:	c3                   	ret    
801069da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801069e0:	85 c9                	test   %ecx,%ecx
801069e2:	74 2c                	je     80106a10 <walkpgdir+0x70>
801069e4:	e8 97 ba ff ff       	call   80102480 <kalloc>
801069e9:	85 c0                	test   %eax,%eax
801069eb:	89 c3                	mov    %eax,%ebx
801069ed:	74 21                	je     80106a10 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
801069ef:	83 ec 04             	sub    $0x4,%esp
801069f2:	68 00 10 00 00       	push   $0x1000
801069f7:	6a 00                	push   $0x0
801069f9:	50                   	push   %eax
801069fa:	e8 41 db ff ff       	call   80104540 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801069ff:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106a05:	83 c4 10             	add    $0x10,%esp
80106a08:	83 c8 07             	or     $0x7,%eax
80106a0b:	89 06                	mov    %eax,(%esi)
80106a0d:	eb b5                	jmp    801069c4 <walkpgdir+0x24>
80106a0f:	90                   	nop
}
80106a10:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106a13:	31 c0                	xor    %eax,%eax
}
80106a15:	5b                   	pop    %ebx
80106a16:	5e                   	pop    %esi
80106a17:	5f                   	pop    %edi
80106a18:	5d                   	pop    %ebp
80106a19:	c3                   	ret    
80106a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106a20 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106a20:	55                   	push   %ebp
80106a21:	89 e5                	mov    %esp,%ebp
80106a23:	57                   	push   %edi
80106a24:	56                   	push   %esi
80106a25:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106a26:	89 d3                	mov    %edx,%ebx
80106a28:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106a2e:	83 ec 1c             	sub    $0x1c,%esp
80106a31:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106a34:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106a38:	8b 7d 08             	mov    0x8(%ebp),%edi
80106a3b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106a40:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106a43:	8b 45 0c             	mov    0xc(%ebp),%eax
80106a46:	29 df                	sub    %ebx,%edi
80106a48:	83 c8 01             	or     $0x1,%eax
80106a4b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106a4e:	eb 15                	jmp    80106a65 <mappages+0x45>
    if(*pte & PTE_P)
80106a50:	f6 00 01             	testb  $0x1,(%eax)
80106a53:	75 45                	jne    80106a9a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80106a55:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106a58:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
80106a5b:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106a5d:	74 31                	je     80106a90 <mappages+0x70>
      break;
    a += PGSIZE;
80106a5f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106a65:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106a68:	b9 01 00 00 00       	mov    $0x1,%ecx
80106a6d:	89 da                	mov    %ebx,%edx
80106a6f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106a72:	e8 29 ff ff ff       	call   801069a0 <walkpgdir>
80106a77:	85 c0                	test   %eax,%eax
80106a79:	75 d5                	jne    80106a50 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80106a7b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106a7e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106a83:	5b                   	pop    %ebx
80106a84:	5e                   	pop    %esi
80106a85:	5f                   	pop    %edi
80106a86:	5d                   	pop    %ebp
80106a87:	c3                   	ret    
80106a88:	90                   	nop
80106a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a90:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106a93:	31 c0                	xor    %eax,%eax
}
80106a95:	5b                   	pop    %ebx
80106a96:	5e                   	pop    %esi
80106a97:	5f                   	pop    %edi
80106a98:	5d                   	pop    %ebp
80106a99:	c3                   	ret    
      panic("remap");
80106a9a:	83 ec 0c             	sub    $0xc,%esp
80106a9d:	68 5c 7e 10 80       	push   $0x80107e5c
80106aa2:	e8 c9 98 ff ff       	call   80100370 <panic>
80106aa7:	89 f6                	mov    %esi,%esi
80106aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ab0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106ab0:	55                   	push   %ebp
80106ab1:	89 e5                	mov    %esp,%ebp
80106ab3:	57                   	push   %edi
80106ab4:	56                   	push   %esi
80106ab5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106ab6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106abc:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
80106abe:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106ac4:	83 ec 1c             	sub    $0x1c,%esp
80106ac7:	89 4d dc             	mov    %ecx,-0x24(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106aca:	39 d3                	cmp    %edx,%ebx
80106acc:	73 6b                	jae    80106b39 <deallocuvm.part.0+0x89>
80106ace:	89 d6                	mov    %edx,%esi
80106ad0:	eb 48                	jmp    80106b1a <deallocuvm.part.0+0x6a>
80106ad2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a += (NPTENTRIES - 1) * PGSIZE;
    else if((*pte & PTE_P) != 0){
80106ad8:	8b 10                	mov    (%eax),%edx
80106ada:	f6 c2 01             	test   $0x1,%dl
80106add:	74 31                	je     80106b10 <deallocuvm.part.0+0x60>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106adf:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106ae5:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80106ae8:	74 7b                	je     80106b65 <deallocuvm.part.0+0xb5>
        panic("kfree");
      char *v = P2V(pa);
      
      // find the shared pages and let them stay
      if(a > KERNBASE - 0x1000*(proc->allocatedPages) || a > KERNBASE){
80106aea:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
80106af1:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106af6:	8b 49 7c             	mov    0x7c(%ecx),%ecx
80106af9:	c1 e1 0c             	shl    $0xc,%ecx
80106afc:	29 ca                	sub    %ecx,%edx
80106afe:	39 da                	cmp    %ebx,%edx
80106b00:	72 46                	jb     80106b48 <deallocuvm.part.0+0x98>
80106b02:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80106b08:	77 3e                	ja     80106b48 <deallocuvm.part.0+0x98>
        kfree(v);
      }
  //    else{
//	 cprintf("dealllocuvm: Shared memory\n");
    // }
      *pte = 0;
80106b0a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80106b10:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b16:	39 f3                	cmp    %esi,%ebx
80106b18:	73 1f                	jae    80106b39 <deallocuvm.part.0+0x89>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106b1a:	31 c9                	xor    %ecx,%ecx
80106b1c:	89 da                	mov    %ebx,%edx
80106b1e:	89 f8                	mov    %edi,%eax
80106b20:	e8 7b fe ff ff       	call   801069a0 <walkpgdir>
    if(!pte)
80106b25:	85 c0                	test   %eax,%eax
80106b27:	75 af                	jne    80106ad8 <deallocuvm.part.0+0x28>
      a += (NPTENTRIES - 1) * PGSIZE;
80106b29:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106b2f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b35:	39 f3                	cmp    %esi,%ebx
80106b37:	72 e1                	jb     80106b1a <deallocuvm.part.0+0x6a>
    }
  }
  return newsz;
}
80106b39:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106b3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b3f:	5b                   	pop    %ebx
80106b40:	5e                   	pop    %esi
80106b41:	5f                   	pop    %edi
80106b42:	5d                   	pop    %ebp
80106b43:	c3                   	ret    
80106b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      char *v = P2V(pa);
80106b48:	8b 55 e4             	mov    -0x1c(%ebp),%edx
        kfree(v);
80106b4b:	83 ec 0c             	sub    $0xc,%esp
80106b4e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      char *v = P2V(pa);
80106b51:	81 c2 00 00 00 80    	add    $0x80000000,%edx
        kfree(v);
80106b57:	52                   	push   %edx
80106b58:	e8 73 b7 ff ff       	call   801022d0 <kfree>
80106b5d:	83 c4 10             	add    $0x10,%esp
80106b60:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106b63:	eb a5                	jmp    80106b0a <deallocuvm.part.0+0x5a>
        panic("kfree");
80106b65:	83 ec 0c             	sub    $0xc,%esp
80106b68:	68 92 77 10 80       	push   $0x80107792
80106b6d:	e8 fe 97 ff ff       	call   80100370 <panic>
80106b72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b80 <ShareMemInit>:
{
80106b80:	55                   	push   %ebp
80106b81:	89 e5                	mov    %esp,%ebp
80106b83:	53                   	push   %ebx
80106b84:	31 db                	xor    %ebx,%ebx
80106b86:	83 ec 04             	sub    $0x4,%esp
80106b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
   SharedMem[i] = (int*)kalloc();// returns a pointer to physical page
80106b90:	e8 eb b8 ff ff       	call   80102480 <kalloc>
80106b95:	83 c3 04             	add    $0x4,%ebx
80106b98:	89 83 fc 7e 11 80    	mov    %eax,-0x7fee8104(%ebx)
   keys[i] = -1;// not shared yet
80106b9e:	c7 83 5c 7f 11 80 ff 	movl   $0xffffffff,-0x7fee80a4(%ebx)
80106ba5:	ff ff ff 
   pageReferences[i] = 0;
80106ba8:	c7 83 3c 7e 11 80 00 	movl   $0x0,-0x7fee81c4(%ebx)
80106baf:	00 00 00 
  for(int i = 0; i < PAGES; ++i){
80106bb2:	83 fb 50             	cmp    $0x50,%ebx
80106bb5:	75 d9                	jne    80106b90 <ShareMemInit+0x10>
}
80106bb7:	83 c4 04             	add    $0x4,%esp
80106bba:	5b                   	pop    %ebx
80106bbb:	5d                   	pop    %ebp
80106bbc:	c3                   	ret    
80106bbd:	8d 76 00             	lea    0x0(%esi),%esi

80106bc0 <shm_jared>:
{
80106bc0:	55                   	push   %ebp
  for(int i = 0; i < 20; ++i){
80106bc1:	31 d2                	xor    %edx,%edx
{
80106bc3:	89 e5                	mov    %esp,%ebp
80106bc5:	57                   	push   %edi
80106bc6:	56                   	push   %esi
80106bc7:	53                   	push   %ebx
80106bc8:	83 ec 0c             	sub    $0xc,%esp
80106bcb:	8b 5d 08             	mov    0x8(%ebp),%ebx
80106bce:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106bd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->keysUsed[i] == key){
80106bd8:	39 9c 90 80 00 00 00 	cmp    %ebx,0x80(%eax,%edx,4)
80106bdf:	0f 84 db 00 00 00    	je     80106cc0 <shm_jared+0x100>
  for(int i = 0; i < 20; ++i){
80106be5:	83 c2 01             	add    $0x1,%edx
80106be8:	83 fa 14             	cmp    $0x14,%edx
80106beb:	75 eb                	jne    80106bd8 <shm_jared+0x18>
80106bed:	ba 60 7f 11 80       	mov    $0x80117f60,%edx
80106bf2:	b9 b0 7f 11 80       	mov    $0x80117fb0,%ecx
80106bf7:	89 f6                	mov    %esi,%esi
80106bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(keys[i] == key){
80106c00:	3b 1a                	cmp    (%edx),%ebx
80106c02:	0f 84 c8 00 00 00    	je     80106cd0 <shm_jared+0x110>
80106c08:	83 c2 04             	add    $0x4,%edx
  for(int i = 0; i < PAGES; ++i){
80106c0b:	39 d1                	cmp    %edx,%ecx
80106c0d:	75 f1                	jne    80106c00 <shm_jared+0x40>
	mappages(proc->pgdir, (void*)( KERNBASE - 0x1000*(allocatedPages+1) ) , PGSIZE, V2P(SharedMem[i]), PTE_W|PTE_U);
80106c0f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80106c12:	8b 48 7c             	mov    0x7c(%eax),%ecx
  for(int i = 0; i < PAGES; ++i){
80106c15:	31 f6                	xor    %esi,%esi
80106c17:	31 ff                	xor    %edi,%edi
	mappages(proc->pgdir, (void*)( KERNBASE - 0x1000*(allocatedPages+1) ) , PGSIZE, V2P(SharedMem[i]), PTE_W|PTE_U);
80106c19:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80106c1c:	eb 0a                	jmp    80106c28 <shm_jared+0x68>
80106c1e:	66 90                	xchg   %ax,%ax
80106c20:	83 c6 04             	add    $0x4,%esi
    for(int i = 0; i < PAGES; ++i){
80106c23:	83 fe 50             	cmp    $0x50,%esi
80106c26:	74 68                	je     80106c90 <shm_jared+0xd0>
      if(keys[i] == -1 && counter < num_pages){ 
80106c28:	83 be 60 7f 11 80 ff 	cmpl   $0xffffffff,-0x7fee80a0(%esi)
80106c2f:	75 ef                	jne    80106c20 <shm_jared+0x60>
80106c31:	39 fb                	cmp    %edi,%ebx
80106c33:	7e eb                	jle    80106c20 <shm_jared+0x60>
        keys[i] = key;
80106c35:	8b 55 08             	mov    0x8(%ebp),%edx
	mappages(proc->pgdir, (void*)( KERNBASE - 0x1000*(allocatedPages+1) ) , PGSIZE, V2P(SharedMem[i]), PTE_W|PTE_U);
80106c38:	83 c1 01             	add    $0x1,%ecx
80106c3b:	83 ec 08             	sub    $0x8,%esp
80106c3e:	c1 e1 0c             	shl    $0xc,%ecx
	++counter;
80106c41:	83 c7 01             	add    $0x1,%edi
        keys[i] = key;
80106c44:	89 96 60 7f 11 80    	mov    %edx,-0x7fee80a0(%esi)
	mappages(proc->pgdir, (void*)( KERNBASE - 0x1000*(allocatedPages+1) ) , PGSIZE, V2P(SharedMem[i]), PTE_W|PTE_U);
80106c4a:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106c4f:	8b 40 04             	mov    0x4(%eax),%eax
80106c52:	29 ca                	sub    %ecx,%edx
80106c54:	8b 8e 00 7f 11 80    	mov    -0x7fee8100(%esi),%ecx
80106c5a:	6a 06                	push   $0x6
80106c5c:	81 c1 00 00 00 80    	add    $0x80000000,%ecx
80106c62:	51                   	push   %ecx
80106c63:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106c68:	e8 b3 fd ff ff       	call   80106a20 <mappages>
	++proc->allocatedPages;
80106c6d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
	++pageReferences[i];
80106c73:	83 86 40 7e 11 80 01 	addl   $0x1,-0x7fee81c0(%esi)
80106c7a:	83 c6 04             	add    $0x4,%esi
	++counter;
80106c7d:	83 c4 10             	add    $0x10,%esp
	++proc->allocatedPages;
80106c80:	8b 48 7c             	mov    0x7c(%eax),%ecx
80106c83:	83 c1 01             	add    $0x1,%ecx
    for(int i = 0; i < PAGES; ++i){
80106c86:	83 fe 50             	cmp    $0x50,%esi
	++proc->allocatedPages;
80106c89:	89 48 7c             	mov    %ecx,0x7c(%eax)
    for(int i = 0; i < PAGES; ++i){
80106c8c:	75 9a                	jne    80106c28 <shm_jared+0x68>
80106c8e:	66 90                	xchg   %ax,%ax
80106c90:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(int i = 0; i < 20; ++i){
80106c93:	31 d2                	xor    %edx,%edx
80106c95:	8d 76 00             	lea    0x0(%esi),%esi
    if(proc->keysUsed[i] != -1){
80106c98:	83 bc 90 80 00 00 00 	cmpl   $0xffffffff,0x80(%eax,%edx,4)
80106c9f:	ff 
80106ca0:	0f 85 92 00 00 00    	jne    80106d38 <shm_jared+0x178>
  for(int i = 0; i < 20; ++i){
80106ca6:	83 c2 01             	add    $0x1,%edx
80106ca9:	83 fa 14             	cmp    $0x14,%edx
80106cac:	75 ea                	jne    80106c98 <shm_jared+0xd8>
}
80106cae:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106cb1:	c1 e1 0c             	shl    $0xc,%ecx
80106cb4:	b8 00 00 00 80       	mov    $0x80000000,%eax
80106cb9:	29 c8                	sub    %ecx,%eax
80106cbb:	5b                   	pop    %ebx
80106cbc:	5e                   	pop    %esi
80106cbd:	5f                   	pop    %edi
80106cbe:	5d                   	pop    %ebp
80106cbf:	c3                   	ret    
      return proc->keyAddresses[i];
80106cc0:	8b 84 90 d0 00 00 00 	mov    0xd0(%eax,%edx,4),%eax
}
80106cc7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106cca:	5b                   	pop    %ebx
80106ccb:	5e                   	pop    %esi
80106ccc:	5f                   	pop    %edi
80106ccd:	5d                   	pop    %ebp
80106cce:	c3                   	ret    
80106ccf:	90                   	nop
80106cd0:	8b 48 7c             	mov    0x7c(%eax),%ecx
    if(keys[i] == key){
80106cd3:	31 f6                	xor    %esi,%esi
	mappages(proc->pgdir, (void*)(KERNBASE - 0x1000*(allocatedPages+1)) , PGSIZE, V2P(SharedMem[i]), PTE_W|PTE_U);
80106cd5:	bf 00 00 00 80       	mov    $0x80000000,%edi
80106cda:	eb 0c                	jmp    80106ce8 <shm_jared+0x128>
80106cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106ce0:	83 c6 04             	add    $0x4,%esi
    for(int i = 0; i < PAGES; ++i){
80106ce3:	83 fe 50             	cmp    $0x50,%esi
80106ce6:	74 ab                	je     80106c93 <shm_jared+0xd3>
      if(keys[i] == key){      
80106ce8:	3b 9e 60 7f 11 80    	cmp    -0x7fee80a0(%esi),%ebx
80106cee:	75 f0                	jne    80106ce0 <shm_jared+0x120>
	mappages(proc->pgdir, (void*)(KERNBASE - 0x1000*(allocatedPages+1)) , PGSIZE, V2P(SharedMem[i]), PTE_W|PTE_U);
80106cf0:	83 c1 01             	add    $0x1,%ecx
80106cf3:	89 fa                	mov    %edi,%edx
80106cf5:	83 ec 08             	sub    $0x8,%esp
80106cf8:	c1 e1 0c             	shl    $0xc,%ecx
80106cfb:	8b 40 04             	mov    0x4(%eax),%eax
80106cfe:	6a 06                	push   $0x6
80106d00:	29 ca                	sub    %ecx,%edx
80106d02:	8b 8e 00 7f 11 80    	mov    -0x7fee8100(%esi),%ecx
80106d08:	81 c1 00 00 00 80    	add    $0x80000000,%ecx
80106d0e:	51                   	push   %ecx
80106d0f:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106d14:	e8 07 fd ff ff       	call   80106a20 <mappages>
        ++proc->allocatedPages;
80106d19:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
   	++pageReferences[i];
80106d1f:	83 86 40 7e 11 80 01 	addl   $0x1,-0x7fee81c0(%esi)
80106d26:	83 c4 10             	add    $0x10,%esp
        ++proc->allocatedPages;
80106d29:	8b 48 7c             	mov    0x7c(%eax),%ecx
80106d2c:	83 c1 01             	add    $0x1,%ecx
80106d2f:	89 48 7c             	mov    %ecx,0x7c(%eax)
80106d32:	eb ac                	jmp    80106ce0 <shm_jared+0x120>
80106d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106d38:	8d 14 90             	lea    (%eax,%edx,4),%edx
      proc->keyAddresses[i] = KERNBASE - 0x1000*proc->allocatedPages;
80106d3b:	c1 e1 0c             	shl    $0xc,%ecx
80106d3e:	b8 00 00 00 80       	mov    $0x80000000,%eax
80106d43:	29 c8                	sub    %ecx,%eax
      proc->keysUsed[i] = key;
80106d45:	89 9a 80 00 00 00    	mov    %ebx,0x80(%edx)
      proc->keyAddresses[i] = KERNBASE - 0x1000*proc->allocatedPages;
80106d4b:	89 82 d0 00 00 00    	mov    %eax,0xd0(%edx)
}
80106d51:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d54:	5b                   	pop    %ebx
80106d55:	5e                   	pop    %esi
80106d56:	5f                   	pop    %edi
80106d57:	5d                   	pop    %ebp
80106d58:	c3                   	ret    
80106d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106d60 <seginit>:
{
80106d60:	55                   	push   %ebp
80106d61:	89 e5                	mov    %esp,%ebp
80106d63:	53                   	push   %ebx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106d64:	31 db                	xor    %ebx,%ebx
{
80106d66:	83 ec 14             	sub    $0x14,%esp
  c = &cpus[cpunum()];
80106d69:	e8 82 b9 ff ff       	call   801026f0 <cpunum>
80106d6e:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106d74:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
80106d79:	8d 90 a0 27 11 80    	lea    -0x7feed860(%eax),%edx
80106d7f:	c6 80 1d 28 11 80 9a 	movb   $0x9a,-0x7feed7e3(%eax)
80106d86:	c6 80 1e 28 11 80 cf 	movb   $0xcf,-0x7feed7e2(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106d8d:	c6 80 25 28 11 80 92 	movb   $0x92,-0x7feed7db(%eax)
80106d94:	c6 80 26 28 11 80 cf 	movb   $0xcf,-0x7feed7da(%eax)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106d9b:	66 89 4a 78          	mov    %cx,0x78(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106d9f:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106da4:	66 89 5a 7a          	mov    %bx,0x7a(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106da8:	66 89 8a 80 00 00 00 	mov    %cx,0x80(%edx)
80106daf:	31 db                	xor    %ebx,%ebx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106db1:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106db6:	66 89 9a 82 00 00 00 	mov    %bx,0x82(%edx)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106dbd:	66 89 8a 90 00 00 00 	mov    %cx,0x90(%edx)
80106dc4:	31 db                	xor    %ebx,%ebx
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106dc6:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106dcb:	66 89 9a 92 00 00 00 	mov    %bx,0x92(%edx)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106dd2:	31 db                	xor    %ebx,%ebx
80106dd4:	66 89 8a 98 00 00 00 	mov    %cx,0x98(%edx)
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106ddb:	8d 88 54 28 11 80    	lea    -0x7feed7ac(%eax),%ecx
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106de1:	66 89 9a 9a 00 00 00 	mov    %bx,0x9a(%edx)
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106de8:	31 db                	xor    %ebx,%ebx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106dea:	c6 80 35 28 11 80 fa 	movb   $0xfa,-0x7feed7cb(%eax)
80106df1:	c6 80 36 28 11 80 cf 	movb   $0xcf,-0x7feed7ca(%eax)
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106df8:	66 89 9a 88 00 00 00 	mov    %bx,0x88(%edx)
80106dff:	66 89 8a 8a 00 00 00 	mov    %cx,0x8a(%edx)
80106e06:	89 cb                	mov    %ecx,%ebx
80106e08:	c1 e9 18             	shr    $0x18,%ecx
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106e0b:	c6 80 3d 28 11 80 f2 	movb   $0xf2,-0x7feed7c3(%eax)
80106e12:	c6 80 3e 28 11 80 cf 	movb   $0xcf,-0x7feed7c2(%eax)
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106e19:	88 8a 8f 00 00 00    	mov    %cl,0x8f(%edx)
80106e1f:	c6 80 2d 28 11 80 92 	movb   $0x92,-0x7feed7d3(%eax)
  pd[0] = size-1;
80106e26:	b9 37 00 00 00       	mov    $0x37,%ecx
80106e2b:	c6 80 2e 28 11 80 c0 	movb   $0xc0,-0x7feed7d2(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106e32:	05 10 28 11 80       	add    $0x80112810,%eax
80106e37:	66 89 4d f2          	mov    %cx,-0xe(%ebp)
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106e3b:	c1 eb 10             	shr    $0x10,%ebx
  pd[1] = (uint)p;
80106e3e:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106e42:	c1 e8 10             	shr    $0x10,%eax
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106e45:	c6 42 7c 00          	movb   $0x0,0x7c(%edx)
80106e49:	c6 42 7f 00          	movb   $0x0,0x7f(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106e4d:	c6 82 84 00 00 00 00 	movb   $0x0,0x84(%edx)
80106e54:	c6 82 87 00 00 00 00 	movb   $0x0,0x87(%edx)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106e5b:	c6 82 94 00 00 00 00 	movb   $0x0,0x94(%edx)
80106e62:	c6 82 97 00 00 00 00 	movb   $0x0,0x97(%edx)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106e69:	c6 82 9c 00 00 00 00 	movb   $0x0,0x9c(%edx)
80106e70:	c6 82 9f 00 00 00 00 	movb   $0x0,0x9f(%edx)
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106e77:	88 9a 8c 00 00 00    	mov    %bl,0x8c(%edx)
80106e7d:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106e81:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106e84:	0f 01 10             	lgdtl  (%eax)
  asm volatile("movw %0, %%gs" : : "r" (v));
80106e87:	b8 18 00 00 00       	mov    $0x18,%eax
80106e8c:	8e e8                	mov    %eax,%gs
  proc = 0;
80106e8e:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80106e95:	00 00 00 00 
  c = &cpus[cpunum()];
80106e99:	65 89 15 00 00 00 00 	mov    %edx,%gs:0x0
}
80106ea0:	83 c4 14             	add    $0x14,%esp
80106ea3:	5b                   	pop    %ebx
80106ea4:	5d                   	pop    %ebp
80106ea5:	c3                   	ret    
80106ea6:	8d 76 00             	lea    0x0(%esi),%esi
80106ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106eb0 <setupkvm>:
{
80106eb0:	55                   	push   %ebp
80106eb1:	89 e5                	mov    %esp,%ebp
80106eb3:	56                   	push   %esi
80106eb4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106eb5:	e8 c6 b5 ff ff       	call   80102480 <kalloc>
80106eba:	85 c0                	test   %eax,%eax
80106ebc:	74 52                	je     80106f10 <setupkvm+0x60>
  memset(pgdir, 0, PGSIZE);
80106ebe:	83 ec 04             	sub    $0x4,%esp
80106ec1:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106ec3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106ec8:	68 00 10 00 00       	push   $0x1000
80106ecd:	6a 00                	push   $0x0
80106ecf:	50                   	push   %eax
80106ed0:	e8 6b d6 ff ff       	call   80104540 <memset>
80106ed5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0)
80106ed8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106edb:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106ede:	83 ec 08             	sub    $0x8,%esp
80106ee1:	8b 13                	mov    (%ebx),%edx
80106ee3:	ff 73 0c             	pushl  0xc(%ebx)
80106ee6:	50                   	push   %eax
80106ee7:	29 c1                	sub    %eax,%ecx
80106ee9:	89 f0                	mov    %esi,%eax
80106eeb:	e8 30 fb ff ff       	call   80106a20 <mappages>
80106ef0:	83 c4 10             	add    $0x10,%esp
80106ef3:	85 c0                	test   %eax,%eax
80106ef5:	78 19                	js     80106f10 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106ef7:	83 c3 10             	add    $0x10,%ebx
80106efa:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106f00:	72 d6                	jb     80106ed8 <setupkvm+0x28>
}
80106f02:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106f05:	89 f0                	mov    %esi,%eax
80106f07:	5b                   	pop    %ebx
80106f08:	5e                   	pop    %esi
80106f09:	5d                   	pop    %ebp
80106f0a:	c3                   	ret    
80106f0b:	90                   	nop
80106f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106f10:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
80106f13:	31 f6                	xor    %esi,%esi
}
80106f15:	89 f0                	mov    %esi,%eax
80106f17:	5b                   	pop    %ebx
80106f18:	5e                   	pop    %esi
80106f19:	5d                   	pop    %ebp
80106f1a:	c3                   	ret    
80106f1b:	90                   	nop
80106f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106f20 <kvmalloc>:
{
80106f20:	55                   	push   %ebp
80106f21:	89 e5                	mov    %esp,%ebp
80106f23:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106f26:	e8 85 ff ff ff       	call   80106eb0 <setupkvm>
80106f2b:	a3 90 7e 11 80       	mov    %eax,0x80117e90
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106f30:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106f35:	0f 22 d8             	mov    %eax,%cr3
}
80106f38:	c9                   	leave  
80106f39:	c3                   	ret    
80106f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106f40 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106f40:	a1 90 7e 11 80       	mov    0x80117e90,%eax
{
80106f45:	55                   	push   %ebp
80106f46:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106f48:	05 00 00 00 80       	add    $0x80000000,%eax
80106f4d:	0f 22 d8             	mov    %eax,%cr3
}
80106f50:	5d                   	pop    %ebp
80106f51:	c3                   	ret    
80106f52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f60 <switchuvm>:
{
80106f60:	55                   	push   %ebp
80106f61:	89 e5                	mov    %esp,%ebp
80106f63:	53                   	push   %ebx
80106f64:	83 ec 04             	sub    $0x4,%esp
80106f67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80106f6a:	e8 01 d5 ff ff       	call   80104470 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106f6f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106f75:	b9 67 00 00 00       	mov    $0x67,%ecx
80106f7a:	8d 50 08             	lea    0x8(%eax),%edx
80106f7d:	66 89 88 a0 00 00 00 	mov    %cx,0xa0(%eax)
80106f84:	c6 80 a6 00 00 00 40 	movb   $0x40,0xa6(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80106f8b:	c6 80 a5 00 00 00 89 	movb   $0x89,0xa5(%eax)
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106f92:	66 89 90 a2 00 00 00 	mov    %dx,0xa2(%eax)
80106f99:	89 d1                	mov    %edx,%ecx
80106f9b:	c1 ea 18             	shr    $0x18,%edx
80106f9e:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80106fa4:	ba 10 00 00 00       	mov    $0x10,%edx
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106fa9:	c1 e9 10             	shr    $0x10,%ecx
  cpu->ts.ss0 = SEG_KDATA << 3;
80106fac:	66 89 50 10          	mov    %dx,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80106fb0:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106fb7:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
  cpu->ts.iomb = (ushort) 0xFFFF;
80106fbd:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80106fc2:	8b 52 08             	mov    0x8(%edx),%edx
  cpu->ts.iomb = (ushort) 0xFFFF;
80106fc5:	66 89 48 6e          	mov    %cx,0x6e(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80106fc9:	81 c2 00 10 00 00    	add    $0x1000,%edx
80106fcf:	89 50 0c             	mov    %edx,0xc(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106fd2:	b8 30 00 00 00       	mov    $0x30,%eax
80106fd7:	0f 00 d8             	ltr    %ax
  if(p->pgdir == 0)
80106fda:	8b 43 04             	mov    0x4(%ebx),%eax
80106fdd:	85 c0                	test   %eax,%eax
80106fdf:	74 11                	je     80106ff2 <switchuvm+0x92>
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106fe1:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106fe6:	0f 22 d8             	mov    %eax,%cr3
}
80106fe9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106fec:	c9                   	leave  
  popcli();
80106fed:	e9 ae d4 ff ff       	jmp    801044a0 <popcli>
    panic("switchuvm: no pgdir");
80106ff2:	83 ec 0c             	sub    $0xc,%esp
80106ff5:	68 62 7e 10 80       	push   $0x80107e62
80106ffa:	e8 71 93 ff ff       	call   80100370 <panic>
80106fff:	90                   	nop

80107000 <inituvm>:
{
80107000:	55                   	push   %ebp
80107001:	89 e5                	mov    %esp,%ebp
80107003:	57                   	push   %edi
80107004:	56                   	push   %esi
80107005:	53                   	push   %ebx
80107006:	83 ec 1c             	sub    $0x1c,%esp
80107009:	8b 75 10             	mov    0x10(%ebp),%esi
8010700c:	8b 45 08             	mov    0x8(%ebp),%eax
8010700f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80107012:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80107018:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
8010701b:	77 49                	ja     80107066 <inituvm+0x66>
  mem = kalloc();
8010701d:	e8 5e b4 ff ff       	call   80102480 <kalloc>
  memset(mem, 0, PGSIZE);
80107022:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80107025:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107027:	68 00 10 00 00       	push   $0x1000
8010702c:	6a 00                	push   $0x0
8010702e:	50                   	push   %eax
8010702f:	e8 0c d5 ff ff       	call   80104540 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107034:	58                   	pop    %eax
80107035:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010703b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107040:	5a                   	pop    %edx
80107041:	6a 06                	push   $0x6
80107043:	50                   	push   %eax
80107044:	31 d2                	xor    %edx,%edx
80107046:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107049:	e8 d2 f9 ff ff       	call   80106a20 <mappages>
  memmove(mem, init, sz);
8010704e:	89 75 10             	mov    %esi,0x10(%ebp)
80107051:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107054:	83 c4 10             	add    $0x10,%esp
80107057:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010705a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010705d:	5b                   	pop    %ebx
8010705e:	5e                   	pop    %esi
8010705f:	5f                   	pop    %edi
80107060:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107061:	e9 8a d5 ff ff       	jmp    801045f0 <memmove>
    panic("inituvm: more than a page");
80107066:	83 ec 0c             	sub    $0xc,%esp
80107069:	68 76 7e 10 80       	push   $0x80107e76
8010706e:	e8 fd 92 ff ff       	call   80100370 <panic>
80107073:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107080 <loaduvm>:
{
80107080:	55                   	push   %ebp
80107081:	89 e5                	mov    %esp,%ebp
80107083:	57                   	push   %edi
80107084:	56                   	push   %esi
80107085:	53                   	push   %ebx
80107086:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80107089:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107090:	0f 85 91 00 00 00    	jne    80107127 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80107096:	8b 75 18             	mov    0x18(%ebp),%esi
80107099:	31 db                	xor    %ebx,%ebx
8010709b:	85 f6                	test   %esi,%esi
8010709d:	75 1a                	jne    801070b9 <loaduvm+0x39>
8010709f:	eb 6f                	jmp    80107110 <loaduvm+0x90>
801070a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070a8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801070ae:	81 ee 00 10 00 00    	sub    $0x1000,%esi
801070b4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
801070b7:	76 57                	jbe    80107110 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801070b9:	8b 55 0c             	mov    0xc(%ebp),%edx
801070bc:	8b 45 08             	mov    0x8(%ebp),%eax
801070bf:	31 c9                	xor    %ecx,%ecx
801070c1:	01 da                	add    %ebx,%edx
801070c3:	e8 d8 f8 ff ff       	call   801069a0 <walkpgdir>
801070c8:	85 c0                	test   %eax,%eax
801070ca:	74 4e                	je     8010711a <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
801070cc:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
801070ce:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
801070d1:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
801070d6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801070db:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801070e1:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801070e4:	01 d9                	add    %ebx,%ecx
801070e6:	05 00 00 00 80       	add    $0x80000000,%eax
801070eb:	57                   	push   %edi
801070ec:	51                   	push   %ecx
801070ed:	50                   	push   %eax
801070ee:	ff 75 10             	pushl  0x10(%ebp)
801070f1:	e8 2a a8 ff ff       	call   80101920 <readi>
801070f6:	83 c4 10             	add    $0x10,%esp
801070f9:	39 c7                	cmp    %eax,%edi
801070fb:	74 ab                	je     801070a8 <loaduvm+0x28>
}
801070fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107100:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107105:	5b                   	pop    %ebx
80107106:	5e                   	pop    %esi
80107107:	5f                   	pop    %edi
80107108:	5d                   	pop    %ebp
80107109:	c3                   	ret    
8010710a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107110:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107113:	31 c0                	xor    %eax,%eax
}
80107115:	5b                   	pop    %ebx
80107116:	5e                   	pop    %esi
80107117:	5f                   	pop    %edi
80107118:	5d                   	pop    %ebp
80107119:	c3                   	ret    
      panic("loaduvm: address should exist");
8010711a:	83 ec 0c             	sub    $0xc,%esp
8010711d:	68 90 7e 10 80       	push   $0x80107e90
80107122:	e8 49 92 ff ff       	call   80100370 <panic>
    panic("loaduvm: addr must be page aligned");
80107127:	83 ec 0c             	sub    $0xc,%esp
8010712a:	68 34 7f 10 80       	push   $0x80107f34
8010712f:	e8 3c 92 ff ff       	call   80100370 <panic>
80107134:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010713a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107140 <allocuvm>:
{
80107140:	55                   	push   %ebp
80107141:	89 e5                	mov    %esp,%ebp
80107143:	57                   	push   %edi
80107144:	56                   	push   %esi
80107145:	53                   	push   %ebx
80107146:	83 ec 0c             	sub    $0xc,%esp
80107149:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(newsz >= KERNBASE)
8010714c:	85 ff                	test   %edi,%edi
8010714e:	78 7b                	js     801071cb <allocuvm+0x8b>
  if(newsz < oldsz)
80107150:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80107153:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80107156:	72 75                	jb     801071cd <allocuvm+0x8d>
  a = PGROUNDUP(oldsz);
80107158:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
8010715e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80107164:	39 df                	cmp    %ebx,%edi
80107166:	77 43                	ja     801071ab <allocuvm+0x6b>
80107168:	eb 6e                	jmp    801071d8 <allocuvm+0x98>
8010716a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80107170:	83 ec 04             	sub    $0x4,%esp
80107173:	68 00 10 00 00       	push   $0x1000
80107178:	6a 00                	push   $0x0
8010717a:	50                   	push   %eax
8010717b:	e8 c0 d3 ff ff       	call   80104540 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107180:	58                   	pop    %eax
80107181:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107187:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010718c:	5a                   	pop    %edx
8010718d:	6a 06                	push   $0x6
8010718f:	50                   	push   %eax
80107190:	89 da                	mov    %ebx,%edx
80107192:	8b 45 08             	mov    0x8(%ebp),%eax
80107195:	e8 86 f8 ff ff       	call   80106a20 <mappages>
8010719a:	83 c4 10             	add    $0x10,%esp
8010719d:	85 c0                	test   %eax,%eax
8010719f:	78 47                	js     801071e8 <allocuvm+0xa8>
  for(; a < newsz; a += PGSIZE){
801071a1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801071a7:	39 df                	cmp    %ebx,%edi
801071a9:	76 2d                	jbe    801071d8 <allocuvm+0x98>
    mem = kalloc();
801071ab:	e8 d0 b2 ff ff       	call   80102480 <kalloc>
    if(mem == 0){
801071b0:	85 c0                	test   %eax,%eax
    mem = kalloc();
801071b2:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801071b4:	75 ba                	jne    80107170 <allocuvm+0x30>
      cprintf("allocuvm out of memory\n");
801071b6:	83 ec 0c             	sub    $0xc,%esp
801071b9:	68 ae 7e 10 80       	push   $0x80107eae
801071be:	e8 9d 94 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
801071c3:	83 c4 10             	add    $0x10,%esp
801071c6:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801071c9:	77 4f                	ja     8010721a <allocuvm+0xda>
      return 0;
801071cb:	31 c0                	xor    %eax,%eax
}
801071cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801071d0:	5b                   	pop    %ebx
801071d1:	5e                   	pop    %esi
801071d2:	5f                   	pop    %edi
801071d3:	5d                   	pop    %ebp
801071d4:	c3                   	ret    
801071d5:	8d 76 00             	lea    0x0(%esi),%esi
801071d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  for(; a < newsz; a += PGSIZE){
801071db:	89 f8                	mov    %edi,%eax
}
801071dd:	5b                   	pop    %ebx
801071de:	5e                   	pop    %esi
801071df:	5f                   	pop    %edi
801071e0:	5d                   	pop    %ebp
801071e1:	c3                   	ret    
801071e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801071e8:	83 ec 0c             	sub    $0xc,%esp
801071eb:	68 c6 7e 10 80       	push   $0x80107ec6
801071f0:	e8 6b 94 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
801071f5:	83 c4 10             	add    $0x10,%esp
801071f8:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801071fb:	76 0d                	jbe    8010720a <allocuvm+0xca>
801071fd:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107200:	8b 45 08             	mov    0x8(%ebp),%eax
80107203:	89 fa                	mov    %edi,%edx
80107205:	e8 a6 f8 ff ff       	call   80106ab0 <deallocuvm.part.0>
      kfree(mem);
8010720a:	83 ec 0c             	sub    $0xc,%esp
8010720d:	56                   	push   %esi
8010720e:	e8 bd b0 ff ff       	call   801022d0 <kfree>
      return 0;
80107213:	83 c4 10             	add    $0x10,%esp
80107216:	31 c0                	xor    %eax,%eax
80107218:	eb b3                	jmp    801071cd <allocuvm+0x8d>
8010721a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010721d:	8b 45 08             	mov    0x8(%ebp),%eax
80107220:	89 fa                	mov    %edi,%edx
80107222:	e8 89 f8 ff ff       	call   80106ab0 <deallocuvm.part.0>
      return 0;
80107227:	31 c0                	xor    %eax,%eax
80107229:	eb a2                	jmp    801071cd <allocuvm+0x8d>
8010722b:	90                   	nop
8010722c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107230 <deallocuvm>:
{
80107230:	55                   	push   %ebp
80107231:	89 e5                	mov    %esp,%ebp
80107233:	8b 55 0c             	mov    0xc(%ebp),%edx
80107236:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107239:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010723c:	39 d1                	cmp    %edx,%ecx
8010723e:	73 10                	jae    80107250 <deallocuvm+0x20>
}
80107240:	5d                   	pop    %ebp
80107241:	e9 6a f8 ff ff       	jmp    80106ab0 <deallocuvm.part.0>
80107246:	8d 76 00             	lea    0x0(%esi),%esi
80107249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107250:	89 d0                	mov    %edx,%eax
80107252:	5d                   	pop    %ebp
80107253:	c3                   	ret    
80107254:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010725a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107260 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107260:	55                   	push   %ebp
80107261:	89 e5                	mov    %esp,%ebp
80107263:	57                   	push   %edi
80107264:	56                   	push   %esi
80107265:	53                   	push   %ebx
80107266:	83 ec 0c             	sub    $0xc,%esp
80107269:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010726c:	85 f6                	test   %esi,%esi
8010726e:	74 59                	je     801072c9 <freevm+0x69>
80107270:	31 c9                	xor    %ecx,%ecx
80107272:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107277:	89 f0                	mov    %esi,%eax
80107279:	e8 32 f8 ff ff       	call   80106ab0 <deallocuvm.part.0>
8010727e:	89 f3                	mov    %esi,%ebx
80107280:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107286:	eb 0f                	jmp    80107297 <freevm+0x37>
80107288:	90                   	nop
80107289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107290:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107293:	39 fb                	cmp    %edi,%ebx
80107295:	74 23                	je     801072ba <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107297:	8b 03                	mov    (%ebx),%eax
80107299:	a8 01                	test   $0x1,%al
8010729b:	74 f3                	je     80107290 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010729d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
801072a2:	83 ec 0c             	sub    $0xc,%esp
801072a5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801072a8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801072ad:	50                   	push   %eax
801072ae:	e8 1d b0 ff ff       	call   801022d0 <kfree>
801072b3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801072b6:	39 fb                	cmp    %edi,%ebx
801072b8:	75 dd                	jne    80107297 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801072ba:	89 75 08             	mov    %esi,0x8(%ebp)
}
801072bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072c0:	5b                   	pop    %ebx
801072c1:	5e                   	pop    %esi
801072c2:	5f                   	pop    %edi
801072c3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801072c4:	e9 07 b0 ff ff       	jmp    801022d0 <kfree>
    panic("freevm: no pgdir");
801072c9:	83 ec 0c             	sub    $0xc,%esp
801072cc:	68 e2 7e 10 80       	push   $0x80107ee2
801072d1:	e8 9a 90 ff ff       	call   80100370 <panic>
801072d6:	8d 76 00             	lea    0x0(%esi),%esi
801072d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801072e0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801072e0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801072e1:	31 c9                	xor    %ecx,%ecx
{
801072e3:	89 e5                	mov    %esp,%ebp
801072e5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
801072e8:	8b 55 0c             	mov    0xc(%ebp),%edx
801072eb:	8b 45 08             	mov    0x8(%ebp),%eax
801072ee:	e8 ad f6 ff ff       	call   801069a0 <walkpgdir>
  if(pte == 0)
801072f3:	85 c0                	test   %eax,%eax
801072f5:	74 05                	je     801072fc <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
801072f7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801072fa:	c9                   	leave  
801072fb:	c3                   	ret    
    panic("clearpteu");
801072fc:	83 ec 0c             	sub    $0xc,%esp
801072ff:	68 f3 7e 10 80       	push   $0x80107ef3
80107304:	e8 67 90 ff ff       	call   80100370 <panic>
80107309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107310 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107310:	55                   	push   %ebp
80107311:	89 e5                	mov    %esp,%ebp
80107313:	57                   	push   %edi
80107314:	56                   	push   %esi
80107315:	53                   	push   %ebx
80107316:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107319:	e8 92 fb ff ff       	call   80106eb0 <setupkvm>
8010731e:	85 c0                	test   %eax,%eax
80107320:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107323:	0f 84 a8 00 00 00    	je     801073d1 <copyuvm+0xc1>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107329:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010732c:	85 c9                	test   %ecx,%ecx
8010732e:	0f 84 ac 00 00 00    	je     801073e0 <copyuvm+0xd0>
80107334:	31 f6                	xor    %esi,%esi
80107336:	eb 4e                	jmp    80107386 <copyuvm+0x76>
80107338:	90                   	nop
80107339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107340:	83 ec 04             	sub    $0x4,%esp
80107343:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107349:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010734c:	68 00 10 00 00       	push   $0x1000
80107351:	57                   	push   %edi
80107352:	50                   	push   %eax
80107353:	e8 98 d2 ff ff       	call   801045f0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80107358:	58                   	pop    %eax
80107359:	5a                   	pop    %edx
8010735a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010735d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107360:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107365:	53                   	push   %ebx
80107366:	81 c2 00 00 00 80    	add    $0x80000000,%edx
8010736c:	52                   	push   %edx
8010736d:	89 f2                	mov    %esi,%edx
8010736f:	e8 ac f6 ff ff       	call   80106a20 <mappages>
80107374:	83 c4 10             	add    $0x10,%esp
80107377:	85 c0                	test   %eax,%eax
80107379:	78 41                	js     801073bc <copyuvm+0xac>
  for(i = 0; i < sz; i += PGSIZE){
8010737b:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107381:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107384:	76 5a                	jbe    801073e0 <copyuvm+0xd0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107386:	8b 45 08             	mov    0x8(%ebp),%eax
80107389:	31 c9                	xor    %ecx,%ecx
8010738b:	89 f2                	mov    %esi,%edx
8010738d:	e8 0e f6 ff ff       	call   801069a0 <walkpgdir>
80107392:	85 c0                	test   %eax,%eax
80107394:	0f 84 a7 00 00 00    	je     80107441 <copyuvm+0x131>
    if(!(*pte & PTE_P))
8010739a:	8b 18                	mov    (%eax),%ebx
8010739c:	f6 c3 01             	test   $0x1,%bl
8010739f:	0f 84 8f 00 00 00    	je     80107434 <copyuvm+0x124>
    pa = PTE_ADDR(*pte);
801073a5:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
801073a7:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
801073ad:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
801073b3:	e8 c8 b0 ff ff       	call   80102480 <kalloc>
801073b8:	85 c0                	test   %eax,%eax
801073ba:	75 84                	jne    80107340 <copyuvm+0x30>
		goto bad;
  }
  return d;

bad:
  freevm(d);
801073bc:	83 ec 0c             	sub    $0xc,%esp
801073bf:	ff 75 e0             	pushl  -0x20(%ebp)
801073c2:	e8 99 fe ff ff       	call   80107260 <freevm>
  return 0;
801073c7:	83 c4 10             	add    $0x10,%esp
801073ca:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
801073d1:	8b 45 e0             	mov    -0x20(%ebp),%eax
801073d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073d7:	5b                   	pop    %ebx
801073d8:	5e                   	pop    %esi
801073d9:	5f                   	pop    %edi
801073da:	5d                   	pop    %ebp
801073db:	c3                   	ret    
801073dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < sz; i += PGSIZE){
801073e0:	8b 7d 08             	mov    0x8(%ebp),%edi
801073e3:	bb 00 f0 ff 7f       	mov    $0x7ffff000,%ebx
801073e8:	31 f6                	xor    %esi,%esi
801073ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(i = 0; i < proc->allocatedPages; ++i){
801073f0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801073f6:	3b 70 7c             	cmp    0x7c(%eax),%esi
801073f9:	73 d6                	jae    801073d1 <copyuvm+0xc1>
	pte = walkpgdir(pgdir, (void *) KERNBASE - 0x1000*(i+1), 0);
801073fb:	31 c9                	xor    %ecx,%ecx
801073fd:	89 da                	mov    %ebx,%edx
801073ff:	89 f8                	mov    %edi,%eax
80107401:	e8 9a f5 ff ff       	call   801069a0 <walkpgdir>
	if (mappages(d, (void*) KERNBASE - 0x1000*(i+1), PGSIZE, pa, PTE_W|PTE_U) < 0)
80107406:	83 ec 08             	sub    $0x8,%esp
80107409:	89 da                	mov    %ebx,%edx
8010740b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107410:	6a 06                	push   $0x6
	pa = PTE_ADDR(*pte);
80107412:	8b 00                	mov    (%eax),%eax
	pte = walkpgdir(pgdir, (void *) KERNBASE - 0x1000*(i+1), 0);
80107414:	83 c6 01             	add    $0x1,%esi
80107417:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
	pa = PTE_ADDR(*pte);
8010741d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
	if (mappages(d, (void*) KERNBASE - 0x1000*(i+1), PGSIZE, pa, PTE_W|PTE_U) < 0)
80107422:	50                   	push   %eax
80107423:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107426:	e8 f5 f5 ff ff       	call   80106a20 <mappages>
8010742b:	83 c4 10             	add    $0x10,%esp
8010742e:	85 c0                	test   %eax,%eax
80107430:	79 be                	jns    801073f0 <copyuvm+0xe0>
80107432:	eb 88                	jmp    801073bc <copyuvm+0xac>
      panic("copyuvm: page not present");
80107434:	83 ec 0c             	sub    $0xc,%esp
80107437:	68 17 7f 10 80       	push   $0x80107f17
8010743c:	e8 2f 8f ff ff       	call   80100370 <panic>
      panic("copyuvm: pte should exist");
80107441:	83 ec 0c             	sub    $0xc,%esp
80107444:	68 fd 7e 10 80       	push   $0x80107efd
80107449:	e8 22 8f ff ff       	call   80100370 <panic>
8010744e:	66 90                	xchg   %ax,%ax

80107450 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107450:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107451:	31 c9                	xor    %ecx,%ecx
{
80107453:	89 e5                	mov    %esp,%ebp
80107455:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107458:	8b 55 0c             	mov    0xc(%ebp),%edx
8010745b:	8b 45 08             	mov    0x8(%ebp),%eax
8010745e:	e8 3d f5 ff ff       	call   801069a0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107463:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107465:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107466:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107468:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
8010746d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107470:	05 00 00 00 80       	add    $0x80000000,%eax
80107475:	83 fa 05             	cmp    $0x5,%edx
80107478:	ba 00 00 00 00       	mov    $0x0,%edx
8010747d:	0f 45 c2             	cmovne %edx,%eax
}
80107480:	c3                   	ret    
80107481:	eb 0d                	jmp    80107490 <copyout>
80107483:	90                   	nop
80107484:	90                   	nop
80107485:	90                   	nop
80107486:	90                   	nop
80107487:	90                   	nop
80107488:	90                   	nop
80107489:	90                   	nop
8010748a:	90                   	nop
8010748b:	90                   	nop
8010748c:	90                   	nop
8010748d:	90                   	nop
8010748e:	90                   	nop
8010748f:	90                   	nop

80107490 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107490:	55                   	push   %ebp
80107491:	89 e5                	mov    %esp,%ebp
80107493:	57                   	push   %edi
80107494:	56                   	push   %esi
80107495:	53                   	push   %ebx
80107496:	83 ec 1c             	sub    $0x1c,%esp
80107499:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010749c:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
8010749f:	8b 7d 10             	mov    0x10(%ebp),%edi
801074a2:	85 db                	test   %ebx,%ebx
801074a4:	75 40                	jne    801074e6 <copyout+0x56>
801074a6:	eb 70                	jmp    80107518 <copyout+0x88>
801074a8:	90                   	nop
801074a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801074b0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801074b3:	89 f1                	mov    %esi,%ecx
801074b5:	29 d1                	sub    %edx,%ecx
801074b7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801074bd:	39 d9                	cmp    %ebx,%ecx
801074bf:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801074c2:	29 f2                	sub    %esi,%edx
801074c4:	83 ec 04             	sub    $0x4,%esp
801074c7:	01 d0                	add    %edx,%eax
801074c9:	51                   	push   %ecx
801074ca:	57                   	push   %edi
801074cb:	50                   	push   %eax
801074cc:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801074cf:	e8 1c d1 ff ff       	call   801045f0 <memmove>
    len -= n;
    buf += n;
801074d4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
801074d7:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
801074da:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
801074e0:	01 cf                	add    %ecx,%edi
  while(len > 0){
801074e2:	29 cb                	sub    %ecx,%ebx
801074e4:	74 32                	je     80107518 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
801074e6:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801074e8:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
801074eb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801074ee:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801074f4:	56                   	push   %esi
801074f5:	ff 75 08             	pushl  0x8(%ebp)
801074f8:	e8 53 ff ff ff       	call   80107450 <uva2ka>
    if(pa0 == 0)
801074fd:	83 c4 10             	add    $0x10,%esp
80107500:	85 c0                	test   %eax,%eax
80107502:	75 ac                	jne    801074b0 <copyout+0x20>
  }
  return 0;
}
80107504:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107507:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010750c:	5b                   	pop    %ebx
8010750d:	5e                   	pop    %esi
8010750e:	5f                   	pop    %edi
8010750f:	5d                   	pop    %ebp
80107510:	c3                   	ret    
80107511:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107518:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010751b:	31 c0                	xor    %eax,%eax
}
8010751d:	5b                   	pop    %ebx
8010751e:	5e                   	pop    %esi
8010751f:	5f                   	pop    %edi
80107520:	5d                   	pop    %ebp
80107521:	c3                   	ret    
