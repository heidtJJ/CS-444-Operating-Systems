
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

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
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   f:	83 ec 08             	sub    $0x8,%esp
  12:	6a 02                	push   $0x2
  14:	68 30 08 00 00       	push   $0x830
  19:	e8 54 03 00 00       	call   372 <open>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	85 c0                	test   %eax,%eax
  23:	0f 88 9f 00 00 00    	js     c8 <main+0xc8>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  29:	83 ec 0c             	sub    $0xc,%esp
  2c:	6a 00                	push   $0x0
  2e:	e8 77 03 00 00       	call   3aa <dup>
  dup(0);  // stderr
  33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3a:	e8 6b 03 00 00       	call   3aa <dup>
  3f:	83 c4 10             	add    $0x10,%esp
  42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(;;){
    printf(1, "init: starting sh\n");
  48:	83 ec 08             	sub    $0x8,%esp
  4b:	68 38 08 00 00       	push   $0x838
  50:	6a 01                	push   $0x1
  52:	e8 49 04 00 00       	call   4a0 <printf>
    pid = fork();
  57:	e8 ce 02 00 00       	call   32a <fork>
    if(pid < 0){
  5c:	83 c4 10             	add    $0x10,%esp
  5f:	85 c0                	test   %eax,%eax
    pid = fork();
  61:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  63:	78 2c                	js     91 <main+0x91>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
  65:	74 3d                	je     a4 <main+0xa4>
  67:	89 f6                	mov    %esi,%esi
  69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  70:	e8 c5 02 00 00       	call   33a <wait>
  75:	85 c0                	test   %eax,%eax
  77:	78 cf                	js     48 <main+0x48>
  79:	39 c3                	cmp    %eax,%ebx
  7b:	74 cb                	je     48 <main+0x48>
      printf(1, "zombie!\n");
  7d:	83 ec 08             	sub    $0x8,%esp
  80:	68 77 08 00 00       	push   $0x877
  85:	6a 01                	push   $0x1
  87:	e8 14 04 00 00       	call   4a0 <printf>
  8c:	83 c4 10             	add    $0x10,%esp
  8f:	eb df                	jmp    70 <main+0x70>
      printf(1, "init: fork failed\n");
  91:	53                   	push   %ebx
  92:	53                   	push   %ebx
  93:	68 4b 08 00 00       	push   $0x84b
  98:	6a 01                	push   $0x1
  9a:	e8 01 04 00 00       	call   4a0 <printf>
      exit();
  9f:	e8 8e 02 00 00       	call   332 <exit>
      exec("sh", argv);
  a4:	50                   	push   %eax
  a5:	50                   	push   %eax
  a6:	68 78 0b 00 00       	push   $0xb78
  ab:	68 5e 08 00 00       	push   $0x85e
  b0:	e8 b5 02 00 00       	call   36a <exec>
      printf(1, "init: exec sh failed\n");
  b5:	5a                   	pop    %edx
  b6:	59                   	pop    %ecx
  b7:	68 61 08 00 00       	push   $0x861
  bc:	6a 01                	push   $0x1
  be:	e8 dd 03 00 00       	call   4a0 <printf>
      exit();
  c3:	e8 6a 02 00 00       	call   332 <exit>
    mknod("console", 1, 1);
  c8:	50                   	push   %eax
  c9:	6a 01                	push   $0x1
  cb:	6a 01                	push   $0x1
  cd:	68 30 08 00 00       	push   $0x830
  d2:	e8 a3 02 00 00       	call   37a <mknod>
    open("console", O_RDWR);
  d7:	58                   	pop    %eax
  d8:	5a                   	pop    %edx
  d9:	6a 02                	push   $0x2
  db:	68 30 08 00 00       	push   $0x830
  e0:	e8 8d 02 00 00       	call   372 <open>
  e5:	83 c4 10             	add    $0x10,%esp
  e8:	e9 3c ff ff ff       	jmp    29 <main+0x29>
  ed:	66 90                	xchg   %ax,%ax
  ef:	90                   	nop

000000f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	53                   	push   %ebx
  f4:	8b 45 08             	mov    0x8(%ebp),%eax
  f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  fa:	89 c2                	mov    %eax,%edx
  fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 100:	83 c1 01             	add    $0x1,%ecx
 103:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 107:	83 c2 01             	add    $0x1,%edx
 10a:	84 db                	test   %bl,%bl
 10c:	88 5a ff             	mov    %bl,-0x1(%edx)
 10f:	75 ef                	jne    100 <strcpy+0x10>
    ;
  return os;
}
 111:	5b                   	pop    %ebx
 112:	5d                   	pop    %ebp
 113:	c3                   	ret    
 114:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 11a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000120 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	56                   	push   %esi
 124:	53                   	push   %ebx
 125:	8b 55 08             	mov    0x8(%ebp),%edx
 128:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 12b:	0f b6 02             	movzbl (%edx),%eax
 12e:	0f b6 19             	movzbl (%ecx),%ebx
 131:	84 c0                	test   %al,%al
 133:	75 1e                	jne    153 <strcmp+0x33>
 135:	eb 29                	jmp    160 <strcmp+0x40>
 137:	89 f6                	mov    %esi,%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 140:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 143:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 146:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
 149:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 14d:	84 c0                	test   %al,%al
 14f:	74 0f                	je     160 <strcmp+0x40>
 151:	89 f1                	mov    %esi,%ecx
 153:	38 d8                	cmp    %bl,%al
 155:	74 e9                	je     140 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 157:	29 d8                	sub    %ebx,%eax
}
 159:	5b                   	pop    %ebx
 15a:	5e                   	pop    %esi
 15b:	5d                   	pop    %ebp
 15c:	c3                   	ret    
 15d:	8d 76 00             	lea    0x0(%esi),%esi
  while(*p && *p == *q)
 160:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 162:	29 d8                	sub    %ebx,%eax
}
 164:	5b                   	pop    %ebx
 165:	5e                   	pop    %esi
 166:	5d                   	pop    %ebp
 167:	c3                   	ret    
 168:	90                   	nop
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000170 <strlen>:

uint
strlen(char *s)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 176:	80 39 00             	cmpb   $0x0,(%ecx)
 179:	74 12                	je     18d <strlen+0x1d>
 17b:	31 d2                	xor    %edx,%edx
 17d:	8d 76 00             	lea    0x0(%esi),%esi
 180:	83 c2 01             	add    $0x1,%edx
 183:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 187:	89 d0                	mov    %edx,%eax
 189:	75 f5                	jne    180 <strlen+0x10>
    ;
  return n;
}
 18b:	5d                   	pop    %ebp
 18c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 18d:	31 c0                	xor    %eax,%eax
}
 18f:	5d                   	pop    %ebp
 190:	c3                   	ret    
 191:	eb 0d                	jmp    1a0 <memset>
 193:	90                   	nop
 194:	90                   	nop
 195:	90                   	nop
 196:	90                   	nop
 197:	90                   	nop
 198:	90                   	nop
 199:	90                   	nop
 19a:	90                   	nop
 19b:	90                   	nop
 19c:	90                   	nop
 19d:	90                   	nop
 19e:	90                   	nop
 19f:	90                   	nop

000001a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	57                   	push   %edi
 1a4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ad:	89 d7                	mov    %edx,%edi
 1af:	fc                   	cld    
 1b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1b2:	89 d0                	mov    %edx,%eax
 1b4:	5f                   	pop    %edi
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret    
 1b7:	89 f6                	mov    %esi,%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001c0 <strchr>:

char*
strchr(const char *s, char c)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	53                   	push   %ebx
 1c4:	8b 45 08             	mov    0x8(%ebp),%eax
 1c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 1ca:	0f b6 10             	movzbl (%eax),%edx
 1cd:	84 d2                	test   %dl,%dl
 1cf:	74 1d                	je     1ee <strchr+0x2e>
    if(*s == c)
 1d1:	38 d3                	cmp    %dl,%bl
 1d3:	89 d9                	mov    %ebx,%ecx
 1d5:	75 0d                	jne    1e4 <strchr+0x24>
 1d7:	eb 17                	jmp    1f0 <strchr+0x30>
 1d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1e0:	38 ca                	cmp    %cl,%dl
 1e2:	74 0c                	je     1f0 <strchr+0x30>
  for(; *s; s++)
 1e4:	83 c0 01             	add    $0x1,%eax
 1e7:	0f b6 10             	movzbl (%eax),%edx
 1ea:	84 d2                	test   %dl,%dl
 1ec:	75 f2                	jne    1e0 <strchr+0x20>
      return (char*)s;
  return 0;
 1ee:	31 c0                	xor    %eax,%eax
}
 1f0:	5b                   	pop    %ebx
 1f1:	5d                   	pop    %ebp
 1f2:	c3                   	ret    
 1f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <gets>:

char*
gets(char *buf, int max)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	57                   	push   %edi
 204:	56                   	push   %esi
 205:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 206:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 208:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 20b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 20e:	eb 29                	jmp    239 <gets+0x39>
    cc = read(0, &c, 1);
 210:	83 ec 04             	sub    $0x4,%esp
 213:	6a 01                	push   $0x1
 215:	57                   	push   %edi
 216:	6a 00                	push   $0x0
 218:	e8 2d 01 00 00       	call   34a <read>
    if(cc < 1)
 21d:	83 c4 10             	add    $0x10,%esp
 220:	85 c0                	test   %eax,%eax
 222:	7e 1d                	jle    241 <gets+0x41>
      break;
    buf[i++] = c;
 224:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 228:	8b 55 08             	mov    0x8(%ebp),%edx
 22b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 22d:	3c 0a                	cmp    $0xa,%al
    buf[i++] = c;
 22f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 233:	74 1b                	je     250 <gets+0x50>
 235:	3c 0d                	cmp    $0xd,%al
 237:	74 17                	je     250 <gets+0x50>
  for(i=0; i+1 < max; ){
 239:	8d 5e 01             	lea    0x1(%esi),%ebx
 23c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 23f:	7c cf                	jl     210 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 241:	8b 45 08             	mov    0x8(%ebp),%eax
 244:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 248:	8d 65 f4             	lea    -0xc(%ebp),%esp
 24b:	5b                   	pop    %ebx
 24c:	5e                   	pop    %esi
 24d:	5f                   	pop    %edi
 24e:	5d                   	pop    %ebp
 24f:	c3                   	ret    
  buf[i] = '\0';
 250:	8b 45 08             	mov    0x8(%ebp),%eax
  for(i=0; i+1 < max; ){
 253:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 255:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 259:	8d 65 f4             	lea    -0xc(%ebp),%esp
 25c:	5b                   	pop    %ebx
 25d:	5e                   	pop    %esi
 25e:	5f                   	pop    %edi
 25f:	5d                   	pop    %ebp
 260:	c3                   	ret    
 261:	eb 0d                	jmp    270 <stat>
 263:	90                   	nop
 264:	90                   	nop
 265:	90                   	nop
 266:	90                   	nop
 267:	90                   	nop
 268:	90                   	nop
 269:	90                   	nop
 26a:	90                   	nop
 26b:	90                   	nop
 26c:	90                   	nop
 26d:	90                   	nop
 26e:	90                   	nop
 26f:	90                   	nop

00000270 <stat>:

int
stat(char *n, struct stat *st)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	56                   	push   %esi
 274:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 275:	83 ec 08             	sub    $0x8,%esp
 278:	6a 00                	push   $0x0
 27a:	ff 75 08             	pushl  0x8(%ebp)
 27d:	e8 f0 00 00 00       	call   372 <open>
  if(fd < 0)
 282:	83 c4 10             	add    $0x10,%esp
 285:	85 c0                	test   %eax,%eax
 287:	78 27                	js     2b0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 289:	83 ec 08             	sub    $0x8,%esp
 28c:	ff 75 0c             	pushl  0xc(%ebp)
 28f:	89 c3                	mov    %eax,%ebx
 291:	50                   	push   %eax
 292:	e8 f3 00 00 00       	call   38a <fstat>
  close(fd);
 297:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 29a:	89 c6                	mov    %eax,%esi
  close(fd);
 29c:	e8 b9 00 00 00       	call   35a <close>
  return r;
 2a1:	83 c4 10             	add    $0x10,%esp
}
 2a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2a7:	89 f0                	mov    %esi,%eax
 2a9:	5b                   	pop    %ebx
 2aa:	5e                   	pop    %esi
 2ab:	5d                   	pop    %ebp
 2ac:	c3                   	ret    
 2ad:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2b0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2b5:	eb ed                	jmp    2a4 <stat+0x34>
 2b7:	89 f6                	mov    %esi,%esi
 2b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002c0 <atoi>:

int
atoi(const char *s)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	53                   	push   %ebx
 2c4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2c7:	0f be 11             	movsbl (%ecx),%edx
 2ca:	8d 42 d0             	lea    -0x30(%edx),%eax
 2cd:	3c 09                	cmp    $0x9,%al
 2cf:	b8 00 00 00 00       	mov    $0x0,%eax
 2d4:	77 1f                	ja     2f5 <atoi+0x35>
 2d6:	8d 76 00             	lea    0x0(%esi),%esi
 2d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 2e0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 2e3:	83 c1 01             	add    $0x1,%ecx
 2e6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 2ea:	0f be 11             	movsbl (%ecx),%edx
 2ed:	8d 5a d0             	lea    -0x30(%edx),%ebx
 2f0:	80 fb 09             	cmp    $0x9,%bl
 2f3:	76 eb                	jbe    2e0 <atoi+0x20>
  return n;
}
 2f5:	5b                   	pop    %ebx
 2f6:	5d                   	pop    %ebp
 2f7:	c3                   	ret    
 2f8:	90                   	nop
 2f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000300 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	56                   	push   %esi
 304:	53                   	push   %ebx
 305:	8b 5d 10             	mov    0x10(%ebp),%ebx
 308:	8b 45 08             	mov    0x8(%ebp),%eax
 30b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 30e:	85 db                	test   %ebx,%ebx
 310:	7e 14                	jle    326 <memmove+0x26>
 312:	31 d2                	xor    %edx,%edx
 314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 318:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 31c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 31f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 322:	39 da                	cmp    %ebx,%edx
 324:	75 f2                	jne    318 <memmove+0x18>
  return vdst;
}
 326:	5b                   	pop    %ebx
 327:	5e                   	pop    %esi
 328:	5d                   	pop    %ebp
 329:	c3                   	ret    

0000032a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 32a:	b8 01 00 00 00       	mov    $0x1,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <exit>:
SYSCALL(exit)
 332:	b8 02 00 00 00       	mov    $0x2,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <wait>:
SYSCALL(wait)
 33a:	b8 03 00 00 00       	mov    $0x3,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <pipe>:
SYSCALL(pipe)
 342:	b8 04 00 00 00       	mov    $0x4,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <read>:
SYSCALL(read)
 34a:	b8 05 00 00 00       	mov    $0x5,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <write>:
SYSCALL(write)
 352:	b8 10 00 00 00       	mov    $0x10,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <close>:
SYSCALL(close)
 35a:	b8 15 00 00 00       	mov    $0x15,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <kill>:
SYSCALL(kill)
 362:	b8 06 00 00 00       	mov    $0x6,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <exec>:
SYSCALL(exec)
 36a:	b8 07 00 00 00       	mov    $0x7,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <open>:
SYSCALL(open)
 372:	b8 0f 00 00 00       	mov    $0xf,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <mknod>:
SYSCALL(mknod)
 37a:	b8 11 00 00 00       	mov    $0x11,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <unlink>:
SYSCALL(unlink)
 382:	b8 12 00 00 00       	mov    $0x12,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <fstat>:
SYSCALL(fstat)
 38a:	b8 08 00 00 00       	mov    $0x8,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <link>:
SYSCALL(link)
 392:	b8 13 00 00 00       	mov    $0x13,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <mkdir>:
SYSCALL(mkdir)
 39a:	b8 14 00 00 00       	mov    $0x14,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <chdir>:
SYSCALL(chdir)
 3a2:	b8 09 00 00 00       	mov    $0x9,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <dup>:
SYSCALL(dup)
 3aa:	b8 0a 00 00 00       	mov    $0xa,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <getpid>:
SYSCALL(getpid)
 3b2:	b8 0b 00 00 00       	mov    $0xb,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <sbrk>:
SYSCALL(sbrk)
 3ba:	b8 0c 00 00 00       	mov    $0xc,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <sleep>:
SYSCALL(sleep)
 3c2:	b8 0d 00 00 00       	mov    $0xd,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <uptime>:
SYSCALL(uptime)
 3ca:	b8 0e 00 00 00       	mov    $0xe,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <dup2>:
SYSCALL(dup2)
 3d2:	b8 16 00 00 00       	mov    $0x16,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <getcwd>:
SYSCALL(getcwd)
 3da:	b8 17 00 00 00       	mov    $0x17,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <getmz>:
SYSCALL(getmz)
 3e2:	b8 18 00 00 00       	mov    $0x18,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <jared>:
SYSCALL(jared)
 3ea:	b8 19 00 00 00       	mov    $0x19,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    
 3f2:	66 90                	xchg   %ax,%ax
 3f4:	66 90                	xchg   %ax,%ax
 3f6:	66 90                	xchg   %ax,%ax
 3f8:	66 90                	xchg   %ax,%ax
 3fa:	66 90                	xchg   %ax,%ax
 3fc:	66 90                	xchg   %ax,%ax
 3fe:	66 90                	xchg   %ax,%ax

00000400 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	56                   	push   %esi
 405:	53                   	push   %ebx
 406:	89 c6                	mov    %eax,%esi
 408:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 40b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 40e:	85 db                	test   %ebx,%ebx
 410:	74 7e                	je     490 <printint+0x90>
 412:	89 d0                	mov    %edx,%eax
 414:	c1 e8 1f             	shr    $0x1f,%eax
 417:	84 c0                	test   %al,%al
 419:	74 75                	je     490 <printint+0x90>
    neg = 1;
    x = -xx;
 41b:	89 d0                	mov    %edx,%eax
    neg = 1;
 41d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 424:	f7 d8                	neg    %eax
 426:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 429:	31 ff                	xor    %edi,%edi
 42b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 42e:	89 ce                	mov    %ecx,%esi
 430:	eb 08                	jmp    43a <printint+0x3a>
 432:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 438:	89 cf                	mov    %ecx,%edi
 43a:	31 d2                	xor    %edx,%edx
 43c:	8d 4f 01             	lea    0x1(%edi),%ecx
 43f:	f7 f6                	div    %esi
 441:	0f b6 92 88 08 00 00 	movzbl 0x888(%edx),%edx
  }while((x /= base) != 0);
 448:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 44a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 44d:	75 e9                	jne    438 <printint+0x38>
  if(neg)
 44f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 452:	8b 75 c0             	mov    -0x40(%ebp),%esi
 455:	85 c0                	test   %eax,%eax
 457:	74 08                	je     461 <printint+0x61>
    buf[i++] = '-';
 459:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 45e:	8d 4f 02             	lea    0x2(%edi),%ecx

  while(--i >= 0)
 461:	8d 79 ff             	lea    -0x1(%ecx),%edi
 464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 468:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
  write(fd, &c, 1);
 46d:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 470:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 473:	6a 01                	push   $0x1
 475:	53                   	push   %ebx
 476:	56                   	push   %esi
 477:	88 45 d7             	mov    %al,-0x29(%ebp)
 47a:	e8 d3 fe ff ff       	call   352 <write>
  while(--i >= 0)
 47f:	83 c4 10             	add    $0x10,%esp
 482:	83 ff ff             	cmp    $0xffffffff,%edi
 485:	75 e1                	jne    468 <printint+0x68>
    putc(fd, buf[i]);
}
 487:	8d 65 f4             	lea    -0xc(%ebp),%esp
 48a:	5b                   	pop    %ebx
 48b:	5e                   	pop    %esi
 48c:	5f                   	pop    %edi
 48d:	5d                   	pop    %ebp
 48e:	c3                   	ret    
 48f:	90                   	nop
    x = xx;
 490:	89 d0                	mov    %edx,%eax
  neg = 0;
 492:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 499:	eb 8b                	jmp    426 <printint+0x26>
 49b:	90                   	nop
 49c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
 4a5:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4a6:	8d 45 10             	lea    0x10(%ebp),%eax
{
 4a9:	83 ec 2c             	sub    $0x2c,%esp
  for(i = 0; fmt[i]; i++){
 4ac:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 4af:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 4b2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4b5:	0f b6 1e             	movzbl (%esi),%ebx
 4b8:	83 c6 01             	add    $0x1,%esi
 4bb:	84 db                	test   %bl,%bl
 4bd:	0f 84 b0 00 00 00    	je     573 <printf+0xd3>
 4c3:	31 d2                	xor    %edx,%edx
 4c5:	eb 39                	jmp    500 <printf+0x60>
 4c7:	89 f6                	mov    %esi,%esi
 4c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4d0:	83 f8 25             	cmp    $0x25,%eax
 4d3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 4d6:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 4db:	74 18                	je     4f5 <printf+0x55>
  write(fd, &c, 1);
 4dd:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 4e0:	83 ec 04             	sub    $0x4,%esp
 4e3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 4e6:	6a 01                	push   $0x1
 4e8:	50                   	push   %eax
 4e9:	57                   	push   %edi
 4ea:	e8 63 fe ff ff       	call   352 <write>
 4ef:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 4f2:	83 c4 10             	add    $0x10,%esp
 4f5:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 4f8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 4fc:	84 db                	test   %bl,%bl
 4fe:	74 73                	je     573 <printf+0xd3>
    if(state == 0){
 500:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 502:	0f be cb             	movsbl %bl,%ecx
 505:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 508:	74 c6                	je     4d0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 50a:	83 fa 25             	cmp    $0x25,%edx
 50d:	75 e6                	jne    4f5 <printf+0x55>
      if(c == 'd'){
 50f:	83 f8 64             	cmp    $0x64,%eax
 512:	0f 84 f8 00 00 00    	je     610 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 518:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 51e:	83 f9 70             	cmp    $0x70,%ecx
 521:	74 5d                	je     580 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 523:	83 f8 73             	cmp    $0x73,%eax
 526:	0f 84 84 00 00 00    	je     5b0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 52c:	83 f8 63             	cmp    $0x63,%eax
 52f:	0f 84 ea 00 00 00    	je     61f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 535:	83 f8 25             	cmp    $0x25,%eax
 538:	0f 84 c2 00 00 00    	je     600 <printf+0x160>
  write(fd, &c, 1);
 53e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 541:	83 ec 04             	sub    $0x4,%esp
 544:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 548:	6a 01                	push   $0x1
 54a:	50                   	push   %eax
 54b:	57                   	push   %edi
 54c:	e8 01 fe ff ff       	call   352 <write>
 551:	83 c4 0c             	add    $0xc,%esp
 554:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 557:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 55a:	6a 01                	push   $0x1
 55c:	50                   	push   %eax
 55d:	57                   	push   %edi
 55e:	83 c6 01             	add    $0x1,%esi
 561:	e8 ec fd ff ff       	call   352 <write>
  for(i = 0; fmt[i]; i++){
 566:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 56a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 56d:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 56f:	84 db                	test   %bl,%bl
 571:	75 8d                	jne    500 <printf+0x60>
    }
  }
}
 573:	8d 65 f4             	lea    -0xc(%ebp),%esp
 576:	5b                   	pop    %ebx
 577:	5e                   	pop    %esi
 578:	5f                   	pop    %edi
 579:	5d                   	pop    %ebp
 57a:	c3                   	ret    
 57b:	90                   	nop
 57c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 16, 0);
 580:	83 ec 0c             	sub    $0xc,%esp
 583:	b9 10 00 00 00       	mov    $0x10,%ecx
 588:	6a 00                	push   $0x0
 58a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 58d:	89 f8                	mov    %edi,%eax
 58f:	8b 13                	mov    (%ebx),%edx
 591:	e8 6a fe ff ff       	call   400 <printint>
        ap++;
 596:	89 d8                	mov    %ebx,%eax
 598:	83 c4 10             	add    $0x10,%esp
      state = 0;
 59b:	31 d2                	xor    %edx,%edx
        ap++;
 59d:	83 c0 04             	add    $0x4,%eax
 5a0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5a3:	e9 4d ff ff ff       	jmp    4f5 <printf+0x55>
 5a8:	90                   	nop
 5a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 5b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5b3:	8b 18                	mov    (%eax),%ebx
        ap++;
 5b5:	83 c0 04             	add    $0x4,%eax
 5b8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 5bb:	85 db                	test   %ebx,%ebx
 5bd:	74 7c                	je     63b <printf+0x19b>
        while(*s != 0){
 5bf:	0f b6 03             	movzbl (%ebx),%eax
 5c2:	84 c0                	test   %al,%al
 5c4:	74 29                	je     5ef <printf+0x14f>
 5c6:	8d 76 00             	lea    0x0(%esi),%esi
 5c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 5d0:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 5d3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 5d6:	83 ec 04             	sub    $0x4,%esp
 5d9:	6a 01                	push   $0x1
          s++;
 5db:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 5de:	50                   	push   %eax
 5df:	57                   	push   %edi
 5e0:	e8 6d fd ff ff       	call   352 <write>
        while(*s != 0){
 5e5:	0f b6 03             	movzbl (%ebx),%eax
 5e8:	83 c4 10             	add    $0x10,%esp
 5eb:	84 c0                	test   %al,%al
 5ed:	75 e1                	jne    5d0 <printf+0x130>
      state = 0;
 5ef:	31 d2                	xor    %edx,%edx
 5f1:	e9 ff fe ff ff       	jmp    4f5 <printf+0x55>
 5f6:	8d 76 00             	lea    0x0(%esi),%esi
 5f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  write(fd, &c, 1);
 600:	83 ec 04             	sub    $0x4,%esp
 603:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 606:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 609:	6a 01                	push   $0x1
 60b:	e9 4c ff ff ff       	jmp    55c <printf+0xbc>
        printint(fd, *ap, 10, 1);
 610:	83 ec 0c             	sub    $0xc,%esp
 613:	b9 0a 00 00 00       	mov    $0xa,%ecx
 618:	6a 01                	push   $0x1
 61a:	e9 6b ff ff ff       	jmp    58a <printf+0xea>
        putc(fd, *ap);
 61f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 622:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 625:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 627:	6a 01                	push   $0x1
        putc(fd, *ap);
 629:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 62c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 62f:	50                   	push   %eax
 630:	57                   	push   %edi
 631:	e8 1c fd ff ff       	call   352 <write>
 636:	e9 5b ff ff ff       	jmp    596 <printf+0xf6>
        while(*s != 0){
 63b:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 640:	bb 80 08 00 00       	mov    $0x880,%ebx
 645:	eb 89                	jmp    5d0 <printf+0x130>
 647:	66 90                	xchg   %ax,%ax
 649:	66 90                	xchg   %ax,%ax
 64b:	66 90                	xchg   %ax,%ax
 64d:	66 90                	xchg   %ax,%ax
 64f:	90                   	nop

00000650 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 650:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 651:	a1 80 0b 00 00       	mov    0xb80,%eax
{
 656:	89 e5                	mov    %esp,%ebp
 658:	57                   	push   %edi
 659:	56                   	push   %esi
 65a:	53                   	push   %ebx
 65b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 65e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 660:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 663:	39 c8                	cmp    %ecx,%eax
 665:	73 19                	jae    680 <free+0x30>
 667:	89 f6                	mov    %esi,%esi
 669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 670:	39 d1                	cmp    %edx,%ecx
 672:	72 1c                	jb     690 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 674:	39 d0                	cmp    %edx,%eax
 676:	73 18                	jae    690 <free+0x40>
{
 678:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 67a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 67c:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 67e:	72 f0                	jb     670 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 680:	39 d0                	cmp    %edx,%eax
 682:	72 f4                	jb     678 <free+0x28>
 684:	39 d1                	cmp    %edx,%ecx
 686:	73 f0                	jae    678 <free+0x28>
 688:	90                   	nop
 689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 690:	8b 73 fc             	mov    -0x4(%ebx),%esi
 693:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 696:	39 fa                	cmp    %edi,%edx
 698:	74 19                	je     6b3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 69a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 69d:	8b 50 04             	mov    0x4(%eax),%edx
 6a0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6a3:	39 f1                	cmp    %esi,%ecx
 6a5:	74 23                	je     6ca <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6a7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 6a9:	a3 80 0b 00 00       	mov    %eax,0xb80
}
 6ae:	5b                   	pop    %ebx
 6af:	5e                   	pop    %esi
 6b0:	5f                   	pop    %edi
 6b1:	5d                   	pop    %ebp
 6b2:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 6b3:	03 72 04             	add    0x4(%edx),%esi
 6b6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6b9:	8b 10                	mov    (%eax),%edx
 6bb:	8b 12                	mov    (%edx),%edx
 6bd:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6c0:	8b 50 04             	mov    0x4(%eax),%edx
 6c3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6c6:	39 f1                	cmp    %esi,%ecx
 6c8:	75 dd                	jne    6a7 <free+0x57>
    p->s.size += bp->s.size;
 6ca:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 6cd:	a3 80 0b 00 00       	mov    %eax,0xb80
    p->s.size += bp->s.size;
 6d2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6d5:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6d8:	89 10                	mov    %edx,(%eax)
}
 6da:	5b                   	pop    %ebx
 6db:	5e                   	pop    %esi
 6dc:	5f                   	pop    %edi
 6dd:	5d                   	pop    %ebp
 6de:	c3                   	ret    
 6df:	90                   	nop

000006e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	57                   	push   %edi
 6e4:	56                   	push   %esi
 6e5:	53                   	push   %ebx
 6e6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6ec:	8b 15 80 0b 00 00    	mov    0xb80,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f2:	8d 78 07             	lea    0x7(%eax),%edi
 6f5:	c1 ef 03             	shr    $0x3,%edi
 6f8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 6fb:	85 d2                	test   %edx,%edx
 6fd:	0f 84 93 00 00 00    	je     796 <malloc+0xb6>
 703:	8b 02                	mov    (%edx),%eax
 705:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 708:	39 cf                	cmp    %ecx,%edi
 70a:	76 64                	jbe    770 <malloc+0x90>
 70c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 712:	bb 00 10 00 00       	mov    $0x1000,%ebx
 717:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 71a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 721:	eb 0e                	jmp    731 <malloc+0x51>
 723:	90                   	nop
 724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 728:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 72a:	8b 48 04             	mov    0x4(%eax),%ecx
 72d:	39 cf                	cmp    %ecx,%edi
 72f:	76 3f                	jbe    770 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 731:	39 05 80 0b 00 00    	cmp    %eax,0xb80
 737:	89 c2                	mov    %eax,%edx
 739:	75 ed                	jne    728 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 73b:	83 ec 0c             	sub    $0xc,%esp
 73e:	56                   	push   %esi
 73f:	e8 76 fc ff ff       	call   3ba <sbrk>
  if(p == (char*)-1)
 744:	83 c4 10             	add    $0x10,%esp
 747:	83 f8 ff             	cmp    $0xffffffff,%eax
 74a:	74 1c                	je     768 <malloc+0x88>
  hp->s.size = nu;
 74c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 74f:	83 ec 0c             	sub    $0xc,%esp
 752:	83 c0 08             	add    $0x8,%eax
 755:	50                   	push   %eax
 756:	e8 f5 fe ff ff       	call   650 <free>
  return freep;
 75b:	8b 15 80 0b 00 00    	mov    0xb80,%edx
      if((p = morecore(nunits)) == 0)
 761:	83 c4 10             	add    $0x10,%esp
 764:	85 d2                	test   %edx,%edx
 766:	75 c0                	jne    728 <malloc+0x48>
        return 0;
 768:	31 c0                	xor    %eax,%eax
 76a:	eb 1c                	jmp    788 <malloc+0xa8>
 76c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 770:	39 cf                	cmp    %ecx,%edi
 772:	74 1c                	je     790 <malloc+0xb0>
        p->s.size -= nunits;
 774:	29 f9                	sub    %edi,%ecx
 776:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 779:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 77c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 77f:	89 15 80 0b 00 00    	mov    %edx,0xb80
      return (void*)(p + 1);
 785:	83 c0 08             	add    $0x8,%eax
  }
}
 788:	8d 65 f4             	lea    -0xc(%ebp),%esp
 78b:	5b                   	pop    %ebx
 78c:	5e                   	pop    %esi
 78d:	5f                   	pop    %edi
 78e:	5d                   	pop    %ebp
 78f:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 790:	8b 08                	mov    (%eax),%ecx
 792:	89 0a                	mov    %ecx,(%edx)
 794:	eb e9                	jmp    77f <malloc+0x9f>
    base.s.ptr = freep = prevp = &base;
 796:	c7 05 80 0b 00 00 84 	movl   $0xb84,0xb80
 79d:	0b 00 00 
 7a0:	c7 05 84 0b 00 00 84 	movl   $0xb84,0xb84
 7a7:	0b 00 00 
    base.s.size = 0;
 7aa:	b8 84 0b 00 00       	mov    $0xb84,%eax
 7af:	c7 05 88 0b 00 00 00 	movl   $0x0,0xb88
 7b6:	00 00 00 
 7b9:	e9 4e ff ff ff       	jmp    70c <malloc+0x2c>
 7be:	66 90                	xchg   %ax,%ax

000007c0 <calloc>:

void*
calloc(uint nmemb, uint sz)
{
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	56                   	push   %esi
 7c4:	53                   	push   %ebx
  uint full_sz = 0;
  if (__builtin_mul_overflow(nmemb, sz, &full_sz))
 7c5:	8b 45 08             	mov    0x8(%ebp),%eax
 7c8:	f7 65 0c             	mull   0xc(%ebp)
 7cb:	70 25                	jo     7f2 <calloc+0x32>
    return NULL;
  void *region = malloc(full_sz);
 7cd:	83 ec 0c             	sub    $0xc,%esp
 7d0:	89 c3                	mov    %eax,%ebx
 7d2:	50                   	push   %eax
 7d3:	e8 08 ff ff ff       	call   6e0 <malloc>
  memset(region, 0, full_sz);
 7d8:	83 c4 0c             	add    $0xc,%esp
  void *region = malloc(full_sz);
 7db:	89 c6                	mov    %eax,%esi
  memset(region, 0, full_sz);
 7dd:	53                   	push   %ebx
 7de:	6a 00                	push   $0x0
 7e0:	50                   	push   %eax
 7e1:	e8 ba f9 ff ff       	call   1a0 <memset>
  return region;
 7e6:	83 c4 10             	add    $0x10,%esp
}
 7e9:	8d 65 f8             	lea    -0x8(%ebp),%esp
 7ec:	89 f0                	mov    %esi,%eax
 7ee:	5b                   	pop    %ebx
 7ef:	5e                   	pop    %esi
 7f0:	5d                   	pop    %ebp
 7f1:	c3                   	ret    
    return NULL;
 7f2:	31 f6                	xor    %esi,%esi
 7f4:	eb f3                	jmp    7e9 <calloc+0x29>
 7f6:	8d 76 00             	lea    0x0(%esi),%esi
 7f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000800 <strdup>:

char*
strdup(char *s)
{
 800:	55                   	push   %ebp
 801:	89 e5                	mov    %esp,%ebp
 803:	56                   	push   %esi
 804:	53                   	push   %ebx
 805:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *buf = malloc(strlen(s) + 1);
 808:	83 ec 0c             	sub    $0xc,%esp
 80b:	53                   	push   %ebx
 80c:	e8 5f f9 ff ff       	call   170 <strlen>
 811:	83 c0 01             	add    $0x1,%eax
 814:	89 04 24             	mov    %eax,(%esp)
 817:	e8 c4 fe ff ff       	call   6e0 <malloc>
 81c:	89 c6                	mov    %eax,%esi
  strcpy(buf, s);
 81e:	58                   	pop    %eax
 81f:	5a                   	pop    %edx
 820:	53                   	push   %ebx
 821:	56                   	push   %esi
 822:	e8 c9 f8 ff ff       	call   f0 <strcpy>
  return buf;
}
 827:	8d 65 f8             	lea    -0x8(%ebp),%esp
 82a:	89 f0                	mov    %esi,%eax
 82c:	5b                   	pop    %ebx
 82d:	5e                   	pop    %esi
 82e:	5d                   	pop    %ebp
 82f:	c3                   	ret    