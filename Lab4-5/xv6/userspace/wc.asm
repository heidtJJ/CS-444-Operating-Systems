
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	be 01 00 00 00       	mov    $0x1,%esi
  16:	83 ec 18             	sub    $0x18,%esp
  19:	8b 01                	mov    (%ecx),%eax
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	83 c3 04             	add    $0x4,%ebx
  int fd, i;

  if(argc <= 1){
  21:	83 f8 01             	cmp    $0x1,%eax
{
  24:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(argc <= 1){
  27:	7e 56                	jle    7f <main+0x7f>
  29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	83 ec 08             	sub    $0x8,%esp
  33:	6a 00                	push   $0x0
  35:	ff 33                	pushl  (%ebx)
  37:	e8 b6 03 00 00       	call   3f2 <open>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	85 c0                	test   %eax,%eax
  41:	89 c7                	mov    %eax,%edi
  43:	78 26                	js     6b <main+0x6b>
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  45:	83 ec 08             	sub    $0x8,%esp
  48:	ff 33                	pushl  (%ebx)
  for(i = 1; i < argc; i++){
  4a:	83 c6 01             	add    $0x1,%esi
    wc(fd, argv[i]);
  4d:	50                   	push   %eax
  4e:	83 c3 04             	add    $0x4,%ebx
  51:	e8 4a 00 00 00       	call   a0 <wc>
    close(fd);
  56:	89 3c 24             	mov    %edi,(%esp)
  59:	e8 7c 03 00 00       	call   3da <close>
  for(i = 1; i < argc; i++){
  5e:	83 c4 10             	add    $0x10,%esp
  61:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  64:	75 ca                	jne    30 <main+0x30>
  }
  exit();
  66:	e8 47 03 00 00       	call   3b2 <exit>
      printf(1, "wc: cannot open %s\n", argv[i]);
  6b:	50                   	push   %eax
  6c:	ff 33                	pushl  (%ebx)
  6e:	68 d3 08 00 00       	push   $0x8d3
  73:	6a 01                	push   $0x1
  75:	e8 a6 04 00 00       	call   520 <printf>
      exit();
  7a:	e8 33 03 00 00       	call   3b2 <exit>
    wc(0, "");
  7f:	52                   	push   %edx
  80:	52                   	push   %edx
  81:	68 c5 08 00 00       	push   $0x8c5
  86:	6a 00                	push   $0x0
  88:	e8 13 00 00 00       	call   a0 <wc>
    exit();
  8d:	e8 20 03 00 00       	call   3b2 <exit>
  92:	66 90                	xchg   %ax,%ax
  94:	66 90                	xchg   %ax,%ax
  96:	66 90                	xchg   %ax,%ax
  98:	66 90                	xchg   %ax,%ax
  9a:	66 90                	xchg   %ax,%ax
  9c:	66 90                	xchg   %ax,%ax
  9e:	66 90                	xchg   %ax,%ax

000000a0 <wc>:
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	57                   	push   %edi
  a4:	56                   	push   %esi
  a5:	53                   	push   %ebx
  inword = 0;
  a6:	31 f6                	xor    %esi,%esi
  l = w = c = 0;
  a8:	31 db                	xor    %ebx,%ebx
{
  aa:	83 ec 1c             	sub    $0x1c,%esp
  l = w = c = 0;
  ad:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  b4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  bb:	90                   	nop
  bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((n = read(fd, buf, sizeof(buf))) > 0){
  c0:	83 ec 04             	sub    $0x4,%esp
  c3:	68 00 02 00 00       	push   $0x200
  c8:	68 40 0c 00 00       	push   $0xc40
  cd:	ff 75 08             	pushl  0x8(%ebp)
  d0:	e8 f5 02 00 00       	call   3ca <read>
  d5:	83 c4 10             	add    $0x10,%esp
  d8:	83 f8 00             	cmp    $0x0,%eax
  db:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  de:	7e 54                	jle    134 <wc+0x94>
  e0:	31 ff                	xor    %edi,%edi
  e2:	eb 0e                	jmp    f2 <wc+0x52>
  e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        inword = 0;
  e8:	31 f6                	xor    %esi,%esi
    for(i=0; i<n; i++){
  ea:	83 c7 01             	add    $0x1,%edi
  ed:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
  f0:	74 3a                	je     12c <wc+0x8c>
      if(buf[i] == '\n')
  f2:	0f be 87 40 0c 00 00 	movsbl 0xc40(%edi),%eax
        l++;
  f9:	31 c9                	xor    %ecx,%ecx
  fb:	3c 0a                	cmp    $0xa,%al
  fd:	0f 94 c1             	sete   %cl
      if(strchr(" \r\t\n\v", buf[i]))
 100:	83 ec 08             	sub    $0x8,%esp
 103:	50                   	push   %eax
 104:	68 b0 08 00 00       	push   $0x8b0
        l++;
 109:	01 cb                	add    %ecx,%ebx
      if(strchr(" \r\t\n\v", buf[i]))
 10b:	e8 30 01 00 00       	call   240 <strchr>
 110:	83 c4 10             	add    $0x10,%esp
 113:	85 c0                	test   %eax,%eax
 115:	75 d1                	jne    e8 <wc+0x48>
      else if(!inword){
 117:	85 f6                	test   %esi,%esi
 119:	75 cf                	jne    ea <wc+0x4a>
        w++;
 11b:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    for(i=0; i<n; i++){
 11f:	83 c7 01             	add    $0x1,%edi
 122:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
        inword = 1;
 125:	be 01 00 00 00       	mov    $0x1,%esi
    for(i=0; i<n; i++){
 12a:	75 c6                	jne    f2 <wc+0x52>
 12c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 12f:	01 55 dc             	add    %edx,-0x24(%ebp)
 132:	eb 8c                	jmp    c0 <wc+0x20>
  if(n < 0){
 134:	75 24                	jne    15a <wc+0xba>
  printf(1, "%d %d %d %s\n", l, w, c, name);
 136:	83 ec 08             	sub    $0x8,%esp
 139:	ff 75 0c             	pushl  0xc(%ebp)
 13c:	ff 75 dc             	pushl  -0x24(%ebp)
 13f:	ff 75 e0             	pushl  -0x20(%ebp)
 142:	53                   	push   %ebx
 143:	68 c6 08 00 00       	push   $0x8c6
 148:	6a 01                	push   $0x1
 14a:	e8 d1 03 00 00       	call   520 <printf>
}
 14f:	83 c4 20             	add    $0x20,%esp
 152:	8d 65 f4             	lea    -0xc(%ebp),%esp
 155:	5b                   	pop    %ebx
 156:	5e                   	pop    %esi
 157:	5f                   	pop    %edi
 158:	5d                   	pop    %ebp
 159:	c3                   	ret    
    printf(1, "wc: read error\n");
 15a:	83 ec 08             	sub    $0x8,%esp
 15d:	68 b6 08 00 00       	push   $0x8b6
 162:	6a 01                	push   $0x1
 164:	e8 b7 03 00 00       	call   520 <printf>
    exit();
 169:	e8 44 02 00 00       	call   3b2 <exit>
 16e:	66 90                	xchg   %ax,%ax

00000170 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	53                   	push   %ebx
 174:	8b 45 08             	mov    0x8(%ebp),%eax
 177:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 17a:	89 c2                	mov    %eax,%edx
 17c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 180:	83 c1 01             	add    $0x1,%ecx
 183:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 187:	83 c2 01             	add    $0x1,%edx
 18a:	84 db                	test   %bl,%bl
 18c:	88 5a ff             	mov    %bl,-0x1(%edx)
 18f:	75 ef                	jne    180 <strcpy+0x10>
    ;
  return os;
}
 191:	5b                   	pop    %ebx
 192:	5d                   	pop    %ebp
 193:	c3                   	ret    
 194:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 19a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	56                   	push   %esi
 1a4:	53                   	push   %ebx
 1a5:	8b 55 08             	mov    0x8(%ebp),%edx
 1a8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1ab:	0f b6 02             	movzbl (%edx),%eax
 1ae:	0f b6 19             	movzbl (%ecx),%ebx
 1b1:	84 c0                	test   %al,%al
 1b3:	75 1e                	jne    1d3 <strcmp+0x33>
 1b5:	eb 29                	jmp    1e0 <strcmp+0x40>
 1b7:	89 f6                	mov    %esi,%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 1c0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 1c3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 1c6:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
 1c9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1cd:	84 c0                	test   %al,%al
 1cf:	74 0f                	je     1e0 <strcmp+0x40>
 1d1:	89 f1                	mov    %esi,%ecx
 1d3:	38 d8                	cmp    %bl,%al
 1d5:	74 e9                	je     1c0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 1d7:	29 d8                	sub    %ebx,%eax
}
 1d9:	5b                   	pop    %ebx
 1da:	5e                   	pop    %esi
 1db:	5d                   	pop    %ebp
 1dc:	c3                   	ret    
 1dd:	8d 76 00             	lea    0x0(%esi),%esi
  while(*p && *p == *q)
 1e0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1e2:	29 d8                	sub    %ebx,%eax
}
 1e4:	5b                   	pop    %ebx
 1e5:	5e                   	pop    %esi
 1e6:	5d                   	pop    %ebp
 1e7:	c3                   	ret    
 1e8:	90                   	nop
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001f0 <strlen>:

uint
strlen(char *s)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1f6:	80 39 00             	cmpb   $0x0,(%ecx)
 1f9:	74 12                	je     20d <strlen+0x1d>
 1fb:	31 d2                	xor    %edx,%edx
 1fd:	8d 76 00             	lea    0x0(%esi),%esi
 200:	83 c2 01             	add    $0x1,%edx
 203:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 207:	89 d0                	mov    %edx,%eax
 209:	75 f5                	jne    200 <strlen+0x10>
    ;
  return n;
}
 20b:	5d                   	pop    %ebp
 20c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 20d:	31 c0                	xor    %eax,%eax
}
 20f:	5d                   	pop    %ebp
 210:	c3                   	ret    
 211:	eb 0d                	jmp    220 <memset>
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

00000220 <memset>:

void*
memset(void *dst, int c, uint n)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 227:	8b 4d 10             	mov    0x10(%ebp),%ecx
 22a:	8b 45 0c             	mov    0xc(%ebp),%eax
 22d:	89 d7                	mov    %edx,%edi
 22f:	fc                   	cld    
 230:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 232:	89 d0                	mov    %edx,%eax
 234:	5f                   	pop    %edi
 235:	5d                   	pop    %ebp
 236:	c3                   	ret    
 237:	89 f6                	mov    %esi,%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000240 <strchr>:

char*
strchr(const char *s, char c)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	53                   	push   %ebx
 244:	8b 45 08             	mov    0x8(%ebp),%eax
 247:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 24a:	0f b6 10             	movzbl (%eax),%edx
 24d:	84 d2                	test   %dl,%dl
 24f:	74 1d                	je     26e <strchr+0x2e>
    if(*s == c)
 251:	38 d3                	cmp    %dl,%bl
 253:	89 d9                	mov    %ebx,%ecx
 255:	75 0d                	jne    264 <strchr+0x24>
 257:	eb 17                	jmp    270 <strchr+0x30>
 259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 260:	38 ca                	cmp    %cl,%dl
 262:	74 0c                	je     270 <strchr+0x30>
  for(; *s; s++)
 264:	83 c0 01             	add    $0x1,%eax
 267:	0f b6 10             	movzbl (%eax),%edx
 26a:	84 d2                	test   %dl,%dl
 26c:	75 f2                	jne    260 <strchr+0x20>
      return (char*)s;
  return 0;
 26e:	31 c0                	xor    %eax,%eax
}
 270:	5b                   	pop    %ebx
 271:	5d                   	pop    %ebp
 272:	c3                   	ret    
 273:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000280 <gets>:

char*
gets(char *buf, int max)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	57                   	push   %edi
 284:	56                   	push   %esi
 285:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 286:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 288:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 28b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 28e:	eb 29                	jmp    2b9 <gets+0x39>
    cc = read(0, &c, 1);
 290:	83 ec 04             	sub    $0x4,%esp
 293:	6a 01                	push   $0x1
 295:	57                   	push   %edi
 296:	6a 00                	push   $0x0
 298:	e8 2d 01 00 00       	call   3ca <read>
    if(cc < 1)
 29d:	83 c4 10             	add    $0x10,%esp
 2a0:	85 c0                	test   %eax,%eax
 2a2:	7e 1d                	jle    2c1 <gets+0x41>
      break;
    buf[i++] = c;
 2a4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2a8:	8b 55 08             	mov    0x8(%ebp),%edx
 2ab:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 2ad:	3c 0a                	cmp    $0xa,%al
    buf[i++] = c;
 2af:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2b3:	74 1b                	je     2d0 <gets+0x50>
 2b5:	3c 0d                	cmp    $0xd,%al
 2b7:	74 17                	je     2d0 <gets+0x50>
  for(i=0; i+1 < max; ){
 2b9:	8d 5e 01             	lea    0x1(%esi),%ebx
 2bc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2bf:	7c cf                	jl     290 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 2c1:	8b 45 08             	mov    0x8(%ebp),%eax
 2c4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2cb:	5b                   	pop    %ebx
 2cc:	5e                   	pop    %esi
 2cd:	5f                   	pop    %edi
 2ce:	5d                   	pop    %ebp
 2cf:	c3                   	ret    
  buf[i] = '\0';
 2d0:	8b 45 08             	mov    0x8(%ebp),%eax
  for(i=0; i+1 < max; ){
 2d3:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 2d5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 2d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2dc:	5b                   	pop    %ebx
 2dd:	5e                   	pop    %esi
 2de:	5f                   	pop    %edi
 2df:	5d                   	pop    %ebp
 2e0:	c3                   	ret    
 2e1:	eb 0d                	jmp    2f0 <stat>
 2e3:	90                   	nop
 2e4:	90                   	nop
 2e5:	90                   	nop
 2e6:	90                   	nop
 2e7:	90                   	nop
 2e8:	90                   	nop
 2e9:	90                   	nop
 2ea:	90                   	nop
 2eb:	90                   	nop
 2ec:	90                   	nop
 2ed:	90                   	nop
 2ee:	90                   	nop
 2ef:	90                   	nop

000002f0 <stat>:

int
stat(char *n, struct stat *st)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	56                   	push   %esi
 2f4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f5:	83 ec 08             	sub    $0x8,%esp
 2f8:	6a 00                	push   $0x0
 2fa:	ff 75 08             	pushl  0x8(%ebp)
 2fd:	e8 f0 00 00 00       	call   3f2 <open>
  if(fd < 0)
 302:	83 c4 10             	add    $0x10,%esp
 305:	85 c0                	test   %eax,%eax
 307:	78 27                	js     330 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 309:	83 ec 08             	sub    $0x8,%esp
 30c:	ff 75 0c             	pushl  0xc(%ebp)
 30f:	89 c3                	mov    %eax,%ebx
 311:	50                   	push   %eax
 312:	e8 f3 00 00 00       	call   40a <fstat>
  close(fd);
 317:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 31a:	89 c6                	mov    %eax,%esi
  close(fd);
 31c:	e8 b9 00 00 00       	call   3da <close>
  return r;
 321:	83 c4 10             	add    $0x10,%esp
}
 324:	8d 65 f8             	lea    -0x8(%ebp),%esp
 327:	89 f0                	mov    %esi,%eax
 329:	5b                   	pop    %ebx
 32a:	5e                   	pop    %esi
 32b:	5d                   	pop    %ebp
 32c:	c3                   	ret    
 32d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 330:	be ff ff ff ff       	mov    $0xffffffff,%esi
 335:	eb ed                	jmp    324 <stat+0x34>
 337:	89 f6                	mov    %esi,%esi
 339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000340 <atoi>:

int
atoi(const char *s)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	53                   	push   %ebx
 344:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 347:	0f be 11             	movsbl (%ecx),%edx
 34a:	8d 42 d0             	lea    -0x30(%edx),%eax
 34d:	3c 09                	cmp    $0x9,%al
 34f:	b8 00 00 00 00       	mov    $0x0,%eax
 354:	77 1f                	ja     375 <atoi+0x35>
 356:	8d 76 00             	lea    0x0(%esi),%esi
 359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 360:	8d 04 80             	lea    (%eax,%eax,4),%eax
 363:	83 c1 01             	add    $0x1,%ecx
 366:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 36a:	0f be 11             	movsbl (%ecx),%edx
 36d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 370:	80 fb 09             	cmp    $0x9,%bl
 373:	76 eb                	jbe    360 <atoi+0x20>
  return n;
}
 375:	5b                   	pop    %ebx
 376:	5d                   	pop    %ebp
 377:	c3                   	ret    
 378:	90                   	nop
 379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000380 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	56                   	push   %esi
 384:	53                   	push   %ebx
 385:	8b 5d 10             	mov    0x10(%ebp),%ebx
 388:	8b 45 08             	mov    0x8(%ebp),%eax
 38b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 38e:	85 db                	test   %ebx,%ebx
 390:	7e 14                	jle    3a6 <memmove+0x26>
 392:	31 d2                	xor    %edx,%edx
 394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 398:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 39c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 39f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 3a2:	39 da                	cmp    %ebx,%edx
 3a4:	75 f2                	jne    398 <memmove+0x18>
  return vdst;
}
 3a6:	5b                   	pop    %ebx
 3a7:	5e                   	pop    %esi
 3a8:	5d                   	pop    %ebp
 3a9:	c3                   	ret    

000003aa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3aa:	b8 01 00 00 00       	mov    $0x1,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <exit>:
SYSCALL(exit)
 3b2:	b8 02 00 00 00       	mov    $0x2,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <wait>:
SYSCALL(wait)
 3ba:	b8 03 00 00 00       	mov    $0x3,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <pipe>:
SYSCALL(pipe)
 3c2:	b8 04 00 00 00       	mov    $0x4,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <read>:
SYSCALL(read)
 3ca:	b8 05 00 00 00       	mov    $0x5,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <write>:
SYSCALL(write)
 3d2:	b8 10 00 00 00       	mov    $0x10,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <close>:
SYSCALL(close)
 3da:	b8 15 00 00 00       	mov    $0x15,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <kill>:
SYSCALL(kill)
 3e2:	b8 06 00 00 00       	mov    $0x6,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <exec>:
SYSCALL(exec)
 3ea:	b8 07 00 00 00       	mov    $0x7,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <open>:
SYSCALL(open)
 3f2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <mknod>:
SYSCALL(mknod)
 3fa:	b8 11 00 00 00       	mov    $0x11,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <unlink>:
SYSCALL(unlink)
 402:	b8 12 00 00 00       	mov    $0x12,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <fstat>:
SYSCALL(fstat)
 40a:	b8 08 00 00 00       	mov    $0x8,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <link>:
SYSCALL(link)
 412:	b8 13 00 00 00       	mov    $0x13,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <mkdir>:
SYSCALL(mkdir)
 41a:	b8 14 00 00 00       	mov    $0x14,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <chdir>:
SYSCALL(chdir)
 422:	b8 09 00 00 00       	mov    $0x9,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <dup>:
SYSCALL(dup)
 42a:	b8 0a 00 00 00       	mov    $0xa,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <getpid>:
SYSCALL(getpid)
 432:	b8 0b 00 00 00       	mov    $0xb,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <sbrk>:
SYSCALL(sbrk)
 43a:	b8 0c 00 00 00       	mov    $0xc,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <sleep>:
SYSCALL(sleep)
 442:	b8 0d 00 00 00       	mov    $0xd,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <uptime>:
SYSCALL(uptime)
 44a:	b8 0e 00 00 00       	mov    $0xe,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <dup2>:
SYSCALL(dup2)
 452:	b8 16 00 00 00       	mov    $0x16,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <getcwd>:
SYSCALL(getcwd)
 45a:	b8 17 00 00 00       	mov    $0x17,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <ps_jared>:
SYSCALL(ps_jared)
 462:	b8 18 00 00 00       	mov    $0x18,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <setpriority_jared>:
SYSCALL(setpriority_jared)
 46a:	b8 19 00 00 00       	mov    $0x19,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    
 472:	66 90                	xchg   %ax,%ax
 474:	66 90                	xchg   %ax,%ax
 476:	66 90                	xchg   %ax,%ax
 478:	66 90                	xchg   %ax,%ax
 47a:	66 90                	xchg   %ax,%ax
 47c:	66 90                	xchg   %ax,%ax
 47e:	66 90                	xchg   %ax,%ax

00000480 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	53                   	push   %ebx
 486:	89 c6                	mov    %eax,%esi
 488:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 48b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 48e:	85 db                	test   %ebx,%ebx
 490:	74 7e                	je     510 <printint+0x90>
 492:	89 d0                	mov    %edx,%eax
 494:	c1 e8 1f             	shr    $0x1f,%eax
 497:	84 c0                	test   %al,%al
 499:	74 75                	je     510 <printint+0x90>
    neg = 1;
    x = -xx;
 49b:	89 d0                	mov    %edx,%eax
    neg = 1;
 49d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 4a4:	f7 d8                	neg    %eax
 4a6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 4a9:	31 ff                	xor    %edi,%edi
 4ab:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 4ae:	89 ce                	mov    %ecx,%esi
 4b0:	eb 08                	jmp    4ba <printint+0x3a>
 4b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4b8:	89 cf                	mov    %ecx,%edi
 4ba:	31 d2                	xor    %edx,%edx
 4bc:	8d 4f 01             	lea    0x1(%edi),%ecx
 4bf:	f7 f6                	div    %esi
 4c1:	0f b6 92 f0 08 00 00 	movzbl 0x8f0(%edx),%edx
  }while((x /= base) != 0);
 4c8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 4ca:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 4cd:	75 e9                	jne    4b8 <printint+0x38>
  if(neg)
 4cf:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4d2:	8b 75 c0             	mov    -0x40(%ebp),%esi
 4d5:	85 c0                	test   %eax,%eax
 4d7:	74 08                	je     4e1 <printint+0x61>
    buf[i++] = '-';
 4d9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 4de:	8d 4f 02             	lea    0x2(%edi),%ecx

  while(--i >= 0)
 4e1:	8d 79 ff             	lea    -0x1(%ecx),%edi
 4e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4e8:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
  write(fd, &c, 1);
 4ed:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 4f0:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 4f3:	6a 01                	push   $0x1
 4f5:	53                   	push   %ebx
 4f6:	56                   	push   %esi
 4f7:	88 45 d7             	mov    %al,-0x29(%ebp)
 4fa:	e8 d3 fe ff ff       	call   3d2 <write>
  while(--i >= 0)
 4ff:	83 c4 10             	add    $0x10,%esp
 502:	83 ff ff             	cmp    $0xffffffff,%edi
 505:	75 e1                	jne    4e8 <printint+0x68>
    putc(fd, buf[i]);
}
 507:	8d 65 f4             	lea    -0xc(%ebp),%esp
 50a:	5b                   	pop    %ebx
 50b:	5e                   	pop    %esi
 50c:	5f                   	pop    %edi
 50d:	5d                   	pop    %ebp
 50e:	c3                   	ret    
 50f:	90                   	nop
    x = xx;
 510:	89 d0                	mov    %edx,%eax
  neg = 0;
 512:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 519:	eb 8b                	jmp    4a6 <printint+0x26>
 51b:	90                   	nop
 51c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000520 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
 524:	56                   	push   %esi
 525:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 526:	8d 45 10             	lea    0x10(%ebp),%eax
{
 529:	83 ec 2c             	sub    $0x2c,%esp
  for(i = 0; fmt[i]; i++){
 52c:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 52f:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 532:	89 45 d0             	mov    %eax,-0x30(%ebp)
 535:	0f b6 1e             	movzbl (%esi),%ebx
 538:	83 c6 01             	add    $0x1,%esi
 53b:	84 db                	test   %bl,%bl
 53d:	0f 84 b0 00 00 00    	je     5f3 <printf+0xd3>
 543:	31 d2                	xor    %edx,%edx
 545:	eb 39                	jmp    580 <printf+0x60>
 547:	89 f6                	mov    %esi,%esi
 549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 550:	83 f8 25             	cmp    $0x25,%eax
 553:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 556:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 55b:	74 18                	je     575 <printf+0x55>
  write(fd, &c, 1);
 55d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 560:	83 ec 04             	sub    $0x4,%esp
 563:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 566:	6a 01                	push   $0x1
 568:	50                   	push   %eax
 569:	57                   	push   %edi
 56a:	e8 63 fe ff ff       	call   3d2 <write>
 56f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 572:	83 c4 10             	add    $0x10,%esp
 575:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 578:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 57c:	84 db                	test   %bl,%bl
 57e:	74 73                	je     5f3 <printf+0xd3>
    if(state == 0){
 580:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 582:	0f be cb             	movsbl %bl,%ecx
 585:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 588:	74 c6                	je     550 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 58a:	83 fa 25             	cmp    $0x25,%edx
 58d:	75 e6                	jne    575 <printf+0x55>
      if(c == 'd'){
 58f:	83 f8 64             	cmp    $0x64,%eax
 592:	0f 84 f8 00 00 00    	je     690 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 598:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 59e:	83 f9 70             	cmp    $0x70,%ecx
 5a1:	74 5d                	je     600 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5a3:	83 f8 73             	cmp    $0x73,%eax
 5a6:	0f 84 84 00 00 00    	je     630 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ac:	83 f8 63             	cmp    $0x63,%eax
 5af:	0f 84 ea 00 00 00    	je     69f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5b5:	83 f8 25             	cmp    $0x25,%eax
 5b8:	0f 84 c2 00 00 00    	je     680 <printf+0x160>
  write(fd, &c, 1);
 5be:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5c1:	83 ec 04             	sub    $0x4,%esp
 5c4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5c8:	6a 01                	push   $0x1
 5ca:	50                   	push   %eax
 5cb:	57                   	push   %edi
 5cc:	e8 01 fe ff ff       	call   3d2 <write>
 5d1:	83 c4 0c             	add    $0xc,%esp
 5d4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5d7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 5da:	6a 01                	push   $0x1
 5dc:	50                   	push   %eax
 5dd:	57                   	push   %edi
 5de:	83 c6 01             	add    $0x1,%esi
 5e1:	e8 ec fd ff ff       	call   3d2 <write>
  for(i = 0; fmt[i]; i++){
 5e6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 5ea:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5ed:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 5ef:	84 db                	test   %bl,%bl
 5f1:	75 8d                	jne    580 <printf+0x60>
    }
  }
}
 5f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5f6:	5b                   	pop    %ebx
 5f7:	5e                   	pop    %esi
 5f8:	5f                   	pop    %edi
 5f9:	5d                   	pop    %ebp
 5fa:	c3                   	ret    
 5fb:	90                   	nop
 5fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 16, 0);
 600:	83 ec 0c             	sub    $0xc,%esp
 603:	b9 10 00 00 00       	mov    $0x10,%ecx
 608:	6a 00                	push   $0x0
 60a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 60d:	89 f8                	mov    %edi,%eax
 60f:	8b 13                	mov    (%ebx),%edx
 611:	e8 6a fe ff ff       	call   480 <printint>
        ap++;
 616:	89 d8                	mov    %ebx,%eax
 618:	83 c4 10             	add    $0x10,%esp
      state = 0;
 61b:	31 d2                	xor    %edx,%edx
        ap++;
 61d:	83 c0 04             	add    $0x4,%eax
 620:	89 45 d0             	mov    %eax,-0x30(%ebp)
 623:	e9 4d ff ff ff       	jmp    575 <printf+0x55>
 628:	90                   	nop
 629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 630:	8b 45 d0             	mov    -0x30(%ebp),%eax
 633:	8b 18                	mov    (%eax),%ebx
        ap++;
 635:	83 c0 04             	add    $0x4,%eax
 638:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 63b:	85 db                	test   %ebx,%ebx
 63d:	74 7c                	je     6bb <printf+0x19b>
        while(*s != 0){
 63f:	0f b6 03             	movzbl (%ebx),%eax
 642:	84 c0                	test   %al,%al
 644:	74 29                	je     66f <printf+0x14f>
 646:	8d 76 00             	lea    0x0(%esi),%esi
 649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 650:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 653:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 656:	83 ec 04             	sub    $0x4,%esp
 659:	6a 01                	push   $0x1
          s++;
 65b:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 65e:	50                   	push   %eax
 65f:	57                   	push   %edi
 660:	e8 6d fd ff ff       	call   3d2 <write>
        while(*s != 0){
 665:	0f b6 03             	movzbl (%ebx),%eax
 668:	83 c4 10             	add    $0x10,%esp
 66b:	84 c0                	test   %al,%al
 66d:	75 e1                	jne    650 <printf+0x130>
      state = 0;
 66f:	31 d2                	xor    %edx,%edx
 671:	e9 ff fe ff ff       	jmp    575 <printf+0x55>
 676:	8d 76 00             	lea    0x0(%esi),%esi
 679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  write(fd, &c, 1);
 680:	83 ec 04             	sub    $0x4,%esp
 683:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 686:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 689:	6a 01                	push   $0x1
 68b:	e9 4c ff ff ff       	jmp    5dc <printf+0xbc>
        printint(fd, *ap, 10, 1);
 690:	83 ec 0c             	sub    $0xc,%esp
 693:	b9 0a 00 00 00       	mov    $0xa,%ecx
 698:	6a 01                	push   $0x1
 69a:	e9 6b ff ff ff       	jmp    60a <printf+0xea>
        putc(fd, *ap);
 69f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 6a2:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 6a5:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 6a7:	6a 01                	push   $0x1
        putc(fd, *ap);
 6a9:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 6ac:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6af:	50                   	push   %eax
 6b0:	57                   	push   %edi
 6b1:	e8 1c fd ff ff       	call   3d2 <write>
 6b6:	e9 5b ff ff ff       	jmp    616 <printf+0xf6>
        while(*s != 0){
 6bb:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 6c0:	bb e7 08 00 00       	mov    $0x8e7,%ebx
 6c5:	eb 89                	jmp    650 <printf+0x130>
 6c7:	66 90                	xchg   %ax,%ax
 6c9:	66 90                	xchg   %ax,%ax
 6cb:	66 90                	xchg   %ax,%ax
 6cd:	66 90                	xchg   %ax,%ax
 6cf:	90                   	nop

000006d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d1:	a1 20 0c 00 00       	mov    0xc20,%eax
{
 6d6:	89 e5                	mov    %esp,%ebp
 6d8:	57                   	push   %edi
 6d9:	56                   	push   %esi
 6da:	53                   	push   %ebx
 6db:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6de:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 6e0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e3:	39 c8                	cmp    %ecx,%eax
 6e5:	73 19                	jae    700 <free+0x30>
 6e7:	89 f6                	mov    %esi,%esi
 6e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 6f0:	39 d1                	cmp    %edx,%ecx
 6f2:	72 1c                	jb     710 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f4:	39 d0                	cmp    %edx,%eax
 6f6:	73 18                	jae    710 <free+0x40>
{
 6f8:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6fa:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6fc:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6fe:	72 f0                	jb     6f0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 700:	39 d0                	cmp    %edx,%eax
 702:	72 f4                	jb     6f8 <free+0x28>
 704:	39 d1                	cmp    %edx,%ecx
 706:	73 f0                	jae    6f8 <free+0x28>
 708:	90                   	nop
 709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 710:	8b 73 fc             	mov    -0x4(%ebx),%esi
 713:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 716:	39 fa                	cmp    %edi,%edx
 718:	74 19                	je     733 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 71a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 71d:	8b 50 04             	mov    0x4(%eax),%edx
 720:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 723:	39 f1                	cmp    %esi,%ecx
 725:	74 23                	je     74a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 727:	89 08                	mov    %ecx,(%eax)
  freep = p;
 729:	a3 20 0c 00 00       	mov    %eax,0xc20
}
 72e:	5b                   	pop    %ebx
 72f:	5e                   	pop    %esi
 730:	5f                   	pop    %edi
 731:	5d                   	pop    %ebp
 732:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 733:	03 72 04             	add    0x4(%edx),%esi
 736:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 739:	8b 10                	mov    (%eax),%edx
 73b:	8b 12                	mov    (%edx),%edx
 73d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 740:	8b 50 04             	mov    0x4(%eax),%edx
 743:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 746:	39 f1                	cmp    %esi,%ecx
 748:	75 dd                	jne    727 <free+0x57>
    p->s.size += bp->s.size;
 74a:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 74d:	a3 20 0c 00 00       	mov    %eax,0xc20
    p->s.size += bp->s.size;
 752:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 755:	8b 53 f8             	mov    -0x8(%ebx),%edx
 758:	89 10                	mov    %edx,(%eax)
}
 75a:	5b                   	pop    %ebx
 75b:	5e                   	pop    %esi
 75c:	5f                   	pop    %edi
 75d:	5d                   	pop    %ebp
 75e:	c3                   	ret    
 75f:	90                   	nop

00000760 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	56                   	push   %esi
 765:	53                   	push   %ebx
 766:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 769:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 76c:	8b 15 20 0c 00 00    	mov    0xc20,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 772:	8d 78 07             	lea    0x7(%eax),%edi
 775:	c1 ef 03             	shr    $0x3,%edi
 778:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 77b:	85 d2                	test   %edx,%edx
 77d:	0f 84 93 00 00 00    	je     816 <malloc+0xb6>
 783:	8b 02                	mov    (%edx),%eax
 785:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 788:	39 cf                	cmp    %ecx,%edi
 78a:	76 64                	jbe    7f0 <malloc+0x90>
 78c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 792:	bb 00 10 00 00       	mov    $0x1000,%ebx
 797:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 79a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7a1:	eb 0e                	jmp    7b1 <malloc+0x51>
 7a3:	90                   	nop
 7a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7aa:	8b 48 04             	mov    0x4(%eax),%ecx
 7ad:	39 cf                	cmp    %ecx,%edi
 7af:	76 3f                	jbe    7f0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7b1:	39 05 20 0c 00 00    	cmp    %eax,0xc20
 7b7:	89 c2                	mov    %eax,%edx
 7b9:	75 ed                	jne    7a8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 7bb:	83 ec 0c             	sub    $0xc,%esp
 7be:	56                   	push   %esi
 7bf:	e8 76 fc ff ff       	call   43a <sbrk>
  if(p == (char*)-1)
 7c4:	83 c4 10             	add    $0x10,%esp
 7c7:	83 f8 ff             	cmp    $0xffffffff,%eax
 7ca:	74 1c                	je     7e8 <malloc+0x88>
  hp->s.size = nu;
 7cc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7cf:	83 ec 0c             	sub    $0xc,%esp
 7d2:	83 c0 08             	add    $0x8,%eax
 7d5:	50                   	push   %eax
 7d6:	e8 f5 fe ff ff       	call   6d0 <free>
  return freep;
 7db:	8b 15 20 0c 00 00    	mov    0xc20,%edx
      if((p = morecore(nunits)) == 0)
 7e1:	83 c4 10             	add    $0x10,%esp
 7e4:	85 d2                	test   %edx,%edx
 7e6:	75 c0                	jne    7a8 <malloc+0x48>
        return 0;
 7e8:	31 c0                	xor    %eax,%eax
 7ea:	eb 1c                	jmp    808 <malloc+0xa8>
 7ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 7f0:	39 cf                	cmp    %ecx,%edi
 7f2:	74 1c                	je     810 <malloc+0xb0>
        p->s.size -= nunits;
 7f4:	29 f9                	sub    %edi,%ecx
 7f6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7f9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7fc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7ff:	89 15 20 0c 00 00    	mov    %edx,0xc20
      return (void*)(p + 1);
 805:	83 c0 08             	add    $0x8,%eax
  }
}
 808:	8d 65 f4             	lea    -0xc(%ebp),%esp
 80b:	5b                   	pop    %ebx
 80c:	5e                   	pop    %esi
 80d:	5f                   	pop    %edi
 80e:	5d                   	pop    %ebp
 80f:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 810:	8b 08                	mov    (%eax),%ecx
 812:	89 0a                	mov    %ecx,(%edx)
 814:	eb e9                	jmp    7ff <malloc+0x9f>
    base.s.ptr = freep = prevp = &base;
 816:	c7 05 20 0c 00 00 24 	movl   $0xc24,0xc20
 81d:	0c 00 00 
 820:	c7 05 24 0c 00 00 24 	movl   $0xc24,0xc24
 827:	0c 00 00 
    base.s.size = 0;
 82a:	b8 24 0c 00 00       	mov    $0xc24,%eax
 82f:	c7 05 28 0c 00 00 00 	movl   $0x0,0xc28
 836:	00 00 00 
 839:	e9 4e ff ff ff       	jmp    78c <malloc+0x2c>
 83e:	66 90                	xchg   %ax,%ax

00000840 <calloc>:

void*
calloc(uint nmemb, uint sz)
{
 840:	55                   	push   %ebp
 841:	89 e5                	mov    %esp,%ebp
 843:	56                   	push   %esi
 844:	53                   	push   %ebx
  uint full_sz = 0;
  if (__builtin_mul_overflow(nmemb, sz, &full_sz))
 845:	8b 45 08             	mov    0x8(%ebp),%eax
 848:	f7 65 0c             	mull   0xc(%ebp)
 84b:	70 25                	jo     872 <calloc+0x32>
    return NULL;
  void *region = malloc(full_sz);
 84d:	83 ec 0c             	sub    $0xc,%esp
 850:	89 c3                	mov    %eax,%ebx
 852:	50                   	push   %eax
 853:	e8 08 ff ff ff       	call   760 <malloc>
  memset(region, 0, full_sz);
 858:	83 c4 0c             	add    $0xc,%esp
  void *region = malloc(full_sz);
 85b:	89 c6                	mov    %eax,%esi
  memset(region, 0, full_sz);
 85d:	53                   	push   %ebx
 85e:	6a 00                	push   $0x0
 860:	50                   	push   %eax
 861:	e8 ba f9 ff ff       	call   220 <memset>
  return region;
 866:	83 c4 10             	add    $0x10,%esp
}
 869:	8d 65 f8             	lea    -0x8(%ebp),%esp
 86c:	89 f0                	mov    %esi,%eax
 86e:	5b                   	pop    %ebx
 86f:	5e                   	pop    %esi
 870:	5d                   	pop    %ebp
 871:	c3                   	ret    
    return NULL;
 872:	31 f6                	xor    %esi,%esi
 874:	eb f3                	jmp    869 <calloc+0x29>
 876:	8d 76 00             	lea    0x0(%esi),%esi
 879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000880 <strdup>:

char*
strdup(char *s)
{
 880:	55                   	push   %ebp
 881:	89 e5                	mov    %esp,%ebp
 883:	56                   	push   %esi
 884:	53                   	push   %ebx
 885:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *buf = malloc(strlen(s) + 1);
 888:	83 ec 0c             	sub    $0xc,%esp
 88b:	53                   	push   %ebx
 88c:	e8 5f f9 ff ff       	call   1f0 <strlen>
 891:	83 c0 01             	add    $0x1,%eax
 894:	89 04 24             	mov    %eax,(%esp)
 897:	e8 c4 fe ff ff       	call   760 <malloc>
 89c:	89 c6                	mov    %eax,%esi
  strcpy(buf, s);
 89e:	58                   	pop    %eax
 89f:	5a                   	pop    %edx
 8a0:	53                   	push   %ebx
 8a1:	56                   	push   %esi
 8a2:	e8 c9 f8 ff ff       	call   170 <strcpy>
  return buf;
}
 8a7:	8d 65 f8             	lea    -0x8(%ebp),%esp
 8aa:	89 f0                	mov    %esi,%eax
 8ac:	5b                   	pop    %ebx
 8ad:	5e                   	pop    %esi
 8ae:	5d                   	pop    %ebp
 8af:	c3                   	ret    
