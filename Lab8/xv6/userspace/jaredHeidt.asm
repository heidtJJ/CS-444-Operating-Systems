
_jaredHeidt:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
	total += *test;
	lock_release(&lk);
}
int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
	int arg = 10; 
	int result = thread_create(worker, &arg);
   f:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
  12:	83 ec 18             	sub    $0x18,%esp
	int arg = 10; 
  15:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%ebp)
	int result = thread_create(worker, &arg);
  1c:	53                   	push   %ebx
  1d:	68 90 00 00 00       	push   $0x90
  22:	e8 e9 00 00 00       	call   110 <thread_create>

	result = thread_create(worker, &arg);
  27:	58                   	pop    %eax
  28:	5a                   	pop    %edx
  29:	53                   	push   %ebx
  2a:	68 90 00 00 00       	push   $0x90
  2f:	e8 dc 00 00 00       	call   110 <thread_create>
	result = thread_create(worker, &arg);
  34:	59                   	pop    %ecx
  35:	58                   	pop    %eax
  36:	53                   	push   %ebx
  37:	68 90 00 00 00       	push   $0x90
  3c:	e8 cf 00 00 00       	call   110 <thread_create>
	result = thread_create(worker, &arg);
  41:	58                   	pop    %eax
  42:	5a                   	pop    %edx
  43:	53                   	push   %ebx
  44:	68 90 00 00 00       	push   $0x90
  49:	e8 c2 00 00 00       	call   110 <thread_create>
  4e:	89 c3                	mov    %eax,%ebx
	while(total == 1){
  50:	a1 e0 0c 00 00       	mov    0xce0,%eax
  55:	83 c4 10             	add    $0x10,%esp
  58:	83 f8 01             	cmp    $0x1,%eax
  5b:	75 1f                	jne    7c <main+0x7c>
  5d:	8d 76 00             	lea    0x0(%esi),%esi
		printf(1, "Result: %d, %d\n", result, total);
  60:	6a 01                	push   $0x1
  62:	53                   	push   %ebx
  63:	68 10 09 00 00       	push   $0x910
  68:	6a 01                	push   $0x1
  6a:	e8 11 05 00 00       	call   580 <printf>
	while(total == 1){
  6f:	a1 e0 0c 00 00       	mov    0xce0,%eax
  74:	83 c4 10             	add    $0x10,%esp
  77:	83 f8 01             	cmp    $0x1,%eax
  7a:	74 e4                	je     60 <main+0x60>
	}
	printf(1, "Result: %d, %d\n", result, total);
  7c:	50                   	push   %eax
  7d:	53                   	push   %ebx
  7e:	68 10 09 00 00       	push   $0x910
  83:	6a 01                	push   $0x1
  85:	e8 f6 04 00 00       	call   580 <printf>
	exit();
  8a:	e8 93 03 00 00       	call   422 <exit>
  8f:	90                   	nop

00000090 <worker>:
void worker(void *arg){
  90:	55                   	push   %ebp
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  91:	ba 01 00 00 00       	mov    $0x1,%edx
  96:	89 e5                	mov    %esp,%ebp
  98:	83 ec 10             	sub    $0x10,%esp
	lk->flag = 0;
  9b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  a8:	89 d0                	mov    %edx,%eax
  aa:	f0 87 45 fc          	lock xchg %eax,-0x4(%ebp)
	while(xchg(&lk->flag, 1) != 0);
  ae:	85 c0                	test   %eax,%eax
  b0:	75 f6                	jne    a8 <worker+0x18>
	total += *test;
  b2:	8b 55 08             	mov    0x8(%ebp),%edx
  b5:	8b 12                	mov    (%edx),%edx
  b7:	01 15 e0 0c 00 00    	add    %edx,0xce0
  bd:	f0 87 45 fc          	lock xchg %eax,-0x4(%ebp)
}
  c1:	c9                   	leave  
  c2:	c3                   	ret    
  c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000d0 <lock_init>:
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
	lk->flag = 0;
  d3:	8b 45 08             	mov    0x8(%ebp),%eax
  d6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
  dc:	31 c0                	xor    %eax,%eax
  de:	5d                   	pop    %ebp
  df:	c3                   	ret    

000000e0 <lock_acquire>:
void lock_acquire(lock_t *lk){
  e0:	55                   	push   %ebp
  e1:	b9 01 00 00 00       	mov    $0x1,%ecx
  e6:	89 e5                	mov    %esp,%ebp
  e8:	8b 55 08             	mov    0x8(%ebp),%edx
  eb:	90                   	nop
  ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  f0:	89 c8                	mov    %ecx,%eax
  f2:	f0 87 02             	lock xchg %eax,(%edx)
	while(xchg(&lk->flag, 1) != 0);
  f5:	85 c0                	test   %eax,%eax
  f7:	75 f7                	jne    f0 <lock_acquire+0x10>
}
  f9:	5d                   	pop    %ebp
  fa:	c3                   	ret    
  fb:	90                   	nop
  fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000100 <lock_release>:
void lock_release(lock_t *lk){
 100:	55                   	push   %ebp
 101:	31 c0                	xor    %eax,%eax
 103:	89 e5                	mov    %esp,%ebp
 105:	8b 55 08             	mov    0x8(%ebp),%edx
 108:	f0 87 02             	lock xchg %eax,(%edx)
}
 10b:	5d                   	pop    %ebp
 10c:	c3                   	ret    
 10d:	8d 76 00             	lea    0x0(%esi),%esi

00000110 <thread_create>:
int thread_create(void (*start_routine)(void*), void *arg){
 110:	55                   	push   %ebp
 111:	ba 01 00 00 00       	mov    $0x1,%edx
 116:	89 e5                	mov    %esp,%ebp
 118:	56                   	push   %esi
 119:	53                   	push   %ebx
 11a:	83 ec 10             	sub    $0x10,%esp
	lk->flag = 0;
 11d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 128:	89 d0                	mov    %edx,%eax
 12a:	f0 87 45 f4          	lock xchg %eax,-0xc(%ebp)
	while(xchg(&lk->flag, 1) != 0);
 12e:	85 c0                	test   %eax,%eax
 130:	89 c3                	mov    %eax,%ebx
 132:	75 f4                	jne    128 <thread_create+0x18>
	void *stack = malloc(PGSIZE*2);
 134:	83 ec 0c             	sub    $0xc,%esp
 137:	68 00 20 00 00       	push   $0x2000
 13c:	e8 7f 06 00 00       	call   7c0 <malloc>
 141:	89 c6                	mov    %eax,%esi
 143:	89 d8                	mov    %ebx,%eax
 145:	f0 87 45 f4          	lock xchg %eax,-0xc(%ebp)
	if((uint)stack % PGSIZE)
 149:	89 f0                	mov    %esi,%eax
		stack = stack + (PGSIZE - (uint)stack % PGSIZE);
 14b:	89 f2                	mov    %esi,%edx
	if((uint)stack % PGSIZE)
 14d:	83 c4 0c             	add    $0xc,%esp
 150:	25 ff 0f 00 00       	and    $0xfff,%eax
		stack = stack + (PGSIZE - (uint)stack % PGSIZE);
 155:	29 c2                	sub    %eax,%edx
 157:	81 c2 00 10 00 00    	add    $0x1000,%edx
 15d:	85 c0                	test   %eax,%eax
 15f:	0f 45 f2             	cmovne %edx,%esi
	int result = clone_jared(start_routine,arg,stack);
 162:	56                   	push   %esi
 163:	ff 75 0c             	pushl  0xc(%ebp)
 166:	ff 75 08             	pushl  0x8(%ebp)
 169:	e8 64 03 00 00       	call   4d2 <clone_jared>
	free(stack);
 16e:	89 34 24             	mov    %esi,(%esp)
	int result = clone_jared(start_routine,arg,stack);
 171:	89 c3                	mov    %eax,%ebx
	free(stack);
 173:	e8 b8 05 00 00       	call   730 <free>
}
 178:	8d 65 f8             	lea    -0x8(%ebp),%esp
 17b:	89 d8                	mov    %ebx,%eax
 17d:	5b                   	pop    %ebx
 17e:	5e                   	pop    %esi
 17f:	5d                   	pop    %ebp
 180:	c3                   	ret    
 181:	eb 0d                	jmp    190 <thread_join>
 183:	90                   	nop
 184:	90                   	nop
 185:	90                   	nop
 186:	90                   	nop
 187:	90                   	nop
 188:	90                   	nop
 189:	90                   	nop
 18a:	90                   	nop
 18b:	90                   	nop
 18c:	90                   	nop
 18d:	90                   	nop
 18e:	90                   	nop
 18f:	90                   	nop

00000190 <thread_join>:
int thread_join(){
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	83 ec 34             	sub    $0x34,%esp
	void *stack = malloc(sizeof(void*));
 196:	6a 04                	push   $0x4
 198:	e8 23 06 00 00       	call   7c0 <malloc>
	lk->flag = 0;
 19d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	void *stack = malloc(sizeof(void*));
 1a4:	89 c1                	mov    %eax,%ecx
	lk->flag = 0;
 1a6:	83 c4 10             	add    $0x10,%esp
 1a9:	ba 01 00 00 00       	mov    $0x1,%edx
 1ae:	66 90                	xchg   %ax,%ax
 1b0:	89 d0                	mov    %edx,%eax
 1b2:	f0 87 45 f4          	lock xchg %eax,-0xc(%ebp)
	while(xchg(&lk->flag, 1) != 0);
 1b6:	85 c0                	test   %eax,%eax
 1b8:	75 f6                	jne    1b0 <thread_join+0x20>
	free(stack);
 1ba:	83 ec 0c             	sub    $0xc,%esp
 1bd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 1c0:	51                   	push   %ecx
 1c1:	e8 6a 05 00 00       	call   730 <free>
 1c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 1c9:	f0 87 45 f4          	lock xchg %eax,-0xc(%ebp)
}
 1cd:	31 c0                	xor    %eax,%eax
 1cf:	c9                   	leave  
 1d0:	c3                   	ret    
 1d1:	66 90                	xchg   %ax,%ax
 1d3:	66 90                	xchg   %ax,%ax
 1d5:	66 90                	xchg   %ax,%ax
 1d7:	66 90                	xchg   %ax,%ax
 1d9:	66 90                	xchg   %ax,%ax
 1db:	66 90                	xchg   %ax,%ax
 1dd:	66 90                	xchg   %ax,%ax
 1df:	90                   	nop

000001e0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	53                   	push   %ebx
 1e4:	8b 45 08             	mov    0x8(%ebp),%eax
 1e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1ea:	89 c2                	mov    %eax,%edx
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f0:	83 c1 01             	add    $0x1,%ecx
 1f3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 1f7:	83 c2 01             	add    $0x1,%edx
 1fa:	84 db                	test   %bl,%bl
 1fc:	88 5a ff             	mov    %bl,-0x1(%edx)
 1ff:	75 ef                	jne    1f0 <strcpy+0x10>
    ;
  return os;
}
 201:	5b                   	pop    %ebx
 202:	5d                   	pop    %ebp
 203:	c3                   	ret    
 204:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 20a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000210 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	56                   	push   %esi
 214:	53                   	push   %ebx
 215:	8b 55 08             	mov    0x8(%ebp),%edx
 218:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 21b:	0f b6 02             	movzbl (%edx),%eax
 21e:	0f b6 19             	movzbl (%ecx),%ebx
 221:	84 c0                	test   %al,%al
 223:	75 1e                	jne    243 <strcmp+0x33>
 225:	eb 29                	jmp    250 <strcmp+0x40>
 227:	89 f6                	mov    %esi,%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 230:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 233:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 236:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
 239:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 23d:	84 c0                	test   %al,%al
 23f:	74 0f                	je     250 <strcmp+0x40>
 241:	89 f1                	mov    %esi,%ecx
 243:	38 d8                	cmp    %bl,%al
 245:	74 e9                	je     230 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 247:	29 d8                	sub    %ebx,%eax
}
 249:	5b                   	pop    %ebx
 24a:	5e                   	pop    %esi
 24b:	5d                   	pop    %ebp
 24c:	c3                   	ret    
 24d:	8d 76 00             	lea    0x0(%esi),%esi
  while(*p && *p == *q)
 250:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 252:	29 d8                	sub    %ebx,%eax
}
 254:	5b                   	pop    %ebx
 255:	5e                   	pop    %esi
 256:	5d                   	pop    %ebp
 257:	c3                   	ret    
 258:	90                   	nop
 259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000260 <strlen>:

uint
strlen(char *s)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 266:	80 39 00             	cmpb   $0x0,(%ecx)
 269:	74 12                	je     27d <strlen+0x1d>
 26b:	31 d2                	xor    %edx,%edx
 26d:	8d 76 00             	lea    0x0(%esi),%esi
 270:	83 c2 01             	add    $0x1,%edx
 273:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 277:	89 d0                	mov    %edx,%eax
 279:	75 f5                	jne    270 <strlen+0x10>
    ;
  return n;
}
 27b:	5d                   	pop    %ebp
 27c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 27d:	31 c0                	xor    %eax,%eax
}
 27f:	5d                   	pop    %ebp
 280:	c3                   	ret    
 281:	eb 0d                	jmp    290 <memset>
 283:	90                   	nop
 284:	90                   	nop
 285:	90                   	nop
 286:	90                   	nop
 287:	90                   	nop
 288:	90                   	nop
 289:	90                   	nop
 28a:	90                   	nop
 28b:	90                   	nop
 28c:	90                   	nop
 28d:	90                   	nop
 28e:	90                   	nop
 28f:	90                   	nop

00000290 <memset>:

void*
memset(void *dst, int c, uint n)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	57                   	push   %edi
 294:	8b 55 08             	mov    0x8(%ebp),%edx
  asm volatile("cld; rep stosb" :
 297:	8b 4d 10             	mov    0x10(%ebp),%ecx
 29a:	8b 45 0c             	mov    0xc(%ebp),%eax
 29d:	89 d7                	mov    %edx,%edi
 29f:	fc                   	cld    
 2a0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2a2:	89 d0                	mov    %edx,%eax
 2a4:	5f                   	pop    %edi
 2a5:	5d                   	pop    %ebp
 2a6:	c3                   	ret    
 2a7:	89 f6                	mov    %esi,%esi
 2a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002b0 <strchr>:

char*
strchr(const char *s, char c)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	53                   	push   %ebx
 2b4:	8b 45 08             	mov    0x8(%ebp),%eax
 2b7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 2ba:	0f b6 10             	movzbl (%eax),%edx
 2bd:	84 d2                	test   %dl,%dl
 2bf:	74 1d                	je     2de <strchr+0x2e>
    if(*s == c)
 2c1:	38 d3                	cmp    %dl,%bl
 2c3:	89 d9                	mov    %ebx,%ecx
 2c5:	75 0d                	jne    2d4 <strchr+0x24>
 2c7:	eb 17                	jmp    2e0 <strchr+0x30>
 2c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2d0:	38 ca                	cmp    %cl,%dl
 2d2:	74 0c                	je     2e0 <strchr+0x30>
  for(; *s; s++)
 2d4:	83 c0 01             	add    $0x1,%eax
 2d7:	0f b6 10             	movzbl (%eax),%edx
 2da:	84 d2                	test   %dl,%dl
 2dc:	75 f2                	jne    2d0 <strchr+0x20>
      return (char*)s;
  return 0;
 2de:	31 c0                	xor    %eax,%eax
}
 2e0:	5b                   	pop    %ebx
 2e1:	5d                   	pop    %ebp
 2e2:	c3                   	ret    
 2e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002f0 <gets>:

char*
gets(char *buf, int max)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	57                   	push   %edi
 2f4:	56                   	push   %esi
 2f5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2f6:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 2f8:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 2fb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 2fe:	eb 29                	jmp    329 <gets+0x39>
    cc = read(0, &c, 1);
 300:	83 ec 04             	sub    $0x4,%esp
 303:	6a 01                	push   $0x1
 305:	57                   	push   %edi
 306:	6a 00                	push   $0x0
 308:	e8 2d 01 00 00       	call   43a <read>
    if(cc < 1)
 30d:	83 c4 10             	add    $0x10,%esp
 310:	85 c0                	test   %eax,%eax
 312:	7e 1d                	jle    331 <gets+0x41>
      break;
    buf[i++] = c;
 314:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 318:	8b 55 08             	mov    0x8(%ebp),%edx
 31b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 31d:	3c 0a                	cmp    $0xa,%al
    buf[i++] = c;
 31f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 323:	74 1b                	je     340 <gets+0x50>
 325:	3c 0d                	cmp    $0xd,%al
 327:	74 17                	je     340 <gets+0x50>
  for(i=0; i+1 < max; ){
 329:	8d 5e 01             	lea    0x1(%esi),%ebx
 32c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 32f:	7c cf                	jl     300 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 331:	8b 45 08             	mov    0x8(%ebp),%eax
 334:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 338:	8d 65 f4             	lea    -0xc(%ebp),%esp
 33b:	5b                   	pop    %ebx
 33c:	5e                   	pop    %esi
 33d:	5f                   	pop    %edi
 33e:	5d                   	pop    %ebp
 33f:	c3                   	ret    
  buf[i] = '\0';
 340:	8b 45 08             	mov    0x8(%ebp),%eax
  for(i=0; i+1 < max; ){
 343:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 345:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 349:	8d 65 f4             	lea    -0xc(%ebp),%esp
 34c:	5b                   	pop    %ebx
 34d:	5e                   	pop    %esi
 34e:	5f                   	pop    %edi
 34f:	5d                   	pop    %ebp
 350:	c3                   	ret    
 351:	eb 0d                	jmp    360 <stat>
 353:	90                   	nop
 354:	90                   	nop
 355:	90                   	nop
 356:	90                   	nop
 357:	90                   	nop
 358:	90                   	nop
 359:	90                   	nop
 35a:	90                   	nop
 35b:	90                   	nop
 35c:	90                   	nop
 35d:	90                   	nop
 35e:	90                   	nop
 35f:	90                   	nop

00000360 <stat>:

int
stat(char *n, struct stat *st)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	56                   	push   %esi
 364:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 365:	83 ec 08             	sub    $0x8,%esp
 368:	6a 00                	push   $0x0
 36a:	ff 75 08             	pushl  0x8(%ebp)
 36d:	e8 f0 00 00 00       	call   462 <open>
  if(fd < 0)
 372:	83 c4 10             	add    $0x10,%esp
 375:	85 c0                	test   %eax,%eax
 377:	78 27                	js     3a0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 379:	83 ec 08             	sub    $0x8,%esp
 37c:	ff 75 0c             	pushl  0xc(%ebp)
 37f:	89 c3                	mov    %eax,%ebx
 381:	50                   	push   %eax
 382:	e8 f3 00 00 00       	call   47a <fstat>
  close(fd);
 387:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 38a:	89 c6                	mov    %eax,%esi
  close(fd);
 38c:	e8 b9 00 00 00       	call   44a <close>
  return r;
 391:	83 c4 10             	add    $0x10,%esp
}
 394:	8d 65 f8             	lea    -0x8(%ebp),%esp
 397:	89 f0                	mov    %esi,%eax
 399:	5b                   	pop    %ebx
 39a:	5e                   	pop    %esi
 39b:	5d                   	pop    %ebp
 39c:	c3                   	ret    
 39d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 3a0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 3a5:	eb ed                	jmp    394 <stat+0x34>
 3a7:	89 f6                	mov    %esi,%esi
 3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003b0 <atoi>:

int
atoi(const char *s)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	53                   	push   %ebx
 3b4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3b7:	0f be 11             	movsbl (%ecx),%edx
 3ba:	8d 42 d0             	lea    -0x30(%edx),%eax
 3bd:	3c 09                	cmp    $0x9,%al
 3bf:	b8 00 00 00 00       	mov    $0x0,%eax
 3c4:	77 1f                	ja     3e5 <atoi+0x35>
 3c6:	8d 76 00             	lea    0x0(%esi),%esi
 3c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 3d0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 3d3:	83 c1 01             	add    $0x1,%ecx
 3d6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 3da:	0f be 11             	movsbl (%ecx),%edx
 3dd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 3e0:	80 fb 09             	cmp    $0x9,%bl
 3e3:	76 eb                	jbe    3d0 <atoi+0x20>
  return n;
}
 3e5:	5b                   	pop    %ebx
 3e6:	5d                   	pop    %ebp
 3e7:	c3                   	ret    
 3e8:	90                   	nop
 3e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003f0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	56                   	push   %esi
 3f4:	53                   	push   %ebx
 3f5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3f8:	8b 45 08             	mov    0x8(%ebp),%eax
 3fb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3fe:	85 db                	test   %ebx,%ebx
 400:	7e 14                	jle    416 <memmove+0x26>
 402:	31 d2                	xor    %edx,%edx
 404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 408:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 40c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 40f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 412:	39 da                	cmp    %ebx,%edx
 414:	75 f2                	jne    408 <memmove+0x18>
  return vdst;
}
 416:	5b                   	pop    %ebx
 417:	5e                   	pop    %esi
 418:	5d                   	pop    %ebp
 419:	c3                   	ret    

0000041a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 41a:	b8 01 00 00 00       	mov    $0x1,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <exit>:
SYSCALL(exit)
 422:	b8 02 00 00 00       	mov    $0x2,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <wait>:
SYSCALL(wait)
 42a:	b8 03 00 00 00       	mov    $0x3,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <pipe>:
SYSCALL(pipe)
 432:	b8 04 00 00 00       	mov    $0x4,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <read>:
SYSCALL(read)
 43a:	b8 05 00 00 00       	mov    $0x5,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <write>:
SYSCALL(write)
 442:	b8 10 00 00 00       	mov    $0x10,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <close>:
SYSCALL(close)
 44a:	b8 15 00 00 00       	mov    $0x15,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <kill>:
SYSCALL(kill)
 452:	b8 06 00 00 00       	mov    $0x6,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <exec>:
SYSCALL(exec)
 45a:	b8 07 00 00 00       	mov    $0x7,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <open>:
SYSCALL(open)
 462:	b8 0f 00 00 00       	mov    $0xf,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <mknod>:
SYSCALL(mknod)
 46a:	b8 11 00 00 00       	mov    $0x11,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <unlink>:
SYSCALL(unlink)
 472:	b8 12 00 00 00       	mov    $0x12,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <fstat>:
SYSCALL(fstat)
 47a:	b8 08 00 00 00       	mov    $0x8,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <link>:
SYSCALL(link)
 482:	b8 13 00 00 00       	mov    $0x13,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <mkdir>:
SYSCALL(mkdir)
 48a:	b8 14 00 00 00       	mov    $0x14,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <chdir>:
SYSCALL(chdir)
 492:	b8 09 00 00 00       	mov    $0x9,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <dup>:
SYSCALL(dup)
 49a:	b8 0a 00 00 00       	mov    $0xa,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <getpid>:
SYSCALL(getpid)
 4a2:	b8 0b 00 00 00       	mov    $0xb,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <sbrk>:
SYSCALL(sbrk)
 4aa:	b8 0c 00 00 00       	mov    $0xc,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <sleep>:
SYSCALL(sleep)
 4b2:	b8 0d 00 00 00       	mov    $0xd,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <uptime>:
SYSCALL(uptime)
 4ba:	b8 0e 00 00 00       	mov    $0xe,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <dup2>:
SYSCALL(dup2)
 4c2:	b8 16 00 00 00       	mov    $0x16,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <getcwd>:
SYSCALL(getcwd)
 4ca:	b8 17 00 00 00       	mov    $0x17,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <clone_jared>:
SYSCALL(clone_jared)
 4d2:	b8 18 00 00 00       	mov    $0x18,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    
 4da:	66 90                	xchg   %ax,%ax
 4dc:	66 90                	xchg   %ax,%ax
 4de:	66 90                	xchg   %ax,%ax

000004e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	53                   	push   %ebx
 4e6:	89 c6                	mov    %eax,%esi
 4e8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 4ee:	85 db                	test   %ebx,%ebx
 4f0:	74 7e                	je     570 <printint+0x90>
 4f2:	89 d0                	mov    %edx,%eax
 4f4:	c1 e8 1f             	shr    $0x1f,%eax
 4f7:	84 c0                	test   %al,%al
 4f9:	74 75                	je     570 <printint+0x90>
    neg = 1;
    x = -xx;
 4fb:	89 d0                	mov    %edx,%eax
    neg = 1;
 4fd:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 504:	f7 d8                	neg    %eax
 506:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 509:	31 ff                	xor    %edi,%edi
 50b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 50e:	89 ce                	mov    %ecx,%esi
 510:	eb 08                	jmp    51a <printint+0x3a>
 512:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 518:	89 cf                	mov    %ecx,%edi
 51a:	31 d2                	xor    %edx,%edx
 51c:	8d 4f 01             	lea    0x1(%edi),%ecx
 51f:	f7 f6                	div    %esi
 521:	0f b6 92 28 09 00 00 	movzbl 0x928(%edx),%edx
  }while((x /= base) != 0);
 528:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 52a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 52d:	75 e9                	jne    518 <printint+0x38>
  if(neg)
 52f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 532:	8b 75 c0             	mov    -0x40(%ebp),%esi
 535:	85 c0                	test   %eax,%eax
 537:	74 08                	je     541 <printint+0x61>
    buf[i++] = '-';
 539:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 53e:	8d 4f 02             	lea    0x2(%edi),%ecx

  while(--i >= 0)
 541:	8d 79 ff             	lea    -0x1(%ecx),%edi
 544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 548:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
  write(fd, &c, 1);
 54d:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 550:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 553:	6a 01                	push   $0x1
 555:	53                   	push   %ebx
 556:	56                   	push   %esi
 557:	88 45 d7             	mov    %al,-0x29(%ebp)
 55a:	e8 e3 fe ff ff       	call   442 <write>
  while(--i >= 0)
 55f:	83 c4 10             	add    $0x10,%esp
 562:	83 ff ff             	cmp    $0xffffffff,%edi
 565:	75 e1                	jne    548 <printint+0x68>
    putc(fd, buf[i]);
}
 567:	8d 65 f4             	lea    -0xc(%ebp),%esp
 56a:	5b                   	pop    %ebx
 56b:	5e                   	pop    %esi
 56c:	5f                   	pop    %edi
 56d:	5d                   	pop    %ebp
 56e:	c3                   	ret    
 56f:	90                   	nop
    x = xx;
 570:	89 d0                	mov    %edx,%eax
  neg = 0;
 572:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 579:	eb 8b                	jmp    506 <printint+0x26>
 57b:	90                   	nop
 57c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000580 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	57                   	push   %edi
 584:	56                   	push   %esi
 585:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 586:	8d 45 10             	lea    0x10(%ebp),%eax
{
 589:	83 ec 2c             	sub    $0x2c,%esp
  for(i = 0; fmt[i]; i++){
 58c:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 58f:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 592:	89 45 d0             	mov    %eax,-0x30(%ebp)
 595:	0f b6 1e             	movzbl (%esi),%ebx
 598:	83 c6 01             	add    $0x1,%esi
 59b:	84 db                	test   %bl,%bl
 59d:	0f 84 b0 00 00 00    	je     653 <printf+0xd3>
 5a3:	31 d2                	xor    %edx,%edx
 5a5:	eb 39                	jmp    5e0 <printf+0x60>
 5a7:	89 f6                	mov    %esi,%esi
 5a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5b0:	83 f8 25             	cmp    $0x25,%eax
 5b3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 5b6:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 5bb:	74 18                	je     5d5 <printf+0x55>
  write(fd, &c, 1);
 5bd:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 5c0:	83 ec 04             	sub    $0x4,%esp
 5c3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 5c6:	6a 01                	push   $0x1
 5c8:	50                   	push   %eax
 5c9:	57                   	push   %edi
 5ca:	e8 73 fe ff ff       	call   442 <write>
 5cf:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 5d2:	83 c4 10             	add    $0x10,%esp
 5d5:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 5d8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 5dc:	84 db                	test   %bl,%bl
 5de:	74 73                	je     653 <printf+0xd3>
    if(state == 0){
 5e0:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 5e2:	0f be cb             	movsbl %bl,%ecx
 5e5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5e8:	74 c6                	je     5b0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5ea:	83 fa 25             	cmp    $0x25,%edx
 5ed:	75 e6                	jne    5d5 <printf+0x55>
      if(c == 'd'){
 5ef:	83 f8 64             	cmp    $0x64,%eax
 5f2:	0f 84 f8 00 00 00    	je     6f0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5f8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 5fe:	83 f9 70             	cmp    $0x70,%ecx
 601:	74 5d                	je     660 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 603:	83 f8 73             	cmp    $0x73,%eax
 606:	0f 84 84 00 00 00    	je     690 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 60c:	83 f8 63             	cmp    $0x63,%eax
 60f:	0f 84 ea 00 00 00    	je     6ff <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 615:	83 f8 25             	cmp    $0x25,%eax
 618:	0f 84 c2 00 00 00    	je     6e0 <printf+0x160>
  write(fd, &c, 1);
 61e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 621:	83 ec 04             	sub    $0x4,%esp
 624:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 628:	6a 01                	push   $0x1
 62a:	50                   	push   %eax
 62b:	57                   	push   %edi
 62c:	e8 11 fe ff ff       	call   442 <write>
 631:	83 c4 0c             	add    $0xc,%esp
 634:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 637:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 63a:	6a 01                	push   $0x1
 63c:	50                   	push   %eax
 63d:	57                   	push   %edi
 63e:	83 c6 01             	add    $0x1,%esi
 641:	e8 fc fd ff ff       	call   442 <write>
  for(i = 0; fmt[i]; i++){
 646:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 64a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 64d:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 64f:	84 db                	test   %bl,%bl
 651:	75 8d                	jne    5e0 <printf+0x60>
    }
  }
}
 653:	8d 65 f4             	lea    -0xc(%ebp),%esp
 656:	5b                   	pop    %ebx
 657:	5e                   	pop    %esi
 658:	5f                   	pop    %edi
 659:	5d                   	pop    %ebp
 65a:	c3                   	ret    
 65b:	90                   	nop
 65c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 16, 0);
 660:	83 ec 0c             	sub    $0xc,%esp
 663:	b9 10 00 00 00       	mov    $0x10,%ecx
 668:	6a 00                	push   $0x0
 66a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 66d:	89 f8                	mov    %edi,%eax
 66f:	8b 13                	mov    (%ebx),%edx
 671:	e8 6a fe ff ff       	call   4e0 <printint>
        ap++;
 676:	89 d8                	mov    %ebx,%eax
 678:	83 c4 10             	add    $0x10,%esp
      state = 0;
 67b:	31 d2                	xor    %edx,%edx
        ap++;
 67d:	83 c0 04             	add    $0x4,%eax
 680:	89 45 d0             	mov    %eax,-0x30(%ebp)
 683:	e9 4d ff ff ff       	jmp    5d5 <printf+0x55>
 688:	90                   	nop
 689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 690:	8b 45 d0             	mov    -0x30(%ebp),%eax
 693:	8b 18                	mov    (%eax),%ebx
        ap++;
 695:	83 c0 04             	add    $0x4,%eax
 698:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 69b:	85 db                	test   %ebx,%ebx
 69d:	74 7c                	je     71b <printf+0x19b>
        while(*s != 0){
 69f:	0f b6 03             	movzbl (%ebx),%eax
 6a2:	84 c0                	test   %al,%al
 6a4:	74 29                	je     6cf <printf+0x14f>
 6a6:	8d 76 00             	lea    0x0(%esi),%esi
 6a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 6b0:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 6b3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 6b6:	83 ec 04             	sub    $0x4,%esp
 6b9:	6a 01                	push   $0x1
          s++;
 6bb:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 6be:	50                   	push   %eax
 6bf:	57                   	push   %edi
 6c0:	e8 7d fd ff ff       	call   442 <write>
        while(*s != 0){
 6c5:	0f b6 03             	movzbl (%ebx),%eax
 6c8:	83 c4 10             	add    $0x10,%esp
 6cb:	84 c0                	test   %al,%al
 6cd:	75 e1                	jne    6b0 <printf+0x130>
      state = 0;
 6cf:	31 d2                	xor    %edx,%edx
 6d1:	e9 ff fe ff ff       	jmp    5d5 <printf+0x55>
 6d6:	8d 76 00             	lea    0x0(%esi),%esi
 6d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  write(fd, &c, 1);
 6e0:	83 ec 04             	sub    $0x4,%esp
 6e3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 6e6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 6e9:	6a 01                	push   $0x1
 6eb:	e9 4c ff ff ff       	jmp    63c <printf+0xbc>
        printint(fd, *ap, 10, 1);
 6f0:	83 ec 0c             	sub    $0xc,%esp
 6f3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6f8:	6a 01                	push   $0x1
 6fa:	e9 6b ff ff ff       	jmp    66a <printf+0xea>
        putc(fd, *ap);
 6ff:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 702:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 705:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 707:	6a 01                	push   $0x1
        putc(fd, *ap);
 709:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 70c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 70f:	50                   	push   %eax
 710:	57                   	push   %edi
 711:	e8 2c fd ff ff       	call   442 <write>
 716:	e9 5b ff ff ff       	jmp    676 <printf+0xf6>
        while(*s != 0){
 71b:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 720:	bb 20 09 00 00       	mov    $0x920,%ebx
 725:	eb 89                	jmp    6b0 <printf+0x130>
 727:	66 90                	xchg   %ax,%ax
 729:	66 90                	xchg   %ax,%ax
 72b:	66 90                	xchg   %ax,%ax
 72d:	66 90                	xchg   %ax,%ax
 72f:	90                   	nop

00000730 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 730:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 731:	a1 e4 0c 00 00       	mov    0xce4,%eax
{
 736:	89 e5                	mov    %esp,%ebp
 738:	57                   	push   %edi
 739:	56                   	push   %esi
 73a:	53                   	push   %ebx
 73b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 73e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 740:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 743:	39 c8                	cmp    %ecx,%eax
 745:	73 19                	jae    760 <free+0x30>
 747:	89 f6                	mov    %esi,%esi
 749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 750:	39 d1                	cmp    %edx,%ecx
 752:	72 1c                	jb     770 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 754:	39 d0                	cmp    %edx,%eax
 756:	73 18                	jae    770 <free+0x40>
{
 758:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 75a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 75c:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 75e:	72 f0                	jb     750 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 760:	39 d0                	cmp    %edx,%eax
 762:	72 f4                	jb     758 <free+0x28>
 764:	39 d1                	cmp    %edx,%ecx
 766:	73 f0                	jae    758 <free+0x28>
 768:	90                   	nop
 769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 770:	8b 73 fc             	mov    -0x4(%ebx),%esi
 773:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 776:	39 fa                	cmp    %edi,%edx
 778:	74 19                	je     793 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 77a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 77d:	8b 50 04             	mov    0x4(%eax),%edx
 780:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 783:	39 f1                	cmp    %esi,%ecx
 785:	74 23                	je     7aa <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 787:	89 08                	mov    %ecx,(%eax)
  freep = p;
 789:	a3 e4 0c 00 00       	mov    %eax,0xce4
}
 78e:	5b                   	pop    %ebx
 78f:	5e                   	pop    %esi
 790:	5f                   	pop    %edi
 791:	5d                   	pop    %ebp
 792:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 793:	03 72 04             	add    0x4(%edx),%esi
 796:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 799:	8b 10                	mov    (%eax),%edx
 79b:	8b 12                	mov    (%edx),%edx
 79d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7a0:	8b 50 04             	mov    0x4(%eax),%edx
 7a3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7a6:	39 f1                	cmp    %esi,%ecx
 7a8:	75 dd                	jne    787 <free+0x57>
    p->s.size += bp->s.size;
 7aa:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 7ad:	a3 e4 0c 00 00       	mov    %eax,0xce4
    p->s.size += bp->s.size;
 7b2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7b5:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7b8:	89 10                	mov    %edx,(%eax)
}
 7ba:	5b                   	pop    %ebx
 7bb:	5e                   	pop    %esi
 7bc:	5f                   	pop    %edi
 7bd:	5d                   	pop    %ebp
 7be:	c3                   	ret    
 7bf:	90                   	nop

000007c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	57                   	push   %edi
 7c4:	56                   	push   %esi
 7c5:	53                   	push   %ebx
 7c6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7cc:	8b 15 e4 0c 00 00    	mov    0xce4,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d2:	8d 78 07             	lea    0x7(%eax),%edi
 7d5:	c1 ef 03             	shr    $0x3,%edi
 7d8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 7db:	85 d2                	test   %edx,%edx
 7dd:	0f 84 93 00 00 00    	je     876 <malloc+0xb6>
 7e3:	8b 02                	mov    (%edx),%eax
 7e5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7e8:	39 cf                	cmp    %ecx,%edi
 7ea:	76 64                	jbe    850 <malloc+0x90>
 7ec:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 7f2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7f7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 7fa:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 801:	eb 0e                	jmp    811 <malloc+0x51>
 803:	90                   	nop
 804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 808:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 80a:	8b 48 04             	mov    0x4(%eax),%ecx
 80d:	39 cf                	cmp    %ecx,%edi
 80f:	76 3f                	jbe    850 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 811:	39 05 e4 0c 00 00    	cmp    %eax,0xce4
 817:	89 c2                	mov    %eax,%edx
 819:	75 ed                	jne    808 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 81b:	83 ec 0c             	sub    $0xc,%esp
 81e:	56                   	push   %esi
 81f:	e8 86 fc ff ff       	call   4aa <sbrk>
  if(p == (char*)-1)
 824:	83 c4 10             	add    $0x10,%esp
 827:	83 f8 ff             	cmp    $0xffffffff,%eax
 82a:	74 1c                	je     848 <malloc+0x88>
  hp->s.size = nu;
 82c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 82f:	83 ec 0c             	sub    $0xc,%esp
 832:	83 c0 08             	add    $0x8,%eax
 835:	50                   	push   %eax
 836:	e8 f5 fe ff ff       	call   730 <free>
  return freep;
 83b:	8b 15 e4 0c 00 00    	mov    0xce4,%edx
      if((p = morecore(nunits)) == 0)
 841:	83 c4 10             	add    $0x10,%esp
 844:	85 d2                	test   %edx,%edx
 846:	75 c0                	jne    808 <malloc+0x48>
        return 0;
 848:	31 c0                	xor    %eax,%eax
 84a:	eb 1c                	jmp    868 <malloc+0xa8>
 84c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 850:	39 cf                	cmp    %ecx,%edi
 852:	74 1c                	je     870 <malloc+0xb0>
        p->s.size -= nunits;
 854:	29 f9                	sub    %edi,%ecx
 856:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 859:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 85c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 85f:	89 15 e4 0c 00 00    	mov    %edx,0xce4
      return (void*)(p + 1);
 865:	83 c0 08             	add    $0x8,%eax
  }
}
 868:	8d 65 f4             	lea    -0xc(%ebp),%esp
 86b:	5b                   	pop    %ebx
 86c:	5e                   	pop    %esi
 86d:	5f                   	pop    %edi
 86e:	5d                   	pop    %ebp
 86f:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 870:	8b 08                	mov    (%eax),%ecx
 872:	89 0a                	mov    %ecx,(%edx)
 874:	eb e9                	jmp    85f <malloc+0x9f>
    base.s.ptr = freep = prevp = &base;
 876:	c7 05 e4 0c 00 00 e8 	movl   $0xce8,0xce4
 87d:	0c 00 00 
 880:	c7 05 e8 0c 00 00 e8 	movl   $0xce8,0xce8
 887:	0c 00 00 
    base.s.size = 0;
 88a:	b8 e8 0c 00 00       	mov    $0xce8,%eax
 88f:	c7 05 ec 0c 00 00 00 	movl   $0x0,0xcec
 896:	00 00 00 
 899:	e9 4e ff ff ff       	jmp    7ec <malloc+0x2c>
 89e:	66 90                	xchg   %ax,%ax

000008a0 <calloc>:

void*
calloc(uint nmemb, uint sz)
{
 8a0:	55                   	push   %ebp
 8a1:	89 e5                	mov    %esp,%ebp
 8a3:	56                   	push   %esi
 8a4:	53                   	push   %ebx
  uint full_sz = 0;
  if (__builtin_mul_overflow(nmemb, sz, &full_sz))
 8a5:	8b 45 08             	mov    0x8(%ebp),%eax
 8a8:	f7 65 0c             	mull   0xc(%ebp)
 8ab:	70 25                	jo     8d2 <calloc+0x32>
    return NULL;
  void *region = malloc(full_sz);
 8ad:	83 ec 0c             	sub    $0xc,%esp
 8b0:	89 c3                	mov    %eax,%ebx
 8b2:	50                   	push   %eax
 8b3:	e8 08 ff ff ff       	call   7c0 <malloc>
  memset(region, 0, full_sz);
 8b8:	83 c4 0c             	add    $0xc,%esp
  void *region = malloc(full_sz);
 8bb:	89 c6                	mov    %eax,%esi
  memset(region, 0, full_sz);
 8bd:	53                   	push   %ebx
 8be:	6a 00                	push   $0x0
 8c0:	50                   	push   %eax
 8c1:	e8 ca f9 ff ff       	call   290 <memset>
  return region;
 8c6:	83 c4 10             	add    $0x10,%esp
}
 8c9:	8d 65 f8             	lea    -0x8(%ebp),%esp
 8cc:	89 f0                	mov    %esi,%eax
 8ce:	5b                   	pop    %ebx
 8cf:	5e                   	pop    %esi
 8d0:	5d                   	pop    %ebp
 8d1:	c3                   	ret    
    return NULL;
 8d2:	31 f6                	xor    %esi,%esi
 8d4:	eb f3                	jmp    8c9 <calloc+0x29>
 8d6:	8d 76 00             	lea    0x0(%esi),%esi
 8d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008e0 <strdup>:

char*
strdup(char *s)
{
 8e0:	55                   	push   %ebp
 8e1:	89 e5                	mov    %esp,%ebp
 8e3:	56                   	push   %esi
 8e4:	53                   	push   %ebx
 8e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *buf = malloc(strlen(s) + 1);
 8e8:	83 ec 0c             	sub    $0xc,%esp
 8eb:	53                   	push   %ebx
 8ec:	e8 6f f9 ff ff       	call   260 <strlen>
 8f1:	83 c0 01             	add    $0x1,%eax
 8f4:	89 04 24             	mov    %eax,(%esp)
 8f7:	e8 c4 fe ff ff       	call   7c0 <malloc>
 8fc:	89 c6                	mov    %eax,%esi
  strcpy(buf, s);
 8fe:	58                   	pop    %eax
 8ff:	5a                   	pop    %edx
 900:	53                   	push   %ebx
 901:	56                   	push   %esi
 902:	e8 d9 f8 ff ff       	call   1e0 <strcpy>
  return buf;
}
 907:	8d 65 f8             	lea    -0x8(%ebp),%esp
 90a:	89 f0                	mov    %esi,%eax
 90c:	5b                   	pop    %ebx
 90d:	5e                   	pop    %esi
 90e:	5d                   	pop    %ebp
 90f:	c3                   	ret    
