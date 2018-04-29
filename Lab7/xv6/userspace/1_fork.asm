
_1_fork:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

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
  int p = (int)shm_jared(0, 1);
   f:	83 ec 08             	sub    $0x8,%esp
  12:	6a 01                	push   $0x1
  14:	6a 00                	push   $0x0
  16:	e8 77 03 00 00       	call   392 <shm_jared>
  int *test;
  test = (int *)p;
  *test = 10;
    printf(1, "test initial value %d\n", *test);
  1b:	83 c4 0c             	add    $0xc,%esp
  *test = 10;
  1e:	c7 00 0a 00 00 00    	movl   $0xa,(%eax)
    printf(1, "test initial value %d\n", *test);
  24:	6a 0a                	push   $0xa
  26:	68 d0 07 00 00       	push   $0x7d0
  2b:	6a 01                	push   $0x1
  2d:	e8 0e 04 00 00       	call   440 <printf>
  int ret = fork();
  32:	e8 a3 02 00 00       	call   2da <fork>

  if (ret == 0){
  37:	83 c4 10             	add    $0x10,%esp
  3a:	85 c0                	test   %eax,%eax
  3c:	75 3a                	jne    78 <main+0x78>
    int * test_child;
    test_child = (int*)shm_jared(0, 1);
  3e:	52                   	push   %edx
  3f:	52                   	push   %edx
  40:	6a 01                	push   $0x1
  42:	6a 00                	push   $0x0
  44:	e8 49 03 00 00       	call   392 <shm_jared>
    printf(1, "test value (child) %d\n", *test_child);
  49:	83 c4 0c             	add    $0xc,%esp
  4c:	ff 30                	pushl  (%eax)
    test_child = (int*)shm_jared(0, 1);
  4e:	89 c3                	mov    %eax,%ebx
    printf(1, "test value (child) %d\n", *test_child);
  50:	68 e7 07 00 00       	push   $0x7e7
  55:	6a 01                	push   $0x1
  57:	e8 e4 03 00 00       	call   440 <printf>
    *test_child = 20;
    printf(1, "test value (child) %d\n", *test_child);
  5c:	83 c4 0c             	add    $0xc,%esp
    *test_child = 20;
  5f:	c7 03 14 00 00 00    	movl   $0x14,(%ebx)
    printf(1, "test value (child) %d\n", *test_child);
  65:	6a 14                	push   $0x14
  67:	68 e7 07 00 00       	push   $0x7e7
  6c:	6a 01                	push   $0x1
  6e:	e8 cd 03 00 00       	call   440 <printf>
    exit();
  73:	e8 6a 02 00 00       	call   2e2 <exit>
  }
  wait();
  78:	e8 6d 02 00 00       	call   2ea <wait>
  test = (int*)shm_jared(0, 1);
  7d:	50                   	push   %eax
  7e:	50                   	push   %eax
  7f:	6a 01                	push   $0x1
  81:	6a 00                	push   $0x0
  83:	e8 0a 03 00 00       	call   392 <shm_jared>
  printf(1, "test value (parent) %d\n", *test);
  88:	83 c4 0c             	add    $0xc,%esp
  8b:	ff 30                	pushl  (%eax)
  8d:	68 fe 07 00 00       	push   $0x7fe
  92:	6a 01                	push   $0x1
  94:	e8 a7 03 00 00       	call   440 <printf>
  

  
  exit();
  99:	e8 44 02 00 00       	call   2e2 <exit>
  9e:	66 90                	xchg   %ax,%ax

000000a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	53                   	push   %ebx
  a4:	8b 45 08             	mov    0x8(%ebp),%eax
  a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  aa:	89 c2                	mov    %eax,%edx
  ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  b0:	83 c1 01             	add    $0x1,%ecx
  b3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  b7:	83 c2 01             	add    $0x1,%edx
  ba:	84 db                	test   %bl,%bl
  bc:	88 5a ff             	mov    %bl,-0x1(%edx)
  bf:	75 ef                	jne    b0 <strcpy+0x10>
    ;
  return os;
}
  c1:	5b                   	pop    %ebx
  c2:	5d                   	pop    %ebp
  c3:	c3                   	ret    
  c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	56                   	push   %esi
  d4:	53                   	push   %ebx
  d5:	8b 55 08             	mov    0x8(%ebp),%edx
  d8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  db:	0f b6 02             	movzbl (%edx),%eax
  de:	0f b6 19             	movzbl (%ecx),%ebx
  e1:	84 c0                	test   %al,%al
  e3:	75 1e                	jne    103 <strcmp+0x33>
  e5:	eb 29                	jmp    110 <strcmp+0x40>
  e7:	89 f6                	mov    %esi,%esi
  e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  f0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  f3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  f6:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
  f9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  fd:	84 c0                	test   %al,%al
  ff:	74 0f                	je     110 <strcmp+0x40>
 101:	89 f1                	mov    %esi,%ecx
 103:	38 d8                	cmp    %bl,%al
 105:	74 e9                	je     f0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 107:	29 d8                	sub    %ebx,%eax
}
 109:	5b                   	pop    %ebx
 10a:	5e                   	pop    %esi
 10b:	5d                   	pop    %ebp
 10c:	c3                   	ret    
 10d:	8d 76 00             	lea    0x0(%esi),%esi
  while(*p && *p == *q)
 110:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 112:	29 d8                	sub    %ebx,%eax
}
 114:	5b                   	pop    %ebx
 115:	5e                   	pop    %esi
 116:	5d                   	pop    %ebp
 117:	c3                   	ret    
 118:	90                   	nop
 119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000120 <strlen>:

uint
strlen(char *s)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 126:	80 39 00             	cmpb   $0x0,(%ecx)
 129:	74 12                	je     13d <strlen+0x1d>
 12b:	31 d2                	xor    %edx,%edx
 12d:	8d 76 00             	lea    0x0(%esi),%esi
 130:	83 c2 01             	add    $0x1,%edx
 133:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 137:	89 d0                	mov    %edx,%eax
 139:	75 f5                	jne    130 <strlen+0x10>
    ;
  return n;
}
 13b:	5d                   	pop    %ebp
 13c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 13d:	31 c0                	xor    %eax,%eax
}
 13f:	5d                   	pop    %ebp
 140:	c3                   	ret    
 141:	eb 0d                	jmp    150 <memset>
 143:	90                   	nop
 144:	90                   	nop
 145:	90                   	nop
 146:	90                   	nop
 147:	90                   	nop
 148:	90                   	nop
 149:	90                   	nop
 14a:	90                   	nop
 14b:	90                   	nop
 14c:	90                   	nop
 14d:	90                   	nop
 14e:	90                   	nop
 14f:	90                   	nop

00000150 <memset>:

void*
memset(void *dst, int c, uint n)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	57                   	push   %edi
 154:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 157:	8b 4d 10             	mov    0x10(%ebp),%ecx
 15a:	8b 45 0c             	mov    0xc(%ebp),%eax
 15d:	89 d7                	mov    %edx,%edi
 15f:	fc                   	cld    
 160:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 162:	89 d0                	mov    %edx,%eax
 164:	5f                   	pop    %edi
 165:	5d                   	pop    %ebp
 166:	c3                   	ret    
 167:	89 f6                	mov    %esi,%esi
 169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000170 <strchr>:

char*
strchr(const char *s, char c)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	53                   	push   %ebx
 174:	8b 45 08             	mov    0x8(%ebp),%eax
 177:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 17a:	0f b6 10             	movzbl (%eax),%edx
 17d:	84 d2                	test   %dl,%dl
 17f:	74 1d                	je     19e <strchr+0x2e>
    if(*s == c)
 181:	38 d3                	cmp    %dl,%bl
 183:	89 d9                	mov    %ebx,%ecx
 185:	75 0d                	jne    194 <strchr+0x24>
 187:	eb 17                	jmp    1a0 <strchr+0x30>
 189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 190:	38 ca                	cmp    %cl,%dl
 192:	74 0c                	je     1a0 <strchr+0x30>
  for(; *s; s++)
 194:	83 c0 01             	add    $0x1,%eax
 197:	0f b6 10             	movzbl (%eax),%edx
 19a:	84 d2                	test   %dl,%dl
 19c:	75 f2                	jne    190 <strchr+0x20>
      return (char*)s;
  return 0;
 19e:	31 c0                	xor    %eax,%eax
}
 1a0:	5b                   	pop    %ebx
 1a1:	5d                   	pop    %ebp
 1a2:	c3                   	ret    
 1a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001b0 <gets>:

char*
gets(char *buf, int max)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	57                   	push   %edi
 1b4:	56                   	push   %esi
 1b5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1b6:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 1b8:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 1bb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 1be:	eb 29                	jmp    1e9 <gets+0x39>
    cc = read(0, &c, 1);
 1c0:	83 ec 04             	sub    $0x4,%esp
 1c3:	6a 01                	push   $0x1
 1c5:	57                   	push   %edi
 1c6:	6a 00                	push   $0x0
 1c8:	e8 2d 01 00 00       	call   2fa <read>
    if(cc < 1)
 1cd:	83 c4 10             	add    $0x10,%esp
 1d0:	85 c0                	test   %eax,%eax
 1d2:	7e 1d                	jle    1f1 <gets+0x41>
      break;
    buf[i++] = c;
 1d4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1d8:	8b 55 08             	mov    0x8(%ebp),%edx
 1db:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 1dd:	3c 0a                	cmp    $0xa,%al
    buf[i++] = c;
 1df:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 1e3:	74 1b                	je     200 <gets+0x50>
 1e5:	3c 0d                	cmp    $0xd,%al
 1e7:	74 17                	je     200 <gets+0x50>
  for(i=0; i+1 < max; ){
 1e9:	8d 5e 01             	lea    0x1(%esi),%ebx
 1ec:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1ef:	7c cf                	jl     1c0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 1f1:	8b 45 08             	mov    0x8(%ebp),%eax
 1f4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1fb:	5b                   	pop    %ebx
 1fc:	5e                   	pop    %esi
 1fd:	5f                   	pop    %edi
 1fe:	5d                   	pop    %ebp
 1ff:	c3                   	ret    
  buf[i] = '\0';
 200:	8b 45 08             	mov    0x8(%ebp),%eax
  for(i=0; i+1 < max; ){
 203:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 205:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 209:	8d 65 f4             	lea    -0xc(%ebp),%esp
 20c:	5b                   	pop    %ebx
 20d:	5e                   	pop    %esi
 20e:	5f                   	pop    %edi
 20f:	5d                   	pop    %ebp
 210:	c3                   	ret    
 211:	eb 0d                	jmp    220 <stat>
 213:	90                   	nop
 214:	90                   	nop
 215:	90                   	nop
 216:	90                   	nop
 217:	90                   	nop
 218:	90                   	nop
 219:	90                   	nop
 21a:	90                   	nop
 21b:	90                   	nop
 21c:	90                   	nop
 21d:	90                   	nop
 21e:	90                   	nop
 21f:	90                   	nop

00000220 <stat>:

int
stat(char *n, struct stat *st)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	56                   	push   %esi
 224:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 225:	83 ec 08             	sub    $0x8,%esp
 228:	6a 00                	push   $0x0
 22a:	ff 75 08             	pushl  0x8(%ebp)
 22d:	e8 f0 00 00 00       	call   322 <open>
  if(fd < 0)
 232:	83 c4 10             	add    $0x10,%esp
 235:	85 c0                	test   %eax,%eax
 237:	78 27                	js     260 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 239:	83 ec 08             	sub    $0x8,%esp
 23c:	ff 75 0c             	pushl  0xc(%ebp)
 23f:	89 c3                	mov    %eax,%ebx
 241:	50                   	push   %eax
 242:	e8 f3 00 00 00       	call   33a <fstat>
  close(fd);
 247:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 24a:	89 c6                	mov    %eax,%esi
  close(fd);
 24c:	e8 b9 00 00 00       	call   30a <close>
  return r;
 251:	83 c4 10             	add    $0x10,%esp
}
 254:	8d 65 f8             	lea    -0x8(%ebp),%esp
 257:	89 f0                	mov    %esi,%eax
 259:	5b                   	pop    %ebx
 25a:	5e                   	pop    %esi
 25b:	5d                   	pop    %ebp
 25c:	c3                   	ret    
 25d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 260:	be ff ff ff ff       	mov    $0xffffffff,%esi
 265:	eb ed                	jmp    254 <stat+0x34>
 267:	89 f6                	mov    %esi,%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000270 <atoi>:

int
atoi(const char *s)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	53                   	push   %ebx
 274:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 277:	0f be 11             	movsbl (%ecx),%edx
 27a:	8d 42 d0             	lea    -0x30(%edx),%eax
 27d:	3c 09                	cmp    $0x9,%al
 27f:	b8 00 00 00 00       	mov    $0x0,%eax
 284:	77 1f                	ja     2a5 <atoi+0x35>
 286:	8d 76 00             	lea    0x0(%esi),%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 290:	8d 04 80             	lea    (%eax,%eax,4),%eax
 293:	83 c1 01             	add    $0x1,%ecx
 296:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 29a:	0f be 11             	movsbl (%ecx),%edx
 29d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 2a0:	80 fb 09             	cmp    $0x9,%bl
 2a3:	76 eb                	jbe    290 <atoi+0x20>
  return n;
}
 2a5:	5b                   	pop    %ebx
 2a6:	5d                   	pop    %ebp
 2a7:	c3                   	ret    
 2a8:	90                   	nop
 2a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002b0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	56                   	push   %esi
 2b4:	53                   	push   %ebx
 2b5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 2b8:	8b 45 08             	mov    0x8(%ebp),%eax
 2bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2be:	85 db                	test   %ebx,%ebx
 2c0:	7e 14                	jle    2d6 <memmove+0x26>
 2c2:	31 d2                	xor    %edx,%edx
 2c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 2c8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2cc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2cf:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 2d2:	39 da                	cmp    %ebx,%edx
 2d4:	75 f2                	jne    2c8 <memmove+0x18>
  return vdst;
}
 2d6:	5b                   	pop    %ebx
 2d7:	5e                   	pop    %esi
 2d8:	5d                   	pop    %ebp
 2d9:	c3                   	ret    

000002da <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2da:	b8 01 00 00 00       	mov    $0x1,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <exit>:
SYSCALL(exit)
 2e2:	b8 02 00 00 00       	mov    $0x2,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <wait>:
SYSCALL(wait)
 2ea:	b8 03 00 00 00       	mov    $0x3,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <pipe>:
SYSCALL(pipe)
 2f2:	b8 04 00 00 00       	mov    $0x4,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <read>:
SYSCALL(read)
 2fa:	b8 05 00 00 00       	mov    $0x5,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <write>:
SYSCALL(write)
 302:	b8 10 00 00 00       	mov    $0x10,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <close>:
SYSCALL(close)
 30a:	b8 15 00 00 00       	mov    $0x15,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <kill>:
SYSCALL(kill)
 312:	b8 06 00 00 00       	mov    $0x6,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <exec>:
SYSCALL(exec)
 31a:	b8 07 00 00 00       	mov    $0x7,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <open>:
SYSCALL(open)
 322:	b8 0f 00 00 00       	mov    $0xf,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <mknod>:
SYSCALL(mknod)
 32a:	b8 11 00 00 00       	mov    $0x11,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <unlink>:
SYSCALL(unlink)
 332:	b8 12 00 00 00       	mov    $0x12,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <fstat>:
SYSCALL(fstat)
 33a:	b8 08 00 00 00       	mov    $0x8,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <link>:
SYSCALL(link)
 342:	b8 13 00 00 00       	mov    $0x13,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <mkdir>:
SYSCALL(mkdir)
 34a:	b8 14 00 00 00       	mov    $0x14,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <chdir>:
SYSCALL(chdir)
 352:	b8 09 00 00 00       	mov    $0x9,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <dup>:
SYSCALL(dup)
 35a:	b8 0a 00 00 00       	mov    $0xa,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <getpid>:
SYSCALL(getpid)
 362:	b8 0b 00 00 00       	mov    $0xb,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <sbrk>:
SYSCALL(sbrk)
 36a:	b8 0c 00 00 00       	mov    $0xc,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <sleep>:
SYSCALL(sleep)
 372:	b8 0d 00 00 00       	mov    $0xd,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <uptime>:
SYSCALL(uptime)
 37a:	b8 0e 00 00 00       	mov    $0xe,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <dup2>:
SYSCALL(dup2)
 382:	b8 16 00 00 00       	mov    $0x16,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <getcwd>:
SYSCALL(getcwd)
 38a:	b8 17 00 00 00       	mov    $0x17,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <shm_jared>:
SYSCALL(shm_jared)
 392:	b8 18 00 00 00       	mov    $0x18,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    
 39a:	66 90                	xchg   %ax,%ax
 39c:	66 90                	xchg   %ax,%ax
 39e:	66 90                	xchg   %ax,%ax

000003a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	56                   	push   %esi
 3a5:	53                   	push   %ebx
 3a6:	89 c6                	mov    %eax,%esi
 3a8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
 3ae:	85 db                	test   %ebx,%ebx
 3b0:	74 7e                	je     430 <printint+0x90>
 3b2:	89 d0                	mov    %edx,%eax
 3b4:	c1 e8 1f             	shr    $0x1f,%eax
 3b7:	84 c0                	test   %al,%al
 3b9:	74 75                	je     430 <printint+0x90>
    neg = 1;
    x = -xx;
 3bb:	89 d0                	mov    %edx,%eax
    neg = 1;
 3bd:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 3c4:	f7 d8                	neg    %eax
 3c6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 3c9:	31 ff                	xor    %edi,%edi
 3cb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3ce:	89 ce                	mov    %ecx,%esi
 3d0:	eb 08                	jmp    3da <printint+0x3a>
 3d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 3d8:	89 cf                	mov    %ecx,%edi
 3da:	31 d2                	xor    %edx,%edx
 3dc:	8d 4f 01             	lea    0x1(%edi),%ecx
 3df:	f7 f6                	div    %esi
 3e1:	0f b6 92 20 08 00 00 	movzbl 0x820(%edx),%edx
  }while((x /= base) != 0);
 3e8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 3ea:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 3ed:	75 e9                	jne    3d8 <printint+0x38>
  if(neg)
 3ef:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3f2:	8b 75 c0             	mov    -0x40(%ebp),%esi
 3f5:	85 c0                	test   %eax,%eax
 3f7:	74 08                	je     401 <printint+0x61>
    buf[i++] = '-';
 3f9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 3fe:	8d 4f 02             	lea    0x2(%edi),%ecx

  while(--i >= 0)
 401:	8d 79 ff             	lea    -0x1(%ecx),%edi
 404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 408:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
  write(fd, &c, 1);
 40d:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 410:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 413:	6a 01                	push   $0x1
 415:	53                   	push   %ebx
 416:	56                   	push   %esi
 417:	88 45 d7             	mov    %al,-0x29(%ebp)
 41a:	e8 e3 fe ff ff       	call   302 <write>
  while(--i >= 0)
 41f:	83 c4 10             	add    $0x10,%esp
 422:	83 ff ff             	cmp    $0xffffffff,%edi
 425:	75 e1                	jne    408 <printint+0x68>
    putc(fd, buf[i]);
}
 427:	8d 65 f4             	lea    -0xc(%ebp),%esp
 42a:	5b                   	pop    %ebx
 42b:	5e                   	pop    %esi
 42c:	5f                   	pop    %edi
 42d:	5d                   	pop    %ebp
 42e:	c3                   	ret    
 42f:	90                   	nop
    x = xx;
 430:	89 d0                	mov    %edx,%eax
  neg = 0;
 432:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 439:	eb 8b                	jmp    3c6 <printint+0x26>
 43b:	90                   	nop
 43c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000440 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	56                   	push   %esi
 445:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 446:	8d 45 10             	lea    0x10(%ebp),%eax
{
 449:	83 ec 2c             	sub    $0x2c,%esp
  for(i = 0; fmt[i]; i++){
 44c:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 44f:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 452:	89 45 d0             	mov    %eax,-0x30(%ebp)
 455:	0f b6 1e             	movzbl (%esi),%ebx
 458:	83 c6 01             	add    $0x1,%esi
 45b:	84 db                	test   %bl,%bl
 45d:	0f 84 b0 00 00 00    	je     513 <printf+0xd3>
 463:	31 d2                	xor    %edx,%edx
 465:	eb 39                	jmp    4a0 <printf+0x60>
 467:	89 f6                	mov    %esi,%esi
 469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 470:	83 f8 25             	cmp    $0x25,%eax
 473:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 476:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 47b:	74 18                	je     495 <printf+0x55>
  write(fd, &c, 1);
 47d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 480:	83 ec 04             	sub    $0x4,%esp
 483:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 486:	6a 01                	push   $0x1
 488:	50                   	push   %eax
 489:	57                   	push   %edi
 48a:	e8 73 fe ff ff       	call   302 <write>
 48f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 492:	83 c4 10             	add    $0x10,%esp
 495:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 498:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 49c:	84 db                	test   %bl,%bl
 49e:	74 73                	je     513 <printf+0xd3>
    if(state == 0){
 4a0:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 4a2:	0f be cb             	movsbl %bl,%ecx
 4a5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 4a8:	74 c6                	je     470 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4aa:	83 fa 25             	cmp    $0x25,%edx
 4ad:	75 e6                	jne    495 <printf+0x55>
      if(c == 'd'){
 4af:	83 f8 64             	cmp    $0x64,%eax
 4b2:	0f 84 f8 00 00 00    	je     5b0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4b8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 4be:	83 f9 70             	cmp    $0x70,%ecx
 4c1:	74 5d                	je     520 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4c3:	83 f8 73             	cmp    $0x73,%eax
 4c6:	0f 84 84 00 00 00    	je     550 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4cc:	83 f8 63             	cmp    $0x63,%eax
 4cf:	0f 84 ea 00 00 00    	je     5bf <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4d5:	83 f8 25             	cmp    $0x25,%eax
 4d8:	0f 84 c2 00 00 00    	je     5a0 <printf+0x160>
  write(fd, &c, 1);
 4de:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4e1:	83 ec 04             	sub    $0x4,%esp
 4e4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4e8:	6a 01                	push   $0x1
 4ea:	50                   	push   %eax
 4eb:	57                   	push   %edi
 4ec:	e8 11 fe ff ff       	call   302 <write>
 4f1:	83 c4 0c             	add    $0xc,%esp
 4f4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4f7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 4fa:	6a 01                	push   $0x1
 4fc:	50                   	push   %eax
 4fd:	57                   	push   %edi
 4fe:	83 c6 01             	add    $0x1,%esi
 501:	e8 fc fd ff ff       	call   302 <write>
  for(i = 0; fmt[i]; i++){
 506:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 50a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 50d:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 50f:	84 db                	test   %bl,%bl
 511:	75 8d                	jne    4a0 <printf+0x60>
    }
  }
}
 513:	8d 65 f4             	lea    -0xc(%ebp),%esp
 516:	5b                   	pop    %ebx
 517:	5e                   	pop    %esi
 518:	5f                   	pop    %edi
 519:	5d                   	pop    %ebp
 51a:	c3                   	ret    
 51b:	90                   	nop
 51c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 16, 0);
 520:	83 ec 0c             	sub    $0xc,%esp
 523:	b9 10 00 00 00       	mov    $0x10,%ecx
 528:	6a 00                	push   $0x0
 52a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 52d:	89 f8                	mov    %edi,%eax
 52f:	8b 13                	mov    (%ebx),%edx
 531:	e8 6a fe ff ff       	call   3a0 <printint>
        ap++;
 536:	89 d8                	mov    %ebx,%eax
 538:	83 c4 10             	add    $0x10,%esp
      state = 0;
 53b:	31 d2                	xor    %edx,%edx
        ap++;
 53d:	83 c0 04             	add    $0x4,%eax
 540:	89 45 d0             	mov    %eax,-0x30(%ebp)
 543:	e9 4d ff ff ff       	jmp    495 <printf+0x55>
 548:	90                   	nop
 549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 550:	8b 45 d0             	mov    -0x30(%ebp),%eax
 553:	8b 18                	mov    (%eax),%ebx
        ap++;
 555:	83 c0 04             	add    $0x4,%eax
 558:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 55b:	85 db                	test   %ebx,%ebx
 55d:	74 7c                	je     5db <printf+0x19b>
        while(*s != 0){
 55f:	0f b6 03             	movzbl (%ebx),%eax
 562:	84 c0                	test   %al,%al
 564:	74 29                	je     58f <printf+0x14f>
 566:	8d 76 00             	lea    0x0(%esi),%esi
 569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 570:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 573:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 576:	83 ec 04             	sub    $0x4,%esp
 579:	6a 01                	push   $0x1
          s++;
 57b:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 57e:	50                   	push   %eax
 57f:	57                   	push   %edi
 580:	e8 7d fd ff ff       	call   302 <write>
        while(*s != 0){
 585:	0f b6 03             	movzbl (%ebx),%eax
 588:	83 c4 10             	add    $0x10,%esp
 58b:	84 c0                	test   %al,%al
 58d:	75 e1                	jne    570 <printf+0x130>
      state = 0;
 58f:	31 d2                	xor    %edx,%edx
 591:	e9 ff fe ff ff       	jmp    495 <printf+0x55>
 596:	8d 76 00             	lea    0x0(%esi),%esi
 599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  write(fd, &c, 1);
 5a0:	83 ec 04             	sub    $0x4,%esp
 5a3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 5a6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5a9:	6a 01                	push   $0x1
 5ab:	e9 4c ff ff ff       	jmp    4fc <printf+0xbc>
        printint(fd, *ap, 10, 1);
 5b0:	83 ec 0c             	sub    $0xc,%esp
 5b3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5b8:	6a 01                	push   $0x1
 5ba:	e9 6b ff ff ff       	jmp    52a <printf+0xea>
        putc(fd, *ap);
 5bf:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 5c2:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 5c5:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 5c7:	6a 01                	push   $0x1
        putc(fd, *ap);
 5c9:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 5cc:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5cf:	50                   	push   %eax
 5d0:	57                   	push   %edi
 5d1:	e8 2c fd ff ff       	call   302 <write>
 5d6:	e9 5b ff ff ff       	jmp    536 <printf+0xf6>
        while(*s != 0){
 5db:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 5e0:	bb 16 08 00 00       	mov    $0x816,%ebx
 5e5:	eb 89                	jmp    570 <printf+0x130>
 5e7:	66 90                	xchg   %ax,%ax
 5e9:	66 90                	xchg   %ax,%ax
 5eb:	66 90                	xchg   %ax,%ax
 5ed:	66 90                	xchg   %ax,%ax
 5ef:	90                   	nop

000005f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f1:	a1 10 0b 00 00       	mov    0xb10,%eax
{
 5f6:	89 e5                	mov    %esp,%ebp
 5f8:	57                   	push   %edi
 5f9:	56                   	push   %esi
 5fa:	53                   	push   %ebx
 5fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5fe:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 600:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 603:	39 c8                	cmp    %ecx,%eax
 605:	73 19                	jae    620 <free+0x30>
 607:	89 f6                	mov    %esi,%esi
 609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 610:	39 d1                	cmp    %edx,%ecx
 612:	72 1c                	jb     630 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 614:	39 d0                	cmp    %edx,%eax
 616:	73 18                	jae    630 <free+0x40>
{
 618:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 61a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 61c:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 61e:	72 f0                	jb     610 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 620:	39 d0                	cmp    %edx,%eax
 622:	72 f4                	jb     618 <free+0x28>
 624:	39 d1                	cmp    %edx,%ecx
 626:	73 f0                	jae    618 <free+0x28>
 628:	90                   	nop
 629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 630:	8b 73 fc             	mov    -0x4(%ebx),%esi
 633:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 636:	39 fa                	cmp    %edi,%edx
 638:	74 19                	je     653 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 63a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 63d:	8b 50 04             	mov    0x4(%eax),%edx
 640:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 643:	39 f1                	cmp    %esi,%ecx
 645:	74 23                	je     66a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 647:	89 08                	mov    %ecx,(%eax)
  freep = p;
 649:	a3 10 0b 00 00       	mov    %eax,0xb10
}
 64e:	5b                   	pop    %ebx
 64f:	5e                   	pop    %esi
 650:	5f                   	pop    %edi
 651:	5d                   	pop    %ebp
 652:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 653:	03 72 04             	add    0x4(%edx),%esi
 656:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 659:	8b 10                	mov    (%eax),%edx
 65b:	8b 12                	mov    (%edx),%edx
 65d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 660:	8b 50 04             	mov    0x4(%eax),%edx
 663:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 666:	39 f1                	cmp    %esi,%ecx
 668:	75 dd                	jne    647 <free+0x57>
    p->s.size += bp->s.size;
 66a:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 66d:	a3 10 0b 00 00       	mov    %eax,0xb10
    p->s.size += bp->s.size;
 672:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 675:	8b 53 f8             	mov    -0x8(%ebx),%edx
 678:	89 10                	mov    %edx,(%eax)
}
 67a:	5b                   	pop    %ebx
 67b:	5e                   	pop    %esi
 67c:	5f                   	pop    %edi
 67d:	5d                   	pop    %ebp
 67e:	c3                   	ret    
 67f:	90                   	nop

00000680 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	57                   	push   %edi
 684:	56                   	push   %esi
 685:	53                   	push   %ebx
 686:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 689:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 68c:	8b 15 10 0b 00 00    	mov    0xb10,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 692:	8d 78 07             	lea    0x7(%eax),%edi
 695:	c1 ef 03             	shr    $0x3,%edi
 698:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 69b:	85 d2                	test   %edx,%edx
 69d:	0f 84 93 00 00 00    	je     736 <malloc+0xb6>
 6a3:	8b 02                	mov    (%edx),%eax
 6a5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6a8:	39 cf                	cmp    %ecx,%edi
 6aa:	76 64                	jbe    710 <malloc+0x90>
 6ac:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 6b2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6b7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 6ba:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6c1:	eb 0e                	jmp    6d1 <malloc+0x51>
 6c3:	90                   	nop
 6c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6c8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6ca:	8b 48 04             	mov    0x4(%eax),%ecx
 6cd:	39 cf                	cmp    %ecx,%edi
 6cf:	76 3f                	jbe    710 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6d1:	39 05 10 0b 00 00    	cmp    %eax,0xb10
 6d7:	89 c2                	mov    %eax,%edx
 6d9:	75 ed                	jne    6c8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 6db:	83 ec 0c             	sub    $0xc,%esp
 6de:	56                   	push   %esi
 6df:	e8 86 fc ff ff       	call   36a <sbrk>
  if(p == (char*)-1)
 6e4:	83 c4 10             	add    $0x10,%esp
 6e7:	83 f8 ff             	cmp    $0xffffffff,%eax
 6ea:	74 1c                	je     708 <malloc+0x88>
  hp->s.size = nu;
 6ec:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 6ef:	83 ec 0c             	sub    $0xc,%esp
 6f2:	83 c0 08             	add    $0x8,%eax
 6f5:	50                   	push   %eax
 6f6:	e8 f5 fe ff ff       	call   5f0 <free>
  return freep;
 6fb:	8b 15 10 0b 00 00    	mov    0xb10,%edx
      if((p = morecore(nunits)) == 0)
 701:	83 c4 10             	add    $0x10,%esp
 704:	85 d2                	test   %edx,%edx
 706:	75 c0                	jne    6c8 <malloc+0x48>
        return 0;
 708:	31 c0                	xor    %eax,%eax
 70a:	eb 1c                	jmp    728 <malloc+0xa8>
 70c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 710:	39 cf                	cmp    %ecx,%edi
 712:	74 1c                	je     730 <malloc+0xb0>
        p->s.size -= nunits;
 714:	29 f9                	sub    %edi,%ecx
 716:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 719:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 71c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 71f:	89 15 10 0b 00 00    	mov    %edx,0xb10
      return (void*)(p + 1);
 725:	83 c0 08             	add    $0x8,%eax
  }
}
 728:	8d 65 f4             	lea    -0xc(%ebp),%esp
 72b:	5b                   	pop    %ebx
 72c:	5e                   	pop    %esi
 72d:	5f                   	pop    %edi
 72e:	5d                   	pop    %ebp
 72f:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 730:	8b 08                	mov    (%eax),%ecx
 732:	89 0a                	mov    %ecx,(%edx)
 734:	eb e9                	jmp    71f <malloc+0x9f>
    base.s.ptr = freep = prevp = &base;
 736:	c7 05 10 0b 00 00 14 	movl   $0xb14,0xb10
 73d:	0b 00 00 
 740:	c7 05 14 0b 00 00 14 	movl   $0xb14,0xb14
 747:	0b 00 00 
    base.s.size = 0;
 74a:	b8 14 0b 00 00       	mov    $0xb14,%eax
 74f:	c7 05 18 0b 00 00 00 	movl   $0x0,0xb18
 756:	00 00 00 
 759:	e9 4e ff ff ff       	jmp    6ac <malloc+0x2c>
 75e:	66 90                	xchg   %ax,%ax

00000760 <calloc>:

void*
calloc(uint nmemb, uint sz)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	56                   	push   %esi
 764:	53                   	push   %ebx
  uint full_sz = 0;
  if (__builtin_mul_overflow(nmemb, sz, &full_sz))
 765:	8b 45 08             	mov    0x8(%ebp),%eax
 768:	f7 65 0c             	mull   0xc(%ebp)
 76b:	70 25                	jo     792 <calloc+0x32>
    return NULL;
  void *region = malloc(full_sz);
 76d:	83 ec 0c             	sub    $0xc,%esp
 770:	89 c3                	mov    %eax,%ebx
 772:	50                   	push   %eax
 773:	e8 08 ff ff ff       	call   680 <malloc>
  memset(region, 0, full_sz);
 778:	83 c4 0c             	add    $0xc,%esp
  void *region = malloc(full_sz);
 77b:	89 c6                	mov    %eax,%esi
  memset(region, 0, full_sz);
 77d:	53                   	push   %ebx
 77e:	6a 00                	push   $0x0
 780:	50                   	push   %eax
 781:	e8 ca f9 ff ff       	call   150 <memset>
  return region;
 786:	83 c4 10             	add    $0x10,%esp
}
 789:	8d 65 f8             	lea    -0x8(%ebp),%esp
 78c:	89 f0                	mov    %esi,%eax
 78e:	5b                   	pop    %ebx
 78f:	5e                   	pop    %esi
 790:	5d                   	pop    %ebp
 791:	c3                   	ret    
    return NULL;
 792:	31 f6                	xor    %esi,%esi
 794:	eb f3                	jmp    789 <calloc+0x29>
 796:	8d 76 00             	lea    0x0(%esi),%esi
 799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000007a0 <strdup>:

char*
strdup(char *s)
{
 7a0:	55                   	push   %ebp
 7a1:	89 e5                	mov    %esp,%ebp
 7a3:	56                   	push   %esi
 7a4:	53                   	push   %ebx
 7a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *buf = malloc(strlen(s) + 1);
 7a8:	83 ec 0c             	sub    $0xc,%esp
 7ab:	53                   	push   %ebx
 7ac:	e8 6f f9 ff ff       	call   120 <strlen>
 7b1:	83 c0 01             	add    $0x1,%eax
 7b4:	89 04 24             	mov    %eax,(%esp)
 7b7:	e8 c4 fe ff ff       	call   680 <malloc>
 7bc:	89 c6                	mov    %eax,%esi
  strcpy(buf, s);
 7be:	58                   	pop    %eax
 7bf:	5a                   	pop    %edx
 7c0:	53                   	push   %ebx
 7c1:	56                   	push   %esi
 7c2:	e8 d9 f8 ff ff       	call   a0 <strcpy>
  return buf;
}
 7c7:	8d 65 f8             	lea    -0x8(%ebp),%esp
 7ca:	89 f0                	mov    %esi,%eax
 7cc:	5b                   	pop    %ebx
 7cd:	5e                   	pop    %esi
 7ce:	5d                   	pop    %ebp
 7cf:	c3                   	ret    
