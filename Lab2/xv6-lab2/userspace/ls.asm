
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  close(fd);
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
  11:	bb 01 00 00 00       	mov    $0x1,%ebx
  16:	83 ec 08             	sub    $0x8,%esp
  19:	8b 31                	mov    (%ecx),%esi
  1b:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
  1e:	83 fe 01             	cmp    $0x1,%esi
  21:	7e 1f                	jle    42 <main+0x42>
  23:	90                   	nop
  24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
  28:	83 ec 0c             	sub    $0xc,%esp
  2b:	ff 34 9f             	pushl  (%edi,%ebx,4)
  for(i=1; i<argc; i++)
  2e:	83 c3 01             	add    $0x1,%ebx
    ls(argv[i]);
  31:	e8 ca 00 00 00       	call   100 <ls>
  for(i=1; i<argc; i++)
  36:	83 c4 10             	add    $0x10,%esp
  39:	39 de                	cmp    %ebx,%esi
  3b:	75 eb                	jne    28 <main+0x28>
  exit();
  3d:	e8 40 05 00 00       	call   582 <exit>
    ls(".");
  42:	83 ec 0c             	sub    $0xc,%esp
  45:	68 b8 0a 00 00       	push   $0xab8
  4a:	e8 b1 00 00 00       	call   100 <ls>
    exit();
  4f:	e8 2e 05 00 00       	call   582 <exit>
  54:	66 90                	xchg   %ax,%ax
  56:	66 90                	xchg   %ax,%ax
  58:	66 90                	xchg   %ax,%ax
  5a:	66 90                	xchg   %ax,%ax
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <fmtname>:
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	56                   	push   %esi
  64:	53                   	push   %ebx
  65:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  68:	83 ec 0c             	sub    $0xc,%esp
  6b:	53                   	push   %ebx
  6c:	e8 4f 03 00 00       	call   3c0 <strlen>
  71:	83 c4 10             	add    $0x10,%esp
  74:	01 d8                	add    %ebx,%eax
  76:	73 0f                	jae    87 <fmtname+0x27>
  78:	eb 12                	jmp    8c <fmtname+0x2c>
  7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  80:	83 e8 01             	sub    $0x1,%eax
  83:	39 c3                	cmp    %eax,%ebx
  85:	77 05                	ja     8c <fmtname+0x2c>
  87:	80 38 2f             	cmpb   $0x2f,(%eax)
  8a:	75 f4                	jne    80 <fmtname+0x20>
  p++;
  8c:	8d 58 01             	lea    0x1(%eax),%ebx
  if(strlen(p) >= DIRSIZ)
  8f:	83 ec 0c             	sub    $0xc,%esp
  92:	53                   	push   %ebx
  93:	e8 28 03 00 00       	call   3c0 <strlen>
  98:	83 c4 10             	add    $0x10,%esp
  9b:	83 f8 0d             	cmp    $0xd,%eax
  9e:	77 4a                	ja     ea <fmtname+0x8a>
  memmove(buf, p, strlen(p));
  a0:	83 ec 0c             	sub    $0xc,%esp
  a3:	53                   	push   %ebx
  a4:	e8 17 03 00 00       	call   3c0 <strlen>
  a9:	83 c4 0c             	add    $0xc,%esp
  ac:	50                   	push   %eax
  ad:	53                   	push   %ebx
  ae:	68 24 0e 00 00       	push   $0xe24
  b3:	e8 98 04 00 00       	call   550 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  b8:	89 1c 24             	mov    %ebx,(%esp)
  bb:	e8 00 03 00 00       	call   3c0 <strlen>
  c0:	89 1c 24             	mov    %ebx,(%esp)
  c3:	89 c6                	mov    %eax,%esi
  return buf;
  c5:	bb 24 0e 00 00       	mov    $0xe24,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  ca:	e8 f1 02 00 00       	call   3c0 <strlen>
  cf:	ba 0e 00 00 00       	mov    $0xe,%edx
  d4:	83 c4 0c             	add    $0xc,%esp
  d7:	05 24 0e 00 00       	add    $0xe24,%eax
  dc:	29 f2                	sub    %esi,%edx
  de:	52                   	push   %edx
  df:	6a 20                	push   $0x20
  e1:	50                   	push   %eax
  e2:	e8 09 03 00 00       	call   3f0 <memset>
  return buf;
  e7:	83 c4 10             	add    $0x10,%esp
}
  ea:	8d 65 f8             	lea    -0x8(%ebp),%esp
  ed:	89 d8                	mov    %ebx,%eax
  ef:	5b                   	pop    %ebx
  f0:	5e                   	pop    %esi
  f1:	5d                   	pop    %ebp
  f2:	c3                   	ret    
  f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <ls>:
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	57                   	push   %edi
 104:	56                   	push   %esi
 105:	53                   	push   %ebx
 106:	81 ec 64 02 00 00    	sub    $0x264,%esp
 10c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((fd = open(path, 0)) < 0){
 10f:	6a 00                	push   $0x0
 111:	57                   	push   %edi
 112:	e8 ab 04 00 00       	call   5c2 <open>
 117:	83 c4 10             	add    $0x10,%esp
 11a:	85 c0                	test   %eax,%eax
 11c:	0f 88 9e 01 00 00    	js     2c0 <ls+0x1c0>
  if(fstat(fd, &st) < 0){
 122:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
 128:	83 ec 08             	sub    $0x8,%esp
 12b:	89 c3                	mov    %eax,%ebx
 12d:	56                   	push   %esi
 12e:	50                   	push   %eax
 12f:	e8 a6 04 00 00       	call   5da <fstat>
 134:	83 c4 10             	add    $0x10,%esp
 137:	85 c0                	test   %eax,%eax
 139:	0f 88 c1 01 00 00    	js     300 <ls+0x200>
  switch(st.type){
 13f:	0f b7 85 d4 fd ff ff 	movzwl -0x22c(%ebp),%eax
 146:	66 83 f8 01          	cmp    $0x1,%ax
 14a:	74 54                	je     1a0 <ls+0xa0>
 14c:	66 83 f8 02          	cmp    $0x2,%ax
 150:	75 37                	jne    189 <ls+0x89>
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 152:	83 ec 0c             	sub    $0xc,%esp
 155:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 15b:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
 161:	57                   	push   %edi
 162:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 168:	e8 f3 fe ff ff       	call   60 <fmtname>
 16d:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 173:	59                   	pop    %ecx
 174:	5f                   	pop    %edi
 175:	52                   	push   %edx
 176:	56                   	push   %esi
 177:	6a 02                	push   $0x2
 179:	50                   	push   %eax
 17a:	68 98 0a 00 00       	push   $0xa98
 17f:	6a 01                	push   $0x1
 181:	e8 5a 05 00 00       	call   6e0 <printf>
    break;
 186:	83 c4 20             	add    $0x20,%esp
  close(fd);
 189:	83 ec 0c             	sub    $0xc,%esp
 18c:	53                   	push   %ebx
 18d:	e8 18 04 00 00       	call   5aa <close>
 192:	83 c4 10             	add    $0x10,%esp
}
 195:	8d 65 f4             	lea    -0xc(%ebp),%esp
 198:	5b                   	pop    %ebx
 199:	5e                   	pop    %esi
 19a:	5f                   	pop    %edi
 19b:	5d                   	pop    %ebp
 19c:	c3                   	ret    
 19d:	8d 76 00             	lea    0x0(%esi),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1a0:	83 ec 0c             	sub    $0xc,%esp
 1a3:	57                   	push   %edi
 1a4:	e8 17 02 00 00       	call   3c0 <strlen>
 1a9:	83 c0 10             	add    $0x10,%eax
 1ac:	83 c4 10             	add    $0x10,%esp
 1af:	3d 00 02 00 00       	cmp    $0x200,%eax
 1b4:	0f 87 26 01 00 00    	ja     2e0 <ls+0x1e0>
    strcpy(buf, path);
 1ba:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 1c0:	83 ec 08             	sub    $0x8,%esp
 1c3:	57                   	push   %edi
 1c4:	8d bd c4 fd ff ff    	lea    -0x23c(%ebp),%edi
 1ca:	50                   	push   %eax
 1cb:	e8 70 01 00 00       	call   340 <strcpy>
    p = buf+strlen(buf);
 1d0:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 1d6:	89 04 24             	mov    %eax,(%esp)
 1d9:	e8 e2 01 00 00       	call   3c0 <strlen>
 1de:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1e4:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 1e7:	01 c8                	add    %ecx,%eax
    *p++ = '/';
 1e9:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 1ec:	89 85 a8 fd ff ff    	mov    %eax,-0x258(%ebp)
    *p++ = '/';
 1f2:	c6 00 2f             	movb   $0x2f,(%eax)
 1f5:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 1fb:	90                   	nop
 1fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 200:	83 ec 04             	sub    $0x4,%esp
 203:	6a 10                	push   $0x10
 205:	57                   	push   %edi
 206:	53                   	push   %ebx
 207:	e8 8e 03 00 00       	call   59a <read>
 20c:	83 c4 10             	add    $0x10,%esp
 20f:	83 f8 10             	cmp    $0x10,%eax
 212:	0f 85 71 ff ff ff    	jne    189 <ls+0x89>
      if(de.inum == 0)
 218:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
 21f:	00 
 220:	74 de                	je     200 <ls+0x100>
      memmove(p, de.name, DIRSIZ);
 222:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
 228:	83 ec 04             	sub    $0x4,%esp
 22b:	6a 0e                	push   $0xe
 22d:	50                   	push   %eax
 22e:	ff b5 a4 fd ff ff    	pushl  -0x25c(%ebp)
 234:	e8 17 03 00 00       	call   550 <memmove>
      p[DIRSIZ] = 0;
 239:	8b 85 a8 fd ff ff    	mov    -0x258(%ebp),%eax
 23f:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 243:	58                   	pop    %eax
 244:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 24a:	5a                   	pop    %edx
 24b:	56                   	push   %esi
 24c:	50                   	push   %eax
 24d:	e8 6e 02 00 00       	call   4c0 <stat>
 252:	83 c4 10             	add    $0x10,%esp
 255:	85 c0                	test   %eax,%eax
 257:	0f 88 c3 00 00 00    	js     320 <ls+0x220>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 25d:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 263:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 26a:	83 ec 0c             	sub    $0xc,%esp
 26d:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 273:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
 279:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
 27f:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
 285:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 28b:	51                   	push   %ecx
 28c:	e8 cf fd ff ff       	call   60 <fmtname>
 291:	5a                   	pop    %edx
 292:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
 298:	59                   	pop    %ecx
 299:	8b 8d ac fd ff ff    	mov    -0x254(%ebp),%ecx
 29f:	51                   	push   %ecx
 2a0:	52                   	push   %edx
 2a1:	ff b5 b4 fd ff ff    	pushl  -0x24c(%ebp)
 2a7:	50                   	push   %eax
 2a8:	68 98 0a 00 00       	push   $0xa98
 2ad:	6a 01                	push   $0x1
 2af:	e8 2c 04 00 00       	call   6e0 <printf>
 2b4:	83 c4 20             	add    $0x20,%esp
 2b7:	e9 44 ff ff ff       	jmp    200 <ls+0x100>
 2bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot open %s\n", path);
 2c0:	83 ec 04             	sub    $0x4,%esp
 2c3:	57                   	push   %edi
 2c4:	68 70 0a 00 00       	push   $0xa70
 2c9:	6a 02                	push   $0x2
 2cb:	e8 10 04 00 00       	call   6e0 <printf>
    return;
 2d0:	83 c4 10             	add    $0x10,%esp
}
 2d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2d6:	5b                   	pop    %ebx
 2d7:	5e                   	pop    %esi
 2d8:	5f                   	pop    %edi
 2d9:	5d                   	pop    %ebp
 2da:	c3                   	ret    
 2db:	90                   	nop
 2dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "ls: path too long\n");
 2e0:	83 ec 08             	sub    $0x8,%esp
 2e3:	68 a5 0a 00 00       	push   $0xaa5
 2e8:	6a 01                	push   $0x1
 2ea:	e8 f1 03 00 00       	call   6e0 <printf>
      break;
 2ef:	83 c4 10             	add    $0x10,%esp
 2f2:	e9 92 fe ff ff       	jmp    189 <ls+0x89>
 2f7:	89 f6                	mov    %esi,%esi
 2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(2, "ls: cannot stat %s\n", path);
 300:	83 ec 04             	sub    $0x4,%esp
 303:	57                   	push   %edi
 304:	68 84 0a 00 00       	push   $0xa84
 309:	6a 02                	push   $0x2
 30b:	e8 d0 03 00 00       	call   6e0 <printf>
    close(fd);
 310:	89 1c 24             	mov    %ebx,(%esp)
 313:	e8 92 02 00 00       	call   5aa <close>
    return;
 318:	83 c4 10             	add    $0x10,%esp
 31b:	e9 75 fe ff ff       	jmp    195 <ls+0x95>
        printf(1, "ls: cannot stat %s\n", buf);
 320:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 326:	83 ec 04             	sub    $0x4,%esp
 329:	50                   	push   %eax
 32a:	68 84 0a 00 00       	push   $0xa84
 32f:	6a 01                	push   $0x1
 331:	e8 aa 03 00 00       	call   6e0 <printf>
        continue;
 336:	83 c4 10             	add    $0x10,%esp
 339:	e9 c2 fe ff ff       	jmp    200 <ls+0x100>
 33e:	66 90                	xchg   %ax,%ax

00000340 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	53                   	push   %ebx
 344:	8b 45 08             	mov    0x8(%ebp),%eax
 347:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 34a:	89 c2                	mov    %eax,%edx
 34c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 350:	83 c1 01             	add    $0x1,%ecx
 353:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 357:	83 c2 01             	add    $0x1,%edx
 35a:	84 db                	test   %bl,%bl
 35c:	88 5a ff             	mov    %bl,-0x1(%edx)
 35f:	75 ef                	jne    350 <strcpy+0x10>
    ;
  return os;
}
 361:	5b                   	pop    %ebx
 362:	5d                   	pop    %ebp
 363:	c3                   	ret    
 364:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 36a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000370 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	56                   	push   %esi
 374:	53                   	push   %ebx
 375:	8b 55 08             	mov    0x8(%ebp),%edx
 378:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 37b:	0f b6 02             	movzbl (%edx),%eax
 37e:	0f b6 19             	movzbl (%ecx),%ebx
 381:	84 c0                	test   %al,%al
 383:	75 1e                	jne    3a3 <strcmp+0x33>
 385:	eb 29                	jmp    3b0 <strcmp+0x40>
 387:	89 f6                	mov    %esi,%esi
 389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 390:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 393:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 396:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
 399:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 39d:	84 c0                	test   %al,%al
 39f:	74 0f                	je     3b0 <strcmp+0x40>
 3a1:	89 f1                	mov    %esi,%ecx
 3a3:	38 d8                	cmp    %bl,%al
 3a5:	74 e9                	je     390 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 3a7:	29 d8                	sub    %ebx,%eax
}
 3a9:	5b                   	pop    %ebx
 3aa:	5e                   	pop    %esi
 3ab:	5d                   	pop    %ebp
 3ac:	c3                   	ret    
 3ad:	8d 76 00             	lea    0x0(%esi),%esi
  while(*p && *p == *q)
 3b0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 3b2:	29 d8                	sub    %ebx,%eax
}
 3b4:	5b                   	pop    %ebx
 3b5:	5e                   	pop    %esi
 3b6:	5d                   	pop    %ebp
 3b7:	c3                   	ret    
 3b8:	90                   	nop
 3b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003c0 <strlen>:

uint
strlen(char *s)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3c6:	80 39 00             	cmpb   $0x0,(%ecx)
 3c9:	74 12                	je     3dd <strlen+0x1d>
 3cb:	31 d2                	xor    %edx,%edx
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
 3d0:	83 c2 01             	add    $0x1,%edx
 3d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 3d7:	89 d0                	mov    %edx,%eax
 3d9:	75 f5                	jne    3d0 <strlen+0x10>
    ;
  return n;
}
 3db:	5d                   	pop    %ebp
 3dc:	c3                   	ret    
  for(n = 0; s[n]; n++)
 3dd:	31 c0                	xor    %eax,%eax
}
 3df:	5d                   	pop    %ebp
 3e0:	c3                   	ret    
 3e1:	eb 0d                	jmp    3f0 <memset>
 3e3:	90                   	nop
 3e4:	90                   	nop
 3e5:	90                   	nop
 3e6:	90                   	nop
 3e7:	90                   	nop
 3e8:	90                   	nop
 3e9:	90                   	nop
 3ea:	90                   	nop
 3eb:	90                   	nop
 3ec:	90                   	nop
 3ed:	90                   	nop
 3ee:	90                   	nop
 3ef:	90                   	nop

000003f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 3fd:	89 d7                	mov    %edx,%edi
 3ff:	fc                   	cld    
 400:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 402:	89 d0                	mov    %edx,%eax
 404:	5f                   	pop    %edi
 405:	5d                   	pop    %ebp
 406:	c3                   	ret    
 407:	89 f6                	mov    %esi,%esi
 409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000410 <strchr>:

char*
strchr(const char *s, char c)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	53                   	push   %ebx
 414:	8b 45 08             	mov    0x8(%ebp),%eax
 417:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 41a:	0f b6 10             	movzbl (%eax),%edx
 41d:	84 d2                	test   %dl,%dl
 41f:	74 1d                	je     43e <strchr+0x2e>
    if(*s == c)
 421:	38 d3                	cmp    %dl,%bl
 423:	89 d9                	mov    %ebx,%ecx
 425:	75 0d                	jne    434 <strchr+0x24>
 427:	eb 17                	jmp    440 <strchr+0x30>
 429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 430:	38 ca                	cmp    %cl,%dl
 432:	74 0c                	je     440 <strchr+0x30>
  for(; *s; s++)
 434:	83 c0 01             	add    $0x1,%eax
 437:	0f b6 10             	movzbl (%eax),%edx
 43a:	84 d2                	test   %dl,%dl
 43c:	75 f2                	jne    430 <strchr+0x20>
      return (char*)s;
  return 0;
 43e:	31 c0                	xor    %eax,%eax
}
 440:	5b                   	pop    %ebx
 441:	5d                   	pop    %ebp
 442:	c3                   	ret    
 443:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000450 <gets>:

char*
gets(char *buf, int max)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
 455:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 456:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 458:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 45b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 45e:	eb 29                	jmp    489 <gets+0x39>
    cc = read(0, &c, 1);
 460:	83 ec 04             	sub    $0x4,%esp
 463:	6a 01                	push   $0x1
 465:	57                   	push   %edi
 466:	6a 00                	push   $0x0
 468:	e8 2d 01 00 00       	call   59a <read>
    if(cc < 1)
 46d:	83 c4 10             	add    $0x10,%esp
 470:	85 c0                	test   %eax,%eax
 472:	7e 1d                	jle    491 <gets+0x41>
      break;
    buf[i++] = c;
 474:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 478:	8b 55 08             	mov    0x8(%ebp),%edx
 47b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 47d:	3c 0a                	cmp    $0xa,%al
    buf[i++] = c;
 47f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 483:	74 1b                	je     4a0 <gets+0x50>
 485:	3c 0d                	cmp    $0xd,%al
 487:	74 17                	je     4a0 <gets+0x50>
  for(i=0; i+1 < max; ){
 489:	8d 5e 01             	lea    0x1(%esi),%ebx
 48c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 48f:	7c cf                	jl     460 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 491:	8b 45 08             	mov    0x8(%ebp),%eax
 494:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 498:	8d 65 f4             	lea    -0xc(%ebp),%esp
 49b:	5b                   	pop    %ebx
 49c:	5e                   	pop    %esi
 49d:	5f                   	pop    %edi
 49e:	5d                   	pop    %ebp
 49f:	c3                   	ret    
  buf[i] = '\0';
 4a0:	8b 45 08             	mov    0x8(%ebp),%eax
  for(i=0; i+1 < max; ){
 4a3:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 4a5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 4a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4ac:	5b                   	pop    %ebx
 4ad:	5e                   	pop    %esi
 4ae:	5f                   	pop    %edi
 4af:	5d                   	pop    %ebp
 4b0:	c3                   	ret    
 4b1:	eb 0d                	jmp    4c0 <stat>
 4b3:	90                   	nop
 4b4:	90                   	nop
 4b5:	90                   	nop
 4b6:	90                   	nop
 4b7:	90                   	nop
 4b8:	90                   	nop
 4b9:	90                   	nop
 4ba:	90                   	nop
 4bb:	90                   	nop
 4bc:	90                   	nop
 4bd:	90                   	nop
 4be:	90                   	nop
 4bf:	90                   	nop

000004c0 <stat>:

int
stat(char *n, struct stat *st)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	56                   	push   %esi
 4c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4c5:	83 ec 08             	sub    $0x8,%esp
 4c8:	6a 00                	push   $0x0
 4ca:	ff 75 08             	pushl  0x8(%ebp)
 4cd:	e8 f0 00 00 00       	call   5c2 <open>
  if(fd < 0)
 4d2:	83 c4 10             	add    $0x10,%esp
 4d5:	85 c0                	test   %eax,%eax
 4d7:	78 27                	js     500 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 4d9:	83 ec 08             	sub    $0x8,%esp
 4dc:	ff 75 0c             	pushl  0xc(%ebp)
 4df:	89 c3                	mov    %eax,%ebx
 4e1:	50                   	push   %eax
 4e2:	e8 f3 00 00 00       	call   5da <fstat>
  close(fd);
 4e7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 4ea:	89 c6                	mov    %eax,%esi
  close(fd);
 4ec:	e8 b9 00 00 00       	call   5aa <close>
  return r;
 4f1:	83 c4 10             	add    $0x10,%esp
}
 4f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4f7:	89 f0                	mov    %esi,%eax
 4f9:	5b                   	pop    %ebx
 4fa:	5e                   	pop    %esi
 4fb:	5d                   	pop    %ebp
 4fc:	c3                   	ret    
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 500:	be ff ff ff ff       	mov    $0xffffffff,%esi
 505:	eb ed                	jmp    4f4 <stat+0x34>
 507:	89 f6                	mov    %esi,%esi
 509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000510 <atoi>:

int
atoi(const char *s)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	53                   	push   %ebx
 514:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 517:	0f be 11             	movsbl (%ecx),%edx
 51a:	8d 42 d0             	lea    -0x30(%edx),%eax
 51d:	3c 09                	cmp    $0x9,%al
 51f:	b8 00 00 00 00       	mov    $0x0,%eax
 524:	77 1f                	ja     545 <atoi+0x35>
 526:	8d 76 00             	lea    0x0(%esi),%esi
 529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 530:	8d 04 80             	lea    (%eax,%eax,4),%eax
 533:	83 c1 01             	add    $0x1,%ecx
 536:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 53a:	0f be 11             	movsbl (%ecx),%edx
 53d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 540:	80 fb 09             	cmp    $0x9,%bl
 543:	76 eb                	jbe    530 <atoi+0x20>
  return n;
}
 545:	5b                   	pop    %ebx
 546:	5d                   	pop    %ebp
 547:	c3                   	ret    
 548:	90                   	nop
 549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000550 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	56                   	push   %esi
 554:	53                   	push   %ebx
 555:	8b 5d 10             	mov    0x10(%ebp),%ebx
 558:	8b 45 08             	mov    0x8(%ebp),%eax
 55b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 55e:	85 db                	test   %ebx,%ebx
 560:	7e 14                	jle    576 <memmove+0x26>
 562:	31 d2                	xor    %edx,%edx
 564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 568:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 56c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 56f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 572:	39 da                	cmp    %ebx,%edx
 574:	75 f2                	jne    568 <memmove+0x18>
  return vdst;
}
 576:	5b                   	pop    %ebx
 577:	5e                   	pop    %esi
 578:	5d                   	pop    %ebp
 579:	c3                   	ret    

0000057a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 57a:	b8 01 00 00 00       	mov    $0x1,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <exit>:
SYSCALL(exit)
 582:	b8 02 00 00 00       	mov    $0x2,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <wait>:
SYSCALL(wait)
 58a:	b8 03 00 00 00       	mov    $0x3,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <pipe>:
SYSCALL(pipe)
 592:	b8 04 00 00 00       	mov    $0x4,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <read>:
SYSCALL(read)
 59a:	b8 05 00 00 00       	mov    $0x5,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <write>:
SYSCALL(write)
 5a2:	b8 10 00 00 00       	mov    $0x10,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <close>:
SYSCALL(close)
 5aa:	b8 15 00 00 00       	mov    $0x15,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    

000005b2 <kill>:
SYSCALL(kill)
 5b2:	b8 06 00 00 00       	mov    $0x6,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret    

000005ba <exec>:
SYSCALL(exec)
 5ba:	b8 07 00 00 00       	mov    $0x7,%eax
 5bf:	cd 40                	int    $0x40
 5c1:	c3                   	ret    

000005c2 <open>:
SYSCALL(open)
 5c2:	b8 0f 00 00 00       	mov    $0xf,%eax
 5c7:	cd 40                	int    $0x40
 5c9:	c3                   	ret    

000005ca <mknod>:
SYSCALL(mknod)
 5ca:	b8 11 00 00 00       	mov    $0x11,%eax
 5cf:	cd 40                	int    $0x40
 5d1:	c3                   	ret    

000005d2 <unlink>:
SYSCALL(unlink)
 5d2:	b8 12 00 00 00       	mov    $0x12,%eax
 5d7:	cd 40                	int    $0x40
 5d9:	c3                   	ret    

000005da <fstat>:
SYSCALL(fstat)
 5da:	b8 08 00 00 00       	mov    $0x8,%eax
 5df:	cd 40                	int    $0x40
 5e1:	c3                   	ret    

000005e2 <link>:
SYSCALL(link)
 5e2:	b8 13 00 00 00       	mov    $0x13,%eax
 5e7:	cd 40                	int    $0x40
 5e9:	c3                   	ret    

000005ea <mkdir>:
SYSCALL(mkdir)
 5ea:	b8 14 00 00 00       	mov    $0x14,%eax
 5ef:	cd 40                	int    $0x40
 5f1:	c3                   	ret    

000005f2 <chdir>:
SYSCALL(chdir)
 5f2:	b8 09 00 00 00       	mov    $0x9,%eax
 5f7:	cd 40                	int    $0x40
 5f9:	c3                   	ret    

000005fa <dup>:
SYSCALL(dup)
 5fa:	b8 0a 00 00 00       	mov    $0xa,%eax
 5ff:	cd 40                	int    $0x40
 601:	c3                   	ret    

00000602 <getpid>:
SYSCALL(getpid)
 602:	b8 0b 00 00 00       	mov    $0xb,%eax
 607:	cd 40                	int    $0x40
 609:	c3                   	ret    

0000060a <sbrk>:
SYSCALL(sbrk)
 60a:	b8 0c 00 00 00       	mov    $0xc,%eax
 60f:	cd 40                	int    $0x40
 611:	c3                   	ret    

00000612 <sleep>:
SYSCALL(sleep)
 612:	b8 0d 00 00 00       	mov    $0xd,%eax
 617:	cd 40                	int    $0x40
 619:	c3                   	ret    

0000061a <uptime>:
SYSCALL(uptime)
 61a:	b8 0e 00 00 00       	mov    $0xe,%eax
 61f:	cd 40                	int    $0x40
 621:	c3                   	ret    

00000622 <dup2>:
SYSCALL(dup2)
 622:	b8 16 00 00 00       	mov    $0x16,%eax
 627:	cd 40                	int    $0x40
 629:	c3                   	ret    

0000062a <getcwd>:
SYSCALL(getcwd)
 62a:	b8 17 00 00 00       	mov    $0x17,%eax
 62f:	cd 40                	int    $0x40
 631:	c3                   	ret    
 632:	66 90                	xchg   %ax,%ax
 634:	66 90                	xchg   %ax,%ax
 636:	66 90                	xchg   %ax,%ax
 638:	66 90                	xchg   %ax,%ax
 63a:	66 90                	xchg   %ax,%ax
 63c:	66 90                	xchg   %ax,%ax
 63e:	66 90                	xchg   %ax,%ax

00000640 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	57                   	push   %edi
 644:	56                   	push   %esi
 645:	53                   	push   %ebx
 646:	89 c6                	mov    %eax,%esi
 648:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 64b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 64e:	85 db                	test   %ebx,%ebx
 650:	74 7e                	je     6d0 <printint+0x90>
 652:	89 d0                	mov    %edx,%eax
 654:	c1 e8 1f             	shr    $0x1f,%eax
 657:	84 c0                	test   %al,%al
 659:	74 75                	je     6d0 <printint+0x90>
    neg = 1;
    x = -xx;
 65b:	89 d0                	mov    %edx,%eax
    neg = 1;
 65d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 664:	f7 d8                	neg    %eax
 666:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 669:	31 ff                	xor    %edi,%edi
 66b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 66e:	89 ce                	mov    %ecx,%esi
 670:	eb 08                	jmp    67a <printint+0x3a>
 672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 678:	89 cf                	mov    %ecx,%edi
 67a:	31 d2                	xor    %edx,%edx
 67c:	8d 4f 01             	lea    0x1(%edi),%ecx
 67f:	f7 f6                	div    %esi
 681:	0f b6 92 c4 0a 00 00 	movzbl 0xac4(%edx),%edx
  }while((x /= base) != 0);
 688:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 68a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 68d:	75 e9                	jne    678 <printint+0x38>
  if(neg)
 68f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 692:	8b 75 c0             	mov    -0x40(%ebp),%esi
 695:	85 c0                	test   %eax,%eax
 697:	74 08                	je     6a1 <printint+0x61>
    buf[i++] = '-';
 699:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 69e:	8d 4f 02             	lea    0x2(%edi),%ecx

  while(--i >= 0)
 6a1:	8d 79 ff             	lea    -0x1(%ecx),%edi
 6a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6a8:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
  write(fd, &c, 1);
 6ad:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 6b0:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 6b3:	6a 01                	push   $0x1
 6b5:	53                   	push   %ebx
 6b6:	56                   	push   %esi
 6b7:	88 45 d7             	mov    %al,-0x29(%ebp)
 6ba:	e8 e3 fe ff ff       	call   5a2 <write>
  while(--i >= 0)
 6bf:	83 c4 10             	add    $0x10,%esp
 6c2:	83 ff ff             	cmp    $0xffffffff,%edi
 6c5:	75 e1                	jne    6a8 <printint+0x68>
    putc(fd, buf[i]);
}
 6c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6ca:	5b                   	pop    %ebx
 6cb:	5e                   	pop    %esi
 6cc:	5f                   	pop    %edi
 6cd:	5d                   	pop    %ebp
 6ce:	c3                   	ret    
 6cf:	90                   	nop
    x = xx;
 6d0:	89 d0                	mov    %edx,%eax
  neg = 0;
 6d2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 6d9:	eb 8b                	jmp    666 <printint+0x26>
 6db:	90                   	nop
 6dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	57                   	push   %edi
 6e4:	56                   	push   %esi
 6e5:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6e6:	8d 45 10             	lea    0x10(%ebp),%eax
{
 6e9:	83 ec 2c             	sub    $0x2c,%esp
  for(i = 0; fmt[i]; i++){
 6ec:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 6ef:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 6f2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6f5:	0f b6 1e             	movzbl (%esi),%ebx
 6f8:	83 c6 01             	add    $0x1,%esi
 6fb:	84 db                	test   %bl,%bl
 6fd:	0f 84 b0 00 00 00    	je     7b3 <printf+0xd3>
 703:	31 d2                	xor    %edx,%edx
 705:	eb 39                	jmp    740 <printf+0x60>
 707:	89 f6                	mov    %esi,%esi
 709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 710:	83 f8 25             	cmp    $0x25,%eax
 713:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 716:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 71b:	74 18                	je     735 <printf+0x55>
  write(fd, &c, 1);
 71d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 720:	83 ec 04             	sub    $0x4,%esp
 723:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 726:	6a 01                	push   $0x1
 728:	50                   	push   %eax
 729:	57                   	push   %edi
 72a:	e8 73 fe ff ff       	call   5a2 <write>
 72f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 732:	83 c4 10             	add    $0x10,%esp
 735:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 738:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 73c:	84 db                	test   %bl,%bl
 73e:	74 73                	je     7b3 <printf+0xd3>
    if(state == 0){
 740:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 742:	0f be cb             	movsbl %bl,%ecx
 745:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 748:	74 c6                	je     710 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 74a:	83 fa 25             	cmp    $0x25,%edx
 74d:	75 e6                	jne    735 <printf+0x55>
      if(c == 'd'){
 74f:	83 f8 64             	cmp    $0x64,%eax
 752:	0f 84 f8 00 00 00    	je     850 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 758:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 75e:	83 f9 70             	cmp    $0x70,%ecx
 761:	74 5d                	je     7c0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 763:	83 f8 73             	cmp    $0x73,%eax
 766:	0f 84 84 00 00 00    	je     7f0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 76c:	83 f8 63             	cmp    $0x63,%eax
 76f:	0f 84 ea 00 00 00    	je     85f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 775:	83 f8 25             	cmp    $0x25,%eax
 778:	0f 84 c2 00 00 00    	je     840 <printf+0x160>
  write(fd, &c, 1);
 77e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 781:	83 ec 04             	sub    $0x4,%esp
 784:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 788:	6a 01                	push   $0x1
 78a:	50                   	push   %eax
 78b:	57                   	push   %edi
 78c:	e8 11 fe ff ff       	call   5a2 <write>
 791:	83 c4 0c             	add    $0xc,%esp
 794:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 797:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 79a:	6a 01                	push   $0x1
 79c:	50                   	push   %eax
 79d:	57                   	push   %edi
 79e:	83 c6 01             	add    $0x1,%esi
 7a1:	e8 fc fd ff ff       	call   5a2 <write>
  for(i = 0; fmt[i]; i++){
 7a6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 7aa:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7ad:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 7af:	84 db                	test   %bl,%bl
 7b1:	75 8d                	jne    740 <printf+0x60>
    }
  }
}
 7b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7b6:	5b                   	pop    %ebx
 7b7:	5e                   	pop    %esi
 7b8:	5f                   	pop    %edi
 7b9:	5d                   	pop    %ebp
 7ba:	c3                   	ret    
 7bb:	90                   	nop
 7bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 16, 0);
 7c0:	83 ec 0c             	sub    $0xc,%esp
 7c3:	b9 10 00 00 00       	mov    $0x10,%ecx
 7c8:	6a 00                	push   $0x0
 7ca:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 7cd:	89 f8                	mov    %edi,%eax
 7cf:	8b 13                	mov    (%ebx),%edx
 7d1:	e8 6a fe ff ff       	call   640 <printint>
        ap++;
 7d6:	89 d8                	mov    %ebx,%eax
 7d8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 7db:	31 d2                	xor    %edx,%edx
        ap++;
 7dd:	83 c0 04             	add    $0x4,%eax
 7e0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 7e3:	e9 4d ff ff ff       	jmp    735 <printf+0x55>
 7e8:	90                   	nop
 7e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 7f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 7f3:	8b 18                	mov    (%eax),%ebx
        ap++;
 7f5:	83 c0 04             	add    $0x4,%eax
 7f8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 7fb:	85 db                	test   %ebx,%ebx
 7fd:	74 7c                	je     87b <printf+0x19b>
        while(*s != 0){
 7ff:	0f b6 03             	movzbl (%ebx),%eax
 802:	84 c0                	test   %al,%al
 804:	74 29                	je     82f <printf+0x14f>
 806:	8d 76 00             	lea    0x0(%esi),%esi
 809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 810:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 813:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 816:	83 ec 04             	sub    $0x4,%esp
 819:	6a 01                	push   $0x1
          s++;
 81b:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 81e:	50                   	push   %eax
 81f:	57                   	push   %edi
 820:	e8 7d fd ff ff       	call   5a2 <write>
        while(*s != 0){
 825:	0f b6 03             	movzbl (%ebx),%eax
 828:	83 c4 10             	add    $0x10,%esp
 82b:	84 c0                	test   %al,%al
 82d:	75 e1                	jne    810 <printf+0x130>
      state = 0;
 82f:	31 d2                	xor    %edx,%edx
 831:	e9 ff fe ff ff       	jmp    735 <printf+0x55>
 836:	8d 76 00             	lea    0x0(%esi),%esi
 839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  write(fd, &c, 1);
 840:	83 ec 04             	sub    $0x4,%esp
 843:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 846:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 849:	6a 01                	push   $0x1
 84b:	e9 4c ff ff ff       	jmp    79c <printf+0xbc>
        printint(fd, *ap, 10, 1);
 850:	83 ec 0c             	sub    $0xc,%esp
 853:	b9 0a 00 00 00       	mov    $0xa,%ecx
 858:	6a 01                	push   $0x1
 85a:	e9 6b ff ff ff       	jmp    7ca <printf+0xea>
        putc(fd, *ap);
 85f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 862:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 865:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 867:	6a 01                	push   $0x1
        putc(fd, *ap);
 869:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 86c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 86f:	50                   	push   %eax
 870:	57                   	push   %edi
 871:	e8 2c fd ff ff       	call   5a2 <write>
 876:	e9 5b ff ff ff       	jmp    7d6 <printf+0xf6>
        while(*s != 0){
 87b:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 880:	bb ba 0a 00 00       	mov    $0xaba,%ebx
 885:	eb 89                	jmp    810 <printf+0x130>
 887:	66 90                	xchg   %ax,%ax
 889:	66 90                	xchg   %ax,%ax
 88b:	66 90                	xchg   %ax,%ax
 88d:	66 90                	xchg   %ax,%ax
 88f:	90                   	nop

00000890 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 890:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 891:	a1 34 0e 00 00       	mov    0xe34,%eax
{
 896:	89 e5                	mov    %esp,%ebp
 898:	57                   	push   %edi
 899:	56                   	push   %esi
 89a:	53                   	push   %ebx
 89b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 89e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 8a0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a3:	39 c8                	cmp    %ecx,%eax
 8a5:	73 19                	jae    8c0 <free+0x30>
 8a7:	89 f6                	mov    %esi,%esi
 8a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 8b0:	39 d1                	cmp    %edx,%ecx
 8b2:	72 1c                	jb     8d0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8b4:	39 d0                	cmp    %edx,%eax
 8b6:	73 18                	jae    8d0 <free+0x40>
{
 8b8:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ba:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8bc:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8be:	72 f0                	jb     8b0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c0:	39 d0                	cmp    %edx,%eax
 8c2:	72 f4                	jb     8b8 <free+0x28>
 8c4:	39 d1                	cmp    %edx,%ecx
 8c6:	73 f0                	jae    8b8 <free+0x28>
 8c8:	90                   	nop
 8c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 8d0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8d3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 8d6:	39 fa                	cmp    %edi,%edx
 8d8:	74 19                	je     8f3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 8da:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8dd:	8b 50 04             	mov    0x4(%eax),%edx
 8e0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8e3:	39 f1                	cmp    %esi,%ecx
 8e5:	74 23                	je     90a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 8e7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 8e9:	a3 34 0e 00 00       	mov    %eax,0xe34
}
 8ee:	5b                   	pop    %ebx
 8ef:	5e                   	pop    %esi
 8f0:	5f                   	pop    %edi
 8f1:	5d                   	pop    %ebp
 8f2:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 8f3:	03 72 04             	add    0x4(%edx),%esi
 8f6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 8f9:	8b 10                	mov    (%eax),%edx
 8fb:	8b 12                	mov    (%edx),%edx
 8fd:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 900:	8b 50 04             	mov    0x4(%eax),%edx
 903:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 906:	39 f1                	cmp    %esi,%ecx
 908:	75 dd                	jne    8e7 <free+0x57>
    p->s.size += bp->s.size;
 90a:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 90d:	a3 34 0e 00 00       	mov    %eax,0xe34
    p->s.size += bp->s.size;
 912:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 915:	8b 53 f8             	mov    -0x8(%ebx),%edx
 918:	89 10                	mov    %edx,(%eax)
}
 91a:	5b                   	pop    %ebx
 91b:	5e                   	pop    %esi
 91c:	5f                   	pop    %edi
 91d:	5d                   	pop    %ebp
 91e:	c3                   	ret    
 91f:	90                   	nop

00000920 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 920:	55                   	push   %ebp
 921:	89 e5                	mov    %esp,%ebp
 923:	57                   	push   %edi
 924:	56                   	push   %esi
 925:	53                   	push   %ebx
 926:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 929:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 92c:	8b 15 34 0e 00 00    	mov    0xe34,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 932:	8d 78 07             	lea    0x7(%eax),%edi
 935:	c1 ef 03             	shr    $0x3,%edi
 938:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 93b:	85 d2                	test   %edx,%edx
 93d:	0f 84 93 00 00 00    	je     9d6 <malloc+0xb6>
 943:	8b 02                	mov    (%edx),%eax
 945:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 948:	39 cf                	cmp    %ecx,%edi
 94a:	76 64                	jbe    9b0 <malloc+0x90>
 94c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 952:	bb 00 10 00 00       	mov    $0x1000,%ebx
 957:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 95a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 961:	eb 0e                	jmp    971 <malloc+0x51>
 963:	90                   	nop
 964:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 968:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 96a:	8b 48 04             	mov    0x4(%eax),%ecx
 96d:	39 cf                	cmp    %ecx,%edi
 96f:	76 3f                	jbe    9b0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 971:	39 05 34 0e 00 00    	cmp    %eax,0xe34
 977:	89 c2                	mov    %eax,%edx
 979:	75 ed                	jne    968 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 97b:	83 ec 0c             	sub    $0xc,%esp
 97e:	56                   	push   %esi
 97f:	e8 86 fc ff ff       	call   60a <sbrk>
  if(p == (char*)-1)
 984:	83 c4 10             	add    $0x10,%esp
 987:	83 f8 ff             	cmp    $0xffffffff,%eax
 98a:	74 1c                	je     9a8 <malloc+0x88>
  hp->s.size = nu;
 98c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 98f:	83 ec 0c             	sub    $0xc,%esp
 992:	83 c0 08             	add    $0x8,%eax
 995:	50                   	push   %eax
 996:	e8 f5 fe ff ff       	call   890 <free>
  return freep;
 99b:	8b 15 34 0e 00 00    	mov    0xe34,%edx
      if((p = morecore(nunits)) == 0)
 9a1:	83 c4 10             	add    $0x10,%esp
 9a4:	85 d2                	test   %edx,%edx
 9a6:	75 c0                	jne    968 <malloc+0x48>
        return 0;
 9a8:	31 c0                	xor    %eax,%eax
 9aa:	eb 1c                	jmp    9c8 <malloc+0xa8>
 9ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 9b0:	39 cf                	cmp    %ecx,%edi
 9b2:	74 1c                	je     9d0 <malloc+0xb0>
        p->s.size -= nunits;
 9b4:	29 f9                	sub    %edi,%ecx
 9b6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 9b9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 9bc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 9bf:	89 15 34 0e 00 00    	mov    %edx,0xe34
      return (void*)(p + 1);
 9c5:	83 c0 08             	add    $0x8,%eax
  }
}
 9c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9cb:	5b                   	pop    %ebx
 9cc:	5e                   	pop    %esi
 9cd:	5f                   	pop    %edi
 9ce:	5d                   	pop    %ebp
 9cf:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 9d0:	8b 08                	mov    (%eax),%ecx
 9d2:	89 0a                	mov    %ecx,(%edx)
 9d4:	eb e9                	jmp    9bf <malloc+0x9f>
    base.s.ptr = freep = prevp = &base;
 9d6:	c7 05 34 0e 00 00 38 	movl   $0xe38,0xe34
 9dd:	0e 00 00 
 9e0:	c7 05 38 0e 00 00 38 	movl   $0xe38,0xe38
 9e7:	0e 00 00 
    base.s.size = 0;
 9ea:	b8 38 0e 00 00       	mov    $0xe38,%eax
 9ef:	c7 05 3c 0e 00 00 00 	movl   $0x0,0xe3c
 9f6:	00 00 00 
 9f9:	e9 4e ff ff ff       	jmp    94c <malloc+0x2c>
 9fe:	66 90                	xchg   %ax,%ax

00000a00 <calloc>:

void*
calloc(uint nmemb, uint sz)
{
 a00:	55                   	push   %ebp
 a01:	89 e5                	mov    %esp,%ebp
 a03:	56                   	push   %esi
 a04:	53                   	push   %ebx
  uint full_sz = 0;
  if (__builtin_mul_overflow(nmemb, sz, &full_sz))
 a05:	8b 45 08             	mov    0x8(%ebp),%eax
 a08:	f7 65 0c             	mull   0xc(%ebp)
 a0b:	70 25                	jo     a32 <calloc+0x32>
    return NULL;
  void *region = malloc(full_sz);
 a0d:	83 ec 0c             	sub    $0xc,%esp
 a10:	89 c3                	mov    %eax,%ebx
 a12:	50                   	push   %eax
 a13:	e8 08 ff ff ff       	call   920 <malloc>
  memset(region, 0, full_sz);
 a18:	83 c4 0c             	add    $0xc,%esp
  void *region = malloc(full_sz);
 a1b:	89 c6                	mov    %eax,%esi
  memset(region, 0, full_sz);
 a1d:	53                   	push   %ebx
 a1e:	6a 00                	push   $0x0
 a20:	50                   	push   %eax
 a21:	e8 ca f9 ff ff       	call   3f0 <memset>
  return region;
 a26:	83 c4 10             	add    $0x10,%esp
}
 a29:	8d 65 f8             	lea    -0x8(%ebp),%esp
 a2c:	89 f0                	mov    %esi,%eax
 a2e:	5b                   	pop    %ebx
 a2f:	5e                   	pop    %esi
 a30:	5d                   	pop    %ebp
 a31:	c3                   	ret    
    return NULL;
 a32:	31 f6                	xor    %esi,%esi
 a34:	eb f3                	jmp    a29 <calloc+0x29>
 a36:	8d 76 00             	lea    0x0(%esi),%esi
 a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a40 <strdup>:

char*
strdup(char *s)
{
 a40:	55                   	push   %ebp
 a41:	89 e5                	mov    %esp,%ebp
 a43:	56                   	push   %esi
 a44:	53                   	push   %ebx
 a45:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *buf = malloc(strlen(s) + 1);
 a48:	83 ec 0c             	sub    $0xc,%esp
 a4b:	53                   	push   %ebx
 a4c:	e8 6f f9 ff ff       	call   3c0 <strlen>
 a51:	83 c0 01             	add    $0x1,%eax
 a54:	89 04 24             	mov    %eax,(%esp)
 a57:	e8 c4 fe ff ff       	call   920 <malloc>
 a5c:	89 c6                	mov    %eax,%esi
  strcpy(buf, s);
 a5e:	58                   	pop    %eax
 a5f:	5a                   	pop    %edx
 a60:	53                   	push   %ebx
 a61:	56                   	push   %esi
 a62:	e8 d9 f8 ff ff       	call   340 <strcpy>
  return buf;
}
 a67:	8d 65 f8             	lea    -0x8(%ebp),%esp
 a6a:	89 f0                	mov    %esi,%eax
 a6c:	5b                   	pop    %ebx
 a6d:	5e                   	pop    %esi
 a6e:	5d                   	pop    %ebp
 a6f:	c3                   	ret    
